# Constitution — Dev Tools

## Principios

1. Solo lo que se usa: un servicio que no se usa se retira, no se deja comentado.
2. Local y para una persona: nada queda expuesto fuera del PC.
3. Solo Windows: sin variantes para otros sistemas.
4. `compose.yaml` manda sobre cualquier otra copia de sus datos.

## Artículos

### Art. I — Puertos solo en localhost

Todo puerto publicado en el host va ligado a `127.0.0.1` (`"127.0.0.1:25:25"`), nunca a `0.0.0.0`.

*Por qué*: smtp4dev no tiene autenticación, y un puerto abierto deja el buzón al alcance de toda la red.

### Art. II — Exposición web solo por traefik-proxy

Un servicio con UI no publica su puerto web en el host: se expone en `traefik-public` con las etiquetas `traefik.enable=true`, `traefik.docker.network=traefik-public` y un router y un service `devtools-<servicio>` con `Host(`<servicio>.devtools.localhost`)` sobre `websecure` con `tls=true`.

*Por qué*: un solo punto de entrada HTTPS con el certificado wildcard de `traefik-proxy`.

### Art. III — Secretos fuera de git

`.env` nunca se versiona; `.env.example` lleva solo nombres de variables y valores de ejemplo.

*Por qué*: `.env` guarda rutas y credenciales propias del PC.

## Convenciones

- **Idioma**: documentación en español con tildes; código, identificadores, variables de entorno y mensajes de los scripts en inglés. Nombres de fichero en inglés.
- **Ramas**: git-flow: `main` estable (releases), `develop` de integración, `feature/<id>-<slug>` y `patch/<id>-<slug>` desde `develop`. El agente publica `develop` sin preguntar (también su primera publicación y los commits directos); el merge a `main`, los tags y los ajustes del repo en GitHub, con el «sí» del dev-lead.
- **Commits**: Conventional Commits; tipo y scope en inglés, título y cuerpo en español con términos técnicos en inglés.
- **Proyecto de referencia**: `../traefik-proxy` (red `traefik-public`, etiquetas de router y certificado `*.devtools.localhost` generado con su `scripts/add-project-cert.mjs devtools`, según su README, «Conectar un proyecto»).

## Reglas de producto

- **Dónde viven los datos**: bind mounts bajo `${COMMON_PATH}\<Servicio>\volumes\`, con rutas Windows con `\`; `COMMON_PATH` sale de `.env`.
- **Idioma de los nombres**: inglés para servicios, dominios, variables de entorno y mensajes de los scripts; español para la documentación.
- **Límites**: todo servicio declara `cpus`, `mem_limit`, `mem_reservation` y `healthcheck`; los valores viven en `compose.yaml`.
- **Avisos**: sin avisos propios. Si falta la red `traefik-public` en el `compose up`, avisa el propio error de Docker; el certificado lo genera `traefik-proxy`, que avisa con sus propios errores.
- **Regla ante conflicto**: `compose.yaml` es la fuente de verdad: `.env.example` solo declara las variables que `compose.yaml` lee. Si no coinciden, se corrige la plantilla, nunca el compose.
