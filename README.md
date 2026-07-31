# Medisel · Documentación del proyecto

Documentos del proyecto **Portal de turnos para exámenes médicos laborales** (Medisel Consultorios Médicos), publicados como sitio estático en GitHub Pages para que el cliente pueda leerlos y validarlos desde el navegador.

## Sitio publicado

👉 https://joajo13.github.io/medisel-docs/

Solo se publica lo que está en `docs/`.

## Estructura

```
medisel-docs/
├── docs/                            ← esto es lo que se publica (GitHub Pages)
│   ├── index.html                   ← índice con links a los documentos
│   ├── presupuesto.html
│   ├── especificacion-funcional.html
│   └── .nojekyll                    ← evita que Jekyll procese el HTML
├── interno/                         ← SOLO LOCAL, fuera de git
│   ├── plan-de-proyecto.html
│   └── srs-tecnico.html
└── sync.ps1                         ← re-copia los HTMLs desde Downloads
```

### Sobre `interno/`

Estos dos documentos **existen sólo en tu máquina**. Están en `.gitignore`, no se versionan y nunca llegaron ni van a llegar a GitHub.

El motivo es que el repo es público: cualquiera que diera con él podría leer el plan de proyecto —que tiene horas, márgenes, capacidad real y análisis de riesgo— y el SRS. Nada de eso está pensado para el cliente.

Se sincronizan igual con `sync.ps1` desde `Downloads`, así que el flujo de actualización no cambia. Simplemente no se commitean.

**Si alguna vez necesitás versionarlos**, creá un repo privado aparte y movelos ahí. No los agregues acá con `git add -f`: volverían a quedar públicos.

## Actualizar los documentos

Cuando regenerás los HTMLs y quedan en `Downloads`:

```powershell
.\sync.ps1
git add -A
git commit -m "docs: actualiza documentos"
git push
```

GitHub Pages redeploya solo en 1–2 minutos.

Si preferís copiar a mano, el mapeo es:

| Archivo en Downloads | Destino | Se versiona |
|---|---|---|
| `CLIENTE  Medisel  Presupuesto.html` | `docs/presupuesto.html` | Sí |
| `CLIENTE  Medisel  Especificacion funcional.html` | `docs/especificacion-funcional.html` | Sí |
| `INTERNO  Medisel  Plan de proyecto.html` | `interno/plan-de-proyecto.html` | **No, sólo local** |
| `INTERNO  Medisel  SRS tecnico.html` | `interno/srs-tecnico.html` | **No, sólo local** |

## Agregar un documento nuevo para el cliente

1. Copiá el HTML a `docs/` con nombre en kebab-case (`docs/mi-documento.html`).
2. Agregá un bloque `<a class="doc">` en `docs/index.html` copiando uno de los existentes.
3. Commit y push.

## Cómo está configurado el deploy

GitHub Pages sirve desde la rama `main`, carpeta `/docs`. Sin build, sin Actions, sin dependencias — los HTML son autocontenidos (CSS inline, sin recursos externos).

Para verlo local, con abrir `docs/index.html` en el navegador alcanza.
