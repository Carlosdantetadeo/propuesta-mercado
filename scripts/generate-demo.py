import json
from pathlib import Path
specs=[('PES','Pescados y mariscos','pescado','#186b80',176,201,150,101),('CAR','Carnes','carne','#9f4937',176,96,150,97),('ABA','Abarrotes','abarrotes','#506a34',1009,438,101,103)]
sectors=[]; stalls=[]
for k,(prefix,name,icon,color,x,y,w,h) in enumerate(specs,1):
 sid=f'10000000-0000-4000-8000-{k:012d}'
 sectors.append(dict(id=sid,nombre=name,rubro=name,color=color,orden=k,contorno=[[[x,y],[x+w,y],[x+w,y+h],[x,y+h]]],icono=icon))
 for i in range(10):
  state='vendido' if i in [7,8] else 'bloqueado' if i==9 else 'disponible'
  stalls.append(dict(id=f'20000000-0000-4000-8000-{k*100+i+1:012d}',codigo=f'{prefix}-{i+1:02}',sector_id=sid,estado=state,area=9,precio=84000+(i%3)*6000,geometria=dict(x=round(x+5+(i%5)*(w-10)/5,2),y=round(y+5+(i//5)*(h-10)/2,2),w=round((w-10)/5-3,2),h=round((h-10)/2-4,2)),version=1,separado_por=None,motivo_bloqueo='Ejemplo: reservado por el propietario' if state=='bloqueado' else None,actualizado_en='2026-10-20T00:00:00Z'))
data=dict(sectores=sectors,puestos=stalls)
Path('src/data/plano-demo.json').write_text(json.dumps(data,ensure_ascii=False,indent=2),encoding='utf-8')
def lit(v):
 if v is None:return 'null'
 if isinstance(v,(dict,list)):return "'"+json.dumps(v,ensure_ascii=False).replace("'","''")+"'::jsonb"
 if isinstance(v,(int,float)):return str(v)
 return "'"+v.replace("'","''")+"'"
sql=['-- DEMONSTRATION ONLY. Never run this seed against commercial inventory.','-- 3 example sectors / 30 example stalls. Prices, codes and internal geometry are illustrative.','begin;']
for table,rows in [('sectores',sectors),('puestos',stalls)]:
 for r in rows:
  sql.append('insert into public.'+table+' ('+','.join(r)+') values ('+','.join(lit(v) for v in r.values())+') on conflict (id) do nothing;')
sql.append('commit;')
Path('supabase/seed.sql').write_text('\n'.join(sql)+'\n',encoding='utf-8')
