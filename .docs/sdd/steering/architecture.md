# Architecture — Dev Tools

## Estructura

```text
compose.yaml            servicios Docker (smtp4dev)
.env.example            plantilla de variables; .env (fuera de git) con los valores del PC
```

## Piezas y responsabilidades

| Pieza | Responsabilidad | Depende de |
| --- | --- | --- |
| `compose.yaml` › `smtp4dev` | SMTP en `25` e IMAP en `143` en el host; UI web en `https://smtp.devtools.localhost` | imagen `rnwood/smtp4dev`, red externa `traefik-public`, red `smtp4dev-network`, `COMMON_PATH` |
| `traefik-proxy` (repo aparte) | terminación TLS en `:443`, enrutado por `Host()` y el certificado `*.devtools.localhost` | su `scripts/add-project-cert.mjs devtools`, que lo genera con `mkcert` y lo registra en su `config/dynamic/devtools.tls.yml` |

## Flujo principal

1. Una sola vez por PC: `node ../traefik-proxy/scripts/add-project-cert.mjs devtools` y reiniciar `traefik-proxy`. `*.localhost` resuelve a `127.0.0.1` sin tocar el fichero hosts.
2. Con `traefik-proxy` levantado, `docker compose up -d` arranca smtp4dev en `traefik-public` y `smtp4dev-network`.
3. Traefik descubre el contenedor por sus etiquetas (router `devtools-smtp`) y sirve `https://smtp.devtools.localhost` hacia su puerto `80`.
4. Las apps del PC envían correo a `localhost:25` y lo leen en la UI o por IMAP en `localhost:143`.

## Dónde va lo nuevo

- Un servicio nuevo → bloque en `compose.yaml` con límites y `healthcheck`, etiquetas de traefik con router y service `devtools-<servicio>` y `Host(`<servicio>.devtools.localhost`)` si tiene UI, volúmenes bajo `${COMMON_PATH}\<Servicio>\volumes\` y sus variables en `.env.example`.

## Decisiones estructurales

- 2026-11-25 — SonarQube y Qodana fuera de alcance — no se usaron nunca — init SDD.
- 2026-11-25 — Solo Windows — es el único PC donde corre — init SDD.
- 2026-11-25 — Dominios `*.devtools.localhost` y certificado generado por `traefik-proxy`; fuera los scripts de hosts y certificados — `traefik-proxy` abandona `.local` (su feature 0002) — patch 0003.
