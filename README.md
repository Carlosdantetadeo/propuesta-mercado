# Operación Comercial — Propuesta web

Sitio web estático de una sola página que presenta la propuesta de operación comercial
para la colocación de puestos del mercado (convertido desde la presentación original).

## Archivos para subir a Vercel

| Archivo | Función |
|---|---|
| `index.html` | Página con las 25 secciones de la propuesta |
| `styles.css` | Estilos y diseño |
| `script.js` | Barra de progreso, navegación lateral y por teclado, animaciones |
| `vercel.json` | Configuración de Vercel (URLs limpias) |

> El archivo `operacion-comercial-mercado (1).pptx` es la fuente original y **no** se despliega.

## Cómo publicar en Vercel

### Opción A — desde la web (más simple)
1. Entra a [vercel.com](https://vercel.com) e inicia sesión.
2. **Add New → Project** y arrastra esta carpeta (o conéctala a un repo de GitHub).
3. Framework Preset: **Other** (es HTML estático, sin build).
4. **Deploy**.

### Opción B — con Vercel CLI
```bash
npm i -g vercel
vercel          # despliegue de prueba (preview)
vercel --prod   # despliegue a producción
```

## Ver en local
Abre `index.html` directamente en el navegador, o levanta un servidor simple:
```bash
python -m http.server 8000
# luego abre http://localhost:8000
```
