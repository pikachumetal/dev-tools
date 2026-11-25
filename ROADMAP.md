# Roadmap — Dev Tools

## Now

Perfil de control: delegate

| Id | Externo | Tarea | Estado | Tras | Tamaño |
| --- | --- | --- | --- | --- | --- |
| 0001 | — | **Puertos de smtp4dev solo en 127.0.0.1**<br>*SMTP 25 e IMAP 143 dejan de escuchar en todas las interfaces*<details><summary>Brief</summary>**Carril:** patch<br>**Requisitos:** `.docs/sdd/steering/constitution.md` Art. I<br>**Decisiones ya tomadas:** `"127.0.0.1:25:25"` y `"127.0.0.1:143:143"` (dev-lead, 2026-11-25, init)<br>**Salda:** Puertos `25` y `143` en `0.0.0.0`<br>**Toca:** `compose.yaml`</details> | ✅ | — | S |
| 0002 | — | **Limpieza: SonarQube, Qodana y variantes no Windows**<br>*Retira lo que no se usa y deja el repo solo para Windows*<details><summary>Brief</summary>**Carril:** patch<br>**Requisitos:** `PRODUCT.md` §Capabilities and Constraints; `.docs/sdd/steering/constitution.md` §Reglas de producto<br>**Decisiones ya tomadas:** SonarQube y Qodana fuera de alcance, se borran (dev-lead, 2026-11-25, init); solo Windows, se borran los `.sh` y lo de Bash y Linux del README (dev-lead, 2026-11-25, init); `winget install FiloSottile.mkcert` en lugar de `choco` (dev-lead, 2026-11-25, init); `devtools.local` sale del fichero hosts y se queda en el SAN del certificado (ningún router de `../traefik-proxy` lo usa)<br>**Salda:** Restos de SonarQube y Qodana; Variantes no Windows; README sin tildes<br>**Toca:** `compose.yaml`, `.env.example`, `scripts/`, `README.md`</details> | ✅ | 0001 | S |

## Next

| Id | Externo | Tarea | Estado | Tras | Tamaño |
| --- | --- | --- | --- | --- | --- |
| 0003 | traefik-proxy 0002 | **Dominios `*.devtools.localhost` con el certificado de traefik-proxy**<br>*dev-tools deja de generar certificados y de tocar el fichero hosts*<details><summary>Brief</summary>**Carril:** patch<br>**Requisitos:** spec de la feature 0002 de traefik-proxy (`../traefik-proxy/.docs/sdd/changes/20261125-163335-feature-0002-localhost-domains/spec.md`); arrancar solo con esa feature fusionada en su `develop`<br>**Decisiones ya tomadas:** borrar `scripts/generate-certs.ps1`; el README remite a `node ../traefik-proxy/scripts/add-project-cert.mjs devtools` (Node 22+, `mkcert -install` hecho una vez) (dev-lead, 2026-11-25); `.local` se abandona sin convivencia y `*.localhost` resuelve sin fichero hosts, así que sobra `scripts/setup-hosts.ps1`; etiquetas a `Host(`smtp.devtools.localhost`)` (traefik-proxy 0002, spec aprobada); comprobar el comando y las rutas contra su `develop` antes de escribir el README<br>**Salda:** nada<br>**Toca:** `compose.yaml`, `scripts/`, `README.md`, `PRODUCT.md`, `CLAUDE.md`, `.docs/sdd/steering/constitution.md` (Art. II, regla ante conflicto), `.docs/sdd/steering/architecture.md`</details> | ✅ | — | S |

## Later

| Id | Externo | Tarea | Estado | Tras | Tamaño |
| --- | --- | --- | --- | --- | --- |
