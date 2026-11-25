---
id: 20261125-170712-patch-0003-localhost-domains
task: 0003
title: Patch — Dominios *.devtools.localhost con el certificado de traefik-proxy
type: patch
solution: dev-lead
status: done
created: 2026-11-25
branch: patch/0003-localhost-domains
commit: <hash>
---

# Patch 0003 — Dominios *.devtools.localhost con el certificado de traefik-proxy

Validación: dev-lead — la prueba de humo (`compose up`, `healthy`, UI cargando en el dominio nuevo) la hace una persona.

## Capacidades

- Ninguna, porque ninguna capacidad describe `compose.yaml` (no existe `capabilities/`).

## 1. Síntoma

`traefik-proxy` fusionó su feature 0002 (`c571e9e`): abandona `.local` sin convivencia, borra `generate-certs.sh` y `tls.yml`, y genera el certificado de cada proyecto con `scripts/add-project-cert.mjs <proyecto>`. dev-tools seguía en `Host(`smtp.devtools.local`)`, con `scripts/generate-certs.ps1` escribiendo `devtools.local*.pem` y `scripts/setup-hosts.ps1` tocando el fichero hosts. Medido antes del cambio: `https://smtp.devtools.local` → `404`.

## 2. Solución fijada

- «borrar `scripts/generate-certs.ps1`; el README remite a `node ../traefik-proxy/scripts/add-project-cert.mjs devtools`» — dev-lead, 2026-11-25 («vale pues habla con traefik-proxy porque el script de generar estara alli no aqui…»; brief de la fila 0003).
- `Host(`smtp.devtools.localhost`)`, sin fichero hosts, y router y service `<proyecto>-<servicio>` — README de `traefik-proxy` en `c571e9e`, «Conectar un proyecto», proyecto de referencia de la constitution.

Lo que da por existente, comprobado: `../traefik-proxy` `origin/develop` en `c571e9e` con `scripts/add-project-cert.mjs` y la sección «Conectar un proyecto»; el certificado `devtools.localhost` ya generado (la UI responde con certificado válido tras el cambio).

## 3. Fix

- **Fichero(s)**: `compose.yaml`, `README.md`, `PRODUCT.md`, `CLAUDE.md`, `.docs/sdd/steering/constitution.md`, `.docs/sdd/steering/operations.md`, `.docs/sdd/steering/architecture.md`; borrados `scripts/generate-certs.ps1` y `scripts/setup-hosts.ps1`.
- **Cambio**: router y service `devtools-smtp` con `Host(`smtp.devtools.localhost`)`; el README remite al script de `traefik-proxy` y a su reinicio; los documentos ancla dejan de nombrar `.local`, `setup-hosts.ps1`, `generate-certs.ps1` y `tls.yml`.
- **Decisiones**:
  - Borrar `generate-certs.ps1` y remitir al script de `traefik-proxy` — dev-lead
  - Borrar `setup-hosts.ps1` y dominio `.localhost` — dev-lead (brief de la fila 0003, aceptado con «1» y «si»)
  - Nombre `devtools-smtp` para router y service — ticket (README de `traefik-proxy`, «Conectar un proyecto»)
  - Regla ante conflicto de la constitution sin la lista de dominios de `setup-hosts.ps1`, que ya no existe — dev-lead (consecuencia del borrado)
- **Retirado**: `scripts/generate-certs.ps1`, `scripts/setup-hosts.ps1` (y con ellos la carpeta `scripts/`) · Lo que el usuario deja de poder hacer: nada; el certificado lo genera `traefik-proxy` y `*.localhost` no necesita fichero hosts.

## 4. Verificación

| # | Caso | Resultado |
| --- | --- | --- |
| 1 | antes: `curl.exe -sk https://smtp.devtools.local` (smtp4dev arriba) | `404` |
| 1 | después: `curl.exe -s --ssl-no-revoke https://smtp.devtools.localhost` | ✅ `200 ssl_verify=0` |
| 2 | `docker compose config --quiet` | ✅ exit 0 |
| 3 | `docker compose ps` | ✅ `Up 22 seconds (healthy) 127.0.0.1:25->25/tcp, 127.0.0.1:143->143/tcp` |
| 4 | referencias viejas (`devtools.local`, `setup-hosts`, `generate-certs`, `gsudo`, `tls.yml`) fuera de `ROADMAP.md` y `changes/` | ✅ ninguna |

Review (sonnet, effort medium): sin Critical ni Important. Minor 1: la regla «Avisos» de la constitution y «scripts en PowerShell» de `CLAUDE.md` hablan de scripts y el repo ya no tiene → rechazado: siguen valiendo para un script futuro, y cambiar una regla de producto es del dev-lead; se le avisa. Minor 2 y 3: coherentes, sin cambio. Minor 4: `commit` y «Esfuerzo real» se rellenan al cerrar.

Nota: `curl.exe` de Windows (schannel) sin `--ssl-no-revoke` falla con `CRYPT_E_NO_REVOCATION_CHECK` porque la CA de mkcert no publica revocación; el navegador no hace esa comprobación.

## 5. Tiempo (ligero)

- Estimación: 0,3 h + gate de cierre (prueba de humo, sin medir)
- Inicio: 2026-11-25T17:07Z
- Esfuerzo real: <pendiente>
