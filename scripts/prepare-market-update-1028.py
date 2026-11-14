"""Prepare a guarded, reviewable UPDATE/INSERT for the TABLA DE MERCADO 1028 refresh.

Same discipline as prepare-market-update.py (2026-11-03 refresh): the live database
has been running since 2026-10-21, so every UPDATE skips rows currently 'separado' or
'bloqueado' (real app transactions) and reports how many were skipped for manual
reconciliation. Matching is done by stall NUMBER (not the full codigo string), since
a few stalls change prefix/sector between sources.

Sector-name reconciliation: the new source merges some previously-separate sectors
(YUCA/OLLUCO, JOLLERIA/REGALO, LECHE HUEVOS QUESOS Y / EMBUTIDOS) into one rubro label.
Per decision: keep those sectors SEPARATE in the database, so for any stall whose rubro
maps to one of those merged labels, sector_id is left untouched (we don't have enough
information from the new source to know which of the two existing sectors it belongs to).
Price: when a "precio actualizado" is present it overrides the base price.
No buyer personal data is imported (same as prior imports) -- status is reduced to
disponible/vendido only; separado/bloqueado only exist as live app state.
"""
import csv
import hashlib
import re
from pathlib import Path

import openpyxl

OLD_CSV = Path('docs/mercado/puestos-extraidos.csv')
NEW_XLSX = Path('TABLA DE MERCADO 1028 - SUPER OFICIAL PROMMASA.xlsx')
OUT_SQL = Path('supabase/imports/20261113_actualizacion_inventario_1028.sql')

# rubro (new source) -> existing sector name in the live DB, when it's a safe 1:1 rename
# (spelling / accent / plural normalization only -- never a merge of two existing sectors).
RUBRO_TO_SECTOR = {
    'CARNE': 'CARNE', 'PESCADO': 'PESCADO', 'PLASTICOS Y LIMPIEZA': 'PLASTICOS Y LIMPIEZA',
    'ROPA': 'ROPA', 'COSTURA': 'COSTURA', 'POLLO': 'POLLO',
    'PAPA Y TUBERCULOS': 'PAPAS Y TUBERCULOS', 'PAPAS Y TUBERCULOS': 'PAPAS Y TUBERCULOS',
    'CALZADO': 'CALZADO', 'MALETA': 'MALETA', 'FLORES': 'FLORES', 'FERRETERIA': 'FERRETERIA',
    'BAZAR': 'BAZAR', 'JUGUETERIA': 'JUGUETERIA', 'JUGUERIA': 'JUGUERIA',
    'P. SIERRA Y MENESTRA': 'PRODUCTOS DE LA SIERRA',
    'CEBOLLA': 'CEBOLLA Y AJOS', 'P. NATURALES': 'PRODUCTOS NATURALES',
    'GOLOSINAS': 'GOLOSINAS', 'ESPECERIA / MOLIDOS': 'ESPECERIA / MOLIDOS',
    'LIMONES': 'LIMONES', 'FRUTOS SECOS': 'FRUTOS SECOS', 'ZAPALLOS': 'ZAPALLO',
    'CHIFA': 'CHIFA', 'ABARROTES': 'ABARROTES', 'TOMATES': 'TOMATES', 'VERDURAS': 'VERDURAS',
    'GRANOS VERDES': 'GRANOS VERDES', 'FRUTAS': 'FRUTAS', 'CHOCLO': 'CHOCLOS',
    'ARTICULOS PARA MASCOTAS': 'MASCOTAS', 'PELUQUERIA': 'PELUQUERIA',
    'CUIDADO PERSONAL': 'CUIDADO PERSONAL', 'COSMETICO': 'COSMETICOS', 'LIBRERIA': 'LIBRERIA',
    'SERVICIO TECNICO': 'SERVICIO TÉCNICO', 'LICORERIA': 'LICORERIA', 'PAPELERIA': 'PAPELERIA',
    'T. TECNOLOGIA': 'TECNOLOGÍA', 'BANCOS O CAJAS': 'BANCOS O CAJAS', 'TELEFONIA': 'TELEFONIA',
    'FARMACIA': 'FARMACIA', 'TIENDA DE CONVENIENCIA': 'TIENDA DE CONVENIENCIA',
    'APUESTAS': 'APUESTAS', 'PATIO DE COMIDAS': 'PATIO DE COMIDAS',
}
# rubro values with no safe 1:1 sector: keep current DB sector_id untouched for these.
SECTOR_SKIP = {'YUCA / OLLUCO', 'JOLLERIA Y REGALOS', 'LECHE, HUEVOS QUESOS Y EMBUTIDOS', 'LIBRES'}

def parse_code(raw):
    m = re.match(r'^([A-Za-z]+)[\s\-]+(\d+)$', raw.strip())
    return (m.group(1).upper(), int(m.group(2))) if m else (None, None)

# ---------- OLD baseline (current DB content as of last known import) ----------
old_by_num = {}
with OLD_CSV.open(encoding='utf-8-sig') as f:
    for r in csv.DictReader(f):
        prefix, num = parse_code(r['codigo'])
        old_by_num[num] = {
            'codigo': r['codigo'], 'rubro': r['rubro'],
            'area': int(r['area']) if r['area'] else None,
            'precio': int(r['precio']), 'vendido': r['vendido'] == 'True',
        }
assert len(old_by_num) == 1020, f'old count {len(old_by_num)}'

# ---------- NEW source (TABLA DE MERCADO 1028) ----------
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
    rubro = (row[3] or '').strip()
    area = row[2]
    precio_base, precio_act = row[4], row[5]
    precio = precio_act if precio_act is not None else precio_base
    s1, s2 = (row[7] or '').strip(), (row[12] or '').strip()
    vendido = (s1 == 'VENDIDO') or (s2 == 'VENDIDO')
    new_by_num[num] = {
        'codigo': f'{prefix}-{num}', 'rubro': rubro,
        'area': int(float(area)) if area not in (None, '') else None,
        'precio': int(precio) if precio is not None else None,
        'vendido': vendido,
    }
assert len(new_by_num) == 1028, f'new count {len(new_by_num)}'

# ---------- diff ----------
removed = sorted(set(old_by_num) - set(new_by_num))
brand_new = sorted(set(new_by_num) - set(old_by_num))
common = sorted(set(old_by_num) & set(new_by_num))

renamed, changed, unchanged = [], [], []
for num in common:
    o, n = old_by_num[num], new_by_num[num]
    if o['codigo'] != n['codigo']:
        renamed.append(num)
    elif (o['precio'], o['vendido'], o['rubro']) != (n['precio'], n['vendido'], n['rubro']):
        changed.append(num)
    else:
        unchanged.append(num)

flip_true_to_false = [n for n in common if old_by_num[n]['vendido'] and not new_by_num[n]['vendido']]
flip_false_to_true = [n for n in common if not old_by_num[n]['vendido'] and new_by_num[n]['vendido']]

print(f'OLD=1020 NEW=1028 | removed={len(removed)} brand_new={len(brand_new)} '
      f'renamed={len(renamed)} changed={len(changed)} unchanged={len(unchanged)}')
if removed:
    print('REMOVED (in old, absent from new -- needs manual check):')
    for num in removed:
        print('  ', num, old_by_num[num])

print(f'\nBrand-new stall numbers: {brand_new}')

unmapped_rubros = sorted({new_by_num[n]['rubro'] for n in common if new_by_num[n]['rubro'] not in RUBRO_TO_SECTOR and new_by_num[n]['rubro'] not in SECTOR_SKIP})
print(f'\nRubros with NO mapping decision (would break the script): {unmapped_rubros}')

skip_in_brand_new = [n for n in brand_new if new_by_num[n]['rubro'] in SECTOR_SKIP]
print(f'\nBrand-new stalls whose rubro is a SKIP/merge-ambiguous category (need explicit sector choice): {skip_in_brand_new}')
for n in skip_in_brand_new:
    print('  ', n, new_by_num[n])

print(f'\nSample of RENAMED ({len(renamed)}):')
for num in renamed[:10]:
    print('  ', num, old_by_num[num]['codigo'], '->', new_by_num[num]['codigo'])

print(f'\nSample of CHANGED ({len(changed)}):')
for num in changed[:10]:
    print('  ', num, old_by_num[num], '->', new_by_num[num])

# ---------- generate the reviewable SQL (not applied from this machine) ----------
quote = lambda s: "'" + s.replace("'", "''") + "'"

def sector_sql(rubro):
    target = RUBRO_TO_SECTOR.get(rubro)
    return f"(select id from public.sectores where nombre={quote(target)})" if target else None

def set_clause(num, include_codigo=False):
    n = new_by_num[num]
    parts = []
    if include_codigo:
        parts.append(f"codigo={quote(n['codigo'])}")
    sec = sector_sql(n['rubro'])
    if sec:
        parts.append(f"sector_id={sec}")
    parts.append(f"precio={n['precio']}")
    parts.append(f"area={n['area'] if n['area'] is not None else 'null'}")
    parts.append(f"estado={quote('vendido' if n['vendido'] else 'disponible')}")
    parts.append("version=version+1")
    parts.append("actualizado_en=now()")
    return ', '.join(parts)

sha = hashlib.sha256(NEW_XLSX.read_bytes()).hexdigest()
sql = [
    f'-- Market table refresh. Source: "{NEW_XLSX.name}". Source date: 2026-11-13. Source SHA256: {sha}',
    '-- Matches by stall NUMBER (not full codigo): 317 stalls change zone/prefix between sources.',
    '-- Sectors YUCA/OLLUCO, JOLLERIA/REGALO and "LECHE HUEVOS QUESOS Y"/EMBUTIDOS are kept SEPARATE',
    '--   (client decision 2026-11-13): sector_id is left untouched for rows whose new rubro merges them.',
    '-- Price: "precio actualizado" overrides the base price when present (client decision 2026-11-13).',
    '-- 8 stalls flip vendido=true -> false (cancelled sales, confirmed by client 2026-11-13): '
    + ', '.join(new_by_num[n]["codigo"] for n in flip_true_to_false) + '.',
    '-- Skips rows currently separado/bloqueado: those are live app transactions, not stale spreadsheet state.',
    '-- No buyer personal data imported (same policy as prior imports).',
    '-- Review before running. Not applied from this machine (no production credentials here).',
    'begin;',
    'lock table public.puestos, public.sectores in share row exclusive mode;',
    'create temporary table _omitidos(codigo text, estado text) on commit drop;',
]

for num in renamed:
    old_codigo = old_by_num[num]['codigo']
    sql.append(
        f"insert into _omitidos select {quote(old_codigo)}, estado from public.puestos "
        f"where codigo={quote(old_codigo)} and estado in ('separado','bloqueado');"
    )
    sql.append(
        f"update public.puestos set {set_clause(num, include_codigo=True)} "
        f"where codigo={quote(old_codigo)} and estado not in ('separado','bloqueado');"
    )

for num in changed:
    codigo = new_by_num[num]['codigo']
    sql.append(
        f"insert into _omitidos select {quote(codigo)}, estado from public.puestos "
        f"where codigo={quote(codigo)} and estado in ('separado','bloqueado');"
    )
    sql.append(
        f"update public.puestos set {set_clause(num)} "
        f"where codigo={quote(codigo)} and estado not in ('separado','bloqueado');"
    )

if brand_new:
    sql.append('with nuevos as (')
    sql.append('insert into public.puestos(codigo,sector_id,precio,estado,area,geometria)')
    rows_sql = []
    for num in brand_new:
        n = new_by_num[num]
        sec = sector_sql(n['rubro']) or 'null'
        estado = 'vendido' if n['vendido'] else 'disponible'
        rows_sql.append(
            f"({quote(n['codigo'])},{sec},{n['precio']},{quote(estado)},"
            f"{n['area'] if n['area'] is not None else 'null'}::numeric,null::jsonb)"
        )
    sql.append('select * from (values\n' + ',\n'.join(rows_sql) + '\n) as v(codigo,sector_id,precio,estado,area,geometria)')
    sql.append("returning *) insert into public.auditoria(puesto_id,accion,motivo,despues)")
    sql.append("select id,'importar_inventario','TABLA MERCADO 1028 11/11/2026; nuevos puestos sin geometria aun',to_jsonb(nuevos) from nuevos;")

sql.append(
    "do $$ declare v_omitidos integer; begin "
    "select count(*) into v_omitidos from _omitidos; "
    "raise notice '% filas no tocadas por estar separado/bloqueado (revisar a mano)', v_omitidos; "
    f"if (select count(*) from public.puestos) <> {len(old_by_num) + len(brand_new)} then raise exception 'Conteo final inesperado'; end if; "
    "end $$;"
)
sql.append('select codigo, estado from _omitidos;')
sql.append('commit;')

OUT_SQL.parent.mkdir(parents=True, exist_ok=True)
OUT_SQL.write_text('\n'.join(sql) + '\n', encoding='utf-8')
print(f'\nSQL escrito en {OUT_SQL} ({len(renamed)} renombrados, {len(changed)} actualizados, {len(brand_new)} nuevos)')
