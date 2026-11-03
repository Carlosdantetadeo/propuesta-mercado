import layout from '../../data/plano-geometria.json';
import { Camera } from './camera';
import { Provider } from './provider';
import { acciones, type Accion, type Puesto, type Rect, type Sector, type Snapshot } from './types';

const $ = <T extends Element = HTMLElement>(id:string) => document.getElementById(id)! as unknown as T;
const esc = (v:unknown) => String(v??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
const normal = (v:string) => v.normalize('NFD').replace(/[\u0300-\u036f\s-]/g,'').toLowerCase();
const stateLabel = {disponible:'Disponible',vendido:'Ocupado · vendido',separado:'Separado',bloqueado:'Bloqueado'};
const geometry = layout.stalls as Record<string,Rect>;
const money=(n:number|null)=>n===null?'Por confirmar':new Intl.NumberFormat('es-PE',{style:'currency',currency:'USD',maximumFractionDigits:0}).format(n);
const bounds=(rects:Rect[]):Rect=>{
  const x=Math.min(...rects.map(r=>r.x)),y=Math.min(...rects.map(r=>r.y));
  return {x,y,w:Math.max(...rects.map(r=>r.x+r.w))-x,h:Math.max(...rects.map(r=>r.y+r.h))-y};
};
const shortName=(s:string)=>({'PLASTICOS Y LIMPIEZA':'PLÁSTICOS Y LIMPIEZA','LECHE, HUEVOS QUESOS Y':'LECHE / HUEVOS / QUESOS','PRODUCTOS DE LA SIERRA':'PRODUCTOS DE LA SIERRA','PRODUCTOS NATURALES':'P. NATURALES','TIENDA DE CONVENIENCIA':'CONVENIENCIA','PAPAS Y TUBERCULOS':'PAPAS Y TUBÉRCULOS','ESPECERIA / MOLIDOS':'ESPECIAS / MOLIDOS','JOLLERIA':'JOYERÍA'}[s]??s);
const actionLabel:Record<Accion,string>={separar:'Separar',liberar:'Liberar',vender:'Vender',bloquear:'Bloquear',desbloquear:'Desbloquear'};
const needsMotivo=new Set<Accion>(['bloquear','desbloquear','vender']);
const roleLabel={admin:'Administrador',asesor:'Asesor',lector:'Lector'} as const;

export async function startMarketMap(opts?:{admin?:boolean}){
  const admin=!!opts?.admin;
  const svg=$<SVGSVGElement>('market-svg'),camera=new Camera(svg),provider=new Provider();
  let puestos:Puesto[]=[],sectores=new Map<string,Sector>(),byCode=new Map<string,Puesto>(),selected='',state='',initialized=false;
  const nodes=new Map<string,SVGGElement>();
  const commercial={x:190,y:53,w:1640,h:862};
  const fitAll=()=>camera.fit(commercial);
  function message(text=''){ $('map-message').textContent=text;$('map-message').hidden=!text; }
  function matches(p:Puesto){
    const q=normal($<HTMLInputElement>('map-search').value),sector=$<HTMLSelectElement>('map-sector').value;
    return (!state||(state==='ocupado'?p.estado==='vendido'||p.estado==='bloqueado':p.estado===state))&&(!sector||p.sector_id===sector)&&(!q||normal(p.codigo).includes(q)||normal(sectores.get(p.sector_id)?.nombre??'').includes(q));
  }
  function filters(){let count=0;for(const p of puestos){const match=matches(p);if(match)count++;nodes.get(p.id)?.classList.toggle('dimmed',!match);}$('visible-map-count').textContent=`${count} de ${puestos.length} puestos`;$('map-detail').hidden=!selected;}
  function lod(){const scale=Math.hypot(svg.getScreenCTM()?.a??1,svg.getScreenCTM()?.b??0);nodes.forEach((node)=>{const w=Number(node.dataset.width);node.classList.toggle('code-hidden',w*scale<23);});}
  camera.onFrame=lod;
  const canManage=()=>admin;
  function renderActions(p:Puesto){
    const box=document.getElementById('detail-actions');if(!box)return;
    const open:('separar'|'liberar')[]=p.estado==='disponible'?['separar']:p.estado==='separado'?['liberar']:[];
    const adminExtra=provider.role==='admin'?acciones(p,'admin','').filter(a=>needsMotivo.has(a)):[];
    box.innerHTML=open.map(a=>`<button type="button" data-kind="open" data-action="${a}" class="detail-action-btn">${actionLabel[a]}</button>`).join('')
      +adminExtra.map(a=>`<button type="button" data-kind="admin" data-action="${a}" class="detail-action-btn warn">${actionLabel[a]}</button>`).join('')
      +(provider.role==='admin'?`<label class="detail-assign">Mover a sector<select id="assign-sector-select"><option value="">—</option>${[...sectores.values()].map(s=>`<option value="${esc(s.id)}" ${s.id===p.sector_id?'selected':''}>${esc(shortName(s.nombre))}</option>`).join('')}</select></label>`:'')
      +`<div id="action-confirm" class="action-confirm" hidden><input id="action-motivo" type="text" placeholder="Motivo (obligatorio)" /><button type="button" id="action-confirm-go">Confirmar</button><button type="button" id="action-confirm-cancel">Cancelar</button></div>`
      +`<p id="action-error" class="action-error" hidden></p>`;
    const confirmBox=document.getElementById('action-confirm') as HTMLElement;
    const motivoInput=document.getElementById('action-motivo') as HTMLInputElement;
    const errorBox=document.getElementById('action-error') as HTMLElement;
    const showError=(msg:string)=>{errorBox.textContent=msg;errorBox.hidden=false;};
    const runOpen=async(action:'separar'|'liberar')=>{
      errorBox.hidden=true;
      try{ await provider.openChange([p],action); }
      catch(e){ showError(e instanceof Error?e.message:'No se pudo completar la acción.'); }
    };
    const runAdmin=async(action:Accion,motivo:string)=>{
      errorBox.hidden=true;
      try{ await provider.change([p],action,motivo); confirmBox.hidden=true; }
      catch(e){ showError(e instanceof Error?e.message:'No se pudo completar la acción.'); }
    };
    box.querySelectorAll<HTMLButtonElement>('[data-action]').forEach(btn=>btn.addEventListener('click',()=>{
      const action=btn.dataset.action!,kind=btn.dataset.kind;
      errorBox.hidden=true;
      if(kind==='open'){ void runOpen(action as 'separar'|'liberar'); return; }
      confirmBox.hidden=false; motivoInput.value=''; motivoInput.focus();
      document.getElementById('action-confirm-go')!.onclick=()=>void runAdmin(action as Accion,motivoInput.value);
    }));
    const cancelBtn=document.getElementById('action-confirm-cancel');
    if(cancelBtn) cancelBtn.onclick=()=>{confirmBox.hidden=true;errorBox.hidden=true;};
    const sectorSelect=document.getElementById('assign-sector-select') as HTMLSelectElement|null;
    if(sectorSelect) sectorSelect.addEventListener('change',async()=>{
      const sectorId=sectorSelect.value;if(!sectorId||sectorId===p.sector_id)return;
      const motivo=prompt('Motivo del cambio de sector:')??'';
      if(!motivo.trim()){sectorSelect.value=p.sector_id;return;}
      try{ await provider.assign([{id:p.id,sector_id:sectorId,version:p.version}],motivo); }
      catch(e){ showError(e instanceof Error?e.message:'No se pudo reasignar el sector.'); sectorSelect.value=p.sector_id; }
    });
  }
  function detail(id:string,zoom=false){
    const p=puestos.find(p=>p.id===id);if(!p)return;
    if(!canManage()&&(p.estado==='vendido'||p.estado==='bloqueado')){
      selected='';nodes.forEach(n=>n.classList.remove('selected'));
      $('map-detail').hidden=true;
      for(const field of ['detail-code','detail-rubro','detail-status','detail-price'])$(field).textContent='';
      if(zoom){const r=geometry[p.codigo];if(r)camera.fit({x:r.x-83,y:r.y-89,w:r.w+166,h:r.h+178});message('Este puesto no está disponible.');}
      return;
    }
    selected=id;nodes.forEach((n,key)=>n.classList.toggle('selected',key===id));
    $('detail-code').textContent=p.codigo;$('detail-rubro').textContent=sectores.get(p.sector_id)?.nombre??'';
    $('detail-status').textContent=stateLabel[p.estado];$('detail-price').textContent=money(p.precio);$('map-detail').hidden=false;
    if(canManage())renderActions(p);
    if(zoom){const r=geometry[p.codigo];if(r)camera.fit({x:r.x-83,y:r.y-89,w:r.w+166,h:r.h+178});}
  }
  function render(data:Snapshot){
    puestos=data.puestos;sectores=new Map(data.sectores.map(s=>[s.id,s]));byCode=new Map(puestos.map(p=>[p.codigo,p]));
    const selector=$<HTMLSelectElement>('map-sector'),previous=selector.value;
    selector.innerHTML='<option value="">Todos los sectores</option>'+data.sectores.map(s=>`<option value="${esc(s.id)}">${esc(shortName(s.nombre))}</option>`).join('');selector.value=previous;
    $('count-free').textContent=String(puestos.filter(p=>p.estado==='disponible').length);
    $('count-occupied').textContent=String(puestos.filter(p=>p.estado==='vendido'||p.estado==='bloqueado').length);
    $('count-total').textContent=String(puestos.length);
    $('market-stalls').replaceChildren();nodes.clear();
    for(const p of puestos){
      const r=geometry[p.codigo];if(!r)continue;
      const n=document.createElementNS('http://www.w3.org/2000/svg','g');
      n.classList.add('map-unit',p.estado);n.dataset.id=p.id;n.dataset.code=p.codigo;n.dataset.width=String(r.w);n.setAttribute('role','button');n.setAttribute('tabindex','0');n.setAttribute('aria-label',`${p.codigo}, ${sectores.get(p.sector_id)?.nombre}, ${stateLabel[p.estado]}`);
      const text=p.codigo;
      n.innerHTML=`<title>${esc(p.codigo)} · ${esc(sectores.get(p.sector_id)?.nombre)} · ${esc(stateLabel[p.estado])}</title><rect x="${r.x+.35}" y="${r.y+.35}" width="${r.w-.7}" height="${r.h-.7}" rx=".45"/><text x="${r.x+r.w/2}" y="${r.y+r.h/2}" font-size="${Math.min(5,r.w/(text.length*.65))}">${esc(text)}</text>`;
      nodes.set(p.id,n);$('market-stalls').append(n);
    }
    type Group={name:string;codes:string[];rect:Rect};const groups:Group[]=[];
    $('market-boundaries').innerHTML=layout.blocks.map(b=>`<rect class="map-sector-boundary" x="${b.x-1}" y="${b.y-1}" width="${b.w+2}" height="${b.h+2}" rx="1"/>`).join('');
    for(const b of layout.blocks.filter(b=>b.label)){
      const names=[...new Set(b.codes.map(c=>sectores.get(byCode.get(c)?.sector_id??'')?.nombre).filter(Boolean))] as string[];
      const name=names.map(shortName).join(' / '),r={x:b.x,y:b.y,w:b.w,h:b.h};
      const previous=groups.at(-1);
      if(previous&&previous.name===name&&Math.abs(previous.rect.y-r.y)<1&&r.x-previous.rect.x-previous.rect.w<35){previous.rect=bounds([previous.rect,r]);previous.codes.push(...b.codes);}
      else groups.push({name,codes:[...b.codes],rect:r});
    }
    $('market-labels').innerHTML=groups.map((g,i)=>{
      const r=g.rect,font=Math.min(7.3,Math.max(3.4,r.w/(g.name.length*.57))),y=r.y-11;
      return `<g class="map-sector-label" data-group="${i}" role="button" tabindex="0" aria-label="Acercar sector ${esc(g.name)}"><rect x="${r.x-2}" y="${y}" width="${r.w+4}" height="9" rx="1.4"/><text x="${r.x+r.w/2}" y="${y+4.7}" font-size="${font}" textLength="${Math.min(r.w-2,g.name.length*font*.58)}" lengthAdjust="spacingAndGlyphs">${esc(g.name)}</text></g>`;
    }).join('');
    for(const node of $('market-labels').querySelectorAll<SVGGElement>('[data-group]')){
      const group=groups[Number(node.dataset.group)];
      const zoom=()=>{const rects=group.codes.map(c=>geometry[c]).filter(Boolean);if(rects.length)camera.fit(bounds(rects));};
      node.addEventListener('click',()=>{if(!camera.suppressClick)zoom();});node.addEventListener('keydown',e=>{if(e.key==='Enter'||e.key===' '){e.preventDefault();zoom();}});
    }
    if(selected)detail(selected);filters();lod();
    if(!initialized){camera.fit(commercial,false);initialized=true;}
    if(nodes.size!==puestos.length)message(`${puestos.length-nodes.size} puestos pendientes de ubicar.`);
  }
  svg.addEventListener('click',e=>{if(camera.suppressClick)return;const n=(e.target as Element).closest<SVGGElement>('[data-id]');if(n)detail(n.dataset.id!);});
  svg.addEventListener('keydown',e=>{if(e.key==='Enter'||e.key===' '){const n=(e.target as Element).closest<SVGGElement>('[data-id]');if(n){e.preventDefault();detail(n.dataset.id!);}}});
  function search(){const q=normal($<HTMLInputElement>('map-search').value);if(!q)return;const exact=puestos.find(p=>normal(p.codigo)===q||p.codigo.split('-')[1]===q);if(exact){message();detail(exact.id,true);return;}const found=puestos.filter(matches).map(p=>geometry[p.codigo]).filter(Boolean);if(found.length){message();camera.fit(bounds(found));}else message('No se encontró ese puesto. Prueba con su código o sector.');}
  $('search-go').addEventListener('click',search);$('map-search').addEventListener('input',()=>{message();filters();});$('map-search').addEventListener('keydown',e=>{if((e as KeyboardEvent).key==='Enter')search();});
  $('map-sector').addEventListener('change',()=>{filters();const found=puestos.filter(matches).map(p=>geometry[p.codigo]).filter(Boolean);if(found.length)camera.fit(bounds(found));});
  document.querySelectorAll<HTMLButtonElement>('[data-state]').forEach(b=>b.addEventListener('click',()=>{state=b.dataset.state!;document.querySelectorAll('[data-state]').forEach(n=>n.setAttribute('aria-pressed',String(n===b)));filters();}));
  $('market-plus').addEventListener('click',()=>camera.zoom(.65));$('market-minus').addEventListener('click',()=>camera.zoom(1.5));$('market-fit').addEventListener('click',fitAll);
  $('reset-map').addEventListener('click',()=>{$<HTMLInputElement>('map-search').value='';$<HTMLSelectElement>('map-sector').value='';state='';selected='';document.querySelectorAll<HTMLElement>('[data-state]').forEach(n=>n.setAttribute('aria-pressed',String(n.dataset.state==='')));message();filters();camera.fit({x:127,y:38,w:2187,h:903});});
  $('close-map-detail').addEventListener('click',()=>{selected='';$('map-detail').hidden=true;nodes.forEach(n=>n.classList.remove('selected'));});
  window.addEventListener('keydown',e=>{if(e.key==='Escape')$('close-map-detail').click();});
  camera.fit(commercial,false);
  function refreshAccountUI(){
    const badge=document.getElementById('account-badge');
    const trigger=document.getElementById('admin-login-trigger');
    const isAdmin=provider.role==='admin';
    if(badge){ badge.hidden=!isAdmin;
      if(isAdmin){ const nameEl=document.getElementById('account-name'); if(nameEl) nameEl.textContent=`${provider.nombre||'Cuenta'} · ${roleLabel[provider.role]}`; }
    }
    if(trigger) trigger.hidden=isAdmin;
    if(selected) detail(selected);
  }
  if(admin){
    const loginPanel=document.getElementById('login-panel');
    const loginForm=document.getElementById('login-form') as HTMLFormElement|null;
    const loginError=document.getElementById('login-error');
    document.getElementById('admin-login-trigger')?.addEventListener('click',()=>{ if(loginPanel) loginPanel.hidden=false; });
    document.getElementById('login-cancel')?.addEventListener('click',()=>{ if(loginPanel) loginPanel.hidden=true; });
    loginForm?.addEventListener('submit',async e=>{
      e.preventDefault();
      const email=(document.getElementById('login-email') as HTMLInputElement).value.trim();
      const password=(document.getElementById('login-password') as HTMLInputElement).value;
      const submitBtn=loginForm.querySelector('button[type=submit]') as HTMLButtonElement;
      submitBtn.disabled=true; if(loginError) loginError.hidden=true;
      try{ await provider.login(email,password); if(loginPanel) loginPanel.hidden=true; refreshAccountUI(); }
      catch(err){ if(loginError){loginError.textContent=err instanceof Error?err.message:'No se pudo iniciar sesión.';loginError.hidden=false;} }
      finally{ submitBtn.disabled=false; }
    });
    document.getElementById('account-logout')?.addEventListener('click',async()=>{ await provider.logout(); refreshAccountUI(); });
    refreshAccountUI();
  }
  await provider.start({snapshot:render,change:p=>{const index=puestos.findIndex(x=>x.id===p.id);if(index>=0)puestos[index]=p;render({puestos,sectores:[...sectores.values()]});},connection:(state,text)=>{
    $('map-connection').textContent=state==='ready'?'Disponibilidad actualizada':'Actualizando…';
    $('map-loading').hidden=state==='ready'||initialized;
    if(state==='error'||text)message(text??'No se pudo actualizar la disponibilidad.');else if(state==='ready')message();
  }});
}
