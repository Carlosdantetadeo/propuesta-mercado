export type Estado = 'disponible' | 'separado' | 'vendido' | 'bloqueado';
export type Rol = 'admin' | 'asesor' | 'lector';
export type Accion = 'separar' | 'liberar' | 'vender' | 'bloquear' | 'desbloquear';
export type Rect = { x: number; y: number; w: number; h: number };
export type Sector = { id: string; nombre: string; rubro: string; color: string; orden: number; contorno: number[][][]; icono: string };
export type Puesto = {
  id: string; codigo: string; sector_id: string; estado: Estado; area: number | null;
  precio: number | null; geometria: Rect | null; version: number; separado_por: string | null;
  motivo_bloqueo: string | null; actualizado_en: string;
};
export type Snapshot = { sectores: Sector[]; puestos: Puesto[] };
export type Asignacion = { id: string; sector_id: string; version: number };
export const estados: Estado[] = ['disponible','separado','vendido','bloqueado'];
export const labels: Record<Estado,string> = { disponible:'Disponible', separado:'Separado', vendido:'Vendido', bloqueado:'Bloqueado' };
export const symbols: Record<Estado,string> = { disponible:'○', separado:'◷', vendido:'✓', bloqueado:'⊘' };
export function acciones(p: Puesto, rol: Rol, userId: string): Accion[] {
  if (rol === 'lector') return [];
  if (p.estado === 'disponible') return rol === 'admin' ? ['separar','bloquear'] : ['separar'];
  if (p.estado === 'bloqueado') return rol === 'admin' ? ['desbloquear'] : [];
  if (p.estado === 'separado') return rol === 'admin' ? ['liberar','vender'] : p.separado_por === userId ? ['liberar'] : [];
  return [];
}
export function conteo(puestos: Iterable<Puesto>) {
  const c = { disponible:0, separado:0, vendido:0, bloqueado:0, total:0, avance:0 };
  for (const p of puestos) { c[p.estado]++; c.total++; }
  c.avance = c.total > c.bloqueado ? Math.round(c.vendido / (c.total-c.bloqueado)*100) : 0;
  return c;
}
