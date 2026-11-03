"""Prepare a guarded, atomic initial import from the reviewed market CSV."""
import csv
import hashlib
from pathlib import Path

source = Path('TABLA DE MERCADO 20_10 - Tabla Mercado.pdf')
rows = list(csv.DictReader(Path('docs/mercado/puestos-extraidos.csv').open(encoding='utf-8-sig')))
assert len(rows) == 956 and len({r['codigo'] for r in rows}) == 956
# Validate every number in the source, including codes printed without a space.
assert {int(r['codigo'].split('-')[1]) for r in rows} == set(range(1,957))
assert sum(r['rojo'] == 'True' for r in rows) == 561
assert all((r['rojo'] == 'True') == (r['estado_documento'] == 'VENDIDO') for r in rows)
assert all(int(r['precio']) > 0 and r['rubro'] for r in rows)
quote = lambda s: "'" + s.replace("'", "''") + "'"
rubros = list(dict.fromkeys(r['rubro'] for r in rows))
sql = [
    '-- Initial commercial inventory. Source date: 2026-10-21. Prices: USD, IGV included.',
    '-- Source SHA256: ' + hashlib.sha256(source.read_bytes()).hexdigest(),
    '-- Red / VENDIDO => vendido; blank / not red => disponible.',
    '-- Areas and geometry are unknown. No buyer personal data imported.',
    'begin;',
    'lock table public.puestos, public.sectores in share row exclusive mode;',
    "do $$ begin if exists(select 1 from public.puestos) then raise exception 'Initial import requires an empty inventory'; end if; end $$;",
    'insert into public.sectores(nombre,rubro,color,orden) values',
    ',\n'.join(f'({quote(r)},{quote(r)},\'#64748b\',{i})' for i,r in enumerate(rubros,1)),
    'on conflict (nombre) do nothing;',
    'with fuente(codigo,rubro,precio,estado) as (values',
    ',\n'.join('('+','.join([quote(r['codigo']),quote(r['rubro']),str(int(r['precio'])),quote('vendido' if r['rojo']=='True' else 'disponible')])+')' for r in rows),
    '), nuevos as (',
    'insert into public.puestos(codigo,sector_id,precio,estado,area,geometria)',
    'select f.codigo,s.id,f.precio,f.estado,null,null from fuente f join public.sectores s on s.nombre=f.rubro returning *',
    ') insert into public.auditoria(puesto_id,accion,motivo,despues)',
    "select id,'importar_inventario','TABLA MERCADO 21/10/2026; USD con IGV; rojo=vendido; sin rojo=disponible',to_jsonb(nuevos) from nuevos;",
    "do $$ begin if (select count(*) from public.puestos) <> 956 or (select count(*) from public.puestos where estado='vendido') <> 561 or (select count(*) from public.puestos where estado='disponible') <> 395 then raise exception 'Inventory validation failed'; end if; end $$;",
    'commit;',
]
target = Path('supabase/imports/20261021_inventario_mercado.sql')
target.parent.mkdir(exist_ok=True)
target.write_text('\n'.join(sql)+'\n', encoding='utf-8')
print(f'{len(rows)} puestos, {len(rubros)} rubros. SQL: {target}')
