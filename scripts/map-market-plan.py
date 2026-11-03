"""Trace numbered islands on plano-original.webp; table codes remain authoritative.

Coordinates are image pixels, not survey dimensions. The raster contains prefix
and category discrepancies; match by unique stall number, preserving CSV rubro.
"""
import csv
import json
from pathlib import Path

rows = list(csv.DictReader(Path('docs/mercado/puestos-extraidos.csv').open(encoding='utf-8-sig')))
by_number = {int(r['codigo'].split('-')[1]): r for r in rows}
sx, sy = 1888/4773, 778/1967
stalls, blocks = {}, []

def block(start, count, x, y, w, h, columns=2, label=True):
    height = h / (count/columns)
    codes = []
    for offset in range(count):
        item = by_number[start+offset]
        assert item['codigo'] not in stalls
        stalls[item['codigo']] = dict(x=round((x+offset%columns*w/columns)*sx,3),
            y=round((y+offset//columns*height)*sy,3),w=round(w/columns*sx,3),h=round(height*sy,3))
        codes.append(item['codigo'])
    blocks.append(dict(x=round(x*sx,3),y=round(y*sy,3),w=round(w*sx,3),h=round(h*sy,3),codes=codes,label=label))

xs = [450,590,728,864,998,1138,1278,1445,1607,1775,1929,2081,2240,2390,2538,2689,2838,2987,3138]
widths = [92,92,92,92,94,98,100,103,103,108,106,106,99,99,96,96,96,96,96]
starts = [
 [1,41,81,131,181,221,271,311,351,391,431,471,511,551,601,641,691,741,791],
 [11,51,91,141,191,231,281,321,361,401,441,481,521,561,611,651,701,751,801],
 [21,61,101,151,0,241,0,0,0,0,0,0,0,571,0,661,711,761,811],
 [31,71,111,161,201,251,291,331,371,411,451,491,531,581,621,671,721,771,821],
 [0,0,121,171,211,261,301,341,381,421,461,501,541,591,631,681,731,781,831],
]
for indices, y, h in zip(starts,[270,540,820,1110,1410],[210,216,240,250,256]):
    for index,start in enumerate(indices):
        if start: block(start,10,xs[index],y,widths[index],h)

# Perimeter service units follow the labeled frontage groups on the raster.
for start,count,x,w in [(877,10,420,730),(887,10,1150,833),(897,10,1983,741),(907,6,2724,420),(913,2,3144,158)]:
    block(start,count,x,179,w,38,count)
for start,count,x,w in [(841,4,674,268),(845,6,942,417),(851,4,1359,303),(855,4,1662,288),(859,3,1950,204),(862,4,2154,336),(866,4,2490,291),(870,4,2781,301),(874,3,3082,232)]:
    block(start,count,x,1715,w,40,count)
# Food court: left / top / bottom / right, as numbered in the original.
block(915,4,1276,810,49,249,1,False)
block(919,17,1434,810,786,60,17,False)
block(936,17,1434,997,786,60,17,False)
block(953,4,2323,810,43,249,1,False)
assert len(stalls)==956

# Stalls traced above are keyed by current codigo for each numbered slot. If a
# slot's prefix/rubro changed since the previous extraction (renumbering), keep
# the old codigo pointing at the same rect too, so it keeps rendering until the
# live database is updated to the new codigo. Stall numbers beyond the traced
# raster (new construction) have no coordinates yet and are left unplaced.
previous = Path('src/data/plano-geometria.json')
if previous.exists():
    for old_code, rect in json.loads(previous.read_text())['stalls'].items():
        stalls.setdefault(old_code, rect)

all_codes = {r['codigo'] for r in rows}
unplaced = sorted(all_codes - set(stalls), key=lambda c: (c.split('-')[0], int(c.split('-')[1])))
target=Path('src/data/plano-geometria.json')
target.write_text(json.dumps(dict(source='plano-original.webp',stalls=stalls,blocks=blocks),ensure_ascii=False,separators=(',',':')),encoding='utf-8')
print(f'{len(stalls)} mapped stalls ({len(stalls)-956} legacy aliases) in {len(blocks)} traced blocks')
print(f'{len(unplaced)} stalls without coordinates (new construction, pending real floor-plan trace):')
print(unplaced)
