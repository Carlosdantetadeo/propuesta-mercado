"""Sync to "TABLA_DE_MERCADO_1028-17-11.md" (2026-11-17), a markdown export of the
same single-STATUS-column source as the 2026-11-14 refresh.

Diff against the current baseline (docs/mercado/puestos-extraidos.csv, reflecting the
live DB after the 2026-11-14 update):
- 43 renamed: zone prefix only (A<->V), same stall number, same rubro -- no sector_id
  change needed since rubro is unchanged.
- 3 stalls flip disponible -> vendido: A-91, V-208, V-247.
- 0 rubro changes, 0 price changes.

Same safety discipline as prior imports: skip rows currently separado/bloqueado, reviewable
only, not applied from this machine.
"""
import csv
import hashlib
import re
from pathlib import Path

NEW_MD = Path('TABLA_DE_MERCADO_1028-17-11.md')
OLD_CSV = Path('docs/mercado/puestos-extraidos.csv')
OUT_SQL = Path('supabase/imports/20261117_actualizacion_1028.sql')


def parse_code(raw):
    m = re.match(r'^([A-Za-z]+)[\s\-]+(\d+)$', raw.strip())
    return (m.group(1).upper(), int(m.group(2))) if m else (None, None)


new_by_num = {}
for line in NEW_MD.read_text(encoding='utf-8').splitlines()[2:]:
    if not line.startswith('|'):
        continue
    parts = [p.strip() for p in line.strip('|').split('|')]
    if len(parts) < 4:
        continue
    puesto, rubro, precio, status = parts[:4]
    prefix, num = parse_code(puesto)
    if prefix is None:
        continue
    new_by_num[num] = {
        'codigo': f'{prefix}-{num}',
        'rubro': rubro.strip(),
        'precio': int(precio) if precio.strip() else None,
        'vendido': status.strip() == 'VENDIDO',
    }
assert len(new_by_num) == 1028

old_by_num = {}
with OLD_CSV.open(encoding='utf-8-sig') as f:
    for r in csv.DictReader(f):
        prefix, num = parse_code(r['codigo'])
        old_by_num[num] = {'codigo': r['codigo'], 'precio': int(r['precio']), 'vendido': r['vendido'] == 'True'}
assert len(old_by_num) == 1028

renamed = {old_by_num[n]['codigo']: new_by_num[n]['codigo'] for n in old_by_num if old_by_num[n]['codigo'] != new_by_num[n]['codigo']}
status_flip = {new_by_num[n]['codigo']: new_by_num[n]['vendido'] for n in old_by_num if old_by_num[n]['vendido'] != new_by_num[n]['vendido']}
price_changed = {new_by_num[n]['codigo']: new_by_num[n]['precio'] for n in old_by_num if old_by_num[n]['precio'] != new_by_num[n]['precio']}

assert len(renamed) == 43 and len(status_flip) == 3 and len(price_changed) == 0

quote = lambda s: "'" + s.replace("'", "''") + "'"
sha = hashlib.sha256(NEW_MD.read_bytes()).hexdigest()

sql = [
    f'-- Sync to "{NEW_MD.name}" (2026-11-17). SHA256: {sha}',
    '-- Markdown export of the single-STATUS-column source, same taxonomy as the 2026-11-14 refresh.',
    f'-- {len(renamed)} renamed (zone prefix only, same rubro), {len(status_flip)} flip to vendido, 0 price changes.',
    '-- Skips rows currently separado/bloqueado: those are live app transactions.',
    '-- Review before running. Not applied from this machine (no production credentials here).',
    'begin;',
    'lock table public.puestos in share row exclusive mode;',
    'create temporary table _omitidos(codigo text, estado text) on commit drop;',
]

touched_old_codes = set()


def omit_and_update(old_codigo, set_parts):
    sql.append(
        f"insert into _omitidos select {quote(old_codigo)}, estado from public.puestos "
        f"where codigo={quote(old_codigo)} and estado in ('separado','bloqueado');"
    )
    sql.append(
        f"update public.puestos set {', '.join(set_parts)}, version=version+1, actualizado_en=now() "
        f"where codigo={quote(old_codigo)} and estado not in ('separado','bloqueado');"
    )


for old_codigo, new_codigo in renamed.items():
    parts = [f"codigo={quote(new_codigo)}"]
    if new_codigo in status_flip:
        parts.append("estado='vendido'")
    omit_and_update(old_codigo, parts)
    touched_old_codes.add(old_codigo)

for codigo, vendido in status_flip.items():
    if codigo in renamed.values():
        continue  # already handled above via the renamed old_codigo
    parts = ["estado='vendido'" if vendido else "estado='disponible'"]
    omit_and_update(codigo, parts)
    touched_old_codes.add(codigo)

sql.append(
    "do $$ declare v_omitidos integer; begin "
    "select count(*) into v_omitidos from _omitidos; "
    "raise notice '% filas no tocadas por estar separado/bloqueado (revisar a mano)', v_omitidos; "
    "if (select count(*) from public.puestos) <> 1028 then raise exception 'Conteo final inesperado'; end if; "
    "end $$;"
)
sql.append('select codigo, estado from _omitidos;')
sql.append('commit;')

OUT_SQL.write_text('\n'.join(sql) + '\n', encoding='utf-8')
print(f'SQL escrito en {OUT_SQL} ({len(touched_old_codes)} filas tocadas: '
      f'{len(renamed)} renombradas, {len(status_flip)} cambio de estado)')
