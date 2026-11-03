import csv, json, collections

SALES_CSV = 'docs/mercado/puestos-extraidos.csv'
GEO_CSV = 'docs/mercado/plano-ocr/puestos.csv'
OLD_GEOMETRY = 'src/data/plano-geometria.json'
OUT = 'src/data/plano-geometria.json'

VB_W, VB_H = 2400, 989  # matches plano_general.jpg pixel size exactly

sales_codes = {r['codigo'] for r in csv.DictReader(open(SALES_CSV, encoding='utf-8-sig'))}
geo_rows = list(csv.DictReader(open(GEO_CSV, encoding='utf-8-sig')))
geo_by_code = {r['codigo']: r for r in geo_rows}
geo_codes = set(geo_by_code)

clean = sorted(sales_codes & geo_codes)
mismatched = sorted(sales_codes - geo_codes)
assert len(clean) + len(mismatched) == len(sales_codes) == 1020
print(f'clean match: {len(clean)}, kept at legacy position: {len(mismatched)}')

old = json.load(open(OLD_GEOMETRY, encoding='utf-8'))
old_stalls = old['stalls']
assert set(mismatched) <= set(old_stalls), 'legacy codes must already have a position'

# --- pitch estimation per ubicacion type, in hires pixel space ---
by_bloque = collections.defaultdict(list)
for r in geo_rows:
    by_bloque[r['bloque']].append(r)

bloque_dx, bloque_dy = [], []
for b, items in by_bloque.items():
    if items[0]['ubicacion'] != 'bloque' or len(items) != 10:
        continue
    xs = sorted(int(i['x_px']) for i in items)
    bloque_dx.append(sum(xs[5:]) / 5 - sum(xs[:5]) / 5)
    ys = sorted(int(i['y_px']) for i in items)
    rows_y = sorted((ys[i] + ys[i + 1]) / 2 for i in range(0, 10, 2))
    for a, c in zip(rows_y, rows_y[1:]):
        bloque_dy.append(c - a)
bloque_dx = sorted(bloque_dx)[len(bloque_dx) // 2]
bloque_dy = sorted(bloque_dy)[len(bloque_dy) // 2]

franja_dx_all = []
for b, items in by_bloque.items():
    if items[0]['ubicacion'] != 'franja':
        continue
    xs = sorted(int(i['x_px']) for i in items)
    franja_dx_all += [c - a for a, c in zip(xs, xs[1:])]
franja_dx_all = sorted(franja_dx_all)
franja_dx = franja_dx_all[len(franja_dx_all) // 2]

patio_items = [r for r in geo_rows if r['ubicacion'] == 'patio_comidas']
px_ = sorted(set(int(r['x_px']) for r in patio_items))
patio_dx = sorted(b - a for a, b in zip(px_, px_[1:]) if b - a > 20)
patio_dx = patio_dx[len(patio_dx) // 2]
py_ = sorted(set(int(r['y_px']) for r in patio_items))
patio_dy = sorted(b - a for a, b in zip(py_, py_[1:]) if b - a > 20)
patio_dy = patio_dy[len(patio_dy) // 2]

print('pitch px (hires 11233x4630): bloque', bloque_dx, bloque_dy, 'franja_dx', franja_dx, 'patio', patio_dx, patio_dy)

FX = VB_W / 11233
FY = VB_H / 4630
FILL = 0.85

def cellsize(ubicacion):
    if ubicacion == 'bloque':
        return bloque_dx * FX * FILL, bloque_dy * FY * FILL
    if ubicacion == 'franja':
        return franja_dx * FX * FILL, bloque_dy * FY * FILL  # franja: own width pitch, bloque-row height as proxy
    if ubicacion == 'patio_comidas':
        return patio_dx * FX * FILL, patio_dy * FY * FILL
    raise ValueError(ubicacion)

stalls = {}
for code in clean:
    r = geo_by_code[code]
    cx = float(r['x_norm']) * VB_W
    cy = float(r['y_norm']) * VB_H
    w, h = cellsize(r['ubicacion'])
    stalls[code] = dict(x=round(cx - w / 2, 2), y=round(cy - h / 2, 2), w=round(w, 2), h=round(h, 2))

for code in mismatched:
    stalls[code] = old_stalls[code]

assert set(stalls) == sales_codes

# --- blocks: new source grouped by its own 'bloque' field ---
blocks = []
new_by_bloque = collections.defaultdict(list)
for code in clean:
    new_by_bloque[geo_by_code[code]['bloque']].append(code)
for bloque_id, codes in new_by_bloque.items():
    rects = [stalls[c] for c in codes]
    x0 = min(r['x'] for r in rects); y0 = min(r['y'] for r in rects)
    x1 = max(r['x'] + r['w'] for r in rects); y1 = max(r['y'] + r['h'] for r in rects)
    blocks.append(dict(x=round(x0, 2), y=round(y0, 2), w=round(x1 - x0, 2), h=round(y1 - y0, 2),
                        codes=sorted(codes), label=True))

# --- blocks: legacy, filtered down to surviving (kept-in-place) codes only ---
keep_set = set(mismatched)
for b in old.get('blocks', []):
    kept = [c for c in b['codes'] if c in keep_set]
    if not kept:
        continue
    rects = [stalls[c] for c in kept]
    x0 = min(r['x'] for r in rects); y0 = min(r['y'] for r in rects)
    x1 = max(r['x'] + r['w'] for r in rects); y1 = max(r['y'] + r['h'] for r in rects)
    blocks.append(dict(x=round(x0, 2), y=round(y0, 2), w=round(x1 - x0, 2), h=round(y1 - y0, 2),
                        codes=kept, label=b.get('label', True)))

out = dict(source='plano-original.webp', stalls=stalls, blocks=blocks)
json.dump(out, open(OUT, 'w', encoding='utf-8'), ensure_ascii=False, separators=(',', ':'))
print(f'{len(stalls)} stalls, {len(blocks)} blocks written to {OUT}')
