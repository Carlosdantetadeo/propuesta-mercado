import { supabase } from '../supabase';
import demoData from '../../data/plano-demo.json';
import { acciones, type Accion, type Asignacion, type Puesto, type Rol, type Snapshot } from './types';
export type Connection = 'loading' | 'ready' | 'reconnecting' | 'error' | 'login';
type Callbacks = { snapshot: (data: Snapshot) => void; change: (p: Puesto) => void; connection: (s:Connection, message?:string) => void };
export class Provider {
  demo = !supabase;
  role: Rol = 'lector';
  userId = '';
  ready = false;
  audit: { codigo: string; accion: string; motivo: string; fecha: string }[] = [];
  private data = structuredClone(demoData) as Snapshot;
  private cb!: Callbacks;
  private channel: ReturnType<NonNullable<typeof supabase>['channel']> | null = null;
  private syncing = false;
  private repeat = false;
  private pending: Puesto[] = [];
  private retry?: ReturnType<typeof setTimeout>;
  private setConnection(state: Connection, message?: string) {
    this.ready = state === 'ready'; this.cb.connection(state,message);
  }
  async start(cb: Callbacks) {
    this.cb = cb;
    if (this.demo) {
      this.role = 'admin'; this.userId = 'demo-admin';
      // Development-only render benchmark. Never injected into a connected backend.
      if (import.meta.env.DEV && new URLSearchParams(location.search).get('stress') === '1000') {
        const source = this.data.puestos;
        this.data.puestos = Array.from({length:1000},(_,i) => {
          const s=this.data.sectores[i%3], [a,b,,d]=s.contorno[0], n=Math.floor(i/3);
          return {...source[i%30],id:`stress-${i}`,codigo:`TEST-${i+1}`,sector_id:s.id,
            geometria:{x:a[0]+(n%20)*(b[0]-a[0])/20,y:a[1]+Math.floor(n/20)*(d[1]-a[1])/17,w:(b[0]-a[0])/20-1,h:(d[1]-a[1])/17-1}};
        });
      }
      cb.snapshot(structuredClone(this.data)); this.setConnection('ready');
    } else {
      const {data,error} = await supabase!.auth.getSession();
      if(error) throw error;
      if(!data.session) { this.setConnection('login'); return; }
      this.userId=data.session.user.id;
      const {data:profile,error:profileError}=await supabase!.from('perfiles').select('rol').eq('id',this.userId).single();
      if(profileError || !profile) throw new Error('Tu cuenta no tiene un rol asignado. Contacta al administrador.');
      this.role=profile.rol;
      this.subscribe();
      supabase!.auth.onAuthStateChange((event) => {
        if(event==='SIGNED_OUT') { this.ready=false; location.reload(); }
      });
    }
    window.addEventListener('offline',() => this.setConnection('reconnecting','Sin conexión. Las acciones están deshabilitadas.'));
    window.addEventListener('online',() => {
      if (this.demo) this.setConnection('ready');
      else this.subscribe();
    });
  }
  private subscribe() {
    if(this.channel) void supabase!.removeChannel(this.channel);
    this.setConnection('reconnecting');
    this.channel = supabase!.channel(`plano-${crypto.randomUUID()}`)
      .on('postgres_changes',{event:'*',schema:'public',table:'puestos'},payload => {
        if(payload.eventType==='UPDATE') {
          const p=payload.new as Puesto;
          if(this.syncing) this.pending.push(p); else this.cb.change(p);
        } else void this.sync();
      })
      .on('postgres_changes',{event:'*',schema:'public',table:'sectores'},() => void this.sync())
      .subscribe(status => {
        if(status==='SUBSCRIBED') void this.sync();
        else if(['CHANNEL_ERROR','TIMED_OUT','CLOSED'].includes(status)) {
          this.setConnection('reconnecting');
          clearTimeout(this.retry);
          this.retry=setTimeout(()=>{ if(navigator.onLine) this.subscribe(); },4000);
        }
      });
  }
  async sync() {
    if(this.demo) return;
    if(this.syncing) { this.repeat=true; return; }
    this.syncing=true; this.pending=[]; this.setConnection('reconnecting');
    try {
      const {data:sectores,error} = await supabase!.from('sectores').select('*').order('orden');
      if(error) throw error;
      const puestos: Puesto[]=[];
      for(let offset=0;;offset+=500) {
        const {data,error} = await supabase!.from('puestos').select('*').order('id').range(offset,offset+499);
        if(error) throw error;
        puestos.push(...data as Puesto[]);
        if(data.length<500) break;
      }
      this.cb.snapshot({sectores:sectores!,puestos});
      for(const p of this.pending) this.cb.change(p);
      this.setConnection('ready');
    } catch(error) {
      this.setConnection('error',error instanceof Error ? error.message : 'No se pudo sincronizar. Reintentando.');
      clearTimeout(this.retry); this.retry=setTimeout(()=>void this.sync(),4000);
    } finally {
      this.syncing=false;
      if(this.repeat) { this.repeat=false; void this.sync(); }
    }
  }
  setDemoRole(role: Rol) {
    if(!this.demo) return;
    this.role=role; this.userId=role==='asesor'?'demo-asesor':'demo-admin';
  }
  private checkReady() { if(!this.ready || !navigator.onLine) throw new Error('Espera a recuperar la conexión antes de continuar.'); }
  async change(puestos: Puesto[], action: Accion, motivo: string) {
    this.checkReady();
    if(!this.demo) {
      const {data,error}=await supabase!.rpc('cambiar_estado_puestos',{
        p_cambios:puestos.map(p=>({id:p.id,version:p.version})),p_accion:action,p_motivo:motivo
      });
      if(error) { void this.sync(); throw new Error(error.message); }
      (data as Puesto[]).forEach(p=>this.cb.change(p)); return;
    }
    if(['bloquear','desbloquear','vender'].includes(action)&&!motivo.trim()) throw new Error('Escribe un motivo.');
    const selected=puestos.map(p=>{
      const actual=this.data.puestos.find(x=>x.id===p.id)!;
      if(actual.version!==p.version || !acciones(actual,this.role,this.userId).includes(action)) throw new Error('El puesto cambió o la acción no está permitida.');
      return actual;
    });
    for(const p of selected) {
      p.estado=({separar:'separado',liberar:'disponible',vender:'vendido',bloquear:'bloqueado',desbloquear:'disponible'} as const)[action];
      p.separado_por=action==='separar'?this.userId:p.estado==='disponible'?null:p.separado_por;
      p.motivo_bloqueo=action==='bloquear'?motivo:null;
      p.version++; p.actualizado_en=new Date().toISOString();
      this.audit.unshift({codigo:p.codigo,accion:action,motivo,fecha:p.actualizado_en});
      this.cb.change(structuredClone(p));
    }
  }
  async assign(rows: Asignacion[], motivo: string) {
    this.checkReady();
    if(!this.demo) {
      const {data,error}=await supabase!.rpc('asignar_sectores',{p_asignaciones:rows,p_motivo:motivo});
      if(error) { void this.sync(); throw new Error(error.message); }
      (data as Puesto[]).forEach(p=>this.cb.change(p)); return;
    }
    if(this.role!=='admin'||!motivo.trim()) throw new Error('Se requiere administrador y motivo.');
    const selected=rows.map(r=>{
      const p=this.data.puestos.find(p=>p.id===r.id);
      if(!p||p.version!==r.version||!this.data.sectores.some(s=>s.id===r.sector_id)) throw new Error('Asignación inválida o desactualizada.');
      return {p,r};
    });
    selected.forEach(({p,r})=>{
      p.sector_id=r.sector_id; p.version++;
      this.audit.unshift({codigo:p.codigo,accion:'asignar_sector',motivo,fecha:new Date().toISOString()});
      this.cb.change(structuredClone(p));
    });
  }
  async getAudit() {
    if(this.demo) return this.audit;
    const {data,error}=await supabase!.from('auditoria').select('accion,motivo,creada_en,puestos(codigo)').order('creada_en',{ascending:false}).limit(50);
    if(error) throw new Error(error.message);
    return data.map((r:any)=>({codigo:r.puestos?.codigo??'—',accion:r.accion,motivo:r.motivo,fecha:r.creada_en}));
  }
}
