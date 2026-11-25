# Deuda técnica — Dev Tools

## Por triar

| Ítem | Origen | Fecha |
| --- | --- | --- |
| Retirar SonarQube: el bloque comentado de `sonarqube` y `sonarqube-db`, y la red `sonarqube-network`, de `compose.yaml` (hoy es un cambio sin commitear) | entrevista del init: SonarQube fuera de alcance | 2026-11-25 |
| `.env.example` declara variables que `compose.yaml` no lee: `SMTP4DEV_WEB_PORT`, `SONARQUBE_PORT`, `SONARQUBE_POSTGRES_*`, `QODANA_*` | `.env.example`; regla ante conflicto de la constitution | 2026-11-25 |
| `setup-hosts.ps1` incluye `sonarqube.devtools.local`, que ya no existe, y `devtools.local`, que ningún servicio usa; comprobar si `traefik-proxy` usa el dominio raíz antes de quitarlo (también del SAN de `generate-certs.ps1`) | `scripts/setup-hosts.ps1`; regla ante conflicto | 2026-11-25 |
| Puertos `25` y `143` publicados en `0.0.0.0`; pasar a `127.0.0.1:25:25` y `127.0.0.1:143:143` | `compose.yaml`; Art. I de la constitution | 2026-11-25 |
| Retirar `scripts/setup-hosts.sh`, `scripts/generate-certs.sh` y las partes Bash y Linux/Mac del README | entrevista del init: solo Windows | 2026-11-25 |
| `generate-certs.ps1` sugiere `choco install mkcert`; cambiar a `winget install FiloSottile.mkcert` | `scripts/generate-certs.ps1`; regla de avisos | 2026-11-25 |
| README describe SonarQube como servicio activo (tabla, configuración, volúmenes y redes) | `README.md` | 2026-11-25 |
| README escrito sin tildes | `README.md`; convención de idioma | 2026-11-25 |
| Imágenes con `:latest` (`rnwood/smtp4dev:latest`): un `pull` puede cambiar de versión sin aviso | `compose.yaml` | 2026-11-25 |

## En espera

| Ítem | Causa | Origen | Impacto | Falta | Fecha |
| --- | --- | --- | --- | --- | --- |

## Lista

| Ítem | Causa | Origen | Impacto | Evidencia | Remedio temporal | Arreglo | Destino |
| --- | --- | --- | --- | --- | --- | --- | --- |
