-- Sync to "TABLA DE MERCADO 1028 - SUPER OFICIAL PROMMASA ACTUALIZADOok.xlsx" (2026-11-14). SHA256: ee5987febb7a77091fde26ff6126dfffb0e88c0a3fcfaa59aed9ae57b0d4a4b3
-- Single-STATUS-column source (no more H/M ambiguity): 607 vendido / 421 disponible overall.
-- 10 renamed (zone prefix only, same rubro), 2 flip to vendido, 74 price corrections.
-- Skips rows currently separado/bloqueado: those are live app transactions.
-- Review before running. Not applied from this machine (no production credentials here).
do $$
declare
  v_total integer;
  v_omitidos text[] := '{}';
begin
  lock table public.puestos in share row exclusive mode;

  if exists (select 1 from public.puestos where codigo='V-291' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-291');
  else
    update public.puestos set codigo='A-291', version=version+1, actualizado_en=now() where codigo='V-291';
  end if;
  if exists (select 1 from public.puestos where codigo='V-292' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-292');
  else
    update public.puestos set codigo='A-292', version=version+1, actualizado_en=now() where codigo='V-292';
  end if;
  if exists (select 1 from public.puestos where codigo='V-293' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-293');
  else
    update public.puestos set codigo='A-293', version=version+1, actualizado_en=now() where codigo='V-293';
  end if;
  if exists (select 1 from public.puestos where codigo='V-294' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-294');
  else
    update public.puestos set codigo='A-294', version=version+1, actualizado_en=now() where codigo='V-294';
  end if;
  if exists (select 1 from public.puestos where codigo='V-295' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-295');
  else
    update public.puestos set codigo='A-295', version=version+1, actualizado_en=now() where codigo='V-295';
  end if;
  if exists (select 1 from public.puestos where codigo='V-296' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-296');
  else
    update public.puestos set codigo='A-296', version=version+1, actualizado_en=now() where codigo='V-296';
  end if;
  if exists (select 1 from public.puestos where codigo='V-297' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-297');
  else
    update public.puestos set codigo='A-297', version=version+1, actualizado_en=now() where codigo='V-297';
  end if;
  if exists (select 1 from public.puestos where codigo='V-298' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-298');
  else
    update public.puestos set codigo='A-298', version=version+1, actualizado_en=now() where codigo='V-298';
  end if;
  if exists (select 1 from public.puestos where codigo='V-299' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-299');
  else
    update public.puestos set codigo='A-299', version=version+1, actualizado_en=now() where codigo='V-299';
  end if;
  if exists (select 1 from public.puestos where codigo='V-300' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-300');
  else
    update public.puestos set codigo='A-300', version=version+1, actualizado_en=now() where codigo='V-300';
  end if;
  if exists (select 1 from public.puestos where codigo='V-121' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'V-121');
  else
    update public.puestos set estado='vendido', version=version+1, actualizado_en=now() where codigo='V-121';
  end if;
  if exists (select 1 from public.puestos where codigo='A-706' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-706');
  else
    update public.puestos set estado='vendido', version=version+1, actualizado_en=now() where codigo='A-706';
  end if;
  if exists (select 1 from public.puestos where codigo='A-877' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-877');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-877';
  end if;
  if exists (select 1 from public.puestos where codigo='A-878' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-878');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-878';
  end if;
  if exists (select 1 from public.puestos where codigo='A-879' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-879');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-879';
  end if;
  if exists (select 1 from public.puestos where codigo='A-880' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-880');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-880';
  end if;
  if exists (select 1 from public.puestos where codigo='A-881' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-881');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-881';
  end if;
  if exists (select 1 from public.puestos where codigo='A-882' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-882');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-882';
  end if;
  if exists (select 1 from public.puestos where codigo='A-883' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-883');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-883';
  end if;
  if exists (select 1 from public.puestos where codigo='A-884' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-884');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-884';
  end if;
  if exists (select 1 from public.puestos where codigo='A-885' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-885');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-885';
  end if;
  if exists (select 1 from public.puestos where codigo='A-886' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-886');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-886';
  end if;
  if exists (select 1 from public.puestos where codigo='A-887' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-887');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-887';
  end if;
  if exists (select 1 from public.puestos where codigo='A-888' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-888');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-888';
  end if;
  if exists (select 1 from public.puestos where codigo='A-889' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-889');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-889';
  end if;
  if exists (select 1 from public.puestos where codigo='A-890' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-890');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-890';
  end if;
  if exists (select 1 from public.puestos where codigo='A-891' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-891');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-891';
  end if;
  if exists (select 1 from public.puestos where codigo='A-892' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-892');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-892';
  end if;
  if exists (select 1 from public.puestos where codigo='A-893' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-893');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-893';
  end if;
  if exists (select 1 from public.puestos where codigo='A-894' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-894');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-894';
  end if;
  if exists (select 1 from public.puestos where codigo='A-895' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-895');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-895';
  end if;
  if exists (select 1 from public.puestos where codigo='A-896' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-896');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-896';
  end if;
  if exists (select 1 from public.puestos where codigo='A-897' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-897');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-897';
  end if;
  if exists (select 1 from public.puestos where codigo='A-898' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-898');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-898';
  end if;
  if exists (select 1 from public.puestos where codigo='A-899' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-899');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-899';
  end if;
  if exists (select 1 from public.puestos where codigo='A-900' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-900');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-900';
  end if;
  if exists (select 1 from public.puestos where codigo='A-901' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-901');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-901';
  end if;
  if exists (select 1 from public.puestos where codigo='A-902' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-902');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-902';
  end if;
  if exists (select 1 from public.puestos where codigo='A-903' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-903');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-903';
  end if;
  if exists (select 1 from public.puestos where codigo='A-904' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-904');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-904';
  end if;
  if exists (select 1 from public.puestos where codigo='A-905' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-905');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-905';
  end if;
  if exists (select 1 from public.puestos where codigo='A-906' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-906');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-906';
  end if;
  if exists (select 1 from public.puestos where codigo='A-907' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-907');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-907';
  end if;
  if exists (select 1 from public.puestos where codigo='A-908' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-908');
  else
    update public.puestos set precio=66000, version=version+1, actualizado_en=now() where codigo='A-908';
  end if;
  if exists (select 1 from public.puestos where codigo='A-909' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-909');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-909';
  end if;
  if exists (select 1 from public.puestos where codigo='A-910' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'A-910');
  else
    update public.puestos set precio=71000, version=version+1, actualizado_en=now() where codigo='A-910';
  end if;
  if exists (select 1 from public.puestos where codigo='S-911' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-911');
  else
    update public.puestos set precio=88000, version=version+1, actualizado_en=now() where codigo='S-911';
  end if;
  if exists (select 1 from public.puestos where codigo='S-912' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-912');
  else
    update public.puestos set precio=88000, version=version+1, actualizado_en=now() where codigo='S-912';
  end if;
  if exists (select 1 from public.puestos where codigo='S-913' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-913');
  else
    update public.puestos set precio=88000, version=version+1, actualizado_en=now() where codigo='S-913';
  end if;
  if exists (select 1 from public.puestos where codigo='S-916' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-916');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-916';
  end if;
  if exists (select 1 from public.puestos where codigo='S-917' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-917');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-917';
  end if;
  if exists (select 1 from public.puestos where codigo='S-918' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-918');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-918';
  end if;
  if exists (select 1 from public.puestos where codigo='S-923' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-923');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-923';
  end if;
  if exists (select 1 from public.puestos where codigo='S-924' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-924');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-924';
  end if;
  if exists (select 1 from public.puestos where codigo='S-925' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-925');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-925';
  end if;
  if exists (select 1 from public.puestos where codigo='S-926' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-926');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-926';
  end if;
  if exists (select 1 from public.puestos where codigo='S-927' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-927');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-927';
  end if;
  if exists (select 1 from public.puestos where codigo='S-928' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-928');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-928';
  end if;
  if exists (select 1 from public.puestos where codigo='S-929' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-929');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-929';
  end if;
  if exists (select 1 from public.puestos where codigo='S-930' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-930');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-930';
  end if;
  if exists (select 1 from public.puestos where codigo='S-931' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-931');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-931';
  end if;
  if exists (select 1 from public.puestos where codigo='S-932' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-932');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-932';
  end if;
  if exists (select 1 from public.puestos where codigo='S-933' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-933');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-933';
  end if;
  if exists (select 1 from public.puestos where codigo='S-934' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-934');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-934';
  end if;
  if exists (select 1 from public.puestos where codigo='S-935' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-935');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-935';
  end if;
  if exists (select 1 from public.puestos where codigo='S-936' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-936');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-936';
  end if;
  if exists (select 1 from public.puestos where codigo='S-937' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-937');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-937';
  end if;
  if exists (select 1 from public.puestos where codigo='S-938' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-938');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-938';
  end if;
  if exists (select 1 from public.puestos where codigo='S-939' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-939');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-939';
  end if;
  if exists (select 1 from public.puestos where codigo='S-940' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-940');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-940';
  end if;
  if exists (select 1 from public.puestos where codigo='S-941' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-941');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-941';
  end if;
  if exists (select 1 from public.puestos where codigo='S-942' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-942');
  else
    update public.puestos set precio=88000, version=version+1, actualizado_en=now() where codigo='S-942';
  end if;
  if exists (select 1 from public.puestos where codigo='S-943' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-943');
  else
    update public.puestos set precio=88000, version=version+1, actualizado_en=now() where codigo='S-943';
  end if;
  if exists (select 1 from public.puestos where codigo='S-944' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-944');
  else
    update public.puestos set precio=88000, version=version+1, actualizado_en=now() where codigo='S-944';
  end if;
  if exists (select 1 from public.puestos where codigo='S-945' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-945');
  else
    update public.puestos set precio=88000, version=version+1, actualizado_en=now() where codigo='S-945';
  end if;
  if exists (select 1 from public.puestos where codigo='S-946' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-946');
  else
    update public.puestos set precio=88000, version=version+1, actualizado_en=now() where codigo='S-946';
  end if;
  if exists (select 1 from public.puestos where codigo='S-947' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-947');
  else
    update public.puestos set precio=88000, version=version+1, actualizado_en=now() where codigo='S-947';
  end if;
  if exists (select 1 from public.puestos where codigo='S-948' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-948');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-948';
  end if;
  if exists (select 1 from public.puestos where codigo='S-949' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-949');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-949';
  end if;
  if exists (select 1 from public.puestos where codigo='S-950' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-950');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-950';
  end if;
  if exists (select 1 from public.puestos where codigo='S-951' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-951');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-951';
  end if;
  if exists (select 1 from public.puestos where codigo='S-952' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-952');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-952';
  end if;
  if exists (select 1 from public.puestos where codigo='S-953' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-953');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-953';
  end if;
  if exists (select 1 from public.puestos where codigo='S-954' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-954');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-954';
  end if;
  if exists (select 1 from public.puestos where codigo='S-955' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-955');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-955';
  end if;
  if exists (select 1 from public.puestos where codigo='S-956' and estado in ('separado','bloqueado')) then
    v_omitidos := array_append(v_omitidos, 'S-956');
  else
    update public.puestos set precio=82000, version=version+1, actualizado_en=now() where codigo='S-956';
  end if;

  select count(*) into v_total from public.puestos;
  if v_total <> 1028 then raise exception 'Conteo final inesperado: %', v_total; end if;
  raise notice '% filas no tocadas por estar separado/bloqueado (revisar a mano): %', coalesce(array_length(v_omitidos,1),0), v_omitidos;
end $$;
