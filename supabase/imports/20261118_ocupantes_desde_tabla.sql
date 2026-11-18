-- Bulk-load buyer names from "TABLA_DE_MERCADO_1028-17-11.md" (2026-11-17) into ocupante. SHA256: 189a773ce9a1a62d4a59feb4d9c38bd447163ddb36dc1dbd6b811d84ea7b869f
-- Requires 202611180001_ocupante_solo_admin.sql to already be applied (ocupante is
-- admin-only from that point on). Only sets nombre + referencia (no documento/telefono
-- in the source). Only touches rows currently estado='vendido'; anything else is
-- skipped and listed at the end for manual review -- never overwritten blind.
do $$
declare
  v_total integer;
  v_omitidos text[] := '{}';
begin
  lock table public.puestos in share row exclusive mode;

  if exists (select 1 from public.puestos where codigo='A-3' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SARA TICONA LOPEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-3';
  else
    v_omitidos := array_append(v_omitidos, 'A-3');
  end if;
  if exists (select 1 from public.puestos where codigo='A-4' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ELVIS GUARDAMINO DELGADILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-4';
  else
    v_omitidos := array_append(v_omitidos, 'A-4');
  end if;
  if exists (select 1 from public.puestos where codigo='A-6' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YURI GUARDAMINO DELGADILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-6';
  else
    v_omitidos := array_append(v_omitidos, 'A-6');
  end if;
  if exists (select 1 from public.puestos where codigo='A-7' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DELSY LAVADO VILLEGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-7';
  else
    v_omitidos := array_append(v_omitidos, 'A-7');
  end if;
  if exists (select 1 from public.puestos where codigo='A-8' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YURI GUARDAMINO DELGADILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-8';
  else
    v_omitidos := array_append(v_omitidos, 'A-8');
  end if;
  if exists (select 1 from public.puestos where codigo='A-9' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DELSY LAVADO VILLEGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-9';
  else
    v_omitidos := array_append(v_omitidos, 'A-9');
  end if;
  if exists (select 1 from public.puestos where codigo='A-10' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YURI GUARDAMINO DELGADILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-10';
  else
    v_omitidos := array_append(v_omitidos, 'A-10');
  end if;
  if exists (select 1 from public.puestos where codigo='A-15' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANDERSON MARAVI MOLINA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-15';
  else
    v_omitidos := array_append(v_omitidos, 'A-15');
  end if;
  if exists (select 1 from public.puestos where codigo='A-17' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANDERSON MARAVI MOLINA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-17';
  else
    v_omitidos := array_append(v_omitidos, 'A-17');
  end if;
  if exists (select 1 from public.puestos where codigo='A-19' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANDERSON MARAVI MOLINA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-19';
  else
    v_omitidos := array_append(v_omitidos, 'A-19');
  end if;
  if exists (select 1 from public.puestos where codigo='V-21' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RAQUEL POLICARPO CASTILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-21';
  else
    v_omitidos := array_append(v_omitidos, 'V-21');
  end if;
  if exists (select 1 from public.puestos where codigo='V-22' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JACINTO CONDORI AYBAR','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-22';
  else
    v_omitidos := array_append(v_omitidos, 'V-22');
  end if;
  if exists (select 1 from public.puestos where codigo='V-23' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RAQUEL POLICARPO CASTILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-23';
  else
    v_omitidos := array_append(v_omitidos, 'V-23');
  end if;
  if exists (select 1 from public.puestos where codigo='V-24' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARCELINA OVIEDO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-24';
  else
    v_omitidos := array_append(v_omitidos, 'V-24');
  end if;
  if exists (select 1 from public.puestos where codigo='V-25' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HECTOR CERVANTES CASTRO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-25';
  else
    v_omitidos := array_append(v_omitidos, 'V-25');
  end if;
  if exists (select 1 from public.puestos where codigo='V-26' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA PARIAMACHE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-26';
  else
    v_omitidos := array_append(v_omitidos, 'V-26');
  end if;
  if exists (select 1 from public.puestos where codigo='V-27' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHON AVENDAÑO CAUSILLAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-27';
  else
    v_omitidos := array_append(v_omitidos, 'V-27');
  end if;
  if exists (select 1 from public.puestos where codigo='V-28' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA PARIAMACHE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-28';
  else
    v_omitidos := array_append(v_omitidos, 'V-28');
  end if;
  if exists (select 1 from public.puestos where codigo='V-29' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHON AVENDAÑO CAUSILLAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-29';
  else
    v_omitidos := array_append(v_omitidos, 'V-29');
  end if;
  if exists (select 1 from public.puestos where codigo='V-30' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA PARIAMACHE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-30';
  else
    v_omitidos := array_append(v_omitidos, 'V-30');
  end if;
  if exists (select 1 from public.puestos where codigo='V-31' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','FERNANDO FONTAL FARIÑAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-31';
  else
    v_omitidos := array_append(v_omitidos, 'V-31');
  end if;
  if exists (select 1 from public.puestos where codigo='V-37' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CIRILA LAGOS GUTIERREZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-37';
  else
    v_omitidos := array_append(v_omitidos, 'V-37');
  end if;
  if exists (select 1 from public.puestos where codigo='V-39' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PILAR MUÑOZ SOLOAGA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-39';
  else
    v_omitidos := array_append(v_omitidos, 'V-39');
  end if;
  if exists (select 1 from public.puestos where codigo='A-47' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GISELA BARZOLA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-47';
  else
    v_omitidos := array_append(v_omitidos, 'A-47');
  end if;
  if exists (select 1 from public.puestos where codigo='A-48' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','IVAN CHIROQUE SANDOVAL','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-48';
  else
    v_omitidos := array_append(v_omitidos, 'A-48');
  end if;
  if exists (select 1 from public.puestos where codigo='A-49' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHELEN EVANGELISTA GARCIA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-49';
  else
    v_omitidos := array_append(v_omitidos, 'A-49');
  end if;
  if exists (select 1 from public.puestos where codigo='A-50' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','IVAN CHIROQUE SANDOVAL','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-50';
  else
    v_omitidos := array_append(v_omitidos, 'A-50');
  end if;
  if exists (select 1 from public.puestos where codigo='V-61' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA CELESTINA SANTOS SANTOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-61';
  else
    v_omitidos := array_append(v_omitidos, 'V-61');
  end if;
  if exists (select 1 from public.puestos where codigo='V-62' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HILARIO GAMEZ ROJAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-62';
  else
    v_omitidos := array_append(v_omitidos, 'V-62');
  end if;
  if exists (select 1 from public.puestos where codigo='V-63' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIANELA LUZ AGUILAR TORRES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-63';
  else
    v_omitidos := array_append(v_omitidos, 'V-63');
  end if;
  if exists (select 1 from public.puestos where codigo='V-64' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HILARIO GAMEZ ROJAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-64';
  else
    v_omitidos := array_append(v_omitidos, 'V-64');
  end if;
  if exists (select 1 from public.puestos where codigo='V-65' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','IVAN CHIROQUE SANDOVAL','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-65';
  else
    v_omitidos := array_append(v_omitidos, 'V-65');
  end if;
  if exists (select 1 from public.puestos where codigo='V-66' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDER ALANIA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-66';
  else
    v_omitidos := array_append(v_omitidos, 'V-66');
  end if;
  if exists (select 1 from public.puestos where codigo='V-67' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSMERI ZEVALLOS MERMA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-67';
  else
    v_omitidos := array_append(v_omitidos, 'V-67');
  end if;
  if exists (select 1 from public.puestos where codigo='V-68' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSMERI ZEVALLOS MERMA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-68';
  else
    v_omitidos := array_append(v_omitidos, 'V-68');
  end if;
  if exists (select 1 from public.puestos where codigo='V-69' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EUFEMIA QUISPE HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-69';
  else
    v_omitidos := array_append(v_omitidos, 'V-69');
  end if;
  if exists (select 1 from public.puestos where codigo='V-70' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','BETTY CACERES APARICIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-70';
  else
    v_omitidos := array_append(v_omitidos, 'V-70');
  end if;
  if exists (select 1 from public.puestos where codigo='V-71' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANDREA ROJAS CASAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-71';
  else
    v_omitidos := array_append(v_omitidos, 'V-71');
  end if;
  if exists (select 1 from public.puestos where codigo='V-72' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LEONILDA CURO SINCHE CURO SINCHE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-72';
  else
    v_omitidos := array_append(v_omitidos, 'V-72');
  end if;
  if exists (select 1 from public.puestos where codigo='V-74' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LEONILDA CURO SINCHE CURO SINCHE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-74';
  else
    v_omitidos := array_append(v_omitidos, 'V-74');
  end if;
  if exists (select 1 from public.puestos where codigo='A-81' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ZONIA RAMOS SIMON','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-81';
  else
    v_omitidos := array_append(v_omitidos, 'A-81');
  end if;
  if exists (select 1 from public.puestos where codigo='A-82' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ELVIS GUARDAMINO DELGADILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-82';
  else
    v_omitidos := array_append(v_omitidos, 'A-82');
  end if;
  if exists (select 1 from public.puestos where codigo='A-83' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN HUARANCA CONDORI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-83';
  else
    v_omitidos := array_append(v_omitidos, 'A-83');
  end if;
  if exists (select 1 from public.puestos where codigo='A-84' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ELVIS GUARDAMINO DELGADILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-84';
  else
    v_omitidos := array_append(v_omitidos, 'A-84');
  end if;
  if exists (select 1 from public.puestos where codigo='A-86' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NASHIRA URETA CAMPOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-86';
  else
    v_omitidos := array_append(v_omitidos, 'A-86');
  end if;
  if exists (select 1 from public.puestos where codigo='A-87' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EUFEMIA QUISPE HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-87';
  else
    v_omitidos := array_append(v_omitidos, 'A-87');
  end if;
  if exists (select 1 from public.puestos where codigo='A-88' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YOSLIN GABRIEL GUIVARRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-88';
  else
    v_omitidos := array_append(v_omitidos, 'A-88');
  end if;
  if exists (select 1 from public.puestos where codigo='A-89' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIA VILMA ELIAS MORE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-89';
  else
    v_omitidos := array_append(v_omitidos, 'A-89');
  end if;
  if exists (select 1 from public.puestos where codigo='A-90' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YOSLIN GABRIEL GUIVARRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-90';
  else
    v_omitidos := array_append(v_omitidos, 'A-90');
  end if;
  if exists (select 1 from public.puestos where codigo='A-91' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EFRAIN DOMINGUEZ ESTRADA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-91';
  else
    v_omitidos := array_append(v_omitidos, 'A-91');
  end if;
  if exists (select 1 from public.puestos where codigo='V-101' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','FRANKLIN AVENDAÑO CAUSILLAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-101';
  else
    v_omitidos := array_append(v_omitidos, 'V-101');
  end if;
  if exists (select 1 from public.puestos where codigo='V-102' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','FRANKLIN AVENDAÑO CAUSILLAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-102';
  else
    v_omitidos := array_append(v_omitidos, 'V-102');
  end if;
  if exists (select 1 from public.puestos where codigo='V-103' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN CARLOS QUISPE HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-103';
  else
    v_omitidos := array_append(v_omitidos, 'V-103');
  end if;
  if exists (select 1 from public.puestos where codigo='V-104' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GABY MARILYN MEZA BAUTISTA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-104';
  else
    v_omitidos := array_append(v_omitidos, 'V-104');
  end if;
  if exists (select 1 from public.puestos where codigo='V-105' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN CARLOS QUISPE HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-105';
  else
    v_omitidos := array_append(v_omitidos, 'V-105');
  end if;
  if exists (select 1 from public.puestos where codigo='V-106' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIGUEL ANGEL VILA SARMIENTO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-106';
  else
    v_omitidos := array_append(v_omitidos, 'V-106');
  end if;
  if exists (select 1 from public.puestos where codigo='V-107' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','BETTY CACERES APARICIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-107';
  else
    v_omitidos := array_append(v_omitidos, 'V-107');
  end if;
  if exists (select 1 from public.puestos where codigo='V-108' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIGUEL ANGEL VILA SARMIENTO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-108';
  else
    v_omitidos := array_append(v_omitidos, 'V-108');
  end if;
  if exists (select 1 from public.puestos where codigo='V-109' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','BETTY CACERES APARICIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-109';
  else
    v_omitidos := array_append(v_omitidos, 'V-109');
  end if;
  if exists (select 1 from public.puestos where codigo='V-110' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SATURDINA BACILIO POMA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-110';
  else
    v_omitidos := array_append(v_omitidos, 'V-110');
  end if;
  if exists (select 1 from public.puestos where codigo='V-113' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','WILDER HINOSTROZA VASQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-113';
  else
    v_omitidos := array_append(v_omitidos, 'V-113');
  end if;
  if exists (select 1 from public.puestos where codigo='V-118' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSARIO EVELYN PALPA LINO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-118';
  else
    v_omitidos := array_append(v_omitidos, 'V-118');
  end if;
  if exists (select 1 from public.puestos where codigo='V-121' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ERICK KERWIN QUISPE FERNANDEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-121';
  else
    v_omitidos := array_append(v_omitidos, 'V-121');
  end if;
  if exists (select 1 from public.puestos where codigo='V-124' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NANCY MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-124';
  else
    v_omitidos := array_append(v_omitidos, 'V-124');
  end if;
  if exists (select 1 from public.puestos where codigo='A-131' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VICTORIA Y HUGO MOSCOL LUCERO Y ANTONIO DE LA CRUZ LICARES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-131';
  else
    v_omitidos := array_append(v_omitidos, 'A-131');
  end if;
  if exists (select 1 from public.puestos where codigo='A-132' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANAVELI CORONEL DÍAZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-132';
  else
    v_omitidos := array_append(v_omitidos, 'A-132');
  end if;
  if exists (select 1 from public.puestos where codigo='A-134' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANAVELI CORONEL DÍAZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-134';
  else
    v_omitidos := array_append(v_omitidos, 'A-134');
  end if;
  if exists (select 1 from public.puestos where codigo='A-135' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANET URETA CAMPOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-135';
  else
    v_omitidos := array_append(v_omitidos, 'A-135');
  end if;
  if exists (select 1 from public.puestos where codigo='A-136' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LUZ TUCTO LUCAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-136';
  else
    v_omitidos := array_append(v_omitidos, 'A-136');
  end if;
  if exists (select 1 from public.puestos where codigo='A-137' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAVIER SUBLE HUAMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-137';
  else
    v_omitidos := array_append(v_omitidos, 'A-137');
  end if;
  if exists (select 1 from public.puestos where codigo='A-138' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHELEN EVANGELISTA GARCIA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-138';
  else
    v_omitidos := array_append(v_omitidos, 'A-138');
  end if;
  if exists (select 1 from public.puestos where codigo='A-139' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HECTOR CERVANTES CASTRO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-139';
  else
    v_omitidos := array_append(v_omitidos, 'A-139');
  end if;
  if exists (select 1 from public.puestos where codigo='A-140' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARYORI GRIETA BARZOLA ORE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-140';
  else
    v_omitidos := array_append(v_omitidos, 'A-140');
  end if;
  if exists (select 1 from public.puestos where codigo='A-141' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RONAL CUBAS QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-141';
  else
    v_omitidos := array_append(v_omitidos, 'A-141');
  end if;
  if exists (select 1 from public.puestos where codigo='A-142' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ELVIS GUARDAMINO DELGADILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-142';
  else
    v_omitidos := array_append(v_omitidos, 'A-142');
  end if;
  if exists (select 1 from public.puestos where codigo='A-143' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHOSMAR HUAROCC ADRIANO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-143';
  else
    v_omitidos := array_append(v_omitidos, 'A-143');
  end if;
  if exists (select 1 from public.puestos where codigo='A-144' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ELVIS GUARDAMINO DELGADILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-144';
  else
    v_omitidos := array_append(v_omitidos, 'A-144');
  end if;
  if exists (select 1 from public.puestos where codigo='A-145' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHOSMAR HUAROCC ADRIANO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-145';
  else
    v_omitidos := array_append(v_omitidos, 'A-145');
  end if;
  if exists (select 1 from public.puestos where codigo='V-151' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GABY MARILYN MEZA BAUTISTA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-151';
  else
    v_omitidos := array_append(v_omitidos, 'V-151');
  end if;
  if exists (select 1 from public.puestos where codigo='V-152' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHON AVENDAÑO CAUSILLAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-152';
  else
    v_omitidos := array_append(v_omitidos, 'V-152');
  end if;
  if exists (select 1 from public.puestos where codigo='V-153' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GABY MARILYN MEZA BAUTISTA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-153';
  else
    v_omitidos := array_append(v_omitidos, 'V-153');
  end if;
  if exists (select 1 from public.puestos where codigo='V-154' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHON AVENDAÑO CAUSILLAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-154';
  else
    v_omitidos := array_append(v_omitidos, 'V-154');
  end if;
  if exists (select 1 from public.puestos where codigo='V-155' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VICTOR RAFAEL PARIAMACHI PRADO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-155';
  else
    v_omitidos := array_append(v_omitidos, 'V-155');
  end if;
  if exists (select 1 from public.puestos where codigo='V-156' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHON AVENDAÑO CAUSILLAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-156';
  else
    v_omitidos := array_append(v_omitidos, 'V-156');
  end if;
  if exists (select 1 from public.puestos where codigo='V-157' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VICTOR RAFAEL PARIAMACHI PRADO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-157';
  else
    v_omitidos := array_append(v_omitidos, 'V-157');
  end if;
  if exists (select 1 from public.puestos where codigo='V-158' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GENOVA Y JORGE GABRIEL ROMERO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-158';
  else
    v_omitidos := array_append(v_omitidos, 'V-158');
  end if;
  if exists (select 1 from public.puestos where codigo='V-159' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VICTOR RAFAEL PARIAMACHI PRADO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-159';
  else
    v_omitidos := array_append(v_omitidos, 'V-159');
  end if;
  if exists (select 1 from public.puestos where codigo='V-160' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GENOVA Y JORGE GABRIEL ROMERO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-160';
  else
    v_omitidos := array_append(v_omitidos, 'V-160');
  end if;
  if exists (select 1 from public.puestos where codigo='V-164' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANE CABRERA CRUZADO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-164';
  else
    v_omitidos := array_append(v_omitidos, 'V-164');
  end if;
  if exists (select 1 from public.puestos where codigo='A-181' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JOSÉ EMANUEL BARAONA CORONEL','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-181';
  else
    v_omitidos := array_append(v_omitidos, 'A-181');
  end if;
  if exists (select 1 from public.puestos where codigo='A-183' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JOSÉ EMANUEL BARAONA CORONEL','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-183';
  else
    v_omitidos := array_append(v_omitidos, 'A-183');
  end if;
  if exists (select 1 from public.puestos where codigo='A-187' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RONY LUIS CARHUANCHO GUZMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-187';
  else
    v_omitidos := array_append(v_omitidos, 'A-187');
  end if;
  if exists (select 1 from public.puestos where codigo='A-188' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','K´ANTU KELLY CCONCHURO HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-188';
  else
    v_omitidos := array_append(v_omitidos, 'A-188');
  end if;
  if exists (select 1 from public.puestos where codigo='A-189' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RONY LUIS CARHUANCHO GUZMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-189';
  else
    v_omitidos := array_append(v_omitidos, 'A-189');
  end if;
  if exists (select 1 from public.puestos where codigo='A-190' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIRTHA RIVERA ALARCON','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-190';
  else
    v_omitidos := array_append(v_omitidos, 'A-190');
  end if;
  if exists (select 1 from public.puestos where codigo='A-191' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN ADAN ZAVALA TAMAYO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-191';
  else
    v_omitidos := array_append(v_omitidos, 'A-191');
  end if;
  if exists (select 1 from public.puestos where codigo='A-192' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DIEGO FREDDY AQUINO POMA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-192';
  else
    v_omitidos := array_append(v_omitidos, 'A-192');
  end if;
  if exists (select 1 from public.puestos where codigo='A-198' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIBEL MAYTA MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-198';
  else
    v_omitidos := array_append(v_omitidos, 'A-198');
  end if;
  if exists (select 1 from public.puestos where codigo='A-199' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LUZ LILIANA TORO GONZALES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-199';
  else
    v_omitidos := array_append(v_omitidos, 'A-199');
  end if;
  if exists (select 1 from public.puestos where codigo='A-200' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIBEL MAYTA MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-200';
  else
    v_omitidos := array_append(v_omitidos, 'A-200');
  end if;
  if exists (select 1 from public.puestos where codigo='V-203' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LINDA UMAN PADILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-203';
  else
    v_omitidos := array_append(v_omitidos, 'V-203');
  end if;
  if exists (select 1 from public.puestos where codigo='V-208' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSA ROMAN HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-208';
  else
    v_omitidos := array_append(v_omitidos, 'V-208');
  end if;
  if exists (select 1 from public.puestos where codigo='A-221' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ELBIS LIZARRAGA BACILIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-221';
  else
    v_omitidos := array_append(v_omitidos, 'A-221');
  end if;
  if exists (select 1 from public.puestos where codigo='A-223' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ELBIS LIZARRAGA BACILIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-223';
  else
    v_omitidos := array_append(v_omitidos, 'A-223');
  end if;
  if exists (select 1 from public.puestos where codigo='A-227' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIRTHA MALDONADO MEDINA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-227';
  else
    v_omitidos := array_append(v_omitidos, 'A-227');
  end if;
  if exists (select 1 from public.puestos where codigo='A-229' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIRTHA MALDONADO MEDINA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-229';
  else
    v_omitidos := array_append(v_omitidos, 'A-229');
  end if;
  if exists (select 1 from public.puestos where codigo='A-230' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN TICONA CASILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-230';
  else
    v_omitidos := array_append(v_omitidos, 'A-230');
  end if;
  if exists (select 1 from public.puestos where codigo='A-231' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHELEN EVANGELISTA GARCIA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-231';
  else
    v_omitidos := array_append(v_omitidos, 'A-231');
  end if;
  if exists (select 1 from public.puestos where codigo='A-232' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALICIA DORA TICONA CASILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-232';
  else
    v_omitidos := array_append(v_omitidos, 'A-232');
  end if;
  if exists (select 1 from public.puestos where codigo='A-239' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSALINDA HERMOSILLA BEJARANO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-239';
  else
    v_omitidos := array_append(v_omitidos, 'A-239');
  end if;
  if exists (select 1 from public.puestos where codigo='A-240' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHUNIOR PADILLA GUTIERREZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-240';
  else
    v_omitidos := array_append(v_omitidos, 'A-240');
  end if;
  if exists (select 1 from public.puestos where codigo='V-247' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSA ROMAN HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-247';
  else
    v_omitidos := array_append(v_omitidos, 'V-247');
  end if;
  if exists (select 1 from public.puestos where codigo='V-248' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLADYS ROJAS LOAYZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-248';
  else
    v_omitidos := array_append(v_omitidos, 'V-248');
  end if;
  if exists (select 1 from public.puestos where codigo='V-249' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSA ROMAN HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-249';
  else
    v_omitidos := array_append(v_omitidos, 'V-249');
  end if;
  if exists (select 1 from public.puestos where codigo='V-250' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLADYS ROJAS LOAYZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-250';
  else
    v_omitidos := array_append(v_omitidos, 'V-250');
  end if;
  if exists (select 1 from public.puestos where codigo='V-252' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MELISSA FLORES MEJIA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-252';
  else
    v_omitidos := array_append(v_omitidos, 'V-252');
  end if;
  if exists (select 1 from public.puestos where codigo='V-254' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARILU JESSENIA JACINTO RAMOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-254';
  else
    v_omitidos := array_append(v_omitidos, 'V-254');
  end if;
  if exists (select 1 from public.puestos where codigo='V-261' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','OSCAR JACINTO PARQUER','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-261';
  else
    v_omitidos := array_append(v_omitidos, 'V-261');
  end if;
  if exists (select 1 from public.puestos where codigo='V-262' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JULIA RAMOS OBREGON','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-262';
  else
    v_omitidos := array_append(v_omitidos, 'V-262');
  end if;
  if exists (select 1 from public.puestos where codigo='V-263' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','OSCAR JACINTO PARQUER','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-263';
  else
    v_omitidos := array_append(v_omitidos, 'V-263');
  end if;
  if exists (select 1 from public.puestos where codigo='V-264' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARTHA MAYTA CHOQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-264';
  else
    v_omitidos := array_append(v_omitidos, 'V-264');
  end if;
  if exists (select 1 from public.puestos where codigo='V-265' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','OSCAR JACINTO PARQUER','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-265';
  else
    v_omitidos := array_append(v_omitidos, 'V-265');
  end if;
  if exists (select 1 from public.puestos where codigo='V-266' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JULIA RAMOS OBREGON','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-266';
  else
    v_omitidos := array_append(v_omitidos, 'V-266');
  end if;
  if exists (select 1 from public.puestos where codigo='V-267' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDER ALANIA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-267';
  else
    v_omitidos := array_append(v_omitidos, 'V-267');
  end if;
  if exists (select 1 from public.puestos where codigo='V-268' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JULIA RAMOS OBREGON','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-268';
  else
    v_omitidos := array_append(v_omitidos, 'V-268');
  end if;
  if exists (select 1 from public.puestos where codigo='V-269' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDER ALANIA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-269';
  else
    v_omitidos := array_append(v_omitidos, 'V-269');
  end if;
  if exists (select 1 from public.puestos where codigo='A-271' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARYLUZ SEVILLANO MORENO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-271';
  else
    v_omitidos := array_append(v_omitidos, 'A-271');
  end if;
  if exists (select 1 from public.puestos where codigo='A-276' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALICIA DORA TICONA CASILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-276';
  else
    v_omitidos := array_append(v_omitidos, 'A-276');
  end if;
  if exists (select 1 from public.puestos where codigo='A-277' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VICTOR DAVILA REQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-277';
  else
    v_omitidos := array_append(v_omitidos, 'A-277');
  end if;
  if exists (select 1 from public.puestos where codigo='A-278' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHONNY ERICKSON GUTIERREZ TICONA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-278';
  else
    v_omitidos := array_append(v_omitidos, 'A-278');
  end if;
  if exists (select 1 from public.puestos where codigo='A-279' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VICTOR DAVILA REQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-279';
  else
    v_omitidos := array_append(v_omitidos, 'A-279');
  end if;
  if exists (select 1 from public.puestos where codigo='A-280' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GABINO QUISPE VARGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-280';
  else
    v_omitidos := array_append(v_omitidos, 'A-280');
  end if;
  if exists (select 1 from public.puestos where codigo='A-281' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHOSMAR HUAROCC ADRIANO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-281';
  else
    v_omitidos := array_append(v_omitidos, 'A-281');
  end if;
  if exists (select 1 from public.puestos where codigo='A-282' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHOSMAR HUAROCC ADRIANO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-282';
  else
    v_omitidos := array_append(v_omitidos, 'A-282');
  end if;
  if exists (select 1 from public.puestos where codigo='A-283' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHOSMAR HUAROCC ADRIANO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-283';
  else
    v_omitidos := array_append(v_omitidos, 'A-283');
  end if;
  if exists (select 1 from public.puestos where codigo='A-287' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LISBETH CARMEN SOTO BACILIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-287';
  else
    v_omitidos := array_append(v_omitidos, 'A-287');
  end if;
  if exists (select 1 from public.puestos where codigo='A-288' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RICARDINA CONDOR ROQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-288';
  else
    v_omitidos := array_append(v_omitidos, 'A-288');
  end if;
  if exists (select 1 from public.puestos where codigo='A-289' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JESSICA HUACRE HUACRE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-289';
  else
    v_omitidos := array_append(v_omitidos, 'A-289');
  end if;
  if exists (select 1 from public.puestos where codigo='A-290' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CHARO ORTIZ MONTENGRO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-290';
  else
    v_omitidos := array_append(v_omitidos, 'A-290');
  end if;
  if exists (select 1 from public.puestos where codigo='A-291' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','KEVIN JOSEPH VILA JANCCO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-291';
  else
    v_omitidos := array_append(v_omitidos, 'A-291');
  end if;
  if exists (select 1 from public.puestos where codigo='A-292' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NELSON VILA JANCCO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-292';
  else
    v_omitidos := array_append(v_omitidos, 'A-292');
  end if;
  if exists (select 1 from public.puestos where codigo='V-301' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALEXANDRA LIZET CUYA PEÑA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='V-301';
  else
    v_omitidos := array_append(v_omitidos, 'V-301');
  end if;
  if exists (select 1 from public.puestos where codigo='A-317' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CESAR GUEVARA AMAYA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-317';
  else
    v_omitidos := array_append(v_omitidos, 'A-317');
  end if;
  if exists (select 1 from public.puestos where codigo='A-318' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSA ALVARADO MEZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-318';
  else
    v_omitidos := array_append(v_omitidos, 'A-318');
  end if;
  if exists (select 1 from public.puestos where codigo='A-319' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHONNY ERICKSON GUTIERREZ TICONA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-319';
  else
    v_omitidos := array_append(v_omitidos, 'A-319');
  end if;
  if exists (select 1 from public.puestos where codigo='A-320' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSA ALVARADO MEZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-320';
  else
    v_omitidos := array_append(v_omitidos, 'A-320');
  end if;
  if exists (select 1 from public.puestos where codigo='A-322' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LISBETH CARMEN SOTO BACILIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-322';
  else
    v_omitidos := array_append(v_omitidos, 'A-322');
  end if;
  if exists (select 1 from public.puestos where codigo='A-324' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LISBETH CARMEN SOTO BACILIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-324';
  else
    v_omitidos := array_append(v_omitidos, 'A-324');
  end if;
  if exists (select 1 from public.puestos where codigo='A-331' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SABINA SOLLER ENRIQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-331';
  else
    v_omitidos := array_append(v_omitidos, 'A-331');
  end if;
  if exists (select 1 from public.puestos where codigo='A-332' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NELIDA ROJAS CASAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-332';
  else
    v_omitidos := array_append(v_omitidos, 'A-332');
  end if;
  if exists (select 1 from public.puestos where codigo='A-333' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SABINA SOLLER ENRIQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-333';
  else
    v_omitidos := array_append(v_omitidos, 'A-333');
  end if;
  if exists (select 1 from public.puestos where codigo='A-334' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SATURDINA BACILIO POMA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-334';
  else
    v_omitidos := array_append(v_omitidos, 'A-334');
  end if;
  if exists (select 1 from public.puestos where codigo='A-335' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SABINA SOLLER ENRIQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-335';
  else
    v_omitidos := array_append(v_omitidos, 'A-335');
  end if;
  if exists (select 1 from public.puestos where codigo='A-336' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LEONILDA CURO SINCHE CURO SINCHE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-336';
  else
    v_omitidos := array_append(v_omitidos, 'A-336');
  end if;
  if exists (select 1 from public.puestos where codigo='A-337' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ELBIS LIZARRAGA BACILIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-337';
  else
    v_omitidos := array_append(v_omitidos, 'A-337');
  end if;
  if exists (select 1 from public.puestos where codigo='A-338' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LEDIN YOLANDA LOPEZ SICCE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-338';
  else
    v_omitidos := array_append(v_omitidos, 'A-338');
  end if;
  if exists (select 1 from public.puestos where codigo='A-339' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','TEODORA PAULINA RODRIGUEZ DE APONTE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-339';
  else
    v_omitidos := array_append(v_omitidos, 'A-339');
  end if;
  if exists (select 1 from public.puestos where codigo='A-340' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CARMEN GRICELDA PEREZ CHINCHAY','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-340';
  else
    v_omitidos := array_append(v_omitidos, 'A-340');
  end if;
  if exists (select 1 from public.puestos where codigo='A-354' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA CELESTINA SANTOS SANTOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-354';
  else
    v_omitidos := array_append(v_omitidos, 'A-354');
  end if;
  if exists (select 1 from public.puestos where codigo='A-358' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JULIO FUERTES HUAMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-358';
  else
    v_omitidos := array_append(v_omitidos, 'A-358');
  end if;
  if exists (select 1 from public.puestos where codigo='A-359' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JULIO FUERTES HUAMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-359';
  else
    v_omitidos := array_append(v_omitidos, 'A-359');
  end if;
  if exists (select 1 from public.puestos where codigo='A-360' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JULIO FUERTES HUAMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-360';
  else
    v_omitidos := array_append(v_omitidos, 'A-360');
  end if;
  if exists (select 1 from public.puestos where codigo='A-361' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ERASMO GUTIERREZ ORTIZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-361';
  else
    v_omitidos := array_append(v_omitidos, 'A-361');
  end if;
  if exists (select 1 from public.puestos where codigo='A-362' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CANDY ESPINOZA GOMEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-362';
  else
    v_omitidos := array_append(v_omitidos, 'A-362');
  end if;
  if exists (select 1 from public.puestos where codigo='A-363' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAQUELINE GABRIEL GUIVARRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-363';
  else
    v_omitidos := array_append(v_omitidos, 'A-363');
  end if;
  if exists (select 1 from public.puestos where codigo='A-364' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CANDY ESPINOZA GOMEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-364';
  else
    v_omitidos := array_append(v_omitidos, 'A-364');
  end if;
  if exists (select 1 from public.puestos where codigo='A-367' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MAURO CONOVILCA PASTRNA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-367';
  else
    v_omitidos := array_append(v_omitidos, 'A-367');
  end if;
  if exists (select 1 from public.puestos where codigo='A-369' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MAURO CONOVILCA PASTRNA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-369';
  else
    v_omitidos := array_append(v_omitidos, 'A-369');
  end if;
  if exists (select 1 from public.puestos where codigo='A-370' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALICIA DORA TICONA CASILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-370';
  else
    v_omitidos := array_append(v_omitidos, 'A-370');
  end if;
  if exists (select 1 from public.puestos where codigo='A-381' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','TOMASA ARAUJO ARAUJO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-381';
  else
    v_omitidos := array_append(v_omitidos, 'A-381');
  end if;
  if exists (select 1 from public.puestos where codigo='A-382' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','TOMASA ARAUJO ARAUJO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-382';
  else
    v_omitidos := array_append(v_omitidos, 'A-382');
  end if;
  if exists (select 1 from public.puestos where codigo='A-383' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ABEL BARZOLA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-383';
  else
    v_omitidos := array_append(v_omitidos, 'A-383');
  end if;
  if exists (select 1 from public.puestos where codigo='A-384' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','WILDER HINOSTROZA VASQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-384';
  else
    v_omitidos := array_append(v_omitidos, 'A-384');
  end if;
  if exists (select 1 from public.puestos where codigo='A-385' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ABEL BARZOLA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-385';
  else
    v_omitidos := array_append(v_omitidos, 'A-385');
  end if;
  if exists (select 1 from public.puestos where codigo='A-386' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GISELA BARZOLA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-386';
  else
    v_omitidos := array_append(v_omitidos, 'A-386');
  end if;
  if exists (select 1 from public.puestos where codigo='A-388' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLADYS ROJAS LOAYZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-388';
  else
    v_omitidos := array_append(v_omitidos, 'A-388');
  end if;
  if exists (select 1 from public.puestos where codigo='A-390' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLADYS ROJAS LOAYZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-390';
  else
    v_omitidos := array_append(v_omitidos, 'A-390');
  end if;
  if exists (select 1 from public.puestos where codigo='A-391' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','TOMASA ARAUJO ARAUJO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-391';
  else
    v_omitidos := array_append(v_omitidos, 'A-391');
  end if;
  if exists (select 1 from public.puestos where codigo='A-392' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','TOMASA ARAUJO ARAUJO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-392';
  else
    v_omitidos := array_append(v_omitidos, 'A-392');
  end if;
  if exists (select 1 from public.puestos where codigo='A-393' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JACINTO CONDORI AYBAR','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-393';
  else
    v_omitidos := array_append(v_omitidos, 'A-393');
  end if;
  if exists (select 1 from public.puestos where codigo='A-397' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AYLEN ROMERO ANGULO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-397';
  else
    v_omitidos := array_append(v_omitidos, 'A-397');
  end if;
  if exists (select 1 from public.puestos where codigo='A-399' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AYLEN ROMERO ANGULO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-399';
  else
    v_omitidos := array_append(v_omitidos, 'A-399');
  end if;
  if exists (select 1 from public.puestos where codigo='A-401' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RICADINA CONDOR ROQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-401';
  else
    v_omitidos := array_append(v_omitidos, 'A-401');
  end if;
  if exists (select 1 from public.puestos where codigo='A-402' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RICADINA CONDOR ROQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-402';
  else
    v_omitidos := array_append(v_omitidos, 'A-402');
  end if;
  if exists (select 1 from public.puestos where codigo='A-403' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RICADINA CONDOR ROQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-403';
  else
    v_omitidos := array_append(v_omitidos, 'A-403');
  end if;
  if exists (select 1 from public.puestos where codigo='A-404' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RICADINA CONDOR ROQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-404';
  else
    v_omitidos := array_append(v_omitidos, 'A-404');
  end if;
  if exists (select 1 from public.puestos where codigo='A-405' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HENRRY CHAMBI CUTIPA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-405';
  else
    v_omitidos := array_append(v_omitidos, 'A-405');
  end if;
  if exists (select 1 from public.puestos where codigo='A-407' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HENRRY CHAMBI CUTIPA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-407';
  else
    v_omitidos := array_append(v_omitidos, 'A-407');
  end if;
  if exists (select 1 from public.puestos where codigo='A-408' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HENRRY CHAMBI CUTIPA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-408';
  else
    v_omitidos := array_append(v_omitidos, 'A-408');
  end if;
  if exists (select 1 from public.puestos where codigo='A-409' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARTHA MAYTA CHOQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-409';
  else
    v_omitidos := array_append(v_omitidos, 'A-409');
  end if;
  if exists (select 1 from public.puestos where codigo='A-410' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARTHA MAYTA CHOQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-410';
  else
    v_omitidos := array_append(v_omitidos, 'A-410');
  end if;
  if exists (select 1 from public.puestos where codigo='A-412' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DAVID CORDOVA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-412';
  else
    v_omitidos := array_append(v_omitidos, 'A-412');
  end if;
  if exists (select 1 from public.puestos where codigo='A-414' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DAVID CORDOVA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-414';
  else
    v_omitidos := array_append(v_omitidos, 'A-414');
  end if;
  if exists (select 1 from public.puestos where codigo='A-416' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DELSY LAVADO VILLEGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-416';
  else
    v_omitidos := array_append(v_omitidos, 'A-416');
  end if;
  if exists (select 1 from public.puestos where codigo='A-418' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DELSY LAVADO VILLEGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-418';
  else
    v_omitidos := array_append(v_omitidos, 'A-418');
  end if;
  if exists (select 1 from public.puestos where codigo='A-419' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN TICONA CASILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-419';
  else
    v_omitidos := array_append(v_omitidos, 'A-419');
  end if;
  if exists (select 1 from public.puestos where codigo='A-420' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DELSY LAVADO VILLEGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-420';
  else
    v_omitidos := array_append(v_omitidos, 'A-420');
  end if;
  if exists (select 1 from public.puestos where codigo='A-423' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','FRANK ALEXIS PANTA MEZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-423';
  else
    v_omitidos := array_append(v_omitidos, 'A-423');
  end if;
  if exists (select 1 from public.puestos where codigo='A-425' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JACINTO CONDORI AYBAR','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-425';
  else
    v_omitidos := array_append(v_omitidos, 'A-425');
  end if;
  if exists (select 1 from public.puestos where codigo='A-427' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANA MELVA RODRIGUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-427';
  else
    v_omitidos := array_append(v_omitidos, 'A-427');
  end if;
  if exists (select 1 from public.puestos where codigo='A-428' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SAUL GALDOS QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-428';
  else
    v_omitidos := array_append(v_omitidos, 'A-428');
  end if;
  if exists (select 1 from public.puestos where codigo='A-429' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANA MELVA RODRIGUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-429';
  else
    v_omitidos := array_append(v_omitidos, 'A-429');
  end if;
  if exists (select 1 from public.puestos where codigo='A-430' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SAUL GALDOS QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-430';
  else
    v_omitidos := array_append(v_omitidos, 'A-430');
  end if;
  if exists (select 1 from public.puestos where codigo='A-432' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANET YALLICO PEREZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-432';
  else
    v_omitidos := array_append(v_omitidos, 'A-432');
  end if;
  if exists (select 1 from public.puestos where codigo='A-434' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANET YALLICO PEREZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-434';
  else
    v_omitidos := array_append(v_omitidos, 'A-434');
  end if;
  if exists (select 1 from public.puestos where codigo='A-437' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN CHARCA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-437';
  else
    v_omitidos := array_append(v_omitidos, 'A-437');
  end if;
  if exists (select 1 from public.puestos where codigo='A-439' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN CHARCA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-439';
  else
    v_omitidos := array_append(v_omitidos, 'A-439');
  end if;
  if exists (select 1 from public.puestos where codigo='A-440' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSARIO EVELYN PALPA LINO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-440';
  else
    v_omitidos := array_append(v_omitidos, 'A-440');
  end if;
  if exists (select 1 from public.puestos where codigo='A-441' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN CHARCA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-441';
  else
    v_omitidos := array_append(v_omitidos, 'A-441');
  end if;
  if exists (select 1 from public.puestos where codigo='A-442' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HILARIO GAMEZ ROJAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-442';
  else
    v_omitidos := array_append(v_omitidos, 'A-442');
  end if;
  if exists (select 1 from public.puestos where codigo='A-443' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JEFFERSON BARZOLA BARZOLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-443';
  else
    v_omitidos := array_append(v_omitidos, 'A-443');
  end if;
  if exists (select 1 from public.puestos where codigo='A-444' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HILARIO GAMEZ ROJAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-444';
  else
    v_omitidos := array_append(v_omitidos, 'A-444');
  end if;
  if exists (select 1 from public.puestos where codigo='A-445' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CHABELA BARZOLA BARZOLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-445';
  else
    v_omitidos := array_append(v_omitidos, 'A-445');
  end if;
  if exists (select 1 from public.puestos where codigo='A-446' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HILARIO GAMEZ ROJAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-446';
  else
    v_omitidos := array_append(v_omitidos, 'A-446');
  end if;
  if exists (select 1 from public.puestos where codigo='A-447' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANA ASCOY SALCEDO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-447';
  else
    v_omitidos := array_append(v_omitidos, 'A-447');
  end if;
  if exists (select 1 from public.puestos where codigo='A-448' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CELINDA SILVIA MOLINA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-448';
  else
    v_omitidos := array_append(v_omitidos, 'A-448');
  end if;
  if exists (select 1 from public.puestos where codigo='A-449' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANA ASCOY SALCEDO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-449';
  else
    v_omitidos := array_append(v_omitidos, 'A-449');
  end if;
  if exists (select 1 from public.puestos where codigo='A-450' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CELINDA SILVIA MOLINA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-450';
  else
    v_omitidos := array_append(v_omitidos, 'A-450');
  end if;
  if exists (select 1 from public.puestos where codigo='A-452' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANET MARIBEL QUISPE QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-452';
  else
    v_omitidos := array_append(v_omitidos, 'A-452');
  end if;
  if exists (select 1 from public.puestos where codigo='A-453' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PEDRO ECHEVARRIA LAGUNA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-453';
  else
    v_omitidos := array_append(v_omitidos, 'A-453');
  end if;
  if exists (select 1 from public.puestos where codigo='A-454' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDWAR MUÑOZ BOZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-454';
  else
    v_omitidos := array_append(v_omitidos, 'A-454');
  end if;
  if exists (select 1 from public.puestos where codigo='A-456' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDWAR MUÑOZ BOZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-456';
  else
    v_omitidos := array_append(v_omitidos, 'A-456');
  end if;
  if exists (select 1 from public.puestos where codigo='A-457' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JONAS CALDAS RAMOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-457';
  else
    v_omitidos := array_append(v_omitidos, 'A-457');
  end if;
  if exists (select 1 from public.puestos where codigo='A-458' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JONAS CALDAS RAMOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-458';
  else
    v_omitidos := array_append(v_omitidos, 'A-458');
  end if;
  if exists (select 1 from public.puestos where codigo='A-459' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JONAS CALDAS RAMOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-459';
  else
    v_omitidos := array_append(v_omitidos, 'A-459');
  end if;
  if exists (select 1 from public.puestos where codigo='A-460' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JONAS CALDAS RAMOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-460';
  else
    v_omitidos := array_append(v_omitidos, 'A-460');
  end if;
  if exists (select 1 from public.puestos where codigo='A-461' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDWAR MUÑOZ BOZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-461';
  else
    v_omitidos := array_append(v_omitidos, 'A-461');
  end if;
  if exists (select 1 from public.puestos where codigo='A-462' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALAN ESPINOZA GOMEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-462';
  else
    v_omitidos := array_append(v_omitidos, 'A-462');
  end if;
  if exists (select 1 from public.puestos where codigo='A-463' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAIRO PADILLA GUTIERREZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-463';
  else
    v_omitidos := array_append(v_omitidos, 'A-463');
  end if;
  if exists (select 1 from public.puestos where codigo='A-464' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALAN ESPINOZA GOMEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-464';
  else
    v_omitidos := array_append(v_omitidos, 'A-464');
  end if;
  if exists (select 1 from public.puestos where codigo='A-465' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAIRO PADILLA GUTIERREZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-465';
  else
    v_omitidos := array_append(v_omitidos, 'A-465');
  end if;
  if exists (select 1 from public.puestos where codigo='A-466' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDILBERTO ALIAGA TRINIDAD','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-466';
  else
    v_omitidos := array_append(v_omitidos, 'A-466');
  end if;
  if exists (select 1 from public.puestos where codigo='A-467' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALICIA DORA TICONA CASILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-467';
  else
    v_omitidos := array_append(v_omitidos, 'A-467');
  end if;
  if exists (select 1 from public.puestos where codigo='A-468' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MAURO CONOVILCA PASTRNA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-468';
  else
    v_omitidos := array_append(v_omitidos, 'A-468');
  end if;
  if exists (select 1 from public.puestos where codigo='A-470' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MAURO CONOVILCA PASTRNA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-470';
  else
    v_omitidos := array_append(v_omitidos, 'A-470');
  end if;
  if exists (select 1 from public.puestos where codigo='A-472' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MANUEL HUAMAN CACERES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-472';
  else
    v_omitidos := array_append(v_omitidos, 'A-472');
  end if;
  if exists (select 1 from public.puestos where codigo='A-474' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MANUEL HUAMAN CACERES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-474';
  else
    v_omitidos := array_append(v_omitidos, 'A-474');
  end if;
  if exists (select 1 from public.puestos where codigo='A-478' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIA CALLATA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-478';
  else
    v_omitidos := array_append(v_omitidos, 'A-478');
  end if;
  if exists (select 1 from public.puestos where codigo='A-479' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HANDERSON ENRIQUE PEÑALOZA VILEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-479';
  else
    v_omitidos := array_append(v_omitidos, 'A-479');
  end if;
  if exists (select 1 from public.puestos where codigo='A-480' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HANDERSON ENRIQUE PEÑALOZA VILEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-480';
  else
    v_omitidos := array_append(v_omitidos, 'A-480');
  end if;
  if exists (select 1 from public.puestos where codigo='A-481' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NAYDA MAYHUA HUAMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-481';
  else
    v_omitidos := array_append(v_omitidos, 'A-481');
  end if;
  if exists (select 1 from public.puestos where codigo='A-482' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NAYDA MAYHUA HUAMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-482';
  else
    v_omitidos := array_append(v_omitidos, 'A-482');
  end if;
  if exists (select 1 from public.puestos where codigo='A-483' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANDREA ROJAS CASAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-483';
  else
    v_omitidos := array_append(v_omitidos, 'A-483');
  end if;
  if exists (select 1 from public.puestos where codigo='A-484' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANET YALLICO PEREZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-484';
  else
    v_omitidos := array_append(v_omitidos, 'A-484');
  end if;
  if exists (select 1 from public.puestos where codigo='A-489' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA LUISA OSORIO CURI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-489';
  else
    v_omitidos := array_append(v_omitidos, 'A-489');
  end if;
  if exists (select 1 from public.puestos where codigo='A-491' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIRTHA RIVERA ALARCON','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-491';
  else
    v_omitidos := array_append(v_omitidos, 'A-491');
  end if;
  if exists (select 1 from public.puestos where codigo='A-492' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDILBERTO ALIAGA TRINIDAD','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-492';
  else
    v_omitidos := array_append(v_omitidos, 'A-492');
  end if;
  if exists (select 1 from public.puestos where codigo='A-493' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIRTHA RIVERA ALARCON','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-493';
  else
    v_omitidos := array_append(v_omitidos, 'A-493');
  end if;
  if exists (select 1 from public.puestos where codigo='A-494' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDILBERTO ALIAGA TRINIDAD','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-494';
  else
    v_omitidos := array_append(v_omitidos, 'A-494');
  end if;
  if exists (select 1 from public.puestos where codigo='A-495' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIA VILMA ELIAS MORE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-495';
  else
    v_omitidos := array_append(v_omitidos, 'A-495');
  end if;
  if exists (select 1 from public.puestos where codigo='A-496' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VIANIY PALOMINO MUÑOZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-496';
  else
    v_omitidos := array_append(v_omitidos, 'A-496');
  end if;
  if exists (select 1 from public.puestos where codigo='A-497' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MABEL GUERRERO VILA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-497';
  else
    v_omitidos := array_append(v_omitidos, 'A-497');
  end if;
  if exists (select 1 from public.puestos where codigo='A-498' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','BRAULIO HUAMANI PALOMINO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-498';
  else
    v_omitidos := array_append(v_omitidos, 'A-498');
  end if;
  if exists (select 1 from public.puestos where codigo='A-499' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','BRAULIO HUAMANI PALOMINO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-499';
  else
    v_omitidos := array_append(v_omitidos, 'A-499');
  end if;
  if exists (select 1 from public.puestos where codigo='A-500' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','BRAULIO HUAMANI PALOMINO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-500';
  else
    v_omitidos := array_append(v_omitidos, 'A-500');
  end if;
  if exists (select 1 from public.puestos where codigo='A-501' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAVIER ORTIZ MONTENEGRO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-501';
  else
    v_omitidos := array_append(v_omitidos, 'A-501');
  end if;
  if exists (select 1 from public.puestos where codigo='A-502' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VIANIY PALOMINO MUÑOZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-502';
  else
    v_omitidos := array_append(v_omitidos, 'A-502');
  end if;
  if exists (select 1 from public.puestos where codigo='A-503' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAVIER ORTIZ MONTENEGRO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-503';
  else
    v_omitidos := array_append(v_omitidos, 'A-503');
  end if;
  if exists (select 1 from public.puestos where codigo='A-504' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHONNY ERICKSON GUTIERREZ TICONA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-504';
  else
    v_omitidos := array_append(v_omitidos, 'A-504');
  end if;
  if exists (select 1 from public.puestos where codigo='A-505' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAVIER ORTIZ MONTENEGRO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-505';
  else
    v_omitidos := array_append(v_omitidos, 'A-505');
  end if;
  if exists (select 1 from public.puestos where codigo='A-506' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLIRIO AQUINO QUINTANA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-506';
  else
    v_omitidos := array_append(v_omitidos, 'A-506');
  end if;
  if exists (select 1 from public.puestos where codigo='A-507' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EMERSON LUSTRE UBETA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-507';
  else
    v_omitidos := array_append(v_omitidos, 'A-507');
  end if;
  if exists (select 1 from public.puestos where codigo='A-508' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLIRIO AQUINO QUINTANA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-508';
  else
    v_omitidos := array_append(v_omitidos, 'A-508');
  end if;
  if exists (select 1 from public.puestos where codigo='A-509' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EMERSON LUSTRE UBETA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-509';
  else
    v_omitidos := array_append(v_omitidos, 'A-509');
  end if;
  if exists (select 1 from public.puestos where codigo='A-510' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EMERSON LUSTRE UBETA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-510';
  else
    v_omitidos := array_append(v_omitidos, 'A-510');
  end if;
  if exists (select 1 from public.puestos where codigo='A-511' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','TEODORA PAULINA RODRIGUEZ DE APONTE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-511';
  else
    v_omitidos := array_append(v_omitidos, 'A-511');
  end if;
  if exists (select 1 from public.puestos where codigo='A-512' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NORMA HUAMANI FLORES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-512';
  else
    v_omitidos := array_append(v_omitidos, 'A-512');
  end if;
  if exists (select 1 from public.puestos where codigo='A-514' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PETER ROCCA HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-514';
  else
    v_omitidos := array_append(v_omitidos, 'A-514');
  end if;
  if exists (select 1 from public.puestos where codigo='A-515' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSALINDA HERMOSILLA BEJARANO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-515';
  else
    v_omitidos := array_append(v_omitidos, 'A-515');
  end if;
  if exists (select 1 from public.puestos where codigo='A-516' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSARIO EVELYN PALPA LINO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-516';
  else
    v_omitidos := array_append(v_omitidos, 'A-516');
  end if;
  if exists (select 1 from public.puestos where codigo='A-517' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LUCY HUAMANI FLORES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-517';
  else
    v_omitidos := array_append(v_omitidos, 'A-517');
  end if;
  if exists (select 1 from public.puestos where codigo='A-518' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUSSELL GALAN VEGA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-518';
  else
    v_omitidos := array_append(v_omitidos, 'A-518');
  end if;
  if exists (select 1 from public.puestos where codigo='A-519' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LUCY HUAMANI FLORES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-519';
  else
    v_omitidos := array_append(v_omitidos, 'A-519');
  end if;
  if exists (select 1 from public.puestos where codigo='A-520' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUSSELL GALAN VEGA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-520';
  else
    v_omitidos := array_append(v_omitidos, 'A-520');
  end if;
  if exists (select 1 from public.puestos where codigo='A-521' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIGUEL ANGEL VILA SARMIENTO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-521';
  else
    v_omitidos := array_append(v_omitidos, 'A-521');
  end if;
  if exists (select 1 from public.puestos where codigo='A-522' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANE CABRERA CRUZADO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-522';
  else
    v_omitidos := array_append(v_omitidos, 'A-522');
  end if;
  if exists (select 1 from public.puestos where codigo='A-523' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIGUEL ANGEL VILA SARMIENTO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-523';
  else
    v_omitidos := array_append(v_omitidos, 'A-523');
  end if;
  if exists (select 1 from public.puestos where codigo='A-524' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANE CABRERA CRUZADO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-524';
  else
    v_omitidos := array_append(v_omitidos, 'A-524');
  end if;
  if exists (select 1 from public.puestos where codigo='A-529' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARILU JESSENIA JACINTO RAMOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-529';
  else
    v_omitidos := array_append(v_omitidos, 'A-529');
  end if;
  if exists (select 1 from public.puestos where codigo='A-531' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','FRANCISCO JAVIER GARCÍA DURAND','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-531';
  else
    v_omitidos := array_append(v_omitidos, 'A-531');
  end if;
  if exists (select 1 from public.puestos where codigo='A-533' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','FRANCISCO JAVIER GARCÍA DURAND','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-533';
  else
    v_omitidos := array_append(v_omitidos, 'A-533');
  end if;
  if exists (select 1 from public.puestos where codigo='A-535' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIO TIOFILO CHALCO ESCRIBA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-535';
  else
    v_omitidos := array_append(v_omitidos, 'A-535');
  end if;
  if exists (select 1 from public.puestos where codigo='A-536' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RONAL CUBAS QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-536';
  else
    v_omitidos := array_append(v_omitidos, 'A-536');
  end if;
  if exists (select 1 from public.puestos where codigo='A-537' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDILBERTO ALIAGA TRINIDAD','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-537';
  else
    v_omitidos := array_append(v_omitidos, 'A-537');
  end if;
  if exists (select 1 from public.puestos where codigo='A-538' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RONAL CUBAS QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-538';
  else
    v_omitidos := array_append(v_omitidos, 'A-538');
  end if;
  if exists (select 1 from public.puestos where codigo='A-539' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDILBERTO ALIAGA TRINIDAD','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-539';
  else
    v_omitidos := array_append(v_omitidos, 'A-539');
  end if;
  if exists (select 1 from public.puestos where codigo='A-541' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLIRIO AQUINO QUINTANA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-541';
  else
    v_omitidos := array_append(v_omitidos, 'A-541');
  end if;
  if exists (select 1 from public.puestos where codigo='A-542' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIO TIOFILO CHALCO ESCRIBA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-542';
  else
    v_omitidos := array_append(v_omitidos, 'A-542');
  end if;
  if exists (select 1 from public.puestos where codigo='A-543' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLIRIO AQUINO QUINTANA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-543';
  else
    v_omitidos := array_append(v_omitidos, 'A-543');
  end if;
  if exists (select 1 from public.puestos where codigo='A-544' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN TICONA CASILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-544';
  else
    v_omitidos := array_append(v_omitidos, 'A-544');
  end if;
  if exists (select 1 from public.puestos where codigo='A-545' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VICTOR DAVILA REQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-545';
  else
    v_omitidos := array_append(v_omitidos, 'A-545');
  end if;
  if exists (select 1 from public.puestos where codigo='A-546' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AYLEN ROMERO ANGULO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-546';
  else
    v_omitidos := array_append(v_omitidos, 'A-546');
  end if;
  if exists (select 1 from public.puestos where codigo='A-547' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VICTOR DAVILA REQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-547';
  else
    v_omitidos := array_append(v_omitidos, 'A-547');
  end if;
  if exists (select 1 from public.puestos where codigo='A-548' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AYLEN ROMERO ANGULO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-548';
  else
    v_omitidos := array_append(v_omitidos, 'A-548');
  end if;
  if exists (select 1 from public.puestos where codigo='A-549' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VICTOR DAVILA REQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-549';
  else
    v_omitidos := array_append(v_omitidos, 'A-549');
  end if;
  if exists (select 1 from public.puestos where codigo='A-550' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AYLEN ROMERO ANGULO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-550';
  else
    v_omitidos := array_append(v_omitidos, 'A-550');
  end if;
  if exists (select 1 from public.puestos where codigo='A-551' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YONY FERRER','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-551';
  else
    v_omitidos := array_append(v_omitidos, 'A-551');
  end if;
  if exists (select 1 from public.puestos where codigo='A-552' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YONY FERRER','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-552';
  else
    v_omitidos := array_append(v_omitidos, 'A-552');
  end if;
  if exists (select 1 from public.puestos where codigo='A-553' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YONY FERRER','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-553';
  else
    v_omitidos := array_append(v_omitidos, 'A-553');
  end if;
  if exists (select 1 from public.puestos where codigo='A-555' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIO TIOFILO CHALCO ESCRIBA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-555';
  else
    v_omitidos := array_append(v_omitidos, 'A-555');
  end if;
  if exists (select 1 from public.puestos where codigo='A-556' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIBEL MAYTA MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-556';
  else
    v_omitidos := array_append(v_omitidos, 'A-556');
  end if;
  if exists (select 1 from public.puestos where codigo='A-557' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HECTOR CERVANTES CASTRO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-557';
  else
    v_omitidos := array_append(v_omitidos, 'A-557');
  end if;
  if exists (select 1 from public.puestos where codigo='A-559' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ESTELA YEM REYES PASTRANA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-559';
  else
    v_omitidos := array_append(v_omitidos, 'A-559');
  end if;
  if exists (select 1 from public.puestos where codigo='A-560' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANDERSON MARAVI MOLINA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-560';
  else
    v_omitidos := array_append(v_omitidos, 'A-560');
  end if;
  if exists (select 1 from public.puestos where codigo='A-561' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','KARINA BARZOLA BARZOLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-561';
  else
    v_omitidos := array_append(v_omitidos, 'A-561');
  end if;
  if exists (select 1 from public.puestos where codigo='A-562' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','KARINA BARZOLA BARZOLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-562';
  else
    v_omitidos := array_append(v_omitidos, 'A-562');
  end if;
  if exists (select 1 from public.puestos where codigo='A-563' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SATURDINA BACILIO POMA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-563';
  else
    v_omitidos := array_append(v_omitidos, 'A-563');
  end if;
  if exists (select 1 from public.puestos where codigo='A-564' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CHABELA BARZOLA BARZOLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-564';
  else
    v_omitidos := array_append(v_omitidos, 'A-564');
  end if;
  if exists (select 1 from public.puestos where codigo='A-565' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA LUISA OSORIO CURI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-565';
  else
    v_omitidos := array_append(v_omitidos, 'A-565');
  end if;
  if exists (select 1 from public.puestos where codigo='A-566' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DIEGO FREDDY AQUINO POMA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-566';
  else
    v_omitidos := array_append(v_omitidos, 'A-566');
  end if;
  if exists (select 1 from public.puestos where codigo='A-567' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA LUISA OSORIO CURI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-567';
  else
    v_omitidos := array_append(v_omitidos, 'A-567');
  end if;
  if exists (select 1 from public.puestos where codigo='A-568' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DIEGO FREDDY AQUINO POMA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-568';
  else
    v_omitidos := array_append(v_omitidos, 'A-568');
  end if;
  if exists (select 1 from public.puestos where codigo='A-569' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHOEL CHAMBI QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-569';
  else
    v_omitidos := array_append(v_omitidos, 'A-569');
  end if;
  if exists (select 1 from public.puestos where codigo='A-570' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHOEL CHAMBI QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-570';
  else
    v_omitidos := array_append(v_omitidos, 'A-570');
  end if;
  if exists (select 1 from public.puestos where codigo='A-571' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HENNRY CHAMBI CUTIPA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-571';
  else
    v_omitidos := array_append(v_omitidos, 'A-571');
  end if;
  if exists (select 1 from public.puestos where codigo='A-572' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HENNRY CHAMBI CUTIPA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-572';
  else
    v_omitidos := array_append(v_omitidos, 'A-572');
  end if;
  if exists (select 1 from public.puestos where codigo='A-573' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ARLITA GUEVARA VALERA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-573';
  else
    v_omitidos := array_append(v_omitidos, 'A-573');
  end if;
  if exists (select 1 from public.puestos where codigo='A-574' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ESTEFANY KARILU BARZOLA BARZOLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-574';
  else
    v_omitidos := array_append(v_omitidos, 'A-574');
  end if;
  if exists (select 1 from public.puestos where codigo='A-575' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ARLITA GUEVARA VALERA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-575';
  else
    v_omitidos := array_append(v_omitidos, 'A-575');
  end if;
  if exists (select 1 from public.puestos where codigo='A-576' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ARLITA GUEVARA VALERA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-576';
  else
    v_omitidos := array_append(v_omitidos, 'A-576');
  end if;
  if exists (select 1 from public.puestos where codigo='A-577' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NASHIRA URETA CAMPOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-577';
  else
    v_omitidos := array_append(v_omitidos, 'A-577');
  end if;
  if exists (select 1 from public.puestos where codigo='A-578' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA PARIAMACHE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-578';
  else
    v_omitidos := array_append(v_omitidos, 'A-578');
  end if;
  if exists (select 1 from public.puestos where codigo='A-579' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NASHIRA URETA CAMPOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-579';
  else
    v_omitidos := array_append(v_omitidos, 'A-579');
  end if;
  if exists (select 1 from public.puestos where codigo='A-580' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA PARIAMACHE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-580';
  else
    v_omitidos := array_append(v_omitidos, 'A-580');
  end if;
  if exists (select 1 from public.puestos where codigo='A-581' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GIOVANNA CALA BARRIOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-581';
  else
    v_omitidos := array_append(v_omitidos, 'A-581');
  end if;
  if exists (select 1 from public.puestos where codigo='A-582' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHONY HUANAY LUCAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-582';
  else
    v_omitidos := array_append(v_omitidos, 'A-582');
  end if;
  if exists (select 1 from public.puestos where codigo='A-583' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EMERSON LUSTRE UBETA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-583';
  else
    v_omitidos := array_append(v_omitidos, 'A-583');
  end if;
  if exists (select 1 from public.puestos where codigo='A-584' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','BRAULIO HUAMANI PALOMINO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-584';
  else
    v_omitidos := array_append(v_omitidos, 'A-584');
  end if;
  if exists (select 1 from public.puestos where codigo='A-585' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EMERSON LUSTRE UBETA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-585';
  else
    v_omitidos := array_append(v_omitidos, 'A-585');
  end if;
  if exists (select 1 from public.puestos where codigo='A-586' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','BRAULIO HUAMANI PALOMINO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-586';
  else
    v_omitidos := array_append(v_omitidos, 'A-586');
  end if;
  if exists (select 1 from public.puestos where codigo='A-601' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALDAIR FABIAM PUJAY ROJAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-601';
  else
    v_omitidos := array_append(v_omitidos, 'A-601');
  end if;
  if exists (select 1 from public.puestos where codigo='A-602' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','BEATRIZ AURELIA ROJAS TRUJILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-602';
  else
    v_omitidos := array_append(v_omitidos, 'A-602');
  end if;
  if exists (select 1 from public.puestos where codigo='A-603' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALDAIR FABIAM PUJAY ROJAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-603';
  else
    v_omitidos := array_append(v_omitidos, 'A-603');
  end if;
  if exists (select 1 from public.puestos where codigo='A-605' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANDREA ROJAS CASAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-605';
  else
    v_omitidos := array_append(v_omitidos, 'A-605');
  end if;
  if exists (select 1 from public.puestos where codigo='A-606' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSMERY HUARCAYA REYES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-606';
  else
    v_omitidos := array_append(v_omitidos, 'A-606');
  end if;
  if exists (select 1 from public.puestos where codigo='A-607' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NELLY MEYHUEY ENCARNACIÒN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-607';
  else
    v_omitidos := array_append(v_omitidos, 'A-607');
  end if;
  if exists (select 1 from public.puestos where codigo='A-608' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NELLY MEYHUEY ENCARNACIÒN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-608';
  else
    v_omitidos := array_append(v_omitidos, 'A-608');
  end if;
  if exists (select 1 from public.puestos where codigo='A-609' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NELLY MEYHUEY ENCARNACIÒN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-609';
  else
    v_omitidos := array_append(v_omitidos, 'A-609');
  end if;
  if exists (select 1 from public.puestos where codigo='A-610' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NELLY MEYHUEY ENCARNACIÒN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-610';
  else
    v_omitidos := array_append(v_omitidos, 'A-610');
  end if;
  if exists (select 1 from public.puestos where codigo='A-611' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSMERI ZEVALLOS MERMA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-611';
  else
    v_omitidos := array_append(v_omitidos, 'A-611');
  end if;
  if exists (select 1 from public.puestos where codigo='A-612' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSMERI ZEVALLOS MERMA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-612';
  else
    v_omitidos := array_append(v_omitidos, 'A-612');
  end if;
  if exists (select 1 from public.puestos where codigo='A-613' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSMERI ZEVALLOS MERMA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-613';
  else
    v_omitidos := array_append(v_omitidos, 'A-613');
  end if;
  if exists (select 1 from public.puestos where codigo='A-614' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HANDERSON ENRIQUE PEÑALOZA VILEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-614';
  else
    v_omitidos := array_append(v_omitidos, 'A-614');
  end if;
  if exists (select 1 from public.puestos where codigo='A-615' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MANUEL HUAMAN CACERES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-615';
  else
    v_omitidos := array_append(v_omitidos, 'A-615');
  end if;
  if exists (select 1 from public.puestos where codigo='A-616' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HANDERSON ENRIQUE PEÑALOZA VILEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-616';
  else
    v_omitidos := array_append(v_omitidos, 'A-616');
  end if;
  if exists (select 1 from public.puestos where codigo='A-617' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN CHARCA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-617';
  else
    v_omitidos := array_append(v_omitidos, 'A-617');
  end if;
  if exists (select 1 from public.puestos where codigo='A-618' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ERNESTO VARGAS PUCLLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-618';
  else
    v_omitidos := array_append(v_omitidos, 'A-618');
  end if;
  if exists (select 1 from public.puestos where codigo='A-619' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GISELA BARZOLA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-619';
  else
    v_omitidos := array_append(v_omitidos, 'A-619');
  end if;
  if exists (select 1 from public.puestos where codigo='A-620' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GISELA BARZOLA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-620';
  else
    v_omitidos := array_append(v_omitidos, 'A-620');
  end if;
  if exists (select 1 from public.puestos where codigo='A-621' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ABEL BARZOLA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-621';
  else
    v_omitidos := array_append(v_omitidos, 'A-621');
  end if;
  if exists (select 1 from public.puestos where codigo='A-622' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ABEL BARZOLA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-622';
  else
    v_omitidos := array_append(v_omitidos, 'A-622');
  end if;
  if exists (select 1 from public.puestos where codigo='A-623' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARTHA MAYTA CHOQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-623';
  else
    v_omitidos := array_append(v_omitidos, 'A-623');
  end if;
  if exists (select 1 from public.puestos where codigo='A-624' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARTHA MAYTA CHOQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-624';
  else
    v_omitidos := array_append(v_omitidos, 'A-624');
  end if;
  if exists (select 1 from public.puestos where codigo='A-625' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','KARINA GUERRERO VILA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-625';
  else
    v_omitidos := array_append(v_omitidos, 'A-625');
  end if;
  if exists (select 1 from public.puestos where codigo='A-626' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','BEATRIZ AURELIA ROJAS TRUJILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-626';
  else
    v_omitidos := array_append(v_omitidos, 'A-626');
  end if;
  if exists (select 1 from public.puestos where codigo='A-627' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','KARINA GUERRERO VILA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-627';
  else
    v_omitidos := array_append(v_omitidos, 'A-627');
  end if;
  if exists (select 1 from public.puestos where codigo='A-628' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','BEATRIZ AURELIA ROJAS TRUJILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-628';
  else
    v_omitidos := array_append(v_omitidos, 'A-628');
  end if;
  if exists (select 1 from public.puestos where codigo='A-629' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','KARINA GUERRERO VILA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-629';
  else
    v_omitidos := array_append(v_omitidos, 'A-629');
  end if;
  if exists (select 1 from public.puestos where codigo='A-641' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YOSLIN GABRIEL GUIVARRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-641';
  else
    v_omitidos := array_append(v_omitidos, 'A-641');
  end if;
  if exists (select 1 from public.puestos where codigo='A-642' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HAYDEE SARMIENTO GONZALO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-642';
  else
    v_omitidos := array_append(v_omitidos, 'A-642');
  end if;
  if exists (select 1 from public.puestos where codigo='A-643' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YOSLIN GABRIEL GUIVARRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-643';
  else
    v_omitidos := array_append(v_omitidos, 'A-643');
  end if;
  if exists (select 1 from public.puestos where codigo='A-644' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HAYDEE SARMIENTO GONZALO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-644';
  else
    v_omitidos := array_append(v_omitidos, 'A-644');
  end if;
  if exists (select 1 from public.puestos where codigo='A-646' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VIRGINIA GUTIERREZ VELAZQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-646';
  else
    v_omitidos := array_append(v_omitidos, 'A-646');
  end if;
  if exists (select 1 from public.puestos where codigo='A-647' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GABINO QUISPE VARGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-647';
  else
    v_omitidos := array_append(v_omitidos, 'A-647');
  end if;
  if exists (select 1 from public.puestos where codigo='A-649' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDGAR PABLO CAHUANA PUQUIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-649';
  else
    v_omitidos := array_append(v_omitidos, 'A-649');
  end if;
  if exists (select 1 from public.puestos where codigo='A-650' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDGAR PABLO CAHUANA PUQUIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-650';
  else
    v_omitidos := array_append(v_omitidos, 'A-650');
  end if;
  if exists (select 1 from public.puestos where codigo='A-651' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARLENY GARCIA RIVAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-651';
  else
    v_omitidos := array_append(v_omitidos, 'A-651');
  end if;
  if exists (select 1 from public.puestos where codigo='A-652' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLIRIO AQUINO QUINTANA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-652';
  else
    v_omitidos := array_append(v_omitidos, 'A-652');
  end if;
  if exists (select 1 from public.puestos where codigo='A-653' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARLENY GARCIA RIVAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-653';
  else
    v_omitidos := array_append(v_omitidos, 'A-653');
  end if;
  if exists (select 1 from public.puestos where codigo='A-654' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLIRIO AQUINO QUINTANA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-654';
  else
    v_omitidos := array_append(v_omitidos, 'A-654');
  end if;
  if exists (select 1 from public.puestos where codigo='A-655' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANET CESPEDES LOPEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-655';
  else
    v_omitidos := array_append(v_omitidos, 'A-655');
  end if;
  if exists (select 1 from public.puestos where codigo='A-656' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIRTHA MALDONADO MEDINA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-656';
  else
    v_omitidos := array_append(v_omitidos, 'A-656');
  end if;
  if exists (select 1 from public.puestos where codigo='A-657' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAKELINE VEGA AGUILAR','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-657';
  else
    v_omitidos := array_append(v_omitidos, 'A-657');
  end if;
  if exists (select 1 from public.puestos where codigo='A-658' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIRTHA MALDONADO MEDINA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-658';
  else
    v_omitidos := array_append(v_omitidos, 'A-658');
  end if;
  if exists (select 1 from public.puestos where codigo='A-659' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARYLUZ SEVILLANO MORENO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-659';
  else
    v_omitidos := array_append(v_omitidos, 'A-659');
  end if;
  if exists (select 1 from public.puestos where codigo='A-660' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIRTHA MALDONADO MEDINA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-660';
  else
    v_omitidos := array_append(v_omitidos, 'A-660');
  end if;
  if exists (select 1 from public.puestos where codigo='A-661' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSA ROMAN HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-661';
  else
    v_omitidos := array_append(v_omitidos, 'A-661');
  end if;
  if exists (select 1 from public.puestos where codigo='A-662' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LINDA UMAN PADILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-662';
  else
    v_omitidos := array_append(v_omitidos, 'A-662');
  end if;
  if exists (select 1 from public.puestos where codigo='A-663' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSA ROMAN HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-663';
  else
    v_omitidos := array_append(v_omitidos, 'A-663');
  end if;
  if exists (select 1 from public.puestos where codigo='A-664' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LINDA UMAN PADILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-664';
  else
    v_omitidos := array_append(v_omitidos, 'A-664');
  end if;
  if exists (select 1 from public.puestos where codigo='A-665' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EUFEMIA QUISPE HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-665';
  else
    v_omitidos := array_append(v_omitidos, 'A-665');
  end if;
  if exists (select 1 from public.puestos where codigo='A-666' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CELINDA SILVIA MOLINA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-666';
  else
    v_omitidos := array_append(v_omitidos, 'A-666');
  end if;
  if exists (select 1 from public.puestos where codigo='A-667' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','KARINA GUERRERO VILA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-667';
  else
    v_omitidos := array_append(v_omitidos, 'A-667');
  end if;
  if exists (select 1 from public.puestos where codigo='A-668' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANET MARIBEL QUISPE QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-668';
  else
    v_omitidos := array_append(v_omitidos, 'A-668');
  end if;
  if exists (select 1 from public.puestos where codigo='A-669' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','KARINA GUERRERO VILA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-669';
  else
    v_omitidos := array_append(v_omitidos, 'A-669');
  end if;
  if exists (select 1 from public.puestos where codigo='A-670' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ARELY DIAZ JOSIAS LOPEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-670';
  else
    v_omitidos := array_append(v_omitidos, 'A-670');
  end if;
  if exists (select 1 from public.puestos where codigo='A-671' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDGAR CHAUCA FERNANDEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-671';
  else
    v_omitidos := array_append(v_omitidos, 'A-671');
  end if;
  if exists (select 1 from public.puestos where codigo='A-672' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','TORIBIO MAMANI MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-672';
  else
    v_omitidos := array_append(v_omitidos, 'A-672');
  end if;
  if exists (select 1 from public.puestos where codigo='A-673' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDGAR CHAUCA FERNANDEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-673';
  else
    v_omitidos := array_append(v_omitidos, 'A-673');
  end if;
  if exists (select 1 from public.puestos where codigo='A-674' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GABINO QUISPE VARGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-674';
  else
    v_omitidos := array_append(v_omitidos, 'A-674');
  end if;
  if exists (select 1 from public.puestos where codigo='A-675' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARCELINA OVIEDO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-675';
  else
    v_omitidos := array_append(v_omitidos, 'A-675');
  end if;
  if exists (select 1 from public.puestos where codigo='A-676' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GABINO QUISPE VARGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-676';
  else
    v_omitidos := array_append(v_omitidos, 'A-676');
  end if;
  if exists (select 1 from public.puestos where codigo='A-677' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MABEL GUERRERO VILA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-677';
  else
    v_omitidos := array_append(v_omitidos, 'A-677');
  end if;
  if exists (select 1 from public.puestos where codigo='A-678' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MABEL GUERRERO VILA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-678';
  else
    v_omitidos := array_append(v_omitidos, 'A-678');
  end if;
  if exists (select 1 from public.puestos where codigo='A-679' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MABEL GUERRERO VILA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-679';
  else
    v_omitidos := array_append(v_omitidos, 'A-679');
  end if;
  if exists (select 1 from public.puestos where codigo='A-680' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MABEL GUERRERO VILA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-680';
  else
    v_omitidos := array_append(v_omitidos, 'A-680');
  end if;
  if exists (select 1 from public.puestos where codigo='A-681' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANET CESPEDES LOPEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-681';
  else
    v_omitidos := array_append(v_omitidos, 'A-681');
  end if;
  if exists (select 1 from public.puestos where codigo='A-682' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','WILBERT UMAN CORDOVA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-682';
  else
    v_omitidos := array_append(v_omitidos, 'A-682');
  end if;
  if exists (select 1 from public.puestos where codigo='A-683' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANET CESPEDES LOPEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-683';
  else
    v_omitidos := array_append(v_omitidos, 'A-683');
  end if;
  if exists (select 1 from public.puestos where codigo='A-684' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','WILBERT UMAN CORDOVA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-684';
  else
    v_omitidos := array_append(v_omitidos, 'A-684');
  end if;
  if exists (select 1 from public.puestos where codigo='A-685' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIA CALLATA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-685';
  else
    v_omitidos := array_append(v_omitidos, 'A-685');
  end if;
  if exists (select 1 from public.puestos where codigo='A-686' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MONICA GUZMAN BOHORQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-686';
  else
    v_omitidos := array_append(v_omitidos, 'A-686');
  end if;
  if exists (select 1 from public.puestos where codigo='A-688' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MONICA GUZMAN BOHORQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-688';
  else
    v_omitidos := array_append(v_omitidos, 'A-688');
  end if;
  if exists (select 1 from public.puestos where codigo='A-691' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HAYDEE SARMIENTO GONZALO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-691';
  else
    v_omitidos := array_append(v_omitidos, 'A-691');
  end if;
  if exists (select 1 from public.puestos where codigo='A-701' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VIANIY PALOMINO MUÑOZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-701';
  else
    v_omitidos := array_append(v_omitidos, 'A-701');
  end if;
  if exists (select 1 from public.puestos where codigo='A-702' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDWAR MUÑOZ BOZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-702';
  else
    v_omitidos := array_append(v_omitidos, 'A-702');
  end if;
  if exists (select 1 from public.puestos where codigo='A-703' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ERASMO GUTIERREZ ORTIZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-703';
  else
    v_omitidos := array_append(v_omitidos, 'A-703');
  end if;
  if exists (select 1 from public.puestos where codigo='A-704' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDWAR MUÑOZ BOZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-704';
  else
    v_omitidos := array_append(v_omitidos, 'A-704');
  end if;
  if exists (select 1 from public.puestos where codigo='A-705' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VIANIY PALOMINO MUÑOZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-705';
  else
    v_omitidos := array_append(v_omitidos, 'A-705');
  end if;
  if exists (select 1 from public.puestos where codigo='A-706' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ERICK KERWIN QUISPE FERNANDEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-706';
  else
    v_omitidos := array_append(v_omitidos, 'A-706');
  end if;
  if exists (select 1 from public.puestos where codigo='A-707' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VIANIY PALOMINO MUÑOZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-707';
  else
    v_omitidos := array_append(v_omitidos, 'A-707');
  end if;
  if exists (select 1 from public.puestos where codigo='A-708' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LIDIA VIRGINIA PADILLA ORTEGA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-708';
  else
    v_omitidos := array_append(v_omitidos, 'A-708');
  end if;
  if exists (select 1 from public.puestos where codigo='A-709' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EUFEMIA QUISPE HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-709';
  else
    v_omitidos := array_append(v_omitidos, 'A-709');
  end if;
  if exists (select 1 from public.puestos where codigo='A-710' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','FREDDY GUTIERREZ ESCRIBA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-710';
  else
    v_omitidos := array_append(v_omitidos, 'A-710');
  end if;
  if exists (select 1 from public.puestos where codigo='A-711' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN TTUPA PERALTA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-711';
  else
    v_omitidos := array_append(v_omitidos, 'A-711');
  end if;
  if exists (select 1 from public.puestos where codigo='A-712' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RAQUEL POLICARPO CASTILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-712';
  else
    v_omitidos := array_append(v_omitidos, 'A-712');
  end if;
  if exists (select 1 from public.puestos where codigo='A-713' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN TTUPA PERALTA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-713';
  else
    v_omitidos := array_append(v_omitidos, 'A-713');
  end if;
  if exists (select 1 from public.puestos where codigo='A-714' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RAQUEL POLICARPO CASTILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-714';
  else
    v_omitidos := array_append(v_omitidos, 'A-714');
  end if;
  if exists (select 1 from public.puestos where codigo='A-716' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YOSLIN GABRIEL GUIVARRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-716';
  else
    v_omitidos := array_append(v_omitidos, 'A-716');
  end if;
  if exists (select 1 from public.puestos where codigo='A-717' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIA VILMA ELIAS MORE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-717';
  else
    v_omitidos := array_append(v_omitidos, 'A-717');
  end if;
  if exists (select 1 from public.puestos where codigo='A-718' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RONY LUIS CARHUANCHO GUZMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-718';
  else
    v_omitidos := array_append(v_omitidos, 'A-718');
  end if;
  if exists (select 1 from public.puestos where codigo='A-719' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIA VILMA ELIAS MORE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-719';
  else
    v_omitidos := array_append(v_omitidos, 'A-719');
  end if;
  if exists (select 1 from public.puestos where codigo='A-720' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RONY LUIS CARHUANCHO GUZMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-720';
  else
    v_omitidos := array_append(v_omitidos, 'A-720');
  end if;
  if exists (select 1 from public.puestos where codigo='A-721' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN TTUPA PERALTA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-721';
  else
    v_omitidos := array_append(v_omitidos, 'A-721');
  end if;
  if exists (select 1 from public.puestos where codigo='A-722' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALCIDES BARZOLA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-722';
  else
    v_omitidos := array_append(v_omitidos, 'A-722');
  end if;
  if exists (select 1 from public.puestos where codigo='A-723' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN TTUPA PERALTA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-723';
  else
    v_omitidos := array_append(v_omitidos, 'A-723');
  end if;
  if exists (select 1 from public.puestos where codigo='A-724' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALCIDES BARZOLA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-724';
  else
    v_omitidos := array_append(v_omitidos, 'A-724');
  end if;
  if exists (select 1 from public.puestos where codigo='A-731' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','WILBERT UMAN CORDOVA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-731';
  else
    v_omitidos := array_append(v_omitidos, 'A-731');
  end if;
  if exists (select 1 from public.puestos where codigo='A-732' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARICIELO ALEXANDRA QUISPE CACERES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-732';
  else
    v_omitidos := array_append(v_omitidos, 'A-732');
  end if;
  if exists (select 1 from public.puestos where codigo='A-733' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','WILBERT UMAN CORDOVA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-733';
  else
    v_omitidos := array_append(v_omitidos, 'A-733');
  end if;
  if exists (select 1 from public.puestos where codigo='A-735' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','WILBERT UMAN CORDOVA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-735';
  else
    v_omitidos := array_append(v_omitidos, 'A-735');
  end if;
  if exists (select 1 from public.puestos where codigo='A-737' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AGUSTIN UMAN LIGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-737';
  else
    v_omitidos := array_append(v_omitidos, 'A-737');
  end if;
  if exists (select 1 from public.puestos where codigo='A-738' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','IVAN CHIROQUE SANDOVAL','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-738';
  else
    v_omitidos := array_append(v_omitidos, 'A-738');
  end if;
  if exists (select 1 from public.puestos where codigo='A-739' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PEDRO ECHEVARRIA LAGUNA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-739';
  else
    v_omitidos := array_append(v_omitidos, 'A-739');
  end if;
  if exists (select 1 from public.puestos where codigo='A-740' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','IVAN CHIROQUE SANDOVAL','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-740';
  else
    v_omitidos := array_append(v_omitidos, 'A-740');
  end if;
  if exists (select 1 from public.puestos where codigo='A-741' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LIDIA VIRGINIA PADILLA ORTEGA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-741';
  else
    v_omitidos := array_append(v_omitidos, 'A-741');
  end if;
  if exists (select 1 from public.puestos where codigo='A-742' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAQUELINE GABRIEL GUIVARRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-742';
  else
    v_omitidos := array_append(v_omitidos, 'A-742');
  end if;
  if exists (select 1 from public.puestos where codigo='A-743' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LIDIA VIRGINIA PADILLA ORTEGA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-743';
  else
    v_omitidos := array_append(v_omitidos, 'A-743');
  end if;
  if exists (select 1 from public.puestos where codigo='A-744' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAQUELINE GABRIEL GUIVARRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-744';
  else
    v_omitidos := array_append(v_omitidos, 'A-744');
  end if;
  if exists (select 1 from public.puestos where codigo='A-746' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIA ANGELICA PUCLLA UMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-746';
  else
    v_omitidos := array_append(v_omitidos, 'A-746');
  end if;
  if exists (select 1 from public.puestos where codigo='A-747' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NELIDA ROJAS CASAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-747';
  else
    v_omitidos := array_append(v_omitidos, 'A-747');
  end if;
  if exists (select 1 from public.puestos where codigo='A-748' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIA ANGELICA PUCLLA UMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-748';
  else
    v_omitidos := array_append(v_omitidos, 'A-748');
  end if;
  if exists (select 1 from public.puestos where codigo='A-750' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ERNESTO VARGAS PUCLLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-750';
  else
    v_omitidos := array_append(v_omitidos, 'A-750');
  end if;
  if exists (select 1 from public.puestos where codigo='A-751' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RONAL CUBAS QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-751';
  else
    v_omitidos := array_append(v_omitidos, 'A-751');
  end if;
  if exists (select 1 from public.puestos where codigo='A-752' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MONICA GUZMAN BOHORQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-752';
  else
    v_omitidos := array_append(v_omitidos, 'A-752');
  end if;
  if exists (select 1 from public.puestos where codigo='A-753' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RONAL CUBAS QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-753';
  else
    v_omitidos := array_append(v_omitidos, 'A-753');
  end if;
  if exists (select 1 from public.puestos where codigo='A-754' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MONICA GUZMAN BOHORQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-754';
  else
    v_omitidos := array_append(v_omitidos, 'A-754');
  end if;
  if exists (select 1 from public.puestos where codigo='A-755' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARYORI GRIETA BARZOLA ORE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-755';
  else
    v_omitidos := array_append(v_omitidos, 'A-755');
  end if;
  if exists (select 1 from public.puestos where codigo='A-756' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIRTHA RIVERA ALARCON','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-756';
  else
    v_omitidos := array_append(v_omitidos, 'A-756');
  end if;
  if exists (select 1 from public.puestos where codigo='A-757' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAKELINE VEGA AGUILAR','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-757';
  else
    v_omitidos := array_append(v_omitidos, 'A-757');
  end if;
  if exists (select 1 from public.puestos where codigo='A-758' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIRTHA RIVERA ALARCON','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-758';
  else
    v_omitidos := array_append(v_omitidos, 'A-758');
  end if;
  if exists (select 1 from public.puestos where codigo='A-759' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HECTOR RUIZ CRISTOBAL','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-759';
  else
    v_omitidos := array_append(v_omitidos, 'A-759');
  end if;
  if exists (select 1 from public.puestos where codigo='A-760' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HECTOR RUIZ CRISTOBAL','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-760';
  else
    v_omitidos := array_append(v_omitidos, 'A-760');
  end if;
  if exists (select 1 from public.puestos where codigo='A-761' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SARA TICONA LOPEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-761';
  else
    v_omitidos := array_append(v_omitidos, 'A-761');
  end if;
  if exists (select 1 from public.puestos where codigo='A-762' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SARA TICONA LOPEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-762';
  else
    v_omitidos := array_append(v_omitidos, 'A-762');
  end if;
  if exists (select 1 from public.puestos where codigo='A-771' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ERASMO GUTIERREZ ORTIZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-771';
  else
    v_omitidos := array_append(v_omitidos, 'A-771');
  end if;
  if exists (select 1 from public.puestos where codigo='A-772' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JACINTO CONDORI AYBAR','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-772';
  else
    v_omitidos := array_append(v_omitidos, 'A-772');
  end if;
  if exists (select 1 from public.puestos where codigo='A-773' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA CELESTINA SANTOS SANTOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-773';
  else
    v_omitidos := array_append(v_omitidos, 'A-773');
  end if;
  if exists (select 1 from public.puestos where codigo='A-774' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JACINTO CONDORI AYBAR','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-774';
  else
    v_omitidos := array_append(v_omitidos, 'A-774');
  end if;
  if exists (select 1 from public.puestos where codigo='A-775' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ERASMO GUTIERREZ ORTIZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-775';
  else
    v_omitidos := array_append(v_omitidos, 'A-775');
  end if;
  if exists (select 1 from public.puestos where codigo='A-776' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARYLUZ SEVILLANO MORENO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-776';
  else
    v_omitidos := array_append(v_omitidos, 'A-776');
  end if;
  if exists (select 1 from public.puestos where codigo='A-777' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ERASMO GUTIERREZ ORTIZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-777';
  else
    v_omitidos := array_append(v_omitidos, 'A-777');
  end if;
  if exists (select 1 from public.puestos where codigo='A-778' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARYLUZ SEVILLANO MORENO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-778';
  else
    v_omitidos := array_append(v_omitidos, 'A-778');
  end if;
  if exists (select 1 from public.puestos where codigo='A-779' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','WILDER HINOSTROZA VASQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-779';
  else
    v_omitidos := array_append(v_omitidos, 'A-779');
  end if;
  if exists (select 1 from public.puestos where codigo='A-780' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','WILDER HINOSTROZA VASQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-780';
  else
    v_omitidos := array_append(v_omitidos, 'A-780');
  end if;
  if exists (select 1 from public.puestos where codigo='A-781' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','KAREN ORELLANA BALBIN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-781';
  else
    v_omitidos := array_append(v_omitidos, 'A-781');
  end if;
  if exists (select 1 from public.puestos where codigo='A-782' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JOSSELIN SARMIENTO GUERRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-782';
  else
    v_omitidos := array_append(v_omitidos, 'A-782');
  end if;
  if exists (select 1 from public.puestos where codigo='A-783' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','KAREN ORELLANA BALBIN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-783';
  else
    v_omitidos := array_append(v_omitidos, 'A-783');
  end if;
  if exists (select 1 from public.puestos where codigo='A-784' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JOSSELIN SARMIENTO GUERRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-784';
  else
    v_omitidos := array_append(v_omitidos, 'A-784');
  end if;
  if exists (select 1 from public.puestos where codigo='A-785' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANELI MEJIA FLORES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-785';
  else
    v_omitidos := array_append(v_omitidos, 'A-785');
  end if;
  if exists (select 1 from public.puestos where codigo='A-786' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JOSSELIN SARMIENTO GUERRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-786';
  else
    v_omitidos := array_append(v_omitidos, 'A-786');
  end if;
  if exists (select 1 from public.puestos where codigo='A-787' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANELI MEJIA FLORES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-787';
  else
    v_omitidos := array_append(v_omitidos, 'A-787');
  end if;
  if exists (select 1 from public.puestos where codigo='A-788' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JOSSELIN SARMIENTO GUERRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-788';
  else
    v_omitidos := array_append(v_omitidos, 'A-788');
  end if;
  if exists (select 1 from public.puestos where codigo='A-789' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDGAR CHAUCA FERNANDEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-789';
  else
    v_omitidos := array_append(v_omitidos, 'A-789');
  end if;
  if exists (select 1 from public.puestos where codigo='A-790' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JOSSELIN SARMIENTO GUERRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-790';
  else
    v_omitidos := array_append(v_omitidos, 'A-790');
  end if;
  if exists (select 1 from public.puestos where codigo='A-801' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHONATAN LOPEZ SILVA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-801';
  else
    v_omitidos := array_append(v_omitidos, 'A-801');
  end if;
  if exists (select 1 from public.puestos where codigo='A-802' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHONATAN LOPEZ SILVA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-802';
  else
    v_omitidos := array_append(v_omitidos, 'A-802');
  end if;
  if exists (select 1 from public.puestos where codigo='A-803' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN TTUPA PERALTA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-803';
  else
    v_omitidos := array_append(v_omitidos, 'A-803');
  end if;
  if exists (select 1 from public.puestos where codigo='A-804' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JANS ALBERT CAQUI MAUTINO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-804';
  else
    v_omitidos := array_append(v_omitidos, 'A-804');
  end if;
  if exists (select 1 from public.puestos where codigo='A-807' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LUCIA SACSI TRIVEÑO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-807';
  else
    v_omitidos := array_append(v_omitidos, 'A-807');
  end if;
  if exists (select 1 from public.puestos where codigo='A-809' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LUCIA SACSI TRIVEÑO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-809';
  else
    v_omitidos := array_append(v_omitidos, 'A-809');
  end if;
  if exists (select 1 from public.puestos where codigo='A-810' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANELI MEJIA FLORES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-810';
  else
    v_omitidos := array_append(v_omitidos, 'A-810');
  end if;
  if exists (select 1 from public.puestos where codigo='A-811' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIGUEL ANGEL RODRIGUEZ BOHORQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-811';
  else
    v_omitidos := array_append(v_omitidos, 'A-811');
  end if;
  if exists (select 1 from public.puestos where codigo='A-813' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MIGUEL ANGEL RODRIGUEZ BOHORQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-813';
  else
    v_omitidos := array_append(v_omitidos, 'A-813');
  end if;
  if exists (select 1 from public.puestos where codigo='A-821' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YURI GUARDAMINO DELGADILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-821';
  else
    v_omitidos := array_append(v_omitidos, 'A-821');
  end if;
  if exists (select 1 from public.puestos where codigo='A-822' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANET URETA CAMPOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-822';
  else
    v_omitidos := array_append(v_omitidos, 'A-822');
  end if;
  if exists (select 1 from public.puestos where codigo='A-823' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YURI GUARDAMINO DELGADILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-823';
  else
    v_omitidos := array_append(v_omitidos, 'A-823');
  end if;
  if exists (select 1 from public.puestos where codigo='A-824' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YANET URETA CAMPOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-824';
  else
    v_omitidos := array_append(v_omitidos, 'A-824');
  end if;
  if exists (select 1 from public.puestos where codigo='A-825' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAKELINE VEGA AGUILAR','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-825';
  else
    v_omitidos := array_append(v_omitidos, 'A-825');
  end if;
  if exists (select 1 from public.puestos where codigo='A-826' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ADRIAN SARMIENTO GUERRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-826';
  else
    v_omitidos := array_append(v_omitidos, 'A-826');
  end if;
  if exists (select 1 from public.puestos where codigo='A-827' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ADRIAN SARMIENTO GUERRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-827';
  else
    v_omitidos := array_append(v_omitidos, 'A-827');
  end if;
  if exists (select 1 from public.puestos where codigo='A-828' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ADRIAN SARMIENTO GUERRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-828';
  else
    v_omitidos := array_append(v_omitidos, 'A-828');
  end if;
  if exists (select 1 from public.puestos where codigo='A-829' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ADRIAN SARMIENTO GUERRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-829';
  else
    v_omitidos := array_append(v_omitidos, 'A-829');
  end if;
  if exists (select 1 from public.puestos where codigo='A-830' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ADRIAN SARMIENTO GUERRA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-830';
  else
    v_omitidos := array_append(v_omitidos, 'A-830');
  end if;
  if exists (select 1 from public.puestos where codigo='A-831' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN HUAMAN MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-831';
  else
    v_omitidos := array_append(v_omitidos, 'A-831');
  end if;
  if exists (select 1 from public.puestos where codigo='A-832' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN HUAMAN MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-832';
  else
    v_omitidos := array_append(v_omitidos, 'A-832');
  end if;
  if exists (select 1 from public.puestos where codigo='A-833' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALICIA DORA TICONA CASILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-833';
  else
    v_omitidos := array_append(v_omitidos, 'A-833');
  end if;
  if exists (select 1 from public.puestos where codigo='A-834' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DELIA BULEGE RAMIREZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-834';
  else
    v_omitidos := array_append(v_omitidos, 'A-834');
  end if;
  if exists (select 1 from public.puestos where codigo='A-835' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MILAGROS SALVATIERRA LLOCLLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-835';
  else
    v_omitidos := array_append(v_omitidos, 'A-835');
  end if;
  if exists (select 1 from public.puestos where codigo='A-836' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','DELIA BULEGE RAMIREZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-836';
  else
    v_omitidos := array_append(v_omitidos, 'A-836');
  end if;
  if exists (select 1 from public.puestos where codigo='A-837' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLADYS MAMANI UMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-837';
  else
    v_omitidos := array_append(v_omitidos, 'A-837');
  end if;
  if exists (select 1 from public.puestos where codigo='A-838' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANA MELVA RODRIGUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-838';
  else
    v_omitidos := array_append(v_omitidos, 'A-838');
  end if;
  if exists (select 1 from public.puestos where codigo='A-839' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLADYS MAMANI UMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-839';
  else
    v_omitidos := array_append(v_omitidos, 'A-839');
  end if;
  if exists (select 1 from public.puestos where codigo='A-840' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANA MELVA RODRIGUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-840';
  else
    v_omitidos := array_append(v_omitidos, 'A-840');
  end if;
  if exists (select 1 from public.puestos where codigo='A-841' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIANELA LUZ AGUILAR TORRES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-841';
  else
    v_omitidos := array_append(v_omitidos, 'A-841');
  end if;
  if exists (select 1 from public.puestos where codigo='A-842' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AGUSTIN ALEJANDRO RETUERTO VERGARA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-842';
  else
    v_omitidos := array_append(v_omitidos, 'A-842');
  end if;
  if exists (select 1 from public.puestos where codigo='A-843' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIANELA LUZ AGUILAR TORRES','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-843';
  else
    v_omitidos := array_append(v_omitidos, 'A-843');
  end if;
  if exists (select 1 from public.puestos where codigo='A-844' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AGUSTIN ALEJANDRO RETUERTO VERGARA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-844';
  else
    v_omitidos := array_append(v_omitidos, 'A-844');
  end if;
  if exists (select 1 from public.puestos where codigo='A-845' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LUCIA SACSI TRIVEÑO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-845';
  else
    v_omitidos := array_append(v_omitidos, 'A-845');
  end if;
  if exists (select 1 from public.puestos where codigo='A-846' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','K´ANTU KELLY CCONCHURO HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-846';
  else
    v_omitidos := array_append(v_omitidos, 'A-846');
  end if;
  if exists (select 1 from public.puestos where codigo='A-847' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PEDRO ECHEVARRIA LAGUNA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-847';
  else
    v_omitidos := array_append(v_omitidos, 'A-847');
  end if;
  if exists (select 1 from public.puestos where codigo='A-848' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','K´ANTU KELLY CCONCHURO HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-848';
  else
    v_omitidos := array_append(v_omitidos, 'A-848');
  end if;
  if exists (select 1 from public.puestos where codigo='A-851' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA CELESTINA SANTOS SANTOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-851';
  else
    v_omitidos := array_append(v_omitidos, 'A-851');
  end if;
  if exists (select 1 from public.puestos where codigo='A-852' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LUZ TUCTO LUCAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-852';
  else
    v_omitidos := array_append(v_omitidos, 'A-852');
  end if;
  if exists (select 1 from public.puestos where codigo='A-853' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUANA CELESTINA SANTOS SANTOS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-853';
  else
    v_omitidos := array_append(v_omitidos, 'A-853');
  end if;
  if exists (select 1 from public.puestos where codigo='A-854' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LUZ TUCTO LUCAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-854';
  else
    v_omitidos := array_append(v_omitidos, 'A-854');
  end if;
  if exists (select 1 from public.puestos where codigo='A-855' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MILAGROS SALVATIERRA LLOCLLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-855';
  else
    v_omitidos := array_append(v_omitidos, 'A-855');
  end if;
  if exists (select 1 from public.puestos where codigo='A-856' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIBEL HINOSTROZA VASQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-856';
  else
    v_omitidos := array_append(v_omitidos, 'A-856');
  end if;
  if exists (select 1 from public.puestos where codigo='A-857' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIBEL HINOSTROZA VASQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-857';
  else
    v_omitidos := array_append(v_omitidos, 'A-857');
  end if;
  if exists (select 1 from public.puestos where codigo='A-858' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIBEL HINOSTROZA VASQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-858';
  else
    v_omitidos := array_append(v_omitidos, 'A-858');
  end if;
  if exists (select 1 from public.puestos where codigo='A-859' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIBEL HINOSTROZA VASQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-859';
  else
    v_omitidos := array_append(v_omitidos, 'A-859');
  end if;
  if exists (select 1 from public.puestos where codigo='A-860' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIBEL HINOSTROZA VASQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-860';
  else
    v_omitidos := array_append(v_omitidos, 'A-860');
  end if;
  if exists (select 1 from public.puestos where codigo='A-861' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LINDA UMAN PADILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-861';
  else
    v_omitidos := array_append(v_omitidos, 'A-861');
  end if;
  if exists (select 1 from public.puestos where codigo='A-862' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NANCY MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-862';
  else
    v_omitidos := array_append(v_omitidos, 'A-862');
  end if;
  if exists (select 1 from public.puestos where codigo='A-863' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','LINDA UMAN PADILLA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-863';
  else
    v_omitidos := array_append(v_omitidos, 'A-863');
  end if;
  if exists (select 1 from public.puestos where codigo='A-864' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NANCY MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-864';
  else
    v_omitidos := array_append(v_omitidos, 'A-864');
  end if;
  if exists (select 1 from public.puestos where codigo='A-866' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AGUSTIN UMAN LIGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-866';
  else
    v_omitidos := array_append(v_omitidos, 'A-866');
  end if;
  if exists (select 1 from public.puestos where codigo='A-867' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EUFEMIA QUISPE HUAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-867';
  else
    v_omitidos := array_append(v_omitidos, 'A-867');
  end if;
  if exists (select 1 from public.puestos where codigo='A-869' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AGUSTIN UMAN LIGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-869';
  else
    v_omitidos := array_append(v_omitidos, 'A-869');
  end if;
  if exists (select 1 from public.puestos where codigo='A-870' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AGUSTIN UMAN LIGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-870';
  else
    v_omitidos := array_append(v_omitidos, 'A-870');
  end if;
  if exists (select 1 from public.puestos where codigo='A-871' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','FRANK ALEXIS PANTA MEZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-871';
  else
    v_omitidos := array_append(v_omitidos, 'A-871');
  end if;
  if exists (select 1 from public.puestos where codigo='A-872' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','FRANK ALEXIS PANTA MEZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-872';
  else
    v_omitidos := array_append(v_omitidos, 'A-872');
  end if;
  if exists (select 1 from public.puestos where codigo='A-873' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','FRANK ALEXIS PANTA MEZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-873';
  else
    v_omitidos := array_append(v_omitidos, 'A-873');
  end if;
  if exists (select 1 from public.puestos where codigo='A-874' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','FRANK ALEXIS PANTA MEZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-874';
  else
    v_omitidos := array_append(v_omitidos, 'A-874');
  end if;
  if exists (select 1 from public.puestos where codigo='A-877' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VIRGINIA GUTIERREZ VELAZQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-877';
  else
    v_omitidos := array_append(v_omitidos, 'A-877');
  end if;
  if exists (select 1 from public.puestos where codigo='A-878' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDER ALANIA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-878';
  else
    v_omitidos := array_append(v_omitidos, 'A-878');
  end if;
  if exists (select 1 from public.puestos where codigo='A-879' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','VIRGINIA GUTIERREZ VELAZQUE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-879';
  else
    v_omitidos := array_append(v_omitidos, 'A-879');
  end if;
  if exists (select 1 from public.puestos where codigo='A-880' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDER ALANIA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-880';
  else
    v_omitidos := array_append(v_omitidos, 'A-880');
  end if;
  if exists (select 1 from public.puestos where codigo='A-881' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN ADAN ZAVALA TAMAYO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-881';
  else
    v_omitidos := array_append(v_omitidos, 'A-881');
  end if;
  if exists (select 1 from public.puestos where codigo='A-882' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARTHA LLOCCE CASTILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-882';
  else
    v_omitidos := array_append(v_omitidos, 'A-882');
  end if;
  if exists (select 1 from public.puestos where codigo='A-883' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN ADAN ZAVALA TAMAYO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-883';
  else
    v_omitidos := array_append(v_omitidos, 'A-883');
  end if;
  if exists (select 1 from public.puestos where codigo='A-884' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARTHA LLOCCE CASTILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-884';
  else
    v_omitidos := array_append(v_omitidos, 'A-884');
  end if;
  if exists (select 1 from public.puestos where codigo='A-885' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN ADAN ZAVALA TAMAYO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-885';
  else
    v_omitidos := array_append(v_omitidos, 'A-885');
  end if;
  if exists (select 1 from public.puestos where codigo='A-886' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARTHA LLOCCE CASTILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-886';
  else
    v_omitidos := array_append(v_omitidos, 'A-886');
  end if;
  if exists (select 1 from public.puestos where codigo='A-887' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CELINDA SILVIA MOLINA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-887';
  else
    v_omitidos := array_append(v_omitidos, 'A-887');
  end if;
  if exists (select 1 from public.puestos where codigo='A-888' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HECTOR CERVANTES CASTRO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-888';
  else
    v_omitidos := array_append(v_omitidos, 'A-888');
  end if;
  if exists (select 1 from public.puestos where codigo='A-889' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARITZA ESTHER MEDINA RAYMUNDEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-889';
  else
    v_omitidos := array_append(v_omitidos, 'A-889');
  end if;
  if exists (select 1 from public.puestos where codigo='A-890' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HECTOR CERVANTES CASTRO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-890';
  else
    v_omitidos := array_append(v_omitidos, 'A-890');
  end if;
  if exists (select 1 from public.puestos where codigo='A-891' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','TOMASA ARAUJO ARAUJO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-891';
  else
    v_omitidos := array_append(v_omitidos, 'A-891');
  end if;
  if exists (select 1 from public.puestos where codigo='A-892' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','TOMASA ARAUJO ARAUJO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-892';
  else
    v_omitidos := array_append(v_omitidos, 'A-892');
  end if;
  if exists (select 1 from public.puestos where codigo='A-893' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN HUAMAN MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-893';
  else
    v_omitidos := array_append(v_omitidos, 'A-893');
  end if;
  if exists (select 1 from public.puestos where codigo='A-894' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN HUAMAN MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-894';
  else
    v_omitidos := array_append(v_omitidos, 'A-894');
  end if;
  if exists (select 1 from public.puestos where codigo='A-895' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JAVIER SUBLE HUAMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-895';
  else
    v_omitidos := array_append(v_omitidos, 'A-895');
  end if;
  if exists (select 1 from public.puestos where codigo='A-896' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN HUAMAN MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-896';
  else
    v_omitidos := array_append(v_omitidos, 'A-896');
  end if;
  if exists (select 1 from public.puestos where codigo='A-897' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CESAR GUEVARA AMAYA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-897';
  else
    v_omitidos := array_append(v_omitidos, 'A-897');
  end if;
  if exists (select 1 from public.puestos where codigo='A-898' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN LOPEZ ECHEVARRIA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-898';
  else
    v_omitidos := array_append(v_omitidos, 'A-898');
  end if;
  if exists (select 1 from public.puestos where codigo='A-899' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CESAR GUEVARA AMAYA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-899';
  else
    v_omitidos := array_append(v_omitidos, 'A-899');
  end if;
  if exists (select 1 from public.puestos where codigo='A-900' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN LOPEZ ECHEVARRIA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-900';
  else
    v_omitidos := array_append(v_omitidos, 'A-900');
  end if;
  if exists (select 1 from public.puestos where codigo='A-901' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUMELIA GUERRA CANTORIN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-901';
  else
    v_omitidos := array_append(v_omitidos, 'A-901');
  end if;
  if exists (select 1 from public.puestos where codigo='A-902' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUMELIA GUERRA CANTORIN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-902';
  else
    v_omitidos := array_append(v_omitidos, 'A-902');
  end if;
  if exists (select 1 from public.puestos where codigo='A-903' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUMELIA GUERRA CANTORIN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-903';
  else
    v_omitidos := array_append(v_omitidos, 'A-903');
  end if;
  if exists (select 1 from public.puestos where codigo='A-904' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUMELIA GUERRA CANTORIN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-904';
  else
    v_omitidos := array_append(v_omitidos, 'A-904');
  end if;
  if exists (select 1 from public.puestos where codigo='A-905' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUMELIA GUERRA CANTORIN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-905';
  else
    v_omitidos := array_append(v_omitidos, 'A-905');
  end if;
  if exists (select 1 from public.puestos where codigo='A-906' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ALDAIR FABIAM PUJAY ROJAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-906';
  else
    v_omitidos := array_append(v_omitidos, 'A-906');
  end if;
  if exists (select 1 from public.puestos where codigo='A-907' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','SARA TICONA LOPEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-907';
  else
    v_omitidos := array_append(v_omitidos, 'A-907');
  end if;
  if exists (select 1 from public.puestos where codigo='A-908' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSA ALVARADO MEZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-908';
  else
    v_omitidos := array_append(v_omitidos, 'A-908');
  end if;
  if exists (select 1 from public.puestos where codigo='A-909' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIA ANGELICA PUCLLA UMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-909';
  else
    v_omitidos := array_append(v_omitidos, 'A-909');
  end if;
  if exists (select 1 from public.puestos where codigo='A-910' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSA ALVARADO MEZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='A-910';
  else
    v_omitidos := array_append(v_omitidos, 'A-910');
  end if;
  if exists (select 1 from public.puestos where codigo='S-911' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-911';
  else
    v_omitidos := array_append(v_omitidos, 'S-911');
  end if;
  if exists (select 1 from public.puestos where codigo='S-912' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-912';
  else
    v_omitidos := array_append(v_omitidos, 'S-912');
  end if;
  if exists (select 1 from public.puestos where codigo='S-913' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-913';
  else
    v_omitidos := array_append(v_omitidos, 'S-913');
  end if;
  if exists (select 1 from public.puestos where codigo='S-914' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-914';
  else
    v_omitidos := array_append(v_omitidos, 'S-914');
  end if;
  if exists (select 1 from public.puestos where codigo='S-915' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-915';
  else
    v_omitidos := array_append(v_omitidos, 'S-915');
  end if;
  if exists (select 1 from public.puestos where codigo='S-916' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-916';
  else
    v_omitidos := array_append(v_omitidos, 'S-916');
  end if;
  if exists (select 1 from public.puestos where codigo='S-917' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-917';
  else
    v_omitidos := array_append(v_omitidos, 'S-917');
  end if;
  if exists (select 1 from public.puestos where codigo='S-918' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-918';
  else
    v_omitidos := array_append(v_omitidos, 'S-918');
  end if;
  if exists (select 1 from public.puestos where codigo='S-919' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-919';
  else
    v_omitidos := array_append(v_omitidos, 'S-919');
  end if;
  if exists (select 1 from public.puestos where codigo='S-920' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-920';
  else
    v_omitidos := array_append(v_omitidos, 'S-920');
  end if;
  if exists (select 1 from public.puestos where codigo='S-921' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-921';
  else
    v_omitidos := array_append(v_omitidos, 'S-921');
  end if;
  if exists (select 1 from public.puestos where codigo='S-922' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-922';
  else
    v_omitidos := array_append(v_omitidos, 'S-922');
  end if;
  if exists (select 1 from public.puestos where codigo='S-923' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-923';
  else
    v_omitidos := array_append(v_omitidos, 'S-923');
  end if;
  if exists (select 1 from public.puestos where codigo='S-924' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-924';
  else
    v_omitidos := array_append(v_omitidos, 'S-924');
  end if;
  if exists (select 1 from public.puestos where codigo='S-925' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-925';
  else
    v_omitidos := array_append(v_omitidos, 'S-925');
  end if;
  if exists (select 1 from public.puestos where codigo='S-926' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-926';
  else
    v_omitidos := array_append(v_omitidos, 'S-926');
  end if;
  if exists (select 1 from public.puestos where codigo='S-927' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-927';
  else
    v_omitidos := array_append(v_omitidos, 'S-927');
  end if;
  if exists (select 1 from public.puestos where codigo='S-928' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-928';
  else
    v_omitidos := array_append(v_omitidos, 'S-928');
  end if;
  if exists (select 1 from public.puestos where codigo='S-929' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-929';
  else
    v_omitidos := array_append(v_omitidos, 'S-929');
  end if;
  if exists (select 1 from public.puestos where codigo='S-930' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-930';
  else
    v_omitidos := array_append(v_omitidos, 'S-930');
  end if;
  if exists (select 1 from public.puestos where codigo='S-931' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-931';
  else
    v_omitidos := array_append(v_omitidos, 'S-931');
  end if;
  if exists (select 1 from public.puestos where codigo='S-932' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-932';
  else
    v_omitidos := array_append(v_omitidos, 'S-932');
  end if;
  if exists (select 1 from public.puestos where codigo='S-933' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-933';
  else
    v_omitidos := array_append(v_omitidos, 'S-933');
  end if;
  if exists (select 1 from public.puestos where codigo='S-934' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-934';
  else
    v_omitidos := array_append(v_omitidos, 'S-934');
  end if;
  if exists (select 1 from public.puestos where codigo='S-935' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-935';
  else
    v_omitidos := array_append(v_omitidos, 'S-935');
  end if;
  if exists (select 1 from public.puestos where codigo='S-936' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-936';
  else
    v_omitidos := array_append(v_omitidos, 'S-936');
  end if;
  if exists (select 1 from public.puestos where codigo='S-937' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-937';
  else
    v_omitidos := array_append(v_omitidos, 'S-937');
  end if;
  if exists (select 1 from public.puestos where codigo='S-938' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-938';
  else
    v_omitidos := array_append(v_omitidos, 'S-938');
  end if;
  if exists (select 1 from public.puestos where codigo='S-939' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-939';
  else
    v_omitidos := array_append(v_omitidos, 'S-939');
  end if;
  if exists (select 1 from public.puestos where codigo='S-940' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-940';
  else
    v_omitidos := array_append(v_omitidos, 'S-940');
  end if;
  if exists (select 1 from public.puestos where codigo='S-941' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-941';
  else
    v_omitidos := array_append(v_omitidos, 'S-941');
  end if;
  if exists (select 1 from public.puestos where codigo='S-942' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-942';
  else
    v_omitidos := array_append(v_omitidos, 'S-942');
  end if;
  if exists (select 1 from public.puestos where codigo='S-943' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-943';
  else
    v_omitidos := array_append(v_omitidos, 'S-943');
  end if;
  if exists (select 1 from public.puestos where codigo='S-944' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-944';
  else
    v_omitidos := array_append(v_omitidos, 'S-944');
  end if;
  if exists (select 1 from public.puestos where codigo='S-945' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-945';
  else
    v_omitidos := array_append(v_omitidos, 'S-945');
  end if;
  if exists (select 1 from public.puestos where codigo='S-946' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-946';
  else
    v_omitidos := array_append(v_omitidos, 'S-946');
  end if;
  if exists (select 1 from public.puestos where codigo='S-947' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-947';
  else
    v_omitidos := array_append(v_omitidos, 'S-947');
  end if;
  if exists (select 1 from public.puestos where codigo='S-948' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-948';
  else
    v_omitidos := array_append(v_omitidos, 'S-948');
  end if;
  if exists (select 1 from public.puestos where codigo='S-949' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-949';
  else
    v_omitidos := array_append(v_omitidos, 'S-949');
  end if;
  if exists (select 1 from public.puestos where codigo='S-950' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-950';
  else
    v_omitidos := array_append(v_omitidos, 'S-950');
  end if;
  if exists (select 1 from public.puestos where codigo='S-951' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-951';
  else
    v_omitidos := array_append(v_omitidos, 'S-951');
  end if;
  if exists (select 1 from public.puestos where codigo='S-952' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-952';
  else
    v_omitidos := array_append(v_omitidos, 'S-952');
  end if;
  if exists (select 1 from public.puestos where codigo='S-953' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-953';
  else
    v_omitidos := array_append(v_omitidos, 'S-953');
  end if;
  if exists (select 1 from public.puestos where codigo='S-954' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-954';
  else
    v_omitidos := array_append(v_omitidos, 'S-954');
  end if;
  if exists (select 1 from public.puestos where codigo='S-955' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-955';
  else
    v_omitidos := array_append(v_omitidos, 'S-955');
  end if;
  if exists (select 1 from public.puestos where codigo='S-956' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-956';
  else
    v_omitidos := array_append(v_omitidos, 'S-956');
  end if;
  if exists (select 1 from public.puestos where codigo='S-957' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-957';
  else
    v_omitidos := array_append(v_omitidos, 'S-957');
  end if;
  if exists (select 1 from public.puestos where codigo='S-958' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-958';
  else
    v_omitidos := array_append(v_omitidos, 'S-958');
  end if;
  if exists (select 1 from public.puestos where codigo='S-959' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-959';
  else
    v_omitidos := array_append(v_omitidos, 'S-959');
  end if;
  if exists (select 1 from public.puestos where codigo='S-960' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-960';
  else
    v_omitidos := array_append(v_omitidos, 'S-960');
  end if;
  if exists (select 1 from public.puestos where codigo='S-961' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-961';
  else
    v_omitidos := array_append(v_omitidos, 'S-961');
  end if;
  if exists (select 1 from public.puestos where codigo='S-962' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-962';
  else
    v_omitidos := array_append(v_omitidos, 'S-962');
  end if;
  if exists (select 1 from public.puestos where codigo='S-963' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-963';
  else
    v_omitidos := array_append(v_omitidos, 'S-963');
  end if;
  if exists (select 1 from public.puestos where codigo='S-964' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-964';
  else
    v_omitidos := array_append(v_omitidos, 'S-964');
  end if;
  if exists (select 1 from public.puestos where codigo='S-965' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-965';
  else
    v_omitidos := array_append(v_omitidos, 'S-965');
  end if;
  if exists (select 1 from public.puestos where codigo='S-966' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-966';
  else
    v_omitidos := array_append(v_omitidos, 'S-966');
  end if;
  if exists (select 1 from public.puestos where codigo='S-967' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-967';
  else
    v_omitidos := array_append(v_omitidos, 'S-967');
  end if;
  if exists (select 1 from public.puestos where codigo='S-968' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-968';
  else
    v_omitidos := array_append(v_omitidos, 'S-968');
  end if;
  if exists (select 1 from public.puestos where codigo='S-969' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-969';
  else
    v_omitidos := array_append(v_omitidos, 'S-969');
  end if;
  if exists (select 1 from public.puestos where codigo='S-970' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-970';
  else
    v_omitidos := array_append(v_omitidos, 'S-970');
  end if;
  if exists (select 1 from public.puestos where codigo='S-971' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-971';
  else
    v_omitidos := array_append(v_omitidos, 'S-971');
  end if;
  if exists (select 1 from public.puestos where codigo='S-972' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-972';
  else
    v_omitidos := array_append(v_omitidos, 'S-972');
  end if;
  if exists (select 1 from public.puestos where codigo='S-973' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-973';
  else
    v_omitidos := array_append(v_omitidos, 'S-973');
  end if;
  if exists (select 1 from public.puestos where codigo='S-974' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-974';
  else
    v_omitidos := array_append(v_omitidos, 'S-974');
  end if;
  if exists (select 1 from public.puestos where codigo='S-975' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-975';
  else
    v_omitidos := array_append(v_omitidos, 'S-975');
  end if;
  if exists (select 1 from public.puestos where codigo='S-976' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-976';
  else
    v_omitidos := array_append(v_omitidos, 'S-976');
  end if;
  if exists (select 1 from public.puestos where codigo='S-977' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-977';
  else
    v_omitidos := array_append(v_omitidos, 'S-977');
  end if;
  if exists (select 1 from public.puestos where codigo='S-978' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-978';
  else
    v_omitidos := array_append(v_omitidos, 'S-978');
  end if;
  if exists (select 1 from public.puestos where codigo='S-979' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-979';
  else
    v_omitidos := array_append(v_omitidos, 'S-979');
  end if;
  if exists (select 1 from public.puestos where codigo='S-980' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-980';
  else
    v_omitidos := array_append(v_omitidos, 'S-980');
  end if;
  if exists (select 1 from public.puestos where codigo='S-981' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-981';
  else
    v_omitidos := array_append(v_omitidos, 'S-981');
  end if;
  if exists (select 1 from public.puestos where codigo='S-982' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-982';
  else
    v_omitidos := array_append(v_omitidos, 'S-982');
  end if;
  if exists (select 1 from public.puestos where codigo='S-983' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-983';
  else
    v_omitidos := array_append(v_omitidos, 'S-983');
  end if;
  if exists (select 1 from public.puestos where codigo='S-984' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-984';
  else
    v_omitidos := array_append(v_omitidos, 'S-984');
  end if;
  if exists (select 1 from public.puestos where codigo='S-985' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-985';
  else
    v_omitidos := array_append(v_omitidos, 'S-985');
  end if;
  if exists (select 1 from public.puestos where codigo='S-986' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','PROMMASA PROMMASA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='S-986';
  else
    v_omitidos := array_append(v_omitidos, 'S-986');
  end if;
  if exists (select 1 from public.puestos where codigo='C-987' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLADYS MAMANI UMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-987';
  else
    v_omitidos := array_append(v_omitidos, 'C-987');
  end if;
  if exists (select 1 from public.puestos where codigo='C-988' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLADYS MAMANI UMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-988';
  else
    v_omitidos := array_append(v_omitidos, 'C-988');
  end if;
  if exists (select 1 from public.puestos where codigo='C-989' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARLENY GARCIA RIVAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-989';
  else
    v_omitidos := array_append(v_omitidos, 'C-989');
  end if;
  if exists (select 1 from public.puestos where codigo='C-990' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANA MELVA RODRIGUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-990';
  else
    v_omitidos := array_append(v_omitidos, 'C-990');
  end if;
  if exists (select 1 from public.puestos where codigo='C-991' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CESAR GUEVARA AMAYA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-991';
  else
    v_omitidos := array_append(v_omitidos, 'C-991');
  end if;
  if exists (select 1 from public.puestos where codigo='C-992' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GLADYS MAMANI UMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-992';
  else
    v_omitidos := array_append(v_omitidos, 'C-992');
  end if;
  if exists (select 1 from public.puestos where codigo='C-993' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CESAR GUEVARA AMAYA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-993';
  else
    v_omitidos := array_append(v_omitidos, 'C-993');
  end if;
  if exists (select 1 from public.puestos where codigo='C-994' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CHARO ORTIZ MONTENGRO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-994';
  else
    v_omitidos := array_append(v_omitidos, 'C-994');
  end if;
  if exists (select 1 from public.puestos where codigo='C-995' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NAYDA MAYHUA HUAMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-995';
  else
    v_omitidos := array_append(v_omitidos, 'C-995');
  end if;
  if exists (select 1 from public.puestos where codigo='C-996' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NAYDA MAYHUA HUAMAN','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-996';
  else
    v_omitidos := array_append(v_omitidos, 'C-996');
  end if;
  if exists (select 1 from public.puestos where codigo='C-997' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHONNY ERICKSON GUTIERREZ TICONA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-997';
  else
    v_omitidos := array_append(v_omitidos, 'C-997');
  end if;
  if exists (select 1 from public.puestos where codigo='C-998' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANA ASCOY SALCEDO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-998';
  else
    v_omitidos := array_append(v_omitidos, 'C-998');
  end if;
  if exists (select 1 from public.puestos where codigo='C-999' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANA ASCOY SALCEDO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-999';
  else
    v_omitidos := array_append(v_omitidos, 'C-999');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1000' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDGAR CHAUCA FERNANDEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1000';
  else
    v_omitidos := array_append(v_omitidos, 'C-1000');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1001' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','EDGAR CHAUCA FERNANDEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1001';
  else
    v_omitidos := array_append(v_omitidos, 'C-1001');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1002' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','WILDER HINOSTROZA VASQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1002';
  else
    v_omitidos := array_append(v_omitidos, 'C-1002');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1003' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','CELINDA SILVIA MOLINA QUISPE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1003';
  else
    v_omitidos := array_append(v_omitidos, 'C-1003');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1004' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YONY FERRER','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1004';
  else
    v_omitidos := array_append(v_omitidos, 'C-1004');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1005' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','YONY FERRER','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1005';
  else
    v_omitidos := array_append(v_omitidos, 'C-1005');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1006' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','AGUSTIN UMAN LIGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1006';
  else
    v_omitidos := array_append(v_omitidos, 'C-1006');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1007' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MAURO CONOVILCA PASTRNA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1007';
  else
    v_omitidos := array_append(v_omitidos, 'C-1007');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1008' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARLENY GARCIA RIVAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1008';
  else
    v_omitidos := array_append(v_omitidos, 'C-1008');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1009' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARLENY GARCIA RIVAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1009';
  else
    v_omitidos := array_append(v_omitidos, 'C-1009');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1010' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RAQUEL POLICARPO CASTILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1010';
  else
    v_omitidos := array_append(v_omitidos, 'C-1010');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1011' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ABEL BARZOLA OSORIO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1011';
  else
    v_omitidos := array_append(v_omitidos, 'C-1011');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1012' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','HERBERT OBREGON','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1012';
  else
    v_omitidos := array_append(v_omitidos, 'C-1012');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1013' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ANDERSON MARAVI MOLINA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1013';
  else
    v_omitidos := array_append(v_omitidos, 'C-1013');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1014' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MONICA GUZMAN BOHORQUEZ','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1014';
  else
    v_omitidos := array_append(v_omitidos, 'C-1014');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1015' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARIA VILMA ELIAS MORE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1015';
  else
    v_omitidos := array_append(v_omitidos, 'C-1015');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1016' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JESSICA HUACRE HUACRE','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1016';
  else
    v_omitidos := array_append(v_omitidos, 'C-1016');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1017' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARTHA LLOCCE CASTILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1017';
  else
    v_omitidos := array_append(v_omitidos, 'C-1017');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1018' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','MARTHA LLOCCE CASTILLO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1018';
  else
    v_omitidos := array_append(v_omitidos, 'C-1018');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1019' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JUAN ADAN ZAVALA TAMAYO','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1019';
  else
    v_omitidos := array_append(v_omitidos, 'C-1019');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1020' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','ROSA ALVARADO MEZA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1020';
  else
    v_omitidos := array_append(v_omitidos, 'C-1020');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1021' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHONATAN LOPEZ SILVA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1021';
  else
    v_omitidos := array_append(v_omitidos, 'C-1021');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1022' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','JHONATAN LOPEZ SILVA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1022';
  else
    v_omitidos := array_append(v_omitidos, 'C-1022');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1023' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NANCY MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1023';
  else
    v_omitidos := array_append(v_omitidos, 'C-1023');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1024' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','NANCY MAMANI','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1024';
  else
    v_omitidos := array_append(v_omitidos, 'C-1024');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1025' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','GABINO QUISPE VARGAS','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1025';
  else
    v_omitidos := array_append(v_omitidos, 'C-1025');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1026' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN LOPEZ ECHEVARRIA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1026';
  else
    v_omitidos := array_append(v_omitidos, 'C-1026');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1027' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN LOPEZ ECHEVARRIA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1027';
  else
    v_omitidos := array_append(v_omitidos, 'C-1027');
  end if;
  if exists (select 1 from public.puestos where codigo='C-1028' and estado='vendido') then
    update public.puestos set ocupante=jsonb_build_object('nombre','RUBEN LOPEZ ECHEVARRIA','referencia','PROMMASA'), version=version+1, actualizado_en=now() where codigo='C-1028';
  else
    v_omitidos := array_append(v_omitidos, 'C-1028');
  end if;

  select count(*) into v_total from public.puestos;
  if v_total <> 1028 then raise exception 'Conteo final inesperado: %', v_total; end if;
  raise notice '% filas no tocadas por no estar en estado vendido (revisar a mano): %', coalesce(array_length(v_omitidos,1),0), v_omitidos;
end $$;
