-- The 'ocupante' column (buyer nombre/documento/telefono/referencia, jsonb) was
-- added in supabase/imports/20261115_admin_ocupante.sql as plain table data.
-- The existing puestos_lectura policy (202610200001_base_comercial.sql) grants
-- SELECT on the whole row to roles 'admin', 'asesor' and 'lector' -- RLS is
-- row-level, so it cannot hide a single column: any asesor/lector session can
-- currently read ocupante like any other column via a direct table query, even
-- though the /admin/puestos UI itself only shows the dashboard to 'admin'.
-- User confirmed (2026-11-18): buyer data must be admin-only. Column-level
-- privilege revoke + a security-definer accessor restores that boundary.

revoke select (ocupante) on public.puestos from authenticated;

-- Admin-only reader: returns every column the admin dashboard needs, including
-- ocupante. Returns zero rows for any non-admin caller (no error, no partial
-- row) so a stale client session degrades to "empty list", not a crash.
create or replace function public.puestos_admin()
returns table (
  id uuid, codigo text, estado text, area numeric, precio numeric,
  sector_id uuid, version integer, actualizado_en timestamptz,
  motivo_bloqueo text, ocupante jsonb
)
language sql stable security definer set search_path = '' as $$
  select id, codigo, estado, area, precio, sector_id, version, actualizado_en,
         motivo_bloqueo, ocupante
  from public.puestos
  where (select public.mi_rol()) = 'admin'
  order by codigo;
$$;
revoke all on function public.puestos_admin() from public, anon;
grant execute on function public.puestos_admin() to authenticated;
