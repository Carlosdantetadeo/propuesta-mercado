"""Extract inventory (code, rubro, price, area, status) from the market table PDF.

Never reads NOMBRES/APELLIDOS/REFERENCIA/OBSERVACIONES columns: those hold buyer
personal data and must not land in this public repository.
"""
import collections
import csv
import json
import re
import unicodedata
from pathlib import Path

import fitz

source = Path('tabla de mercado 03_11.pdf')
out = Path('docs/mercado')
out.mkdir(exist_ok=True)

previous_rubros = set()
previous_csv = out / 'puestos-extraidos.csv'
if previous_csv.exists():
    previous_rubros = {r['rubro'] for r in csv.DictReader(previous_csv.open(encoding='utf-8-sig'))}

def normalize(value):
    return unicodedata.normalize('NFD', value).encode('ascii', 'ignore').decode().upper().strip()

canon_by_norm = {normalize(r): r for r in previous_rubros}

rows = []
with fitz.open(source) as document:
    for page_number, page in enumerate(document, 1):
        words = page.get_text('words')
        lines = collections.defaultdict(list)
        for w in words:
            lines[round((w[1] + w[3]) / 2)].append(w)
        for line_words in lines.values():
            line = sorted(line_words, key=lambda w: w[0])
            code = re.sub(r'\s+', '', ''.join(w[4] for w in line if w[0] < 100))
            if not re.fullmatch(r'[A-Z]+-\d+', code):
                continue
            def column(left, right):
                return ' '.join(w[4] for w in line if left <= (w[0] + w[2]) / 2 < right).strip()
            m2 = column(130, 170)
            rubro = column(175, 280)
            precio = column(283, 325)
            status = column(425, 462)
            canon_rubro = canon_by_norm.get(normalize(rubro), rubro)
            rows.append(dict(
                codigo=code,
                rubro=canon_rubro,
                area=int(m2) if re.fullmatch(r'\d+', m2) else None,
                precio=int(precio.replace(',', '')) if re.fullmatch(r'[\d,]+', precio) else precio,
                estado_documento=status,
                vendido=status == 'VENDIDO',
                pagina=page_number,
            ))

codes = [r['codigo'] for r in rows]
assert len(codes) == len(set(codes)), 'Duplicate stall codes'
with (out / 'puestos-extraidos.csv').open('w', encoding='utf-8-sig', newline='') as stream:
    writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
    writer.writeheader()
    writer.writerows(rows)

summary = dict(
    total=len(rows),
    vendidos=sum(r['vendido'] for r in rows),
    disponibles=sum(not r['vendido'] for r in rows),
    rubros=dict(collections.Counter(r['rubro'] for r in rows)),
    precios_no_numericos=[r['codigo'] for r in rows if not isinstance(r['precio'], int)],
    areas_no_numericas=[r['codigo'] for r in rows if r['area'] is None],
)
(out / 'resumen.json').write_text(json.dumps(summary, ensure_ascii=False, indent=2), encoding='utf-8')
print(json.dumps(summary, ensure_ascii=True, indent=2))
