-- Marca como vendidos los 76 puestos de servicios (S-911..S-986), segun la
-- actualizacion del Excel oficial del 2026-11-15 (bancos, telefonia, farmacia,
-- apuestas, libreria, etc. pasan de disponible a VENDIDO).
-- Respeta separaciones en curso; tambien convierte si quedaron 'bloqueado'.
-- Reescrito 2026-11-17 como un unico bloque DO: la version anterior usaba una
-- tabla temporal "on commit drop" para registrar omitidos, pero el runner de
-- SQL usado para ejecutar esto no mantiene una sola sesion/transaccion entre
-- statements separados por ';' -- la tabla se borraba antes del primer INSERT
-- (error 42P01: relation "_omitidos" does not exist). Al ser un solo statement
-- no depende de eso.
do $$
declare
  v_total integer;
  v_omitidos text[] := '{}';
  v_codigo text;
begin
  lock table public.puestos in share row exclusive mode;

  foreach v_codigo in array array[
    'S-911','S-912','S-913','S-914','S-915','S-916','S-917','S-918','S-919','S-920',
    'S-921','S-922','S-923','S-924','S-925','S-926','S-927','S-928','S-929','S-930',
    'S-931','S-932','S-933','S-934','S-935','S-936','S-937','S-938','S-939','S-940',
    'S-941','S-942','S-943','S-944','S-945','S-946','S-947','S-948','S-949','S-950',
    'S-951','S-952','S-953','S-954','S-955','S-956','S-957','S-958','S-959','S-960',
    'S-961','S-962','S-963','S-964','S-965','S-966','S-967','S-968','S-969','S-970',
    'S-971','S-972','S-973','S-974','S-975','S-976','S-977','S-978','S-979','S-980',
    'S-981','S-982','S-983','S-984','S-985','S-986'
  ] loop
    if exists (select 1 from public.puestos where codigo = v_codigo and estado = 'separado') then
      v_omitidos := array_append(v_omitidos, v_codigo);
    else
      update public.puestos
      set estado = 'vendido', motivo_bloqueo = null, version = version + 1, actualizado_en = now()
      where codigo = v_codigo and estado in ('disponible', 'bloqueado');
    end if;
  end loop;

  select count(*) into v_total from public.puestos where estado = 'vendido';
  raise notice '% puestos vendido en total (esperado 683)', v_total;

  select count(*) into v_total from public.puestos;
  if v_total <> 1028 then
    raise exception 'Conteo final inesperado: %', v_total;
  end if;

  raise notice '% filas omitidas por estar separado (revisar a mano): %', coalesce(array_length(v_omitidos, 1), 0), v_omitidos;
end $$;
