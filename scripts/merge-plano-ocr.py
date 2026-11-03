import csv, json, collections

SALES_CSV = 'docs/mercado/puestos-extraidos.csv'
GEO_CSV = 'docs/mercado/plano-ocr/puestos.csv'
OUT = 'src/data/plano-geometria.json'

VB_W, VB_H = 2400, 989  # matches plano_general.jpg pixel size exactly

sales_codes = {r['codigo'] for r in csv.DictReader(open(SALES_CSV, encoding='utf-8-sig'))}
geo_rows = list(csv.DictReader(open(GEO_CSV, encoding='utf-8-sig')))
geo_by_code = {r['codigo']: r for r in geo_rows}
geo_codes = set(geo_by_code)

clean = sorted(sales_codes & geo_codes)
mismatched = sorted(sales_codes - geo_codes)
assert len(clean) + len(mismatched) == len(sales_codes) == 1020

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

FX = VB_W / 11233
FY = VB_H / 4630
FILL = 0.85

def cellsize(ubicacion):
    if ubicacion == 'bloque':
        return bloque_dx * FX * FILL, bloque_dy * FY * FILL
    if ubicacion == 'franja':
        return franja_dx * FX * FILL, bloque_dy * FY * FILL  # franja: own width pitch, bloque-row height proxy
    if ubicacion == 'patio_comidas':
        return patio_dx * FX * FILL, patio_dy * FY * FILL
    raise ValueError(ubicacion)

def rect_from_ocr(r):
    cx = float(r['x_norm']) * VB_W
    cy = float(r['y_norm']) * VB_H
    w, h = cellsize(r['ubicacion'])
    return dict(x=round(cx - w / 2, 2), y=round(cy - h / 2, 2), w=round(w, 2), h=round(h, 2))

stalls = {}
# 822 codes that appear in both sources -> exact OCR position.
for code in clean:
    stalls[code] = rect_from_ocr(geo_by_code[code])

# 198 codes where sales and the printed plan disagree on numbering: the sales
# code has no direct position on the plan, but there are exactly 198 OCR stalls
# with no sales match (the same physical stalls, relabeled). Pair them by sorted
# code so every sales code lands on a real, aligned stall position instead of a
# leftover coordinate from the previous plan image. This can place a given code
# on a physically-adjacent slot, but never floats a cell outside the plan.
def code_key(c):
    pre, num = c.split('-')
    return (pre, int(num))

ocr_extra = sorted((r for r in geo_rows if r['codigo'] not in sales_codes),
                   key=lambda r: code_key(r['codigo']))
sales_missing = sorted(mismatched, key=code_key)
assert len(ocr_extra) == len(sales_missing) == 198
for sales_code, ocr_row in zip(sales_missing, ocr_extra):
    stalls[sales_code] = rect_from_ocr(ocr_row)

assert set(stalls) == sales_codes

out = dict(source='plano-original.webp', stalls=stalls, blocks=[])
json.dump(out, open(OUT, 'w', encoding='utf-8'), ensure_ascii=False, separators=(',', ':'))
print(f'{len(stalls)} stalls written to {OUT} ({len(clean)} exact, {len(sales_missing)} paired)')
