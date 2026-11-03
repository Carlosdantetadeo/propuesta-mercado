"""Extract inventory and row colors, without buyer personal data."""
import collections
import csv
import json
import re
from pathlib import Path

import fitz

source = Path('TABLA DE MERCADO 20_10 - Tabla Mercado.pdf')
out = Path('docs/mercado')
out.mkdir(exist_ok=True)
rows = []
with fitz.open(source) as document:
    for page_number, page in enumerate(document, 1):
        words = page.get_text('words')
        colors = [(d['rect'], d['fill']) for d in page.get_drawings() if d['fill']]
        anchors = [w for w in words if w[0] < 100 and re.fullmatch(r'[A-Z]+-\d*', w[4])]
        for anchor in anchors:
            y = (anchor[1] + anchor[3]) / 2
            line = sorted([w for w in words if abs((w[1]+w[3])/2-y) < 2], key=lambda w: w[0])
            def column(left, right):
                return ' '.join(w[4] for w in line if left <= (w[0]+w[2])/2 < right).strip()
            code = re.sub(r'\s+', '', column(0, 137))
            if not re.fullmatch(r'[A-Z]+-\d+', code):
                raise ValueError((page_number, code))
            fills = [color for rect, color in colors if rect.x0 < 360 and rect.x1 > 300 and rect.y0 < y < rect.y1]
            red = any(r > .9 and g < .1 and b < .1 for r, g, b in fills)
            yellow = any(r > .9 and g > .9 and b < .1 for r, g, b in fills)
            price = column(232, 296)
            status = column(296, 364)
            rows.append(dict(codigo=code, rubro=column(137,232), precio=int(price.replace(',','')) if re.fullmatch(r'[\d,]+',price) else price,
                             estado_documento=status, rojo=red, amarillo=yellow,
                             ocupado=red, pagina=page_number))

codes = [r['codigo'] for r in rows]
assert len(codes) == len(set(codes)), 'Duplicate stall codes'
with (out/'puestos-extraidos.csv').open('w', encoding='utf-8-sig', newline='') as stream:
    writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
    writer.writeheader()
    writer.writerows(rows)
summary = dict(total=len(rows), rojos=sum(r['rojo'] for r in rows), amarillos=sum(r['amarillo'] for r in rows),
               estados=dict(collections.Counter(r['estado_documento'] for r in rows)),
               rubros=dict(collections.Counter(r['rubro'] for r in rows)),
               discrepancias=[r for r in rows if r['rojo'] != (r['estado_documento'].upper() == 'VENDIDO')],
               precios_no_numericos=[r for r in rows if not isinstance(r['precio'], int)])
(out/'resumen.json').write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding='utf-8')
print(json.dumps(summary, ensure_ascii=True, indent=2))
