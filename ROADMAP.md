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

## Later

| Id | Externo | Tarea | Estado | Tras | Tamaño |
| --- | --- | --- | --- | --- | --- |
