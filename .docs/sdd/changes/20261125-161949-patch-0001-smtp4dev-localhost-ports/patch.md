---
id: 20261125-161949-patch-0001-smtp4dev-localhost-ports
task: 0001
title: Patch — Puertos de smtp4dev solo en 127.0.0.1
type: patch
solution: dev-lead
status: done
created: 2026-11-25
branch: patch/0001-smtp4dev-localhost-ports
commit: <hash>
---

# Patch 0001 — Puertos de smtp4dev solo en 127.0.0.1

Validación: dev-lead — la prueba de humo (`compose up`, `healthy`, UI cargando) la hace una persona.

## Capacidades

- Ninguna, porque ninguna capacidad describe `compose.yaml` (no existe `capabilities/`).

## 1. Síntoma

smtp4dev publica SMTP `25` e IMAP `143` en todas las interfaces: `docker compose config` da `published: "25"` y `published: "143"` sin `host_ip`, es decir, `0.0.0.0`. El buzón, sin autenticación, queda al alcance de la red.

## 2. Solución fijada

«`"127.0.0.1:25:25"` y `"127.0.0.1:143:143"`» — dev-lead, 2026-11-25 (respuesta «1» en el init; constitution Art. I). Lo que da por existente, comprobado: `compose.yaml:64` `- "25:25"` y `compose.yaml:65` `- "143:143"` en el servicio `smtp4dev`.

## 3. Fix

- **Fichero(s)**: `compose.yaml`
- **Cambio**: los dos puertos de smtp4dev se ligan a `127.0.0.1`.
- **Decisiones**:
  - `"127.0.0.1:25:25"` y `"127.0.0.1:143:143"` — dev-lead

## 4. Verificación

| # | Caso | Resultado |
| --- | --- | --- |
| 1 | antes: `docker compose config \| Select-String 'host_ip\|published'` | `published: "25"`, `published: "143"`, sin `host_ip` |
| 1 | después: el mismo comando | ✅ `host_ip: 127.0.0.1` con `published: "25"` y con `published: "143"`; `docker compose config --quiet` → exit 0 |

Sin suite de tests en el proyecto: la verificación es el comando de la tabla (`operations.md` §Testing).

Review (sonnet, effort medium): sin Critical ni Important. Regresión descartada: el healthcheck usa `localhost:80` dentro del contenedor y Traefik llega por `traefik-public`; solo fallaría un contenedor de otro proyecto que use `host.docker.internal:25`, y en este repo no hay ninguno. Minor: faltaba la fila «después» en esta tabla → corregido. `commit` y «Esfuerzo real» se rellenan al cerrar.

## 5. Tiempo (ligero)

- Estimación: 0,1 h + gate de cierre (prueba de humo, sin medir)
- Inicio: 2026-11-25T16:19Z
- Esfuerzo real: <pendiente>
