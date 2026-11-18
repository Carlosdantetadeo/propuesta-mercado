"""Bulk-load buyer names into public.puestos.ocupante for the 686 stalls marked
VENDIDO in TABLA_DE_MERCADO_1028-17-11.md (NOMBRES + APELLIDOS columns).

Reverses the project's prior no-buyer-data policy by explicit user request
(2026-11-18): the column must only be readable by admin (see the companion
migration 202611180001_ocupante_solo_admin.sql, which must run first).

Only nombre + referencia are populated -- the source has no documento/telefono.
Guarded like every other bulk update here: only touches rows whose live estado
is still 'vendido' (should be all 686, since the status/rename migrations were
already applied); anything else is skipped and reported, never overwritten.
"""
import csv
import hashlib
import re
from pathlib import Path

NEW_MD = Path('TABLA_DE_MERCADO_1028-17-11.md')
OUT_SQL = Path('supabase/imports/20261118_ocupantes_desde_tabla.sql')


def parse_code(raw):
    m = re.match(r'^([A-Za-z]+)[\s\-]+(\d+)$', raw.strip())
    return (m.group(1).upper(), int(m.group(2))) if m else (None, None)


ocupantes = {}
for line in NEW_MD.read_text(encoding='utf-8').splitlines()[2:]:
    if not line.startswith('|'):
        continue
    parts = [p.strip() for p in line.strip('|').split('|')]
    if len(parts) < 7:
        continue
    puesto, rubro, precio, status, nombres, apellidos, referencia = parts[:7]
    prefix, num = parse_code(puesto)
    if prefix is None:
        continue
    if status.strip() != 'VENDIDO':
        continue
    nombre = ' '.join(p for p in (nombres.strip(), apellidos.strip()) if p)
    if not nombre:
        continue
    ocupantes[f'{prefix}-{num}'] = {'nombre': nombre, 'referencia': referencia.strip()}

assert len(ocupantes) == 686, len(ocupantes)

quote = lambda s: "'" + s.replace("'", "''") + "'"
sha = hashlib.sha256(NEW_MD.read_bytes()).hexdigest()

sql = [
    f'-- Bulk-load buyer names from "{NEW_MD.name}" (2026-11-17) into ocupante. SHA256: {sha}',
    '-- Requires 202611180001_ocupante_solo_admin.sql to already be applied (ocupante is',
    '-- admin-only from that point on). Only sets nombre + referencia (no documento/telefono',
    '-- in the source). Only touches rows currently estado=\'vendido\'; anything else is',
    '-- skipped and listed at the end for manual review -- never overwritten blind.',
    'do $$',
    'declare',
    '  v_total integer;',
    "  v_omitidos text[] := '{}';",
    'begin',
    '  lock table public.puestos in share row exclusive mode;',
    '',
]

for codigo in sorted(ocupantes, key=lambda c: int(c.split('-')[1])):
    o = ocupantes[codigo]
    ocupante_json = (
        "jsonb_build_object('nombre'," + quote(o['nombre']) +
        (",'referencia'," + quote(o['referencia']) if o['referencia'] else '') +
        ')'
    )
    q = quote(codigo)
    sql.append(f"  if exists (select 1 from public.puestos where codigo={q} and estado='vendido') then")
    sql.append(
        f"    update public.puestos set ocupante={ocupante_json}, version=version+1, actualizado_en=now() "
        f"where codigo={q};"
    )
    sql.append('  else')
    sql.append(f"    v_omitidos := array_append(v_omitidos, {q});")
    sql.append('  end if;')

sql.append('')
sql.append('  select count(*) into v_total from public.puestos;')
sql.append("  if v_total <> 1028 then raise exception 'Conteo final inesperado: %', v_total; end if;")
sql.append(
    "  raise notice '% filas no tocadas por no estar en estado vendido (revisar a mano): %', "
    "coalesce(array_length(v_omitidos,1),0), v_omitidos;"
)
sql.append('end $$;')

OUT_SQL.write_text('\n'.join(sql) + '\n', encoding='utf-8')
print(f'SQL escrito en {OUT_SQL} ({len(ocupantes)} ocupantes)')
