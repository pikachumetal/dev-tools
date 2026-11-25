---
id: 20261125-163129-patch-0002-cleanup-windows-only
task: 0002
title: Patch — Limpieza: SonarQube, Qodana y variantes no Windows
type: patch
solution: dev-lead
status: done
created: 2026-11-25
branch: patch/0002-cleanup-windows-only
commit: <hash>
---

# Patch 0002 — Limpieza: SonarQube, Qodana y variantes no Windows

Validación: dev-lead — la prueba de humo (`compose up`, `healthy`, UI cargando) la hace una persona.

## Capacidades

- Ninguna, porque ninguna capacidad describe `compose.yaml` ni `scripts/` (no existe `capabilities/`).

## 1. Síntoma

Restos de lo que quedó fuera de alcance en el init (filas de «Lista» de `debt.md` con destino 0002):

- `compose.yaml`: 25 líneas con `sonar` (bloque comentado de `sonarqube` y `sonarqube-db`, red `sonarqube-network`).
- `.env.example`: 8 variables que `compose.yaml` no lee (`SMTP4DEV_WEB_PORT`, `SONARQUBE_*`, `QODANA_*`).
- `scripts/setup-hosts.ps1`: `sonarqube.devtools.local` y `devtools.local` en la lista de dominios.
- `scripts/setup-hosts.sh` y `scripts/generate-certs.sh`; partes de Bash y Linux/Mac en el README.
- `scripts/generate-certs.ps1:12` sugiere `choco install mkcert`.
- README con SonarQube como servicio activo y sin tildes.

## 2. Solución fijada

Decisiones del dev-lead en la entrevista del init (2026-11-25), recogidas en el brief de la fila 0002 de `ROADMAP.md`:

- «1» a «Fuera de alcance y retirarlos» (SonarQube y Qodana).
- «si, casi te diria que elimina lo que no sea windows...» (solo Windows).
- «ya no uso choco, solo winget» → `winget install FiloSottile.mkcert` (id comprobado con `winget search mkcert`).
- `devtools.local` sale del fichero hosts: ningún `Host()` de `../traefik-proxy` lo usa; se queda en el SAN del certificado.

Lo que da por existente, comprobado: los 6 puntos del síntoma.

## 3. Fix

- **Fichero(s)**: `compose.yaml`, `.env.example`, `scripts/setup-hosts.ps1`, `scripts/generate-certs.ps1`, `README.md`; borrados `scripts/setup-hosts.sh` y `scripts/generate-certs.sh`.
- **Cambio**: se retira todo lo de SonarQube y Qodana y las variantes no Windows; `generate-certs.ps1` sugiere `winget` y su resumen ya no nombra `sonarqube.devtools.local`; el README queda solo con smtp4dev, solo PowerShell y con tildes.
- **Decisiones**:
  - SonarQube y Qodana fuera — dev-lead
  - Solo Windows — dev-lead
  - `winget install FiloSottile.mkcert` — dev-lead
  - `devtools.local` fuera del fichero hosts — dev-lead (aceptó la fila del triaje)
- **Retirado**: bloque comentado de SonarQube y su DB, red comentada `sonarqube-network`, 8 variables de `.env.example`, 2 dominios del fichero hosts, 2 scripts Bash, secciones de SonarQube y Bash/Linux/Mac del README · Lo que el usuario deja de poder hacer: nada (SonarQube ya estaba comentado; los `.sh` eran para otros sistemas).

## 4. Verificación

Usos de lo retirado, buscados fuera de `.git`, `.temp` y `.docs`: `SMTP4DEV_WEB_PORT`, `SONARQUBE_*`, `QODANA_*`, `sonarqube-network`, `setup-hosts.sh` y `generate-certs.sh` solo aparecían en `compose.yaml` (comentado), `.env.example`, el README y el `.env` local (fuera de git, no se toca).

Fuera del patch, a propósito: `.gitattributes` mantiene `*.sh` y `*.bash` (sin efecto al no quedar ficheros así); `.env` local conserva sus variables viejas.

| # | Caso | Resultado |
| --- | --- | --- |
| 1 | antes: `Select-String compose.yaml sonar` · `.env.example` vars · `scripts/` | 25 líneas · 8 variables · 4 scripts |
| 1 | después: las mismas búsquedas | ✅ 0 líneas · 0 variables · `generate-certs.ps1, setup-hosts.ps1` |
| 2 | `docker compose config --quiet` y puertos | ✅ exit 0 · `host_ip: 127.0.0.1` en `25` y `143` |
| 3 | parseo de `setup-hosts.ps1` y `generate-certs.ps1` (revisor) | ✅ 0 errores |

Review (sonnet, effort medium): sin Critical ni Important. Minor 1: `setup-hosts.ps1 -Remove` ya no limpia `devtools.local` ni `sonarqube.devtools.local` de un fichero hosts que ya los tenga → aceptado como efecto lateral: el guion de validación incluye quitarlos a mano. Minor 2: faltaba la fila «después» → corregido; `commit` y «Esfuerzo real» se rellenan al cerrar.

## 5. Tiempo (ligero)

- Estimación: 0,3 h + gate de cierre (prueba de humo, sin medir)
- Inicio: 2026-11-25T16:31Z
- Esfuerzo real: <pendiente>
