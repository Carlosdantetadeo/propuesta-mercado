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

## Actualización 03/11/2026

La fuente `tabla de mercado 03_11.pdf` reemplaza la base de datos como catálogo. Cambios frente a la versión 21/10:

- **1020 puestos** (antes 956): 64 nuevos (`A-961`–`A-1020`, `C-957`–`C-960`), ninguno sin geometría trazada todavía — ver más abajo.
- **4 puestos renombrados**: `C-915`–`C-918` (PATIO DE COMIDAS) ahora figuran como `S-915`–`S-918` (APUESTAS), mismo número físico.
- **86 cambios** de estado, precio, área o rubro en puestos existentes.
- **Área real (m²)** disponible por primera vez por fila; antes era `null`.
- El STATUS ahora viene como texto (`VENDIDO` o vacío), no por color de celda — extracción más confiable.
- Esta fuente trae columnas `NOMBRES`, `APELLIDOS`, `REFERENCIA`, `OBSERVACIONES` con datos personales de compradores. El extractor nunca las lee; no están en ningún archivo de este repositorio.

### Archivos

- `../../scripts/extract-market.py`: reescrito para el nuevo layout de columnas y para excluir explícitamente las columnas con datos personales.
- `../../scripts/map-market-plan.py`: misma malla trazada sobre `plano-original.webp`; ahora conserva el código anterior como alias cuando un número se renombra, y reporta qué códigos quedan sin coordenadas en vez de fallar.
- `../../scripts/prepare-market-update.py`: genera un UPDATE/INSERT guardado (no una carga inicial) que **omite cualquier puesto actualmente `separado` o `bloqueado`** en producción, para no pisar reservas o bloqueos hechos desde la app después del 21/10.
- `../../supabase/imports/20261103_actualizacion_inventario.sql`: salida de lo anterior. **No ejecutado desde aquí** — esta máquina no tiene credenciales del proyecto Supabase `lhxcreidqswmbkhsebly`. Revisar y ejecutar manualmente (SQL editor o `supabase db push`), y revisar la tabla temporal `_omitidos` que imprime al final para reconciliar a mano cualquier fila saltada.

### Pendiente antes de ver los 64 puestos nuevos en el plano visual

El trazado de geometría es manual sobre la imagen `plano-original.webp`; no existe una imagen de planta para la sección donde físicamente están estos 64 puestos nuevos. Hasta tener esa referencia (plano/foto con su ubicación), esos códigos existen en los datos pero no se dibujan en el mapa — el mapa ya está diseñado para tolerar esto (`${pendientes} puestos pendientes de ubicar`).

## Actualización 03/11/2026 (tarde) — plano real con coordenadas de los 1020 puestos

El usuario entregó `plano_naranjal_puestos.zip`: una digitalización (OCR + validación de secuencia) de `26 10 MASTER PLAN DE VENTAS.pdf`, con coordenadas x/y por puesto sobre una imagen base de 11233×4630 px. Resuelve el pendiente anterior.

- **822 de 1020 códigos coinciden exactamente** entre la tabla de ventas (fuente de precio/estado, ya verificada) y este plano OCR — para esos se usó la posición real del plano nuevo, incluidos los 64 que antes no tenían geometría.
- **198 códigos no coinciden entre fuentes** (ej. tabla de ventas dice `A-111`, el plano OCR trae `A-133` en una posición cercana): son bloques donde las dos digitalizaciones independientes (tabla de ventas vs. plano maestro) infirieron o leyeron una numeración distinta para la misma zona físicamente ambigua. **No se adivinó cuál de las dos tiene razón.** Esos 198 conservan la posición ya trazada a mano en la versión anterior (verificada visualmente), sin tocar.
- Se reemplazó la imagen de fondo (`public/promarsa/plano-original.webp`) por el plano general del zip (2400×989, ya a esta escala) y se actualizó el `viewBox` del SVG y las cámaras de encuadre (`commercial`, `reset-map`, zoom de detalle) de 1888×778 a 2400×989.
- Alineación verificada superponiendo las 1020 posiciones generadas sobre la imagen nueva (zoom en cada sector) antes de publicar — no es una suposición.
- El grupo "PATIO DE COMIDAS" ahora se arma automáticamente por `bloque` del plano OCR (un solo bloque de 42 puestos); se eliminó el rectángulo de etiqueta manual que existía en `market-map.ts` para ese caso especial.
- Archivos fuente de esta digitalización archivados en `plano-ocr/` (README propio, `puestos.csv`, `sectores.json` y la imagen de validación con bordes rojo/naranja por confianza). El `sectores.json` de esa carpeta **no se usó** para sector/rubro — esos ya vienen verificados de la tabla de ventas; el plano OCR marca 140 puestos con "confianza de sector baja" que no afectan geometría pero sí advierten sobre su propio etiquetado de rubro.
- Pendiente real restante: ninguno de los 1020 puestos queda ya sin geometría. Los 198 con numeración en disputa entre fuentes podrían revisarse a futuro contra el plano físico si se quiere subir su confianza, pero no es bloqueante — ya se muestran correctamente en el mapa con su posición original verificada.
