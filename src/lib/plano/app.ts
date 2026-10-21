import { zones } from '../../data/promarsa';
import { supabase } from '../supabase';
import { Camera } from './camera';
import { Provider, type Connection } from './provider';
import { PlanoStore } from './store';
import { assignmentsCSV } from './csv';
import { acciones, conteo, estados, labels, symbols, type Accion, type Asignacion, type Puesto, type Rect, type Rol, type Sector } from './types';
const $=<T extends Element=HTMLElement>(id:string)=>document.getElementById(id)! as unknown as T;
const esc=(value:unknown)=>String(value??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]!));
const normalize=(v:string)=>v.normalize('NFD').replace(/[\u0300-\u036f]/g,'').toLowerCase();
const price=(n:number|null)=>n===null?'Por confirmar':new Intl.NumberFormat('es-PE',{style:'currency',currency:'PEN',maximumFractionDigits:0}).format(n);
const icon=(s:Sector)=>({pescado:'≈',carne:'◇',abarrotes:'▦',servicios:'✧',local:'▣'}[s.icono]??'▣');
const rectBounds=(points:number[][]):Rect=>{const xs=points.map(p=>p[0]),ys=points.map(p=>p[1]);return{x:Math.min(...xs),y:Math.min(...ys),w:Math.max(...xs)-Math.min(...xs),h:Math.max(...ys)-Math.min(...ys)}};
const actionText:Record<Accion,string>={separar:'Separar',liberar:'Liberar',vender:'Marcar vendido',bloquear:'Bloquear',desbloquear:'Desbloquear'};
export async function startApp(){
  const provider=new Provider(),store=new PlanoStore(),camera=new Camera($<SVGSVGElement>('map'));
  let sectorId:string|null=null,selectedId:string|null=null,listMode=false,multi=false,limit=60,toastTimer:ReturnType<typeof setTimeout>;
  const selected=new Set<string>(),stallNodes=new Map<string,SVGGElement>(),sectorNodes=new Map<string,SVGGElement>(),cardNodes=new Map<string,HTMLButtonElement>(),listNodes=new Map<string,HTMLButtonElement>();
  const geometryCache=new Map<string,{path:string;bounds:Rect}>();
  let confirmTask:((reason:string)=>Promise<void>)|null=null;
  let lastFocused:Element|null=null;
  const mobile=()=>matchMedia('(max-width:760px)').matches;
  function toast(message:string){$('toast').textContent=message;$('toast').hidden=false;clearTimeout(toastTimer);toastTimer=setTimeout(()=>$('toast').hidden=true,4500);}
  function announce(message:string){$('live-announcement').textContent=message;}
  function geometry(s:Sector){
    if(!geometryCache.has(s.id)){
      const points=s.contorno.flat();
      geometryCache.set(s.id,{path:s.contorno.map(poly=>poly.length?'M'+poly.map(p=>p.join(',')).join('L')+'Z':'').join(' '),bounds:points.length?rectBounds(points):{x:140,y:40,w:1150,h:680}});
    }
    return geometryCache.get(s.id)!;
  }
  function activeBounds():Rect{
    if(!sectorId)return{x:0,y:0,w:1888,h:778};
    const s=store.sectores.get(sectorId)!; const points=[...s.contorno.flat()];
    for(const p of store.list(sectorId)){if(p.geometria){const r=p.geometria;points.push([r.x,r.y],[r.x+r.w,r.y+r.h]);}}
    return points.length?rectBounds(points):{x:140,y:40,w:1150,h:680};
  }
  function drawReference(){
    $('reference-zones').innerHTML=zones.filter(z=>!['Estacionamientos','Carga y descarga'].includes(z.name)).map(z=>`<g><rect x="${z.x}" y="${z.y}" width="${z.w}" height="${z.h}" rx="4" fill="#dce4d5" stroke="#b9c7af" stroke-width="1"/><text class="reference-label" x="${z.x+z.w/2}" y="${z.y+z.h/2}">${esc(z.name.length>22?z.name.slice(0,20)+'…':z.name)}</text></g>`).join('');
    $('facilities').innerHTML=`<g class="facility"><rect x="1313" y="70" width="404" height="341" rx="12" fill="#e2e7dd" stroke="#bcc8b5"/><text x="1515" y="190" text-anchor="middle" style="font-size:38px">P</text><text class="facility-title" x="1515" y="230" text-anchor="middle">ESTACIONAMIENTOS</text><text x="1515" y="254" text-anchor="middle">380 espacios · 10 864 m²</text><path d="M1350 300h330M1350 330h330M1350 360h330" stroke="#bdc9b4" stroke-dasharray="22 6" stroke-width="16"/><rect x="1572" y="468" width="231" height="221" rx="10" fill="#e5e5d6" stroke="#bdbfa6"/><text x="1687" y="555" text-anchor="middle" style="font-size:30px">⇄</text><text class="facility-title" x="1687" y="590" text-anchor="middle">CARGA Y DESCARGA</text><text x="1687" y="612" text-anchor="middle">1 872 m²</text><text x="1687" y="642" text-anchor="middle">Acceso de camiones →</text><text x="115" y="400" transform="rotate(-90 115 400)" text-anchor="middle">AV. ALFREDO MENDIOLA</text><text x="1850" y="400" transform="rotate(-90 1850 400)" text-anchor="middle">CALLE LOS TALLERES</text><text x="500" y="750">↑ ACCESO AL MERCADO</text><text x="620" y="375">♜ PATIO DE COMIDAS</text><text x="184" y="620">WC</text><text x="182" y="637" style="font-size:8px">SERVICIOS*</text><text x="391" y="370" style="font-size:19px">▤</text><text x="384" y="390" style="font-size:7px">ESCALERAS*</text><text x="1310" y="742" style="font-size:8px">* Ubicación esquemática de equipamiento, por validar.</text></g>`;
  }
  function renderTotals(){
    const c=conteo([]);for(const counts of store.counts.values()){for(const key of estados)c[key]+=counts[key];c.total+=counts.total;}
    $('totals').innerHTML=estados.map(state=>`<div class="total-card"><span aria-hidden="true" class="total-icon state-${state}">${symbols[state]}</span><div><strong data-total="${state}">${c[state]}</strong><small>${({disponible:'Disponibles',separado:'Separados',vendido:'Vendidos',bloqueado:'Bloqueados'})[state]}</small></div><span class="total-tail">${c.total?Math.round(c[state]/c.total*100):0}%</span></div>`).join('');
  }
  function updateSector(id:string){
    const s=store.sectores.get(id);if(!s)return;
    const c=store.counts.get(id)??conteo([]),node=sectorNodes.get(id),card=cardNodes.get(id);
    if(node){node.querySelector('.sector-free')!.textContent=`${c.disponible} libres`;node.setAttribute('aria-label',`${s.nombre}: ${c.disponible} disponibles, ${c.separado} separados, ${c.vendido} vendidos, ${c.bloqueado} bloqueados. Entrar al sector.`);}
    if(card){card.querySelector('.sector-metrics')!.innerHTML=`<div class="sector-available"><b>${c.disponible} disponibles</b><span>${c.avance}% vendido</span></div><p class="sector-counts">◷ ${c.separado} separados · ✓ ${c.vendido} vendidos · ⊘ ${c.bloqueado} bloqueados</p><div class="progress" role="progressbar" aria-label="Avance de ${esc(s.nombre)}" aria-valuemin="0" aria-valuemax="100" aria-valuenow="${c.avance}"><span style="width:${c.avance}%"></span></div>`;}
  }
  function renderSectors(){
    geometryCache.clear();sectorNodes.clear();cardNodes.clear();$('sector-layer').replaceChildren();$('sector-cards').replaceChildren();
    const sectors=[...store.sectores.values()].sort((a,b)=>a.orden-b.orden);
    for(const s of sectors){
      const g=geometry(s),color=/^#[0-9a-f]{6}$/i.test(s.color)?s.color:'#49603e';
      if(s.contorno.length){
        const node=document.createElementNS('http://www.w3.org/2000/svg','g');node.classList.add('sector-shape');node.dataset.sector=s.id;node.setAttribute('role','button');node.setAttribute('tabindex','0');
        node.innerHTML=`<path d="${esc(g.path)}" fill="${color}" stroke="${color}"/><text x="${g.bounds.x+g.bounds.w/2}" y="${g.bounds.y+g.bounds.h*.32}" font-size="18">${icon(s)}</text><text x="${g.bounds.x+g.bounds.w/2}" y="${g.bounds.y+g.bounds.h*.55}" font-size="${Math.min(12,g.bounds.w/9)}">${esc(s.nombre.split(' y ')[0])}</text><text class="sector-free" x="${g.bounds.x+g.bounds.w/2}" y="${g.bounds.y+g.bounds.h*.75}" font-size="11"></text>`;
        $('sector-layer').append(node);sectorNodes.set(s.id,node);
      }
      const card=document.createElement('button');card.className='sector-card';card.dataset.sector=s.id;
      card.innerHTML=`<span class="sector-title"><span class="sector-icon" aria-hidden="true">${icon(s)}</span><b>${esc(s.nombre)}</b><span aria-hidden="true">↗</span></span><div class="sector-metrics"></div>`;
      $('sector-cards').append(card);cardNodes.set(s.id,card);updateSector(s.id);
    }
    $('sector-total').textContent=String(sectors.length);
    for(const id of ['filter-sector','bulk-sector','assign-sector']){
      const el=$<HTMLSelectElement>(id),current=el.value;
      el.innerHTML=(id==='filter-sector'?'<option value="">Todos</option>':'')+sectors.map(s=>`<option value="${esc(s.id)}">${esc(s.nombre)}</option>`).join('');
      if(sectors.some(s=>s.id===current))el.value=current;
    }
  }
  function matches(p:Puesto){
    const query=normalize($<HTMLInputElement>('search').value.trim()),state=$<HTMLSelectElement>('filter-state').value,sector=$<HTMLSelectElement>('filter-sector').value;
    if(query&&!normalize(p.codigo+' '+(store.sectores.get(p.sector_id)?.nombre??'')).includes(query))return false;
    if(state&&p.estado!==state||sector&&p.sector_id!==sector)return false;
    for(const [key,field,lower] of [['price-min','precio',true],['price-max','precio',false],['area-min','area',true],['area-max','area',false]] as const){
      const value=$<HTMLInputElement>(key).value;
      if(value!==''&&(p[field]===null||(lower?p[field]!<Number(value):p[field]!>Number(value))))return false;
    }return true;
  }
  function visible(){return (sectorId?store.list(sectorId):[...store.puestos.values()]).filter(matches);}
  function updateStall(node:SVGGElement,p:Puesto,changed=false){
    node.setAttribute('class',`stall ${p.estado}${selectedId===p.id?' selected':''}${selected.has(p.id)?' multi':''}${changed?' changed':''}`);
    node.setAttribute('aria-label',`${p.codigo}, ${labels[p.estado]}, ${p.area??'área por confirmar'} m², ${price(p.precio)}. Ver detalle.`);
    node.setAttribute('aria-pressed',String(multi?selected.has(p.id):p.id===selectedId));
    node.querySelector('.stall-symbol')!.textContent=symbols[p.estado];
    node.style.display=matches(p)?'':'none';
    if(changed)setTimeout(()=>node.classList.remove('changed'),1400);
  }
  function addStall(p:Puesto){
    if(!p.geometria)return;
    const r=p.geometria,node=document.createElementNS('http://www.w3.org/2000/svg','g');node.dataset.puesto=p.id;node.setAttribute('tabindex','0');node.setAttribute('role','button');
    node.innerHTML=`<rect x="${r.x}" y="${r.y}" width="${r.w}" height="${r.h}" rx="${Math.min(3,r.w*.1)}"/><text class="stall-symbol" x="${r.x+r.w/2}" y="${r.y+r.h*.30}" font-size="${Math.min(8,r.w*.24)}"></text><text class="stall-code" x="${r.x+r.w/2}" y="${r.y+r.h*.62}" font-size="${Math.min(6,r.w/4.3)}">${esc(p.codigo)}</text>`;
    updateStall(node,p);$('stall-layer').append(node);stallNodes.set(p.id,node);
  }
  function renderStalls(){
    $('stall-layer').replaceChildren();stallNodes.clear();
    $('map-stage').classList.toggle('sector-detail',!!sectorId);
    if(sectorId)store.list(sectorId).forEach(addStall);
    sectorNodes.forEach((node,id)=>{node.classList.toggle('active',id===sectorId);node.setAttribute('aria-pressed',String(id===sectorId));});
    cardNodes.forEach((node,id)=>{node.classList.toggle('active',id===sectorId);node.setAttribute('aria-pressed',String(id===sectorId));});
    levelOfDetail();
  }
  function levelOfDetail(){
    const matrix=$<SVGSVGElement>('map').getScreenCTM(),scale=matrix?Math.hypot(matrix.a,matrix.b):1;
    let tooSmall=false;
    stallNodes.forEach((node,id)=>{
      const r=store.puestos.get(id)!.geometria!;
      const textSize=Math.min(6,r.w/4.3)*scale;
      node.classList.toggle('code-hidden',textSize<11||r.w*scale<50);
      if(matches(store.puestos.get(id)!)&&Math.min(r.w,r.h)*scale<44)tooSmall=true;
    });
    $('list-fallback').hidden=!sectorId||listMode||!tooSmall;
  }
  camera.onFrame=levelOfDetail;
  function rowContent(p:Puesto){return `<b>${esc(p.codigo)}</b><span class="status-badge state-${p.estado}">${symbols[p.estado]} ${labels[p.estado]}</span><small>${p.area===null?'Área por confirmar':`${p.area} m²`} · ${price(p.precio)}</small>`;}
  function makeRow(p:Puesto){
    const button=document.createElement('button');button.dataset.puesto=p.id;button.innerHTML=rowContent(p);button.classList.toggle('selected',p.id===selectedId);button.classList.toggle('multi',selected.has(p.id));button.setAttribute('aria-pressed',String(multi?selected.has(p.id):p.id===selectedId));return button;
  }
  function renderList(){
    listNodes.clear();$('stall-list').replaceChildren();const list=visible();
    $('results-count').textContent=`${list.length} puestos${sectorId?' en este sector':''} · ${Math.min(limit,list.length)} visibles`;
    list.slice(0,limit).forEach(p=>{const row=makeRow(p);listNodes.set(p.id,row);$('stall-list').append(row);});
    if(list.length>limit){const more=document.createElement('button');more.textContent='Ver más puestos';more.addEventListener('click',()=>{limit+=60;renderList();});$('stall-list').append(more);}
    $('empty-state').hidden=list.length>0;
  }
  function setList(value:boolean){listMode=value;$('map-stage').hidden=value;$('list-panel').hidden=!value;$('map-view').setAttribute('aria-pressed',String(!value));$('list-view').setAttribute('aria-pressed',String(value));if(value)renderList();else{$('empty-state').hidden=visible().length>0;levelOfDetail();}}
  function breadcrumbs(){
    $('breadcrumbs').innerHTML=`<button data-home>Plano</button>${sectorId?`<span aria-hidden="true">›</span><button data-sector="${esc(sectorId)}">${esc(store.sectores.get(sectorId)?.nombre)}</button>`:''}${selectedId?`<span aria-hidden="true">›</span><span aria-current="location">${esc(store.puestos.get(selectedId)?.codigo)}</span>`:''}`;
    $('back-overview').hidden=!sectorId;$('map-caption').textContent=sectorId?(store.sectores.get(sectorId)?.nombre??'SECTOR').toUpperCase():'VISTA GENERAL · SECTORES';
  }
  function enterSector(id:string,fit=true){
    if(!store.sectores.has(id))return;
    closeDetail(false);sectorId=id;limit=60;
    renderStalls();breadcrumbs();setList(false);$<HTMLSelectElement>('bulk-sector').value=id;
    if(fit)camera.fit(activeBounds());
    if(mobile())$('map-stage').scrollIntoView({block:'center',behavior:'smooth'});
    if(!store.list(id).some(p=>p.geometria))setList(true);
    announce(`Sector ${store.sectores.get(id)!.nombre}. ${store.list(id).length} puestos.`);
  }
  function home(){closeDetail(false);sectorId=null;renderStalls();breadcrumbs();setList(false);camera.fit(activeBounds());}
  function closeDetail(restore=true){
    const previous=selectedId;selectedId=null;$('stall-detail').hidden=true;$('sector-overview').hidden=false;$('app').classList.remove('detail-open');
    if(previous){const node=stallNodes.get(previous);if(node)updateStall(node,store.puestos.get(previous)!);listNodes.get(previous)?.classList.remove('selected');}
    breadcrumbs();if(restore&&lastFocused instanceof HTMLElement)lastFocused.focus();else if(restore&&lastFocused instanceof SVGElement)lastFocused.focus();
  }
  function selectPuesto(id:string){
    const p=store.puestos.get(id);if(!p)return;
    if(multi){selected.has(id)?selected.delete(id):selected.add(id);updateSelection();return;}
    lastFocused=document.activeElement;
    const wasList=listMode;
    if(sectorId!==p.sector_id){enterSector(p.sector_id);setList(wasList);}
    const previous=selectedId;selectedId=id;
    if(previous&&stallNodes.has(previous))updateStall(stallNodes.get(previous)!,store.puestos.get(previous)!);
    if(stallNodes.has(id))updateStall(stallNodes.get(id)!,p);
    listNodes.forEach((node,key)=>{node.classList.toggle('selected',key===id);node.setAttribute('aria-pressed',String(key===id));});
    $('app').classList.add('detail-open');$('inspector').dataset.snap='collapsed';$('stall-detail').hidden=false;$('sector-overview').hidden=true;renderDetail();breadcrumbs();
    if(mobile()&&!listMode){$('map-stage').scrollIntoView({block:'start',behavior:'smooth'});if(p.geometria)camera.fit({x:p.geometria.x-25,y:p.geometria.y-25,w:p.geometria.w+50,h:p.geometria.h+50});}
    announce(`${p.codigo}, ${labels[p.estado]}. Ficha abierta.`);
  }
  function renderDetail(){
    if(!selectedId)return;
    const p=store.puestos.get(selectedId);if(!p){closeDetail(false);return;}
    $('detail-code').textContent=p.codigo;$('detail-sector').textContent=store.sectores.get(p.sector_id)?.nombre??'';
    $('detail-state').className=`status-badge state-${p.estado}`;$('detail-state').textContent=`${symbols[p.estado]} ${labels[p.estado]}`;
    $('detail-area').textContent=p.area===null?'Por confirmar':`${p.area} m²`;$('detail-price').textContent=price(p.precio);
    $('detail-reason').textContent=p.motivo_bloqueo??'';$('detail-note').textContent=provider.demo?'Datos de ejemplo. Este precio y código no representan una oferta comercial.':`Última actualización: ${new Date(p.actualizado_en).toLocaleString('es-PE')}`;
    $('actions').replaceChildren();const available=acciones(p,provider.role,provider.userId);
    for(const action of available){const button=document.createElement('button');button.dataset.action=action;button.textContent=actionText[action];button.disabled=!provider.ready;button.addEventListener('click',()=>requestAction([p],action));$('actions').append(button);}
    if(!available.length){const text=document.createElement('p');text.className='no-actions';text.textContent=p.estado==='bloqueado'?'Este puesto no es comercializable.':provider.role==='lector'?'Cuenta de solo lectura.':'No hay acciones disponibles para tu cuenta.';$('actions').append(text);}
  }
  function updateSelection(){
    $('selection-count').textContent=`${selected.size} seleccionados`;
    stallNodes.forEach((node,id)=>updateStall(node,store.puestos.get(id)!));
    listNodes.forEach((node,id)=>{node.classList.toggle('multi',selected.has(id));node.setAttribute('aria-pressed',String(selected.has(id)));});
  }
  function configureRole(){
    const admin=provider.role==='admin';$('admin-tools').hidden=!admin;$('admin-link').hidden=!admin;$('logout').hidden=provider.demo;$('demo-banner').hidden=!provider.demo;
    if(!admin){multi=false;selected.clear();$('app').classList.remove('multi-enabled');$('toggle-multi').setAttribute('aria-pressed','false');$('audit-panel').hidden=true;$('audit-list').replaceChildren();updateSelection();}
    $('avatar').textContent=admin?'A':provider.role==='asesor'?'AS':'L';renderDetail();
    if(location.pathname.startsWith('/admin')&&!admin)toast('Solo el administrador puede acceder a las operaciones masivas.');
  }
  function updateFilters(){
    limit=60;if($<HTMLInputElement>('search').value.trim())setList(true);
    stallNodes.forEach((node,id)=>node.style.display=matches(store.puestos.get(id)!)?'':'none');
    sectorNodes.forEach((node,id)=>node.style.opacity=store.list(id).some(matches)?'1':'.3');
    if(listMode)renderList();else $('empty-state').hidden=visible().length>0;
    levelOfDetail();
  }
  function confirm(title:string,description:string,preview:string[],task:(reason:string)=>Promise<void>){
    if(!provider.ready){toast('Espera a recuperar la conexión.');return;}
    $('confirm-title').textContent=title;$('confirm-description').textContent=description;$('confirm-preview').innerHTML=preview.map(line=>`<div>${esc(line)}</div>`).join('');
    $<HTMLTextAreaElement>('confirm-reason').value='';$('confirm-error').textContent='';confirmTask=task;$<HTMLDialogElement>('confirm-dialog').showModal();
  }
  function requestAction(puestos:Puesto[],action:Accion,excluded=0){
    const snapshot=structuredClone(puestos);
    if(!snapshot.length){toast('No hay puestos compatibles con esta acción en tu selección.');return;}
    confirm(`${actionText[action]} ${snapshot.length===1?snapshot[0].codigo:`${snapshot.length} puestos`}`,
      `${provider.demo?'Cambio de demostración. ':''}${action==='vender'?'La venta cierra la separación. ':''}${action==='bloquear'?'Los puestos dejarán de ser comercializables. ':''}${excluded?`${excluded} puestos no compatibles quedan sin cambios. `:''}La operación se cancela completa si algún puesto cambió.`,
      snapshot.map(p=>`${p.codigo} · ${labels[p.estado]}`),async reason=>provider.change(snapshot,action,reason));
  }
  function requestAssign(rows:Asignacion[]){
    if(!rows.length){toast('Selecciona al menos un puesto.');return;}
    const frozen=structuredClone(rows);
    confirm(`Asignar ${rows.length} puestos`,'Se conservarán los códigos y la posición física. Revisa el sector de destino.',rows.map(r=>`${store.puestos.get(r.id)?.codigo} → ${store.sectores.get(r.sector_id)?.nombre}`),reason=>provider.assign(frozen,reason));
  }
  store.onReset=()=>{
    if(sectorId&&!store.sectores.has(sectorId))sectorId=null;
    for(const id of selected)if(!store.puestos.has(id))selected.delete(id);
    renderSectors();renderTotals();renderStalls();if(listMode)renderList();breadcrumbs();configureRole();updateFilters();
    $('loading-map').hidden=true;$('app').setAttribute('aria-busy','false');
  };
  store.onChange=(p,old)=>{
    const node=stallNodes.get(p.id);
    if(node&&p.sector_id===sectorId)updateStall(node,p,true);
    else if(node){node.remove();stallNodes.delete(p.id);}
    else if(p.sector_id===sectorId)addStall(p);
    updateSector(p.sector_id);if(old&&old.sector_id!==p.sector_id)updateSector(old.sector_id);renderTotals();
    if(listMode){const row=listNodes.get(p.id);if(row&&matches(p)&&(!sectorId||p.sector_id===sectorId)){row.innerHTML=rowContent(p);}else if(row){row.remove();listNodes.delete(p.id);}else if(matches(p)&&(!sectorId||p.sector_id===sectorId)&&listNodes.size<limit){const el=makeRow(p);$('stall-list').append(el);listNodes.set(p.id,el);}const count=visible().length;$('results-count').textContent=`${count} puestos · ${listNodes.size} visibles`;$('empty-state').hidden=count>0;}
    if(selectedId===p.id)renderDetail();levelOfDetail();announce(`${p.codigo} cambió a ${labels[p.estado]}.`);
  };
  function connection(state:Connection,message?:string){
    const ready=state==='ready';$('connection-label').innerHTML=`<i></i>${ready?(provider.demo?'Vista demo':'En vivo'):state==='login'?'Acceso requerido':'Reconectando'}`;
    $('connection-banner').hidden=ready||state==='login';$('connection-banner').textContent=message??'Reconectando… Las acciones se habilitarán al sincronizar.';
    if(state==='login'){$<HTMLDialogElement>('login-dialog').showModal();$('loading-map').hidden=true;$('app').setAttribute('aria-busy','false');}
    renderDetail();
  }
  document.addEventListener('click',e=>{
    const target=(e.target as Element).closest('[data-sector],[data-puesto],[data-home]') as HTMLElement|null;
    if(!target||target.closest('#map')&&camera.suppressClick)return;
    if(target.hasAttribute('data-home'))home();else if(target.dataset.puesto)selectPuesto(target.dataset.puesto);else if(target.dataset.sector)enterSector(target.dataset.sector);
  });
  $('map').addEventListener('keydown',e=>{const event=e as KeyboardEvent;if((event.key==='Enter'||event.key===' ')&&(event.target as Element).matches('[data-sector],[data-puesto]')){event.preventDefault();(event.target as Element).dispatchEvent(new MouseEvent('click',{bubbles:true}));}});
  $('back-overview').addEventListener('click',home);$('zoom-in').addEventListener('click',()=>camera.zoom(.7));$('zoom-out').addEventListener('click',()=>camera.zoom(1.4));$('fit-map').addEventListener('click',()=>camera.fit(activeBounds()));
  $('map-view').addEventListener('click',()=>setList(false));$('list-view').addEventListener('click',()=>setList(true));$('fallback-list').addEventListener('click',()=>setList(true));
  $('close-detail').addEventListener('click',()=>closeDetail());
  $('show-original').addEventListener('change',e=>{const show=(e.target as HTMLInputElement).checked;$('original-image').setAttribute('visibility',show?'visible':'hidden');$('app').classList.toggle('original-visible',show);});
  $('filters-toggle').addEventListener('click',()=>{const hidden=!$('filters').hidden;$('filters').hidden=hidden;$('filters-toggle').setAttribute('aria-expanded',String(!hidden));});
  let debounce:ReturnType<typeof setTimeout>;$('search').addEventListener('input',()=>{clearTimeout(debounce);debounce=setTimeout(updateFilters,120);});
  $('filters').addEventListener('input',updateFilters);
  $('clear-filters').addEventListener('click',()=>{for(const id of ['search','filter-state','filter-sector','price-min','price-max','area-min','area-max'])$<HTMLInputElement>(id).value='';updateFilters();});
  $('demo-role').addEventListener('change',e=>{provider.setDemoRole((e.target as HTMLSelectElement).value as Rol);$<HTMLDialogElement>('confirm-dialog').close();configureRole();});
  $('logout').addEventListener('click',async()=>{await supabase?.auth.signOut();});
  $('login-dialog').addEventListener('cancel',e=>e.preventDefault());
  $('login-form').addEventListener('submit',async e=>{e.preventDefault();const {error}=await supabase!.auth.signInWithPassword({email:$<HTMLInputElement>('login-email').value,password:$<HTMLInputElement>('login-password').value});if(error)$('login-error').textContent=error.message;else location.reload();});
  $('cancel-confirm').addEventListener('click',()=>$<HTMLDialogElement>('confirm-dialog').close());
  $('confirm-form').addEventListener('submit',async e=>{
    e.preventDefault();const reason=$<HTMLTextAreaElement>('confirm-reason').value.trim();if(!reason){$('confirm-error').textContent='Escribe el motivo de la operación.';return;}
    $<HTMLButtonElement>('submit-confirm').disabled=true;$<HTMLButtonElement>('cancel-confirm').disabled=true;
    try{await confirmTask?.(reason);$<HTMLDialogElement>('confirm-dialog').close();toast(provider.demo?'Cambio aplicado en la demostración.':'Cambio confirmado y registrado en auditoría.');selected.clear();updateSelection();}
    catch(error){$('confirm-error').textContent=error instanceof Error?error.message:'No se pudo completar la operación.';}
    finally{$<HTMLButtonElement>('submit-confirm').disabled=false;$<HTMLButtonElement>('cancel-confirm').disabled=false;}
  });
  $('confirm-dialog').addEventListener('cancel',e=>{if($<HTMLButtonElement>('submit-confirm').disabled)e.preventDefault();});
  $('toggle-multi').addEventListener('click',()=>{multi=!multi;closeDetail(false);$('app').classList.toggle('multi-enabled',multi);$('toggle-multi').setAttribute('aria-pressed',String(multi));if(!multi)selected.clear();updateSelection();toast(multi?'Toca puestos para agregarlos a la selección.':'Selección múltiple desactivada.');});
  $('select-sector').addEventListener('click',()=>{const id=$<HTMLSelectElement>('bulk-sector').value;selected.clear();store.list(id).forEach(p=>selected.add(p.id));multi=true;$('app').classList.add('multi-enabled');$('toggle-multi').setAttribute('aria-pressed','true');enterSector(id);updateSelection();});
  $('clear-selection').addEventListener('click',()=>{selected.clear();updateSelection();});
  for(const [button,action] of [['bulk-block','bloquear'],['bulk-unblock','desbloquear']] as const)$(button).addEventListener('click',()=>{const all=[...selected].map(id=>store.puestos.get(id)!).filter(Boolean),eligible=all.filter(p=>acciones(p,provider.role,provider.userId).includes(action));requestAction(eligible,action,all.length-eligible.length);});
  $('assign-selection').addEventListener('click',()=>requestAssign([...selected].map(id=>({id,version:store.puestos.get(id)!.version,sector_id:$<HTMLSelectElement>('assign-sector').value}))));
  $('csv-file').addEventListener('change',async e=>{const input=e.target as HTMLInputElement,file=input.files?.[0];if(!file)return;try{if(file.size>500000)throw new Error('El CSV supera 500 KB.');requestAssign(assignmentsCSV(await file.text(),store.puestos.values(),store.sectores.values()));}catch(error){toast(error instanceof Error?error.message:'CSV inválido.');}finally{input.value='';}});
  $('show-audit').addEventListener('click',async()=>{try{const entries=await provider.getAudit();$('audit-panel').hidden=false;$('audit-list').innerHTML=entries.length?entries.map(a=>`<div class="audit-entry"><b>${esc(a.codigo)}</b> · ${esc(a.accion)}<p>${esc(a.motivo)}</p><small>${esc(new Date(a.fecha).toLocaleString('es-PE'))}</small></div>`).join(''):'<p class="quiet">Todavía no hay movimientos registrados.</p>';}catch(error){toast(error instanceof Error?error.message:'No se pudo cargar la auditoría.');}});
  const snaps=['collapsed','middle','full'];let dragStart=0,dragged=false;
  $('sheet-handle').addEventListener('click',()=>{if(dragged)return;const current=$('inspector').dataset.snap??'collapsed';$('inspector').dataset.snap=snaps[(snaps.indexOf(current)+1)%3];});
  $('sheet-handle').addEventListener('pointerdown',e=>{dragStart=e.clientY;dragged=false;(e.target as HTMLElement).setPointerCapture(e.pointerId);});
  $('sheet-handle').addEventListener('pointerup',e=>{const delta=e.clientY-dragStart;if(Math.abs(delta)>25){dragged=true;const i=snaps.indexOf($('inspector').dataset.snap??'collapsed');$('inspector').dataset.snap=snaps[Math.max(0,Math.min(2,i+(delta<0?1:-1)))];setTimeout(()=>dragged=false,100);}});
  document.addEventListener('keydown',e=>{if(e.key==='Escape'&&!$<HTMLDialogElement>('confirm-dialog').open&&selectedId)closeDetail();});
  drawReference();camera.fit(activeBounds(),false);
  await provider.start({snapshot:data=>store.reset(data),change:p=>store.update(p),connection});
  configureRole();
  // Local development only: deterministic performance/update tests, never in production bundles.
  if(import.meta.env.DEV&&provider.demo)(window as any).__planoTest={store,provider,camera};
}
