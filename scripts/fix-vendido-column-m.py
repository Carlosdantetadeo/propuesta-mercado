"""Correct the 2026-11-13 import: it computed 'vendido' as STATUS-column-H OR STATUS-column-M
(794 vendido / 234 disponible). After back-and-forth on 2026-11-14, the client confirmed the
real, authoritative sales record is STATUS-column-M (the block next to NOMBRES/APELLIDOS in
columns N/O) -- column H must be ignored.

Correct split, column M only: 605 vendido / 423 disponible.

This fixes exactly the 189 stalls that are 'vendido' in the live database only because column H
said so while column M did not. No other field is touched (price/area/sector_id were computed
independently of this bug and are already correct). Same safety discipline as prior imports:
skip rows currently separado/bloqueado, reviewable only, not applied from this machine.

Supersedes the earlier (never-run) fix-vendido-column-h-only.py, which assumed the opposite.
"""
import hashlib
import re
from pathlib import Path

import openpyxl

NEW_XLSX = Path('TABLA DE MERCADO 1028 - SUPER OFICIAL PROMMASA.xlsx')
OUT_SQL = Path('supabase/imports/20261114_correccion_estado_vendido.sql')

def parse_code(raw):
    m = re.match(r'^([A-Za-z]+)[\s\-]+(\d+)$', raw.strip())
    return (m.group(1).upper(), int(m.group(2))) if m else (None, None)

wb = openpyxl.load_workbook(NEW_XLSX, data_only=True, read_only=True)
ws = wb['Tabla Mercado']

to_fix = []
for row in ws.iter_rows(min_row=4, values_only=True):
    puesto = row[0]
    if puesto is None:
        continue
    prefix, num = parse_code(str(puesto))
    if prefix is None:
        continue
    h_vendido = (row[7] or '').strip() == 'VENDIDO'
    m_vendido = (row[12] or '').strip() == 'VENDIDO'
    if h_vendido and not m_vendido:
        to_fix.append(f'{prefix}-{num}')

assert len(to_fix) == 189, f'expected 189, got {len(to_fix)}'
quote = lambda s: "'" + s.replace("'", "''") + "'"
sha = hashlib.sha256(NEW_XLSX.read_bytes()).hexdigest()

sql = [
    f'-- Correction to the 2026-11-13 import. Source: "{NEW_XLSX.name}". SHA256: {sha}',
    "-- The 11-13 import wrongly used STATUS-column-H OR STATUS-column-M to decide 'vendido'.",
    '-- Client confirmed 2026-11-14 (final): only column M is the real sales record; column H is ignored.',
    f'-- Flips these {len(to_fix)} stalls back from vendido to disponible (they were vendido only per column H).',
    '-- Skips rows currently separado/bloqueado: those are live app transactions.',
    '-- Review before running. Not applied from this machine (no production credentials here).',
    'begin;',
    'lock table public.puestos in share row exclusive mode;',
    'create temporary table _omitidos(codigo text, estado text) on commit drop;',
]
for codigo in to_fix:
    sql.append(
        f"insert into _omitidos select {quote(codigo)}, estado from public.puestos "
        f"where codigo={quote(codigo)} and estado in ('separado','bloqueado');"
    )
    sql.append(
        f"update public.puestos set estado='disponible', version=version+1, actualizado_en=now() "
        f"where codigo={quote(codigo)} and estado not in ('separado','bloqueado') and estado='vendido';"
    )
sql.append(
    "do $$ declare v_omitidos integer; v_vendido integer; begin "
    "select count(*) into v_omitidos from _omitidos; "
    "raise notice '% filas no tocadas por estar separado/bloqueado (revisar a mano)', v_omitidos; "
    "select count(*) into v_vendido from public.puestos where estado='vendido'; "
    "raise notice '% puestos vendido tras la correccion (esperado: 605 si no habia separados/bloqueados)', v_vendido; "
    "end $$;"
)
sql.append('select codigo, estado from _omitidos;')
sql.append('commit;')

OUT_SQL.write_text('\n'.join(sql) + '\n', encoding='utf-8')
print(f'SQL escrito en {OUT_SQL} ({len(to_fix)} correcciones)')
