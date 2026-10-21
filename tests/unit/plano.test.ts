import { test } from 'node:test';
import assert from 'node:assert/strict';
import { PlanoStore } from '../../src/lib/plano/store';
import { assignmentsCSV, parseCSV } from '../../src/lib/plano/csv';
import { acciones, conteo, type Snapshot } from '../../src/lib/plano/types';
import data from '../../src/data/plano-demo.json';
const fixture=()=>structuredClone(data) as Snapshot;
test('evento realtime actualiza solo el puesto afectado e ignora versiones repetidas',()=>{
  const store=new PlanoStore();store.reset(fixture());
  const first=[...store.puestos.values()][0],other=[...store.puestos.values()][1];
  let updates=0;store.onChange=()=>updates++;
  const update={...first,estado:'bloqueado' as const,version:2};
  store.update(update);store.update(update);store.update(first);
  assert.equal(updates,1);assert.equal(store.puestos.get(other.id),other);
  assert.equal(store.counts.get(first.sector_id)!.bloqueado,2);
  assert.equal(store.counts.get(first.sector_id)!.disponible,6);
});
test('CSV soporta BOM, CRLF, comillas y punto y coma; rechaza filas ambiguas',()=>{
  const f=fixture();
  assert.deepEqual(parseCSV('\uFEFFcodigo;sector\r\n"PES-01";"Pescados y mariscos"\r\n'),[['codigo','sector'],['PES-01','Pescados y mariscos']]);
  assert.equal(assignmentsCSV('codigo,sector\nPES-01,Carnes',f.puestos,f.sectores)[0].sector_id,f.sectores[1].id);
  for(const csv of ['codigo,sector\nPES-01,Carnes\nPES-01,Carnes','codigo,sector\nBAD,Carnes','codigo,sector\nPES-01,BAD','codigo,sector\n"PES-01,Carnes']){
    assert.throws(()=>assignmentsCSV(csv,f.puestos,f.sectores));
  }
});
test('acciones por rol y avance sin bloqueados',()=>{
  const p=fixture().puestos[9];
  assert.deepEqual(acciones(p,'asesor','x'),[]);
  assert.deepEqual(acciones(p,'admin','x'),['desbloquear']);
  assert.deepEqual(acciones({...p,estado:'separado',separado_por:'owner'},'asesor','x'),[]);
  assert.deepEqual(acciones({...p,estado:'disponible'},'lector','x'),[]);
  assert.equal(conteo(fixture().puestos).avance,22);
});
