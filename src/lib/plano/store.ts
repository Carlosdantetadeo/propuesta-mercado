import { conteo, type Puesto, type Sector, type Snapshot } from './types';
export class PlanoStore {
  sectores = new Map<string, Sector>();
  puestos = new Map<string, Puesto>();
  porSector = new Map<string, Set<string>>();
  counts = new Map<string, ReturnType<typeof conteo>>();
  onReset = () => {};
  onChange = (_p: Puesto, _old?: Puesto) => {};
  reset(data: Snapshot) {
    this.sectores = new Map(data.sectores.map(s => [s.id,s]));
    this.puestos.clear(); this.porSector.clear(); this.counts.clear();
    data.puestos.forEach(p => this.put(p));
    this.onReset();
  }
  list(id: string) { return [...(this.porSector.get(id) ?? [])].map(key => this.puestos.get(key)!); }
  private put(p: Puesto) {
    this.puestos.set(p.id,p);
    if (!this.porSector.has(p.sector_id)) this.porSector.set(p.sector_id,new Set());
    this.porSector.get(p.sector_id)!.add(p.id);
    if (!this.counts.has(p.sector_id)) this.counts.set(p.sector_id,conteo([]));
    const c = this.counts.get(p.sector_id)!;
    c[p.estado]++; c.total++;
    c.avance = c.total>c.bloqueado ? Math.round(c.vendido/(c.total-c.bloqueado)*100) : 0;
  }
  update(p: Puesto) {
    const old = this.puestos.get(p.id);
    if (old && p.version <= old.version) return;
    if (old) {
      this.porSector.get(old.sector_id)?.delete(old.id);
      const c = this.counts.get(old.sector_id)!;
      c[old.estado]--; c.total--;
      c.avance = c.total>c.bloqueado ? Math.round(c.vendido/(c.total-c.bloqueado)*100) : 0;
    }
    this.put(p);
    this.onChange(p,old);
  }
}
