# Architecture — Dev Tools

## Estructura

```text
compose.yaml            servicios Docker (smtp4dev activo; SonarQube y su DB, comentados)
.env.example            plantilla de variables; .env (fuera de git) con los valores del PC
scripts/
  setup-hosts.ps1       añade o quita los dominios *.devtools.local en el fichero hosts (vía gsudo)
  generate-certs.ps1    genera con mkcert el wildcard *.devtools.local en ../traefik-proxy/certs
  setup-hosts.sh        variante Bash (a retirar: solo Windows)
  generate-certs.sh     variante Bash (a retirar: solo Windows)
```

## Piezas y responsabilidades

| Pieza | Responsabilidad | Depende de |
| --- | --- | --- |
| `compose.yaml` › `smtp4dev` | SMTP en `25` e IMAP en `143` en el host; UI web en `https://smtp.devtools.local` | imagen `rnwood/smtp4dev`, red externa `traefik-public`, red `smtp4dev-network`, `COMMON_PATH` |
| `scripts/setup-hosts.ps1` | entradas `127.0.0.1 <dominio>` en el fichero hosts | `gsudo` |
| `scripts/generate-certs.ps1` | certificado `devtools.local.pem` y su clave | `mkcert`, `../traefik-proxy/certs` |
| `traefik-proxy` (repo aparte) | terminación TLS en `:443` y enrutado por `Host()` | su `config/dynamic/tls.yml`, que registra el certificado de `devtools.local` |

## Flujo principal

1. Una sola vez por PC: `generate-certs.ps1` deja el certificado en `traefik-proxy` y `setup-hosts.ps1` apunta los dominios a `127.0.0.1`.
2. Con `traefik-proxy` levantado, `docker compose up -d` arranca smtp4dev en `traefik-public` y `smtp4dev-network`.
3. Traefik descubre el contenedor por sus etiquetas y sirve `https://smtp.devtools.local` hacia su puerto `80`.
4. Las apps del PC envían correo a `localhost:25` y lo leen en la UI o por IMAP en `localhost:143`.

## Dónde va lo nuevo

- Un servicio nuevo → bloque en `compose.yaml` con límites y `healthcheck`, etiquetas de traefik si tiene UI, volúmenes bajo `${COMMON_PATH}\<Servicio>\volumes\`, su dominio en `setup-hosts.ps1` y sus variables en `.env.example`.
- Un paso de preparación del PC → script `.ps1` en `scripts/`.

## Decisiones estructurales

- 2026-11-25 — SonarQube y Qodana fuera de alcance — no se usaron nunca — init SDD.
- 2026-11-25 — Solo Windows — es el único PC donde corre — init SDD.
