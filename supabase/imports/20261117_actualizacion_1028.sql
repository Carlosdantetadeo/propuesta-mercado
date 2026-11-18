-- Sync to "TABLA_DE_MERCADO_1028-17-11.md" (2026-11-17). SHA256: 189a773ce9a1a62d4a59feb4d9c38bd447163ddb36dc1dbd6b811d84ea7b869f
-- Markdown export of the single-STATUS-column source, same taxonomy as the 2026-11-14 refresh.
-- 43 renamed (zone prefix only, same rubro), 3 flip to vendido, 0 price changes.
-- Skips rows currently separado/bloqueado: those are live app transactions.
-- Review before running. Not applied from this machine (no production credentials here).
do $$
declare
  v_total integer;
  v_omitidos text[] := '{}';
begin
  lock table public.puestos in share row exclusive mode;

  if exists (select 1 from public.puestos where codigo='V-41' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-41');
  else
    update public.puestos set codigo='A-41', version=version+1, actualizado_en=now() where codigo='V-41';
  end if;
  if exists (select 1 from public.puestos where codigo='V-42' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-42');
  else
    update public.puestos set codigo='A-42', version=version+1, actualizado_en=now() where codigo='V-42';
  end if;
  if exists (select 1 from public.puestos where codigo='V-43' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-43');
  else
    update public.puestos set codigo='A-43', version=version+1, actualizado_en=now() where codigo='V-43';
  end if;
  if exists (select 1 from public.puestos where codigo='V-44' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-44');
  else
    update public.puestos set codigo='A-44', version=version+1, actualizado_en=now() where codigo='V-44';
  end if;
  if exists (select 1 from public.puestos where codigo='V-45' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-45');
  else
    update public.puestos set codigo='A-45', version=version+1, actualizado_en=now() where codigo='V-45';
  end if;
  if exists (select 1 from public.puestos where codigo='V-46' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-46');
  else
    update public.puestos set codigo='A-46', version=version+1, actualizado_en=now() where codigo='V-46';
  end if;
  if exists (select 1 from public.puestos where codigo='A-71' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-71');
  else
    update public.puestos set codigo='V-71', version=version+1, actualizado_en=now() where codigo='A-71';
  end if;
  if exists (select 1 from public.puestos where codigo='A-73' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-73');
  else
    update public.puestos set codigo='V-73', version=version+1, actualizado_en=now() where codigo='A-73';
  end if;
  if exists (select 1 from public.puestos where codigo='A-75' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-75');
  else
    update public.puestos set codigo='V-75', version=version+1, actualizado_en=now() where codigo='A-75';
  end if;
  if exists (select 1 from public.puestos where codigo='A-76' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-76');
  else
    update public.puestos set codigo='V-76', version=version+1, actualizado_en=now() where codigo='A-76';
  end if;
  if exists (select 1 from public.puestos where codigo='A-77' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-77');
  else
    update public.puestos set codigo='V-77', version=version+1, actualizado_en=now() where codigo='A-77';
  end if;
  if exists (select 1 from public.puestos where codigo='A-78' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-78');
  else
    update public.puestos set codigo='V-78', version=version+1, actualizado_en=now() where codigo='A-78';
  end if;
  if exists (select 1 from public.puestos where codigo='A-79' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-79');
  else
    update public.puestos set codigo='V-79', version=version+1, actualizado_en=now() where codigo='A-79';
  end if;
  if exists (select 1 from public.puestos where codigo='A-80' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-80');
  else
    update public.puestos set codigo='V-80', version=version+1, actualizado_en=now() where codigo='A-80';
  end if;
  if exists (select 1 from public.puestos where codigo='A-161' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-161');
  else
    update public.puestos set codigo='V-161', version=version+1, actualizado_en=now() where codigo='A-161';
  end if;
  if exists (select 1 from public.puestos where codigo='A-162' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-162');
  else
    update public.puestos set codigo='V-162', version=version+1, actualizado_en=now() where codigo='A-162';
  end if;
  if exists (select 1 from public.puestos where codigo='A-163' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-163');
  else
    update public.puestos set codigo='V-163', version=version+1, actualizado_en=now() where codigo='A-163';
  end if;
  if exists (select 1 from public.puestos where codigo='A-164' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-164');
  else
    update public.puestos set codigo='V-164', version=version+1, actualizado_en=now() where codigo='A-164';
  end if;
  if exists (select 1 from public.puestos where codigo='A-165' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-165');
  else
    update public.puestos set codigo='V-165', version=version+1, actualizado_en=now() where codigo='A-165';
  end if;
  if exists (select 1 from public.puestos where codigo='A-166' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-166');
  else
    update public.puestos set codigo='V-166', version=version+1, actualizado_en=now() where codigo='A-166';
  end if;
  if exists (select 1 from public.puestos where codigo='A-167' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-167');
  else
    update public.puestos set codigo='V-167', version=version+1, actualizado_en=now() where codigo='A-167';
  end if;
  if exists (select 1 from public.puestos where codigo='A-168' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-168');
  else
    update public.puestos set codigo='V-168', version=version+1, actualizado_en=now() where codigo='A-168';
  end if;
  if exists (select 1 from public.puestos where codigo='A-169' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-169');
  else
    update public.puestos set codigo='V-169', version=version+1, actualizado_en=now() where codigo='A-169';
  end if;
  if exists (select 1 from public.puestos where codigo='A-170' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-170');
  else
    update public.puestos set codigo='V-170', version=version+1, actualizado_en=now() where codigo='A-170';
  end if;
  if exists (select 1 from public.puestos where codigo='A-251' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-251');
  else
    update public.puestos set codigo='V-251', version=version+1, actualizado_en=now() where codigo='A-251';
  end if;
  if exists (select 1 from public.puestos where codigo='A-252' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-252');
  else
    update public.puestos set codigo='V-252', version=version+1, actualizado_en=now() where codigo='A-252';
  end if;
  if exists (select 1 from public.puestos where codigo='A-253' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-253');
  else
    update public.puestos set codigo='V-253', version=version+1, actualizado_en=now() where codigo='A-253';
  end if;
  if exists (select 1 from public.puestos where codigo='A-254' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-254');
  else
    update public.puestos set codigo='V-254', version=version+1, actualizado_en=now() where codigo='A-254';
  end if;
  if exists (select 1 from public.puestos where codigo='A-255' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-255');
  else
    update public.puestos set codigo='V-255', version=version+1, actualizado_en=now() where codigo='A-255';
  end if;
  if exists (select 1 from public.puestos where codigo='A-256' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-256');
  else
    update public.puestos set codigo='V-256', version=version+1, actualizado_en=now() where codigo='A-256';
  end if;
  if exists (select 1 from public.puestos where codigo='A-257' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-257');
  else
    update public.puestos set codigo='V-257', version=version+1, actualizado_en=now() where codigo='A-257';
  end if;
  if exists (select 1 from public.puestos where codigo='A-258' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-258');
  else
    update public.puestos set codigo='V-258', version=version+1, actualizado_en=now() where codigo='A-258';
  end if;
  if exists (select 1 from public.puestos where codigo='A-259' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-259');
  else
    update public.puestos set codigo='V-259', version=version+1, actualizado_en=now() where codigo='A-259';
  end if;
  if exists (select 1 from public.puestos where codigo='A-260' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-260');
  else
    update public.puestos set codigo='V-260', version=version+1, actualizado_en=now() where codigo='A-260';
  end if;
  if exists (select 1 from public.puestos where codigo='A-261' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-261');
  else
    update public.puestos set codigo='V-261', version=version+1, actualizado_en=now() where codigo='A-261';
  end if;
  if exists (select 1 from public.puestos where codigo='A-262' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-262');
  else
    update public.puestos set codigo='V-262', version=version+1, actualizado_en=now() where codigo='A-262';
  end if;
  if exists (select 1 from public.puestos where codigo='A-263' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-263');
  else
    update public.puestos set codigo='V-263', version=version+1, actualizado_en=now() where codigo='A-263';
  end if;
  if exists (select 1 from public.puestos where codigo='A-265' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-265');
  else
    update public.puestos set codigo='V-265', version=version+1, actualizado_en=now() where codigo='A-265';
  end if;
  if exists (select 1 from public.puestos where codigo='A-266' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-266');
  else
    update public.puestos set codigo='V-266', version=version+1, actualizado_en=now() where codigo='A-266';
  end if;
  if exists (select 1 from public.puestos where codigo='A-267' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-267');
  else
    update public.puestos set codigo='V-267', version=version+1, actualizado_en=now() where codigo='A-267';
  end if;
  if exists (select 1 from public.puestos where codigo='A-268' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-268');
  else
    update public.puestos set codigo='V-268', version=version+1, actualizado_en=now() where codigo='A-268';
  end if;
  if exists (select 1 from public.puestos where codigo='A-269' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-269');
  else
    update public.puestos set codigo='V-269', version=version+1, actualizado_en=now() where codigo='A-269';
  end if;
  if exists (select 1 from public.puestos where codigo='A-270' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-270');
  else
    update public.puestos set codigo='V-270', version=version+1, actualizado_en=now() where codigo='A-270';
  end if;
  if exists (select 1 from public.puestos where codigo='A-91' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-91');
  else
    update public.puestos set estado='vendido', version=version+1, actualizado_en=now() where codigo='A-91';
  end if;
  if exists (select 1 from public.puestos where codigo='V-208' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-208');
  else
    update public.puestos set estado='vendido', version=version+1, actualizado_en=now() where codigo='V-208';
  end if;
  if exists (select 1 from public.puestos where codigo='V-247' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-247');
  else
    update public.puestos set estado='vendido', version=version+1, actualizado_en=now() where codigo='V-247';
  end if;

  select count(*) into v_total from public.puestos;
  if v_total <> 1028 then raise exception 'Conteo final inesperado: %', v_total; end if;
  raise notice '% filas no tocadas por estar separado/bloqueado (revisar a mano): %', coalesce(array_length(v_omitidos,1),0), v_omitidos;
end $$;
