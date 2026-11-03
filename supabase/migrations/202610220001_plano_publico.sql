-- Public read-only inventory. No profiles, buyers, reservation owners or audit data.
create or replace function public.consultar_plano_publico()
returns jsonb language sql stable security definer set search_path = '' as $$
  select jsonb_build_object(
    'sectores', coalesce((select jsonb_agg(to_jsonb(s) order by s.orden, s.nombre)
      from public.sectores s where exists(select 1 from public.puestos p where p.sector_id=s.id)), '[]'::jsonb),
    'puestos', coalesce((select jsonb_agg(jsonb_build_object(
      'id',p.id,'codigo',p.codigo,'sector_id',p.sector_id,'estado',p.estado,
      'area',p.area,'precio',p.precio,'geometria',p.geometria,'version',p.version,
      'actualizado_en',p.actualizado_en,'separado_por',null,'motivo_bloqueo',null
    ) order by p.codigo) from public.puestos p), '[]'::jsonb)
  );
$$;
revoke all on function public.consultar_plano_publico() from public;
grant execute on function public.consultar_plano_publico() to anon, authenticated;
