-- Bootstrap for this repository: no pre-existing database/migrations were found.
-- Deliberately fails on conflicting existing tables; never silently adopts another schema.
create table public.perfiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nombre text not null default '',
  rol text not null check (rol in ('admin', 'asesor', 'lector'))
);
create table public.puestos (
  id uuid primary key default gen_random_uuid(),
  codigo text not null unique check (length(codigo) between 1 and 40),
  estado text not null default 'disponible'
    constraint puestos_estado_check check (estado in ('disponible','separado','vendido')),
  area numeric(12,2) check (area > 0),
  precio numeric(14,2) check (precio >= 0),
  geometria jsonb,
  separado_por uuid references auth.users(id),
  version integer not null default 1,
  actualizado_en timestamptz not null default now()
);
create table public.separaciones (
  id uuid primary key default gen_random_uuid(),
  puesto_id uuid not null references public.puestos(id),
  asesor_id uuid not null references auth.users(id),
  creada_en timestamptz not null default now(),
  cerrada_en timestamptz,
  cierre text check (cierre in ('liberado','vendido'))
);
create unique index separacion_activa_unica on public.separaciones(puesto_id) where cerrada_en is null;
create table public.auditoria (
  id bigint generated always as identity primary key,
  puesto_id uuid not null references public.puestos(id),
  actor_id uuid references auth.users(id),
  accion text not null,
  motivo text not null,
  antes jsonb,
  despues jsonb not null,
  creada_en timestamptz not null default now()
);
create function public.mi_rol() returns text language sql stable security definer
set search_path = '' as $$
  select rol from public.perfiles where id = (select auth.uid());
$$;
revoke all on function public.mi_rol() from public, anon;
grant execute on function public.mi_rol() to authenticated;

alter table public.perfiles enable row level security;
alter table public.puestos enable row level security;
alter table public.separaciones enable row level security;
alter table public.auditoria enable row level security;
revoke all on public.perfiles, public.puestos, public.separaciones, public.auditoria from anon, authenticated;
grant select on public.perfiles, public.puestos, public.separaciones, public.auditoria to authenticated;
create policy perfil_lectura on public.perfiles for select to authenticated
using (id = (select auth.uid()) or (select public.mi_rol()) = 'admin');
create policy puestos_lectura on public.puestos for select to authenticated
using ((select public.mi_rol()) in ('admin','asesor','lector'));
create policy separaciones_lectura on public.separaciones for select to authenticated
using (asesor_id = (select auth.uid()) or (select public.mi_rol()) = 'admin');
create policy auditoria_admin on public.auditoria for select to authenticated
using ((select public.mi_rol()) = 'admin');
-- No permissive write policies: even if a grant is accidentally added, RLS denies
-- direct INSERT/UPDATE/DELETE. Authenticated users cannot self-assign a role.
