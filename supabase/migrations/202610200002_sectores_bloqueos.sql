create table public.sectores (
  id uuid primary key default gen_random_uuid(),
  nombre text not null unique,
  rubro text not null,
  color text not null check (color ~ '^#[0-9a-fA-F]{6}$'),
  orden integer not null default 0,
  contorno jsonb not null default '[]'::jsonb check (jsonb_typeof(contorno) = 'array'),
  icono text not null default 'local'
);
insert into public.sectores(id,nombre,rubro,color,orden,icono)
values ('00000000-0000-4000-8000-000000000001','Sin asignar','Por clasificar','#64748b',999,'local');
alter table public.puestos add column sector_id uuid references public.sectores(id);
update public.puestos set sector_id = '00000000-0000-4000-8000-000000000001' where sector_id is null;
alter table public.puestos alter column sector_id set not null;
alter table public.puestos alter column sector_id set default '00000000-0000-4000-8000-000000000001';
alter table public.puestos drop constraint puestos_estado_check;
alter table public.puestos add constraint puestos_estado_check
check (estado in ('disponible','separado','vendido','bloqueado'));
alter table public.puestos add column motivo_bloqueo text;
alter table public.puestos add constraint bloqueo_con_motivo
check (estado <> 'bloqueado' or nullif(btrim(motivo_bloqueo),'') is not null);
create index puestos_sector_estado on public.puestos(sector_id, estado);
create index auditoria_puesto_fecha on public.auditoria(puesto_id, creada_en desc);
alter table public.sectores enable row level security;
revoke all on public.sectores from anon, authenticated;
grant select on public.sectores to authenticated;
create policy sectores_lectura on public.sectores for select to authenticated
using ((select public.mi_rol()) in ('admin','asesor','lector'));
-- Defense in depth, in addition to absence of permissive write policies / grants.
create policy bloqueo_no_modificable_asesor on public.puestos as restrictive for update to authenticated
using (estado <> 'bloqueado' or (select public.mi_rol()) = 'admin')
with check (estado <> 'bloqueado' or (select public.mi_rol()) = 'admin');

create function public.auditar_puesto() returns trigger language plpgsql security definer
set search_path = '' as $$
begin
  insert into public.auditoria(puesto_id,actor_id,accion,motivo,antes,despues)
  values (new.id,auth.uid(),coalesce(nullif(current_setting('promarsa.accion',true),''),'actualizar'),
    coalesce(nullif(current_setting('promarsa.motivo',true),''),'Cambio administrativo'),
    to_jsonb(old),to_jsonb(new));
  return new;
end;
$$;
revoke all on function public.auditar_puesto() from public, anon, authenticated;
create trigger puesto_auditoria after update on public.puestos
for each row execute function public.auditar_puesto();

create function public.cambiar_estado_puestos(p_cambios jsonb, p_accion text, p_motivo text default '')
returns setof public.puestos language plpgsql security definer set search_path = '' as $$
declare
  r public.puestos;
  v_rol text := public.mi_rol();
  v_uid uuid := auth.uid();
  v_estado text;
  v_count integer;
begin
  if v_uid is null or v_rol is null or v_rol not in ('admin','asesor') then
    raise exception 'No autorizado' using errcode = '42501';
  end if;
  if p_accion is null or p_accion not in ('separar','liberar','vender','bloquear','desbloquear') then
    raise exception 'Acción inválida';
  end if;
  if p_accion in ('bloquear','desbloquear','vender') and v_rol <> 'admin' then
    raise exception 'Solo el administrador puede realizar esta acción' using errcode = '42501';
  end if;
  if p_accion in ('bloquear','desbloquear','vender') and nullif(btrim(p_motivo),'') is null then
    raise exception 'El motivo es obligatorio';
  end if;
  if p_cambios is null or jsonb_typeof(p_cambios) <> 'array' then raise exception 'Selección inválida'; end if;
  v_count := jsonb_array_length(p_cambios);
  if v_count < 1 or v_count > 1000 then raise exception 'Selecciona entre 1 y 1000 puestos'; end if;
  if exists (select 1 from jsonb_to_recordset(p_cambios) as x(id uuid, version integer) where x.id is null or x.version is null)
    or (select count(distinct x.id) from jsonb_to_recordset(p_cambios) as x(id uuid)) <> v_count
    or (select count(*) from public.puestos p join jsonb_to_recordset(p_cambios) as x(id uuid) on p.id=x.id) <> v_count then
    raise exception 'Puestos o versiones inválidos';
  end if;
  perform set_config('promarsa.accion',p_accion,true);
  perform set_config('promarsa.motivo',coalesce(nullif(btrim(p_motivo),''),p_accion),true);
  -- Fixed lock order prevents bulk deadlocks. Locks and version checks are inside
  -- the same transaction as reservations and audit: any conflict rolls back ALL.
  for r in select p.* from public.puestos p
    join jsonb_to_recordset(p_cambios) as x(id uuid) on p.id=x.id
    order by p.id for update of p
  loop
    if r.version <> (select x.version from jsonb_to_recordset(p_cambios) as x(id uuid,version integer) where x.id=r.id) then
      raise exception 'El puesto % cambió. Actualiza y vuelve a intentar.',r.codigo using errcode = '40001';
    end if;
    if p_accion = 'separar' then
      if r.estado <> 'disponible' then raise exception 'El puesto % no está disponible',r.codigo; end if;
      insert into public.separaciones(puesto_id,asesor_id) values (r.id,v_uid);
      v_estado := 'separado';
    elsif p_accion = 'liberar' then
      if r.estado <> 'separado' or (v_rol <> 'admin' and r.separado_por is distinct from v_uid) then
        raise exception 'Solo puedes liberar tu propia separación' using errcode = '42501';
      end if;
      update public.separaciones set cerrada_en=now(),cierre='liberado' where puesto_id=r.id and cerrada_en is null;
      v_estado := 'disponible';
    elsif p_accion = 'vender' then
      if r.estado <> 'separado' then raise exception 'Se requiere una separación previa'; end if;
      update public.separaciones set cerrada_en=now(),cierre='vendido' where puesto_id=r.id and cerrada_en is null;
      v_estado := 'vendido';
    elsif p_accion = 'bloquear' then
      if r.estado <> 'disponible' then raise exception 'Solo se pueden bloquear puestos disponibles'; end if;
      v_estado := 'bloqueado';
    else
      if r.estado <> 'bloqueado' then raise exception 'Solo se pueden desbloquear puestos bloqueados'; end if;
      v_estado := 'disponible';
    end if;
    return query update public.puestos set estado=v_estado,
      separado_por=case when p_accion='separar' then v_uid when v_estado='disponible' then null else separado_por end,
      motivo_bloqueo=case when v_estado='bloqueado' then btrim(p_motivo) else null end,
      version=version+1,actualizado_en=now()
      where id=r.id returning *;
  end loop;
end;
$$;
revoke all on function public.cambiar_estado_puestos(jsonb,text,text) from public, anon;
grant execute on function public.cambiar_estado_puestos(jsonb,text,text) to authenticated;

create function public.asignar_sectores(p_asignaciones jsonb, p_motivo text)
returns setof public.puestos language plpgsql security definer set search_path = '' as $$
declare r public.puestos; v_count integer; v_sector uuid; v_version integer;
begin
  if public.mi_rol() is distinct from 'admin' then raise exception 'Solo administrador' using errcode='42501'; end if;
  if nullif(btrim(p_motivo),'') is null then raise exception 'El motivo es obligatorio'; end if;
  if p_asignaciones is null or jsonb_typeof(p_asignaciones) <> 'array' then raise exception 'Asignación inválida'; end if;
  v_count := jsonb_array_length(p_asignaciones);
  if v_count < 1 or v_count > 1000 then raise exception 'Selecciona entre 1 y 1000 puestos'; end if;
  if (select count(distinct x.id) from jsonb_to_recordset(p_asignaciones) as x(id uuid)) <> v_count
    or (select count(*) from jsonb_to_recordset(p_asignaciones) as x(id uuid,sector_id uuid,version integer)
      join public.puestos p on p.id=x.id join public.sectores s on s.id=x.sector_id where x.version is not null) <> v_count
    then raise exception 'Asignaciones inválidas'; end if;
  perform set_config('promarsa.accion','asignar_sector',true);
  perform set_config('promarsa.motivo',btrim(p_motivo),true);
  for r in select p.* from public.puestos p
    join jsonb_to_recordset(p_asignaciones) as x(id uuid) on p.id=x.id order by p.id for update of p
  loop
    select x.sector_id,x.version into v_sector,v_version
    from jsonb_to_recordset(p_asignaciones) as x(id uuid,sector_id uuid,version integer) where x.id=r.id;
    if r.version <> v_version then raise exception 'El puesto % cambió',r.codigo using errcode='40001'; end if;
    return query update public.puestos set sector_id=v_sector,version=version+1,actualizado_en=now()
      where id=r.id returning *;
  end loop;
end;
$$;
revoke all on function public.asignar_sectores(jsonb,text) from public, anon;
grant execute on function public.asignar_sectores(jsonb,text) to authenticated;

-- Invoker function preserves SELECT RLS, unlike a default security-definer view.
create function public.contadores_sectores()
returns table(sector_id uuid, disponibles bigint,separados bigint,vendidos bigint,bloqueados bigint,avance numeric)
language sql stable security invoker set search_path = '' as $$
  select s.id,
    count(p.id) filter (where p.estado='disponible'), count(p.id) filter (where p.estado='separado'),
    count(p.id) filter (where p.estado='vendido'), count(p.id) filter (where p.estado='bloqueado'),
    coalesce(round(100.0 * count(p.id) filter (where p.estado='vendido') /
      nullif(count(p.id) filter (where p.estado<>'bloqueado'),0),1),0)
  from public.sectores s left join public.puestos p on p.sector_id=s.id group by s.id;
$$;
revoke all on function public.contadores_sectores() from public, anon;
grant execute on function public.contadores_sectores() to authenticated;
do $$
begin
  if exists(select 1 from pg_publication where pubname='supabase_realtime') then
    alter publication supabase_realtime add table public.puestos, public.sectores;
  end if;
end $$;
