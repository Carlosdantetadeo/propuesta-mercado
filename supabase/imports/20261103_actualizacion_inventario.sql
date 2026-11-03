-- Market table refresh. Source date: 2026-11-03. Source SHA256: 805560fc38ba774bc17acd0b3413ba8419cd57f897bab8eba0acbcb835cad1a8
-- Skips rows currently separado/bloqueado: those are live app transactions, not stale PDF state.
-- Review before running. Not applied from this machine (no production credentials here).
begin;
lock table public.puestos, public.sectores in share row exclusive mode;
create temporary table _omitidos(codigo text, estado text) on commit drop;
insert into _omitidos select 'C-915', estado from public.puestos where codigo='C-915' and estado in ('separado','bloqueado');
update public.puestos set codigo='S-915', sector_id=(select id from public.sectores where nombre='APUESTAS'), precio=82000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='C-915' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-916', estado from public.puestos where codigo='C-916' and estado in ('separado','bloqueado');
update public.puestos set codigo='S-916', sector_id=(select id from public.sectores where nombre='APUESTAS'), precio=88000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='C-916' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-917', estado from public.puestos where codigo='C-917' and estado in ('separado','bloqueado');
update public.puestos set codigo='S-917', sector_id=(select id from public.sectores where nombre='APUESTAS'), precio=88000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='C-917' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-918', estado from public.puestos where codigo='C-918' and estado in ('separado','bloqueado');
update public.puestos set codigo='S-918', sector_id=(select id from public.sectores where nombre='APUESTAS'), precio=88000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='C-918' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-113', estado from public.puestos where codigo='A-113' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='ROPA'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-113' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-131', estado from public.puestos where codigo='A-131' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='POLLO'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-131' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-161', estado from public.puestos where codigo='A-161' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='ROPA'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-161' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-163', estado from public.puestos where codigo='A-163' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='ROPA'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-163' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-164', estado from public.puestos where codigo='A-164' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='ROPA'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-164' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-2', estado from public.puestos where codigo='A-2' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='CARNE'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-2' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-292', estado from public.puestos where codigo='A-292' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='BAZAR'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-292' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-378', estado from public.puestos where codigo='A-378' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='JUGUERIA'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-378' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-379', estado from public.puestos where codigo='A-379' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='JUGUERIA'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-379' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-381', estado from public.puestos where codigo='A-381' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-381' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-382', estado from public.puestos where codigo='A-382' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-382' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-383', estado from public.puestos where codigo='A-383' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-383' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-385', estado from public.puestos where codigo='A-385' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-385' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-387', estado from public.puestos where codigo='A-387' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-387' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-388', estado from public.puestos where codigo='A-388' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-388' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-389', estado from public.puestos where codigo='A-389' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-389' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-390', estado from public.puestos where codigo='A-390' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-390' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-4', estado from public.puestos where codigo='A-4' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='CARNE'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-4' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-411', estado from public.puestos where codigo='A-411' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-411' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-412', estado from public.puestos where codigo='A-412' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-412' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-414', estado from public.puestos where codigo='A-414' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-414' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-415', estado from public.puestos where codigo='A-415' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-415' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-417', estado from public.puestos where codigo='A-417' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-417' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-418', estado from public.puestos where codigo='A-418' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-418' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-419', estado from public.puestos where codigo='A-419' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-419' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-432', estado from public.puestos where codigo='A-432' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PAPAS Y TUBERCULOS'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-432' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-453', estado from public.puestos where codigo='A-453' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-453' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-460', estado from public.puestos where codigo='A-460' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PRODUCTOS DE LA SIERRA'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-460' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-531', estado from public.puestos where codigo='A-531' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='FRUTOS SECOS'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-531' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-533', estado from public.puestos where codigo='A-533' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='FRUTOS SECOS'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-533' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-607', estado from public.puestos where codigo='A-607' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='TOMATES'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-607' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-608', estado from public.puestos where codigo='A-608' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='TOMATES'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-608' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-609', estado from public.puestos where codigo='A-609' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='TOMATES'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-609' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-610', estado from public.puestos where codigo='A-610' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='TOMATES'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-610' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-615', estado from public.puestos where codigo='A-615' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-615' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-618', estado from public.puestos where codigo='A-618' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-618' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-640', estado from public.puestos where codigo='A-640' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='ABARROTES'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-640' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-647', estado from public.puestos where codigo='A-647' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-647' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-652', estado from public.puestos where codigo='A-652' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-652' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-654', estado from public.puestos where codigo='A-654' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-654' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-656', estado from public.puestos where codigo='A-656' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-656' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-658', estado from public.puestos where codigo='A-658' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-658' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-660', estado from public.puestos where codigo='A-660' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-660' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-664', estado from public.puestos where codigo='A-664' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='GRANOS VERDES'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-664' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-665', estado from public.puestos where codigo='A-665' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='GRANOS VERDES'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-665' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-75', estado from public.puestos where codigo='A-75' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='ROPA'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-75' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-755', estado from public.puestos where codigo='A-755' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-755' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-758', estado from public.puestos where codigo='A-758' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-758' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-768', estado from public.puestos where codigo='A-768' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='CHOCLOS'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-768' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-770', estado from public.puestos where codigo='A-770' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='CHOCLOS'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='A-770' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-819', estado from public.puestos where codigo='A-819' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-819' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-820', estado from public.puestos where codigo='A-820' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='VERDURAS'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-820' and estado not in ('separado','bloqueado');
insert into _omitidos select 'A-825', estado from public.puestos where codigo='A-825' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='FRUTAS'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='A-825' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-919', estado from public.puestos where codigo='C-919' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=82000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-919' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-920', estado from public.puestos where codigo='C-920' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=82000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-920' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-921', estado from public.puestos where codigo='C-921' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=82000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-921' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-922', estado from public.puestos where codigo='C-922' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=82000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-922' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-923', estado from public.puestos where codigo='C-923' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=77000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-923' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-935', estado from public.puestos where codigo='C-935' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=71000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-935' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-936', estado from public.puestos where codigo='C-936' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=71000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-936' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-939', estado from public.puestos where codigo='C-939' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=77000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-939' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-940', estado from public.puestos where codigo='C-940' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=77000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-940' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-945', estado from public.puestos where codigo='C-945' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=71000, area=10, estado='disponible', version=version+1, actualizado_en=now() where codigo='C-945' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-952', estado from public.puestos where codigo='C-952' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=71000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-952' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-953', estado from public.puestos where codigo='C-953' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=71000, area=10, estado='disponible', version=version+1, actualizado_en=now() where codigo='C-953' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-954', estado from public.puestos where codigo='C-954' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=71000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-954' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-955', estado from public.puestos where codigo='C-955' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=71000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-955' and estado not in ('separado','bloqueado');
insert into _omitidos select 'C-956', estado from public.puestos where codigo='C-956' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PATIO DE COMIDAS'), precio=77000, area=10, estado='vendido', version=version+1, actualizado_en=now() where codigo='C-956' and estado not in ('separado','bloqueado');
insert into _omitidos select 'S-912', estado from public.puestos where codigo='S-912' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='TIENDA DE CONVENIENCIA'), precio=82000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='S-912' and estado not in ('separado','bloqueado');
insert into _omitidos select 'S-913', estado from public.puestos where codigo='S-913' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='APUESTAS'), precio=82000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='S-913' and estado not in ('separado','bloqueado');
insert into _omitidos select 'S-914', estado from public.puestos where codigo='S-914' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='APUESTAS'), precio=82000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='S-914' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-133', estado from public.puestos where codigo='V-133' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='POLLO'), precio=66000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='V-133' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-143', estado from public.puestos where codigo='V-143' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='LECHE, HUEVOS QUESOS Y'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-143' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-145', estado from public.puestos where codigo='V-145' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='LECHE, HUEVOS QUESOS Y'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-145' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-158', estado from public.puestos where codigo='V-158' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PLASTICOS Y LIMPIEZA'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-158' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-160', estado from public.puestos where codigo='V-160' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='PLASTICOS Y LIMPIEZA'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-160' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-186', estado from public.puestos where codigo='V-186' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='POLLO'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-186' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-282', estado from public.puestos where codigo='V-282' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='LECHE, HUEVOS QUESOS Y'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-282' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-329', estado from public.puestos where codigo='V-329' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='EMBUTIDOS'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-329' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-349', estado from public.puestos where codigo='V-349' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='JUGUETERIA'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-349' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-357', estado from public.puestos where codigo='V-357' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='POLLO'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-357' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-541', estado from public.puestos where codigo='V-541' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='REGALO'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-541' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-542', estado from public.puestos where codigo='V-542' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='REGALO'), precio=71000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-542' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-543', estado from public.puestos where codigo='V-543' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='REGALO'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-543' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-544', estado from public.puestos where codigo='V-544' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='REGALO'), precio=66000, area=9, estado='vendido', version=version+1, actualizado_en=now() where codigo='V-544' and estado not in ('separado','bloqueado');
insert into _omitidos select 'V-549', estado from public.puestos where codigo='V-549' and estado in ('separado','bloqueado');
update public.puestos set sector_id=(select id from public.sectores where nombre='REGALO'), precio=71000, area=9, estado='disponible', version=version+1, actualizado_en=now() where codigo='V-549' and estado not in ('separado','bloqueado');
with nuevos as (
insert into public.puestos(codigo,sector_id,precio,estado,area,geometria)
select * from (values
('A-1000',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-1001',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-1002',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-1003',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1004',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1005',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1006',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1007',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1008',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1009',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-1010',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-1011',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-1012',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-1013',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1014',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1015',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1016',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1017',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1018',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-1019',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-1020',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-961',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-962',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-963',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-964',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-965',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-966',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-967',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-968',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-969',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-970',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-971',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-972',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-973',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-974',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-975',(select id from public.sectores where nombre='VERDURAS'),66000,'disponible',9::numeric,null::jsonb),
('A-976',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-977',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-978',(select id from public.sectores where nombre='VERDURAS'),66000,'disponible',9::numeric,null::jsonb),
('A-979',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-980',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-981',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-982',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-983',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-984',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-985',(select id from public.sectores where nombre='VERDURAS'),66000,'disponible',9::numeric,null::jsonb),
('A-986',(select id from public.sectores where nombre='VERDURAS'),66000,'disponible',9::numeric,null::jsonb),
('A-987',(select id from public.sectores where nombre='VERDURAS'),66000,'disponible',9::numeric,null::jsonb),
('A-988',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-989',(select id from public.sectores where nombre='VERDURAS'),71000,'disponible',9::numeric,null::jsonb),
('A-990',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-991',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-992',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('A-993',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-994',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-995',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-996',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-997',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-998',(select id from public.sectores where nombre='VERDURAS'),66000,'vendido',9::numeric,null::jsonb),
('A-999',(select id from public.sectores where nombre='VERDURAS'),71000,'vendido',9::numeric,null::jsonb),
('C-957',(select id from public.sectores where nombre='PATIO DE COMIDAS'),82000,'vendido',10::numeric,null::jsonb),
('C-958',(select id from public.sectores where nombre='PATIO DE COMIDAS'),82000,'vendido',10::numeric,null::jsonb),
('C-959',(select id from public.sectores where nombre='PATIO DE COMIDAS'),82000,'vendido',10::numeric,null::jsonb),
('C-960',(select id from public.sectores where nombre='PATIO DE COMIDAS'),82000,'vendido',10::numeric,null::jsonb)
) as v(codigo,sector_id,precio,estado,area,geometria)
returning *) insert into public.auditoria(puesto_id,accion,motivo,despues)
select id,'importar_inventario','TABLA MERCADO 03/11/2026; nuevos puestos sin geometria aun',to_jsonb(nuevos) from nuevos;
do $$ declare v_omitidos integer; begin select count(*) into v_omitidos from _omitidos; raise notice '% filas no tocadas por estar separado/bloqueado (revisar a mano)', v_omitidos; if (select count(*) from public.puestos) <> 956 + 64 then raise exception 'Conteo final inesperado'; end if; end $$;
select codigo, estado from _omitidos;
commit;
