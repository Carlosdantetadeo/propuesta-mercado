"""Prepare a guarded, reviewable UPDATE/INSERT for the 03/11 market table refresh.

Unlike prepare-market-import.py (one-time load into an empty table), this
targets a database that has been live since 2026-10-21: advisors and admins
may have separated, sold or blocked stalls through the app in the meantime.
Every UPDATE therefore skips rows currently 'separado' or 'bloqueado' —
those reflect real transactions this script must not overwrite — and the
script reports how many rows were skipped for that reason so a human can
reconcile them by hand.
"""
import csv
import hashlib
from pathlib import Path

source = Path('tabla de mercado 03_11.pdf')
new_rows = {r['codigo']: r for r in csv.DictReader(Path('docs/mercado/puestos-extraidos.csv').open(encoding='utf-8-sig'))}
old_rows = {r['codigo']: r for r in csv.DictReader(Path('old-puestos-extraidos-backup.csv').open(encoding='utf-8-sig'))}
assert len(new_rows) == 1020 and len(old_rows) == 956

quote = lambda s: "'" + s.replace("'", "''") + "'"

renamed = sorted(set(old_rows) - set(new_rows))  # same number, new prefix/rubro (e.g. C-915 -> S-915)
brand_new = sorted(set(new_rows) - set(old_rows) - {f"S-{c.split('-')[1]}" for c in renamed})
changed = sorted(c for c in set(old_rows) & set(new_rows)
                  if (old_rows[c]['precio'], old_rows[c]['rojo'] == 'True', old_rows[c]['rubro'])
                  != (str(new_rows[c]['precio']), new_rows[c]['vendido'] == 'True', new_rows[c]['rubro']))
assert len(renamed) == 4 and len(brand_new) == 64 and {f"S-{c.split('-')[1]}" for c in renamed} < set(new_rows)

def values(codigo):
    r = new_rows[codigo]
    estado = 'vendido' if r['vendido'] == 'True' else 'disponible'
    return r['rubro'], int(r['precio']), int(r['area']) if r['area'] else None, estado

sql = [
    f'-- Market table refresh. Source date: 2026-11-03. Source SHA256: {hashlib.sha256(source.read_bytes()).hexdigest()}',
    '-- Skips rows currently separado/bloqueado: those are live app transactions, not stale PDF state.',
    '-- Review before running. Not applied from this machine (no production credentials here).',
    'begin;',
    'lock table public.puestos, public.sectores in share row exclusive mode;',
    'create temporary table _omitidos(codigo text, estado text) on commit drop;',
]

for codigo in renamed:
    new_codigo = f"S-{codigo.split('-')[1]}"
    rubro, precio, area, estado = values(new_codigo)
    sql.append(
        f"insert into _omitidos select {quote(codigo)}, estado from public.puestos "
        f"where codigo={quote(codigo)} and estado in ('separado','bloqueado');"
    )
    sql.append(
        f"update public.puestos set codigo={quote(new_codigo)}, "
        f"sector_id=(select id from public.sectores where nombre={quote(rubro)}), "
        f"precio={precio}, area={area if area is not None else 'null'}, estado={quote(estado)}, "
        f"version=version+1, actualizado_en=now() "
        f"where codigo={quote(codigo)} and estado not in ('separado','bloqueado');"
    )

for codigo in changed:
    rubro, precio, area, estado = values(codigo)
    sql.append(
        f"insert into _omitidos select {quote(codigo)}, estado from public.puestos "
        f"where codigo={quote(codigo)} and estado in ('separado','bloqueado');"
    )
    sql.append(
        f"update public.puestos set sector_id=(select id from public.sectores where nombre={quote(rubro)}), "
        f"precio={precio}, area={area if area is not None else 'null'}, estado={quote(estado)}, "
        f"version=version+1, actualizado_en=now() "
        f"where codigo={quote(codigo)} and estado not in ('separado','bloqueado');"
    )

sql.append('with nuevos as (')
sql.append('insert into public.puestos(codigo,sector_id,precio,estado,area,geometria)')
rows_sql = []
for codigo in brand_new:
    rubro, precio, area, estado = values(codigo)
    rows_sql.append(f"({quote(codigo)},(select id from public.sectores where nombre={quote(rubro)}),{precio},{quote(estado)},{area if area is not None else 'null'}::numeric,null::jsonb)")
sql.append('select * from (values\n' + ',\n'.join(rows_sql) + '\n) as v(codigo,sector_id,precio,estado,area,geometria)')
sql.append("returning *) insert into public.auditoria(puesto_id,accion,motivo,despues)")
sql.append("select id,'importar_inventario','TABLA MERCADO 03/11/2026; nuevos puestos sin geometria aun',to_jsonb(nuevos) from nuevos;")

sql.append("do $$ declare v_omitidos integer; begin "
           "select count(*) into v_omitidos from _omitidos; "
           "raise notice '% filas no tocadas por estar separado/bloqueado (revisar a mano)', v_omitidos; "
           "if (select count(*) from public.puestos) <> 956 + 64 then raise exception 'Conteo final inesperado'; end if; "
           "end $$;")
sql.append('select codigo, estado from _omitidos;')
sql.append('commit;')

target = Path('supabase/imports/20261103_actualizacion_inventario.sql')
target.write_text('\n'.join(sql) + '\n', encoding='utf-8')
print(f'{len(renamed)} renombrados, {len(changed)} actualizados, {len(brand_new)} nuevos. SQL: {target}')
