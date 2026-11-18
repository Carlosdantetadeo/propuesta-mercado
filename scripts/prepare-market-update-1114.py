"""Sync to "TABLA DE MERCADO 1028 - SUPER OFICIAL PROMMASA ACTUALIZADOok.xlsx" (2026-11-14),
a cleaned-up version of the source with a single STATUS column (the duplicate-column ambiguity
from the 2026-11-13 file is gone). Confirms 607 vendido / 421 disponible.

Diff against the current baseline (docs/mercado/puestos-extraidos.csv, reflecting the live DB
after the 2026-11-14 column-M correction):
- 10 renamed: V-291..V-300 -> A-291..A-300 (same rubro, JUGUERIA; only the zone prefix changes).
- 2 stalls flip disponible -> vendido: V-121 (renames to itself, no prefix change) and A-706.
- 74 price corrections, mostly in A-877..A-910 (VERDURAS) and S-911..S-956 (services zone).
- 0 rubro changes.

Same safety discipline as prior imports: skip rows currently separado/bloqueado, reviewable
only, not applied from this machine.
"""
import hashlib
import re
from pathlib import Path

import openpyxl

NEW_XLSX = Path('TABLA DE MERCADO 1028 - SUPER OFICIAL PROMMASA ACTUALIZADOok.xlsx')
OUT_SQL = Path('supabase/imports/20261114_actualizacion_1028_v2.sql')

def parse_code(raw):
    m = re.match(r'^([A-Za-z]+)[\s\-]+(\d+)$', raw.strip())
    return (m.group(1).upper(), int(m.group(2))) if m else (None, None)

wb = openpyxl.load_workbook(NEW_XLSX, data_only=True, read_only=True)
ws = wb['Tabla Mercado']

new_by_num = {}
for row in ws.iter_rows(min_row=4, values_only=True):
    puesto = row[0]
    if puesto is None:
        continue
    prefix, num = parse_code(str(puesto))
    if prefix is None:
        continue
    precio = row[4]
    vendido = isinstance(row[5], str) and row[5].strip() == 'VENDIDO'
    new_by_num[num] = {
        'codigo': f'{prefix}-{num}',
        'precio': int(precio) if precio is not None else None,
        'vendido': vendido,
    }
assert len(new_by_num) == 1028

import csv
old_by_num = {}
with open('docs/mercado/puestos-extraidos.csv', encoding='utf-8-sig') as f:
    for r in csv.DictReader(f):
        prefix, num = parse_code(r['codigo'])
        old_by_num[num] = {'codigo': r['codigo'], 'precio': int(r['precio']), 'vendido': r['vendido'] == 'True'}
assert len(old_by_num) == 1028

renamed = {old_by_num[n]['codigo']: new_by_num[n]['codigo'] for n in old_by_num if old_by_num[n]['codigo'] != new_by_num[n]['codigo']}
status_flip = {new_by_num[n]['codigo']: new_by_num[n]['vendido'] for n in old_by_num if old_by_num[n]['vendido'] != new_by_num[n]['vendido']}
price_changed = {new_by_num[n]['codigo']: new_by_num[n]['precio'] for n in old_by_num if old_by_num[n]['precio'] != new_by_num[n]['precio']}

assert len(renamed) == 10 and len(status_flip) == 2 and len(price_changed) == 74

quote = lambda s: "'" + s.replace("'", "''") + "'"
sha = hashlib.sha256(NEW_XLSX.read_bytes()).hexdigest()

# A single DO block, not a transaction of separate statements sharing a temp
# table: some SQL runners don't keep one session across ';'-separated
# statements, which drops an "on commit drop" temp table before it's read
# (42P01). One statement needs no cross-statement session state and still
# rolls back atomically on `raise exception`.
sql = [
    f'-- Sync to "{NEW_XLSX.name}" (2026-11-14). SHA256: {sha}',
    '-- Single-STATUS-column source (no more H/M ambiguity): 607 vendido / 421 disponible overall.',
    f'-- {len(renamed)} renamed (zone prefix only, same rubro), {len(status_flip)} flip to vendido, {len(price_changed)} price corrections.',
    '-- Skips rows currently separado/bloqueado: those are live app transactions.',
    '-- Review before running. Not applied from this machine (no production credentials here).',
    'do $$',
    'declare',
    '  v_total integer;',
    "  v_omitidos text[] := '{}';",
    'begin',
    '  lock table public.puestos in share row exclusive mode;',
    '',
]

touched_old_codes = set()

def omit_and_update(old_codigo, set_parts):
    sql.append(
        f"  if exists (select 1 from public.puestos where codigo={quote(old_codigo)} and estado in ('separado','bloqueado')) then"
    )
    sql.append(f"    v_omitidos := array_append(v_omitidos, {quote(old_codigo)});")
    sql.append('  else')
    sql.append(
        f"    update public.puestos set {', '.join(set_parts)}, version=version+1, actualizado_en=now() "
        f"where codigo={quote(old_codigo)};"
    )
    sql.append('  end if;')

for old_codigo, new_codigo in renamed.items():
    parts = [f"codigo={quote(new_codigo)}"]
    if new_codigo in status_flip:
        parts.append("estado='vendido'")
    if new_codigo in price_changed:
        parts.append(f"precio={price_changed[new_codigo]}")
    omit_and_update(old_codigo, parts)
    touched_old_codes.add(old_codigo)

for codigo, vendido in status_flip.items():
    if codigo in renamed.values():
        continue  # already handled above via the renamed old_codigo
    parts = ["estado='vendido'" if vendido else "estado='disponible'"]
    if codigo in price_changed:
        parts.append(f"precio={price_changed[codigo]}")
    omit_and_update(codigo, parts)
    touched_old_codes.add(codigo)

for codigo, precio in price_changed.items():
    if codigo in renamed.values() or codigo in status_flip:
        continue
    omit_and_update(codigo, [f"precio={precio}"])
    touched_old_codes.add(codigo)

sql.append('')
sql.append('  select count(*) into v_total from public.puestos;')
sql.append("  if v_total <> 1028 then raise exception 'Conteo final inesperado: %', v_total; end if;")
sql.append(
    "  raise notice '% filas no tocadas por estar separado/bloqueado (revisar a mano): %', "
    "coalesce(array_length(v_omitidos,1),0), v_omitidos;"
)
sql.append('end $$;')

OUT_SQL.write_text('\n'.join(sql) + '\n', encoding='utf-8')
print(f'SQL escrito en {OUT_SQL} ({len(touched_old_codes)} filas tocadas: '
      f'{len(renamed)} renombradas, {len(status_flip)} cambio de estado, {len(price_changed)} cambio de precio)')
