# Base comercial del mercado

La fuente autorizada por el usuario es `TABLA DE MERCADO 20_10 - Tabla Mercado.pdf`, cuyo encabezado indica **21/10/2026**. Sustituye los datos ilustrativos como base del inventario comercial.

Se importó en Supabase `lhxcreidqswmbkhsebly`:

- 956 puestos con códigos únicos, numeración completa del 1 al 956.
- 561 vendidos: fondo rojo y estado VENDIDO coinciden en todos los casos.
- 395 disponibles: sin rojo y con estado vacío, según el criterio autorizado por el usuario.
- 50 rubros conservados tal como aparecen en la fuente, usados como agrupaciones de sectores; no representan aún contornos físicos.
- Precios en USD con IGV incluido.
- Área y geometría pendientes (`null`); no se inventaron coordenadas.

La primera extracción contó 953 puestos porque omitió los códigos sin espacio A-818, A-834 y S-874. El extractor ya contempla ambos formatos. El conteo definitivo es 956.

## Archivos y verificación

- `puestos-extraidos.csv`: inventario sin nombres ni apellidos de compradores.
- `resumen.json`: conteos y comprobaciones del PDF.
- `../../scripts/extract-market.py`: extracción por posición y color de fondo del documento.
- `../../scripts/prepare-market-import.py`: validación y generación del SQL.
- `../../supabase/imports/20261021_inventario_mercado.sql`: carga inicial transaccional, con huella SHA256 de la fuente y comprobación de inventario vacío. **Ya ejecutado; no volver a cargarlo.**

La comparación remota verificó 956 filas y cero diferencias en código, rubro, precio y estado. Se registraron 956 entradas de auditoría de importación. No se crearon reservas ficticias ni usuarios. El sector predeterminado «Sin asignar» se conserva sin puestos.

Los futuros cambios comerciales deben hacerse sobre esta base mediante las operaciones autorizadas; no se debe recargar el PDF para sobrescribir ventas o reservas posteriores. No ejecutar `supabase/seed.sql` sobre este proyecto.

Pendientes: cuenta Auth con perfil autorizado, correspondencia de puestos con el plano y áreas reales, y actualización del despliegue web. La compilación local con Supabase y moneda USD se completó correctamente.
