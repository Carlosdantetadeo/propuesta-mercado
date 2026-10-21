# Plano de puestos de Promarsa

## Desarrollo y demostración

```sh
npm install
npm run dev
```

Abre `/plano/` para explorar el plano y `/admin/puestos/` para ver la administración. Sin credenciales, la página presenta **30 registros, tres sectores, códigos, áreas y precios ficticios**, etiquetados como demostración. Las reservas hechas allí viven solo en memoria: no persisten, no se propagan a otros navegadores y no representan inventario comercial. `?stress=1000` habilita en desarrollo una carga sintética para comprobar la navegación.

## Migraciones y Supabase

En esta carpeta no se encontró una base de datos, esquema comercial, historial de migraciones ni configuración de Supabase. Por eso, `202610200001_base_comercial.sql` es un **esquema inicial nuevo** y la migración `202610200002_sectores_bloqueos.sql` incorpora sectores, el estado bloqueado, políticas y operaciones seguras. No se modifican migraciones aplicadas de otros sistemas. Ambas migraciones necesitan un proyecto Supabase con `auth.users`, los roles `anon` y `authenticated`, y privilegios de crear tablas/funciones. Si la primera tabla, enum, tipo o función ya existe en el proyecto de destino, la aplicación fallará de forma explícita. Revisa el esquema y el plan antes de aplicar las migraciones; no las apliques a producción ni a una base de datos existente sin cotejarla primero.

En un proyecto vacío de desarrollo conectado a su instancia adecuada:

```sh
npx supabase login
npx supabase link --project-ref <referencia-del-proyecto-de-desarrollo>
npx supabase db push --dry-run
npx supabase db push
```

En la instancia local de pruebas, `supabase start` seguido de `supabase db reset` ejecuta las migraciones y el seed. `supabase/seed.sql` crea **datos ilustrativos**; no lo ejecutes contra inventario comercial. Las geometrías de los 30 puestos, rubros, precios y códigos de prueba no se extraen como datos de negocio del PDF.

## Perfiles y acceso

Autentica a las personas con Supabase Auth. Un administrador de confianza debe crear cada perfil en el servidor con su `auth.users.id`, nombre y rol `admin`, `asesor` o `lector`. El cliente de la web **no permite autoasignar roles**. Los usuarios sin perfil no ven inventario ni ejecutan cambios. No se incluye una cuenta, contraseña, rol administrador de prueba ni endpoint público para provisionarlos.

Configura localmente las dos variables del `.env.example` con la URL y la clave pública `anon` del proyecto nuevo. No pongas una clave `service_role` en el navegador. Si solo se configura una variable, la aplicación falla en lugar de cambiar silenciosamente al modo de demostración. Hasta que el proyecto, los perfiles y su configuración estén listos, permanece en la demostración local.

## Reglas transaccionales

Los clientes autenticados tienen lectura por RLS y ningún permiso de escritura directa. Las reservas, liberaciones, ventas, bloqueos, desbloqueos y asignaciones masivas pasan por funciones de Postgres que verifican el rol, comprueban la versión y bloquean las filas en orden estable. Un fallo revierte el lote completo. La restricción de índice parcial impide más de una separación abierta por puesto. Solo un administrador bloquea/desbloquea o vende, con motivo obligatorio. La liberación se permite al asesor que hizo la reserva o a un administrador. Un trigger guarda estado anterior/nuevo, actor y motivo; la auditoría queda visible solo para administradores. La vista de contadores ejecuta con los permisos del usuario y excluye bloqueados del denominador de avance.

Los cambios de `puestos` y `sectores` se transmiten por Postgres Changes. La página pagina la sincronización inicial, aplica eventos por versión al puesto afectado y vuelve a sincronizar cuando se reconecta. La demostración en memoria **no** implementa Postgres, aislamiento concurrente, persistencia ni realtime entre navegadores.

## Datos reales del plano y revisión

El plano PDF original se conserva en `public/promarsa/plano-original.pdf`. La referencia SVG limpia conserva el orden visual del mercado; sus rótulos sectoriales recogen las áreas identificadas. La plantilla `public/promarsa/asignacion-ejemplo.csv` acepta `codigo,sector`, con nombre de sector o ID.

Para mostrar el catálogo comercial real, primero hay que importar códigos, metraje, precios, estados y polígonos de puestos desde una fuente operativa autorizada. Las asignaciones **no desplazan la geometría existente**: se debe confirmar la convención de polígonos si un puesto cambia de sector. Los equipos deben verificar la posición de los servicios marcados esquemáticamente y completar contornos de todas las zonas.

Hay capturas verificadas de la vista general móvil, el detalle móvil y el detalle de escritorio en [`capturas/`](capturas/). Se prueban en navegador 360, 390, 430 y 1440 píxeles. La revisión Axe cubre WCAG 2 A/AA y WCAG 2.1 AA; no reemplaza una evaluación manual ni una prueba con teléfonos reales.

```sh
npm run typecheck
npm run test:unit
npm run test:db
npm run test:e2e
npm run build
```

`npm run test:db` prueba las migraciones reales con PGlite, incluido RLS, la transición de estado, los motivos, auditoría, concurrencia de dos RPC, los lotes y los contadores. La prueba concurrente con PGlite usa un motor embebido y valida las garantías SQL/de bloqueo lógico; no representa una prueba de carga contra una instancia PostgreSQL de producción ni sustitute una prueba paralela multi-conexión contra el proyecto desplegado.

## Supuestos y pendientes antes de producción

- Hace falta un proyecto Supabase de desarrollo vacío y un destino de producción identificado. No se ejecutaron cambios en un proyecto externo.
- Hacen falta los perfiles autorizados y su proceso de alta. La vista de roles simulada en demo no autentica ni prueba RLS remoto.
- Los 30 puestos del seed son demostrativos, no un catálogo aprobado. No se inventaron ventas o precios a partir del PDF.
- Hay que importar y cotejar disponibilidad, precios, área, fechas de separación, responsables y contornos reales con la fuente comercial.
- Se debe verificar con Promarsa la convención y el trazo de polígonos, incluidas las áreas de servicios y accesos que se anotan como esquemáticos.
- Realtime, RLS, latencia, roles revocados, acceso desde dispositivos y carga de 1.000 puestos necesitan validación final en el proyecto y dispositivos objetivo.
- La prueba de carga usa datos sintéticos y no pretende demostrar fluidez física en un modelo concreto de teléfono.
