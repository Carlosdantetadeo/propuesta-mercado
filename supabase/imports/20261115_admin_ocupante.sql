-- Tablero de administración de puestos (2026-11-15).
-- Correr cada instrucción; NO envolver en begin/commit para que la columna
-- se agregue aunque algo más falle. Funciones en lenguaje SQL (una sola
-- instrucción) para evitar que editores partan el cuerpo en los ';'.
-- El plano público (consultar_plano_publico) NO expone estos datos.

-- 1) Columna de datos del ocupante
alter table public.puestos add column if not exists ocupante jsonb;

-- 2) Ocupar (solo admin): deja estado='vendido' y guarda los datos.
create or replace function public.admin_ocupar(p_id uuid, p_version integer, p_ocupante jsonb)
returns setof public.puestos language sql security definer set search_path = '' as $$
  update public.puestos
     set estado='vendido', ocupante=p_ocupante, separado_por=null, motivo_bloqueo=null,
         version=version+1, actualizado_en=now()
   where id=p_id and version=p_version
     and (select public.mi_rol())='admin'
     and estado in ('disponible','separado','bloqueado')
     and coalesce(btrim(p_ocupante->>'nombre'),'') <> ''
  returning *;
$$;

-- 3) Liberar (solo admin): vuelve a 'disponible' y borra los datos.
create or replace function public.admin_liberar(p_id uuid, p_version integer)
returns setof public.puestos language sql security definer set search_path = '' as $$
  update public.puestos
     set estado='disponible', ocupante=null, separado_por=null, motivo_bloqueo=null,
         version=version+1, actualizado_en=now()
   where id=p_id and version=p_version and (select public.mi_rol())='admin'
  returning *;
$$;

-- 4) Permisos
grant execute on function public.admin_ocupar(uuid,integer,jsonb) to authenticated;
grant execute on function public.admin_liberar(uuid,integer) to authenticated;
