-- Recursos privados para asesores. No modifica migraciones existentes.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('recursos-asesores', 'recursos-asesores', false, 104857600, array['application/pdf'])
on conflict (id) do update set
  public = false,
  file_size_limit = excluded.file_size_limit,
  allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists recursos_asesores_lectura on storage.objects;
create policy recursos_asesores_lectura
on storage.objects for select to authenticated
using (
  bucket_id = 'recursos-asesores'
  and (select public.mi_rol()) in ('admin', 'asesor')
);

drop policy if exists recursos_asesores_admin_subir on storage.objects;
create policy recursos_asesores_admin_subir
on storage.objects for insert to authenticated
with check (
  bucket_id = 'recursos-asesores'
  and (select public.mi_rol()) = 'admin'
);

drop policy if exists recursos_asesores_admin_actualizar on storage.objects;
create policy recursos_asesores_admin_actualizar
on storage.objects for update to authenticated
using (
  bucket_id = 'recursos-asesores'
  and (select public.mi_rol()) = 'admin'
)
with check (
  bucket_id = 'recursos-asesores'
  and (select public.mi_rol()) = 'admin'
);

drop policy if exists recursos_asesores_admin_eliminar on storage.objects;
create policy recursos_asesores_admin_eliminar
on storage.objects for delete to authenticated
using (
  bucket_id = 'recursos-asesores'
  and (select public.mi_rol()) = 'admin'
);
