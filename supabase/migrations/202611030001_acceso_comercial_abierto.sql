-- Acceso comercial abierto: cualquiera puede separar/liberar un puesto sin
-- iniciar sesion. No se registra quien lo hizo (separado_por queda null).
-- Vender, bloquear, desbloquear y reasignar sector siguen exigiendo una
-- cuenta autenticada con rol admin (cambiar_estado_puestos / asignar_sectores,
-- sin cambios en esta migracion).
create function public.separar_o_liberar_publico(p_cambios jsonb, p_accion text)
returns setof public.puestos language plpgsql security definer set search_path = '' as $$
declare
  r public.puestos;
  v_estado text;
  v_count integer;
begin
  if p_accion is null or p_accion not in ('separar','liberar') then
    raise exception 'Acción inválida';
  end if;
  if p_cambios is null or jsonb_typeof(p_cambios) <> 'array' then raise exception 'Selección inválida'; end if;
  v_count := jsonb_array_length(p_cambios);
  if v_count < 1 or v_count > 20 then raise exception 'Selecciona entre 1 y 20 puestos'; end if;
  if exists (select 1 from jsonb_to_recordset(p_cambios) as x(id uuid, version integer) where x.id is null or x.version is null)
    or (select count(distinct x.id) from jsonb_to_recordset(p_cambios) as x(id uuid)) <> v_count
    or (select count(*) from public.puestos p join jsonb_to_recordset(p_cambios) as x(id uuid) on p.id=x.id) <> v_count then
    raise exception 'Puestos o versiones inválidos';
  end if;
  perform set_config('promarsa.accion',p_accion,true);
  perform set_config('promarsa.motivo','Acceso comercial abierto (sin cuenta)',true);
  for r in select p.* from public.puestos p
    join jsonb_to_recordset(p_cambios) as x(id uuid) on p.id=x.id
    order by p.id for update of p
  loop
    if r.version <> (select x.version from jsonb_to_recordset(p_cambios) as x(id uuid,version integer) where x.id=r.id) then
      raise exception 'El puesto % cambió. Actualiza y vuelve a intentar.',r.codigo using errcode = '40001';
    end if;
    if p_accion = 'separar' then
      if r.estado <> 'disponible' then raise exception 'El puesto % no está disponible',r.codigo; end if;
      v_estado := 'separado';
    else
      if r.estado <> 'separado' then raise exception 'El puesto % no está separado',r.codigo; end if;
      v_estado := 'disponible';
    end if;
    return query update public.puestos set estado=v_estado,
      separado_por=null,
      version=version+1,actualizado_en=now()
      where id=r.id returning *;
  end loop;
end;
$$;
revoke all on function public.separar_o_liberar_publico(jsonb,text) from public;
grant execute on function public.separar_o_liberar_publico(jsonb,text) to anon, authenticated;
