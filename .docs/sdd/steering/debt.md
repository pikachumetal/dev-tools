# Deuda técnica — Dev Tools

## Por triar

| Ítem | Origen | Fecha |
| --- | --- | --- |

## En espera

| Ítem | Causa | Origen | Impacto | Falta | Fecha |
| --- | --- | --- | --- | --- | --- |
| Imágenes con `:latest` (`rnwood/smtp4dev:latest`): un `pull` puede cambiar de versión sin aviso | sin determinar | `compose.yaml` | bajo | 2.º caso | 2026-11-25 |

## Lista

| Ítem | Causa | Origen | Impacto | Evidencia | Remedio temporal | Arreglo | Destino |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Restos de SonarQube y Qodana: bloque comentado y red `sonarqube-network` en `compose.yaml`; `SMTP4DEV_WEB_PORT`, `SONARQUBE_*` y `QODANA_*` sin uso en `.env.example`; `sonarqube.devtools.local` y `devtools.local` en `setup-hosts.ps1`; SonarQube como activo en el README | defecto del producto | entrevista del init; regla ante conflicto | medio | `Select-String compose.yaml sonar` da 25 líneas; `Select-String .env.example '^(SMTP4DEV_WEB_PORT\|SONARQUBE\|QODANA)'` da 8; ningún `Host()` de `../traefik-proxy` usa `devtools.local` | — | — | 0002 |
| Variantes no Windows: `scripts/setup-hosts.sh`, `scripts/generate-certs.sh`, partes de Bash y Linux del README, y `choco install mkcert` en `generate-certs.ps1` | defecto del producto | entrevista del init: solo Windows | bajo | `Select-String README.md 'Bash\|Linux\|\.sh'` da 18 líneas; `scripts/generate-certs.ps1:12` | — | — | 0002 |
| README sin tildes | defecto del producto | `README.md`; convención de idioma | bajo | `Select-String README.md 'Instalacion\|Descripcion\|Configuracion'` | — | — | 0002 |
