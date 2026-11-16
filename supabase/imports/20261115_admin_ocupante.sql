-- Tablero de administración de puestos (2026-11-15).
-- Agrega datos de ocupante por puesto y funciones que SOLO el rol 'admin'
-- puede ejecutar para ocupar (con datos) o liberar un puesto.
-- El plano público (consultar_plano_publico) NO expone estos datos: la
-- privacidad se mantiene porque esa función ya devuelve un objeto curado
-- sin el campo ocupante. Solo un admin autenticado lee la tabla completa.
begin;

alter table public.puestos add column if not exists ocupante jsonb;

-- Ocupar un puesto con los datos del ocupante (admin). Deja estado='vendido'.
create or replace function public.admin_ocupar(p_id uuid, p_version integer, p_ocupante jsonb)
returns public.puestos language plpgsql security definer set search_path = '' as $$
declare
  r public.puestos;
  v_rol text := public.mi_rol();
begin
  if (select auth.uid()) is null or v_rol <> 'admin' then
    raise exception 'Solo el administrador puede ocupar un puesto' using errcode = '42501';
  end if;
  if p_ocupante is null or nullif(btrim(coalesce(p_ocupante->>'nombre','')),'') is null then
    raise exception 'El nombre del ocupante es obligatorio';
  end if;
  select * into r from public.puestos where id = p_id for update;
  if not found then raise exception 'Puesto no encontrado'; end if;
  if r.version <> p_version then
    raise exception 'El puesto % cambió. Actualiza y vuelve a intentar.', r.codigo using errcode = '40001';
  end if;
  if r.estado not in ('disponible','separado','bloqueado') then
    raise exception 'El puesto % ya está ocupado', r.codigo;
  end if;
  perform set_config('promarsa.accion','ocupar',true);
  perform set_config('promarsa.motivo', left(coalesce(nullif(btrim(p_ocupante->>'nombre',''),''),'ocupar'), 200), true);
  update public.separaciones set cerrada_en = now(), cierre = 'vendido' where puesto_id = p_id and cerrada_en is null;
  update public.puestos set
    estado = 'vendido', ocupante = p_ocupante,
    separado_por = null, motivo_bloqueo = null,
    version = version + 1, actualizado_en = now()
  where id = p_id returning * into r;
  return r;
end;
$$;
revoke all on function public.admin_ocupar(uuid,integer,jsonb) from public, anon;
grant execute on function public.admin_ocupar(uuid,integer,jsonb) to authenticated;

-- Liberar un puesto: vuelve a 'disponible' y borra los datos del ocupante (admin).
create or replace function public.admin_liberar(p_id uuid, p_version integer)
returns public.puestos language plpgsql security definer set search_path = '' as $$
declare
  r public.puestos;
  v_rol text := public.mi_rol();
begin
  if (select auth.uid()) is null or v_rol <> 'admin' then
    raise exception 'Solo el administrador puede liberar un puesto' using errcode = '42501';
  end if;
  select * into r from public.puestos where id = p_id for update;
  if not found then raise exception 'Puesto no encontrado'; end if;
  if r.version <> p_version then
    raise exception 'El puesto % cambió. Actualiza y vuelve a intentar.', r.codigo using errcode = '40001';
  end if;
  perform set_config('promarsa.accion','liberar',true);
  perform set_config('promarsa.motivo','liberado por administrador',true);
  update public.separaciones set cerrada_en = now(), cierre = 'liberado' where puesto_id = p_id and cerrada_en is null;
  update public.puestos set
    estado = 'disponible', ocupante = null,
    separado_por = null, motivo_bloqueo = null,
    version = version + 1, actualizado_en = now()
  where id = p_id returning * into r;
  return r;
end;
$$;
revoke all on function public.admin_liberar(uuid,integer) from public, anon;
grant execute on function public.admin_liberar(uuid,integer) to authenticated;

commit;
