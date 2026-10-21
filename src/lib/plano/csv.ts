import type { Asignacion, Puesto, Sector } from './types';
// RFC4180 quoted cells, CRLF, BOM, escaped quotes; comma or semicolon delimiter.
export function parseCSV(text: string): string[][] {
  text=text.replace(/^\uFEFF/,'');
  const delimiter=text.split(/\r?\n/)[0].includes(';')?';':',';
  const rows:string[][]=[]; let row:string[]=[], cell='', quoted=false;
  for(let i=0;i<text.length;i++){
    const c=text[i];
    if(c==='"') { if(quoted && text[i+1]==='"') {cell+='"';i++;} else quoted=!quoted; }
    else if(c===delimiter&&!quoted){row.push(cell.trim());cell='';}
    else if(c==='\n'&&!quoted){row.push(cell.trim());if(row.some(Boolean))rows.push(row);row=[];cell='';}
    else if(c!=='\r'||quoted)cell+=c;
  }
  if(quoted) throw new Error('CSV inválido: comillas sin cerrar.');
  row.push(cell.trim());if(row.some(Boolean)) rows.push(row);
  return rows;
}
export function assignmentsCSV(text:string,puestos:Iterable<Puesto>,sectores:Iterable<Sector>):Asignacion[]{
  const rows=parseCSV(text), head=rows.shift()?.map(s=>s.toLowerCase());
  if(!head || head.length!==2 || head[0]!=='codigo'||head[1]!=='sector') throw new Error('El encabezado debe ser codigo,sector.');
  if(!rows.length||rows.length>1000) throw new Error('El CSV debe tener entre 1 y 1000 puestos.');
  const ps=new Map([...puestos].map(p=>[p.codigo.toLowerCase(),p])), ss=[...sectores], seen=new Set();
  return rows.map((r,i)=>{
    const p=ps.get(r[0]?.toLowerCase()), s=ss.find(s=>s.id===r[1]||s.nombre.toLowerCase()===r[1]?.toLowerCase());
    if(r.length!==2||!p||!s) throw new Error(`Fila ${i+2}: código o sector desconocido.`);
    if(seen.has(p.id)) throw new Error(`Fila ${i+2}: puesto repetido.`);
    seen.add(p.id);return{id:p.id,sector_id:s.id,version:p.version};
  });
}
