---
id: 20261125-161949-patch-0001-smtp4dev-localhost-ports
task: 0001
title: Patch — Puertos de smtp4dev solo en 127.0.0.1
type: patch
solution: dev-lead
status: done
created: 2026-11-25
branch: patch/0001-smtp4dev-localhost-ports
commit: bfbbcd6
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

Gate: `docker compose config --quiet` → exit 0 · smoke (manual, ensayada por el agente y por el dev-lead) sobre `bfbbcd6`

| # | Caso | Resultado |
| --- | --- | --- |
| 1 | antes: `docker compose config \| Select-String 'host_ip\|published'` | `published: "25"`, `published: "143"`, sin `host_ip` |
| 1 | después: el mismo comando | ✅ `host_ip: 127.0.0.1` con `published: "25"` y con `published: "143"`; `docker compose config --quiet` → exit 0 |
| 2 | agente: `docker compose up -d` y `docker compose ps` | ✅ `Up 14 seconds (healthy) 127.0.0.1:25->25/tcp, 127.0.0.1:143->143/tcp` |
| 3 | agente: `curl.exe -sk https://smtp.devtools.local` | ✅ HTTP `200` |
| 4 | agente: `Test-NetConnection` al puerto 25 en `127.0.0.1` y en la IP de red `10.196.26.35` | ✅ `True` · `False` |
| 5 | dev-lead: el guion de validación (pasos 1-4) | ✅ «validado» |

Sin suite de tests en el proyecto: la verificación es el comando de la tabla (`operations.md` §Testing).

Review (sonnet, effort medium): sin Critical ni Important. Regresión descartada: el healthcheck usa `localhost:80` dentro del contenedor y Traefik llega por `traefik-public`; solo fallaría un contenedor de otro proyecto que use `host.docker.internal:25`, y en este repo no hay ninguno. Minor: faltaba la fila «después» en esta tabla → corregido. `commit` y «Esfuerzo real» se rellenan al cerrar.

Validado: 2026-11-25 · «validado» · no detalló qué probó

## 5. Tiempo (ligero)

- Estimación: 0,1 h + gate de cierre (prueba de humo, sin medir)
- Inicio: 2026-11-25T16:19Z
- Esfuerzo real: 0,25 h — reloj de la sesión 2,37 h desde 2026-11-25T14:04Z, sin 127 min de espera al dev-lead (46 esperas)
- Desviación: +150 % sobre 0,1 h. Causa: la sesión no se abrió para el patch; el reloj arranca a las 14:04Z con el init y el triaje, así que el real del patch queda sin medir aparte.
- Coste de sujetos: no aplica
