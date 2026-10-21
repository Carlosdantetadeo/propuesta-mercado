import { PGlite } from '@electric-sql/pglite';
import { readFile } from 'node:fs/promises';
import { test, before, after } from 'node:test';
import assert from 'node:assert/strict';

let db;
const users={
  admin:'30000000-0000-4000-8000-000000000001',
  asesor:'30000000-0000-4000-8000-000000000002',
  otro:'30000000-0000-4000-8000-000000000003',
  lector:'30000000-0000-4000-8000-000000000004',
  sinrol:'30000000-0000-4000-8000-000000000005'
};
const id=n=>`20000000-0000-4000-8000-${String(n).padStart(12,'0')}`;
const get=async (n=101)=>(await db.query('select * from puestos where id=$1',[id(n)])).rows[0];
const as=async(user,sql,params=[])=>db.transaction(async tx=>{
  await tx.exec('set local role authenticated');
  await tx.query("select set_config('request.jwt.claim.sub',$1,true)",[users[user]]);
  return tx.query(sql,params);
});
const act=async(user,rows,action,reason='Prueba')=>as(user,
  'select * from cambiar_estado_puestos($1::jsonb,$2,$3)',[JSON.stringify(rows),action,reason]);
const changes=async(...ns)=>Promise.all(ns.map(async n=>{const p=await get(n);return{id:p.id,version:p.version};}));
before(async()=>{
  db=new PGlite();
  await db.exec(`
    create role anon;
    create role authenticated;
    create schema auth;
    create table auth.users(id uuid primary key);
    create function auth.uid() returns uuid language sql stable as
      $$ select nullif(current_setting('request.jwt.claim.sub',true),'')::uuid $$;
    grant usage on schema public,auth to anon,authenticated;
    grant execute on function auth.uid() to anon,authenticated;
  `);
  await db.exec(await readFile('supabase/migrations/202610200001_base_comercial.sql','utf8'));
  await db.exec("insert into puestos(codigo) values ('LEGACY-01')");
  await db.exec(await readFile('supabase/migrations/202610200002_sectores_bloqueos.sql','utf8'));
  const legacy=(await db.query("select * from puestos where codigo='LEGACY-01'")).rows[0];
  assert.equal(legacy.sector_id,'00000000-0000-4000-8000-000000000001');
  assert.equal(legacy.codigo,'LEGACY-01');
  await db.exec("delete from puestos where codigo='LEGACY-01'");
  for(const [user,uid] of Object.entries(users)){
    await db.query('insert into auth.users values($1)',[uid]);
    if(user!=='sinrol')await db.query('insert into perfiles(id,nombre,rol) values ($1,$2,$3)',[uid,user,user==='otro'?'asesor':user]);
  }
  const seed=await readFile('supabase/seed.sql','utf8');await db.exec(seed);await db.exec(seed);
});
after(async()=>{await db?.close();});
test('seed idempotente: tres sectores de ejemplo, treinta puestos y sector por defecto',async()=>{
  assert.equal((await db.query('select count(*) from puestos')).rows[0].count,30);
  assert.equal((await db.query('select count(*) from sectores')).rows[0].count,4);
});
test('RLS: anónimo sin lectura; roles asignados leen; usuario sin perfil no ve inventario',async()=>{
  await assert.rejects(()=>db.transaction(async tx=>{await tx.exec('set local role anon');return tx.query('select * from puestos');}),/permission denied/);
  for(const role of ['admin','asesor','lector'])assert.equal((await as(role,'select * from puestos')).rows.length,30);
  assert.equal((await as('sinrol','select * from puestos')).rows.length,0);
  await assert.rejects(()=>as('asesor',"update perfiles set rol='admin' where id=auth.uid()"),/permission denied/);
  await assert.rejects(()=>as('asesor',"insert into perfiles(id,rol) values (auth.uid(),'admin')"),/permission denied/);
});
test('RLS sigue rechazando escrituras incluso si se concede UPDATE accidentalmente',async()=>{
  await db.exec('grant update on puestos to authenticated');
  try{
    for(const user of ['admin','asesor','lector']){
      const result=await as(user,"update puestos set estado='disponible' where id=$1 returning *",[id(110)]);
      assert.equal(result.rows.length,0);
    }
    assert.equal((await get(110)).estado,'bloqueado');
  }finally{await db.exec('revoke update on puestos from authenticated');}
});
test('dos intentos de separación sobre un bloqueado son rechazados sin reserva ni auditoría',async()=>{
  const rows=await changes(110);
  const results=await Promise.allSettled([act('asesor',rows,'separar'),act('otro',rows,'separar')]);
  assert.ok(results.every(r=>r.status==='rejected'));
  assert.equal((await get(110)).estado,'bloqueado');
  assert.equal((await db.query('select count(*) from separaciones where puesto_id=$1',[id(110)])).rows[0].count,0);
  assert.equal((await db.query('select count(*) from auditoria where puesto_id=$1',[id(110)])).rows[0].count,0);
});
test('control de versión + unicidad: solo una de dos solicitudes de separación puede confirmar',async()=>{
  const rows=await changes(101);
  const results=await Promise.allSettled([act('asesor',rows,'separar'),act('otro',rows,'separar')]);
  assert.equal(results.filter(r=>r.status==='fulfilled').length,1);
  assert.equal((await get(101)).estado,'separado');
  assert.equal((await db.query('select count(*) from separaciones where puesto_id=$1 and cerrada_en is null',[id(101)])).rows[0].count,1);
});
test('solo el dueño o admin libera; lector y usuario sin rol no pueden separar',async()=>{
  const p=await get(101),other=p.separado_por===users.asesor?'otro':'asesor';
  await assert.rejects(()=>act(other,[{id:p.id,version:p.version}],'liberar'),/propia separación/);
  for(const user of ['lector','sinrol'])await assert.rejects(async()=>act(user,await changes(102),'separar'),/No autorizado/);
  await act('admin',await changes(101),'liberar');
  assert.equal((await get(101)).estado,'disponible');
});
test('solo admin bloquea/desbloquea; motivo obligatorio tanto al aplicar como al quitar',async()=>{
  await assert.rejects(async()=>act('asesor',await changes(102),'bloquear'),/administrador/);
  await assert.rejects(async()=>act('admin',await changes(102),'bloquear',' '),/motivo/);
  await act('admin',await changes(102),'bloquear','Reserva del propietario');
  await assert.rejects(async()=>act('asesor',await changes(102),'desbloquear'),/administrador/);
  await assert.rejects(async()=>act('admin',await changes(102),'desbloquear',''),/motivo/);
  await act('admin',await changes(102),'desbloquear','Autorización del propietario');
  assert.equal((await get(102)).motivo_bloqueo,null);
});
test('lote incompatible revierte todos los estados, versiones y auditoría',async()=>{
  const before=await get(103);
  await assert.rejects(async()=>act('admin',await changes(103,108),'bloquear'),/disponibles/);
  assert.deepEqual(await get(103),before);
  assert.equal((await db.query('select count(*) from auditoria where puesto_id=$1',[id(103)])).rows[0].count,0);
});
test('rechaza duplicados, ids inexistentes, versiones nulas y acciones nulas',async()=>{
  const rows=await changes(104);
  for(const data of [[...rows,...rows],[{id:id(999),version:1}],[{id:id(104),version:null}]]){
    await assert.rejects(()=>act('admin',data,'bloquear'),/inválid/);
  }
  await assert.rejects(()=>act('admin',rows,null),/inválida/);
});
test('venta solo admin y desde separado; cierra reserva y registra auditoría con actor',async()=>{
  await assert.rejects(async()=>act('admin',await changes(104),'vender'),/separación previa/);
  await act('asesor',await changes(104),'separar');
  await assert.rejects(async()=>act('asesor',await changes(104),'vender'),/administrador/);
  await act('admin',await changes(104),'vender','Contrato firmado');
  const audit=(await as('admin',"select * from auditoria where puesto_id=$1 and accion='vender'",[id(104)])).rows[0];
  assert.equal(audit.actor_id,users.admin);assert.equal(audit.motivo,'Contrato firmado');
  assert.equal(audit.antes.estado,'separado');assert.equal(audit.despues.estado,'vendido');
  assert.equal((await as('asesor','select * from auditoria')).rows.length,0);
  await assert.rejects(()=>as('admin',"delete from auditoria"),/permission denied/);
});
test('asignación masiva solo admin, conserva código y falla completa con versiones obsoletas',async()=>{
  const before=await get(105),other=await get(106);
  const target='10000000-0000-4000-8000-000000000002';
  const rows=[{id:before.id,version:before.version,sector_id:target}];
  await assert.rejects(()=>as('asesor','select * from asignar_sectores($1::jsonb,$2)',[JSON.stringify(rows),'Reorganización']),/administrador/);
  await assert.rejects(()=>as('admin','select * from asignar_sectores($1::jsonb,$2)',[JSON.stringify([...rows,{id:other.id,version:0,sector_id:target}]),'Reorganización']),/cambió/);
  assert.deepEqual(await get(105),before);
  await as('admin','select * from asignar_sectores($1::jsonb,$2)',[JSON.stringify(rows),'Reorganización']);
  assert.equal((await get(105)).codigo,before.codigo);assert.equal((await get(105)).sector_id,target);
});
test('contadores respetan RLS, incluyen bloqueados y excluyen estos del avance',async()=>{
  assert.equal((await as('sinrol','select * from contadores_sectores()')).rows.length,0);
  const result=(await as('lector','select * from contadores_sectores()')).rows;
  const aba=result.find(s=>s.sector_id==='10000000-0000-4000-8000-000000000003');
  assert.equal(aba.disponibles,7);assert.equal(aba.bloqueados,1);assert.equal(Number(aba.avance),22.2);
});
