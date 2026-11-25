# Changelog — Dev Tools

Formato: [Keep a Changelog 1.1.0](https://keepachangelog.com/). Changelog técnico del proyecto, backward-looking: `roadmap.md` es el forward-looking.

## [Unreleased]

## [1.0.0] - 2026-11-25

smoke: 2026-11-25 · 0 hallazgos (suite `smoke` del agente sobre `7de7c0f` y uso del dev-lead en local; 0 corregidos en la release)

### Changed

- **0003** — La UI de smtp4dev pasa a `https://smtp.devtools.localhost` con el certificado que genera `traefik-proxy` (`add-project-cert.mjs`); `.local` deja de funcionar. → [ref](.docs/sdd/changes/20261125-170712-patch-0003-localhost-domains/)

### Removed

- **0002** — Fuera SonarQube, Qodana, los scripts Bash y las instrucciones de Linux/Mac; el aviso de `mkcert` sugiere `winget` y el README queda con tildes. → [ref](.docs/sdd/changes/20261125-163129-patch-0002-cleanup-windows-only/)
- **0003** — Fuera `scripts/generate-certs.ps1` y `scripts/setup-hosts.ps1`: el certificado lo genera `traefik-proxy` y `*.localhost` no necesita fichero hosts. → [ref](.docs/sdd/changes/20261125-170712-patch-0003-localhost-domains/)

### Security

- **0001** — SMTP `25` e IMAP `143` de smtp4dev escuchan solo en `127.0.0.1`, no en todas las interfaces. → [ref](.docs/sdd/changes/20261125-161949-patch-0001-smtp4dev-localhost-ports/)
