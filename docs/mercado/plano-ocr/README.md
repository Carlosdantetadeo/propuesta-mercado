# Plano Naranjal - base de puestos (1020) con sector y codigo

Fuente: "26 10 MASTER PLAN DE VENTAS.pdf" (imagen rasterizada, sin texto). Digitalizado por OCR + validacion de secuencia + revision visual.
Aviso del propio plano: "todas las imagenes son referenciales". No es un plano de lotizacion legal.

## Archivos
- puestos.csv / puestos.json : 1 fila por puesto (usar esto, no las imagenes).
- sectores.json : sector -> cantidad y lista de codigos.
- plano_base_hires.jpg (11233x4630) : imagen base. x_px,y_px estan en ESTE sistema. x_norm,y_norm = x_px/11233, y_px/4630 (0..1, para overlay web).
- plano_sectorizado.jpg : validacion visual. Borde rojo = sector de confianza baja; naranja = media.
- plano_general.jpg : vista general ligera.

## Columnas
codigo, sector, confianza_sector (alta|media|baja), nota_sector, fuente_codigo, nota_codigo, bloque, ubicacion (bloque|franja|patio_comidas), x_px, y_px, x_norm, y_norm

fuente_codigo:
- leido_ocr (870): codigo leido directamente del plano y coherente con la secuencia.
- ocr_discrepante_corregido_por_secuencia (37): el OCR leyo mal (6/9, 1/7, 5/9); se uso la secuencia y se verifico visualmente.
- inferido_secuencia (111): celda no leida; codigo deducido por secuencia del bloque. NO leido directamente.
- error_del_plano (2): A-282 (rotulada A-290, duplicada) y A-149 (rotulada A-159). Se asigna el codigo por secuencia.

## Reglas de numeracion confirmadas
Cada bloque = 2 columnas x 5 filas, codigo = base + 2*fila + columna. Numeracion por columna de bloques (+10 por bloque hacia abajo).
Prefijos: A, V (bloques), S (franjas superior/inferior, S-841..S-918), C (patio de comidas, C-919..C-960). Su significado no figura en el plano.

## Limites conocidos
- 140 puestos con sector de confianza BAJA: 100 en VERDURAS (zona verde derecha sin etiqueta), 30 en CHOCLO y 10 en ABARROTES (A-541). Confirmar con el plano oficial.
- Rotulo "JUGUERIA" (A-371) tal como figura en el plano; posible errata de JUGUETERIA.
- No hay areas (m2), precios ni estado de venta: el plano solo trae una leyenda de medidas por color (3x3, 2.5x4, 2x4.5), no por puesto.
