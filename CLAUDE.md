# CLAUDE.md

`compose.yaml` de herramientas de desarrollo locales (hoy, solo smtp4dev) detrás de `traefik-proxy`. Proyecto con SDD: se entra por las skills del kit.

## Documentos

- Producto y alcance: `PRODUCT.md`
- Reglas no negociables: `.docs/sdd/steering/constitution.md`
- Comandos y prueba de humo: `.docs/sdd/steering/operations.md`
- Estructura y dónde va lo nuevo: `.docs/sdd/steering/architecture.md`
- Trabajo: `ROADMAP.md` · deuda: `.docs/sdd/steering/debt.md` · cambios: `CHANGELOG.md`

## Reglas críticas

- Requiere `traefik-proxy` levantado (red externa `traefik-public`) antes de `docker compose up -d`.
- Ningún puerto se publica fuera de `127.0.0.1`; la UI de cada servicio se expone solo por traefik-proxy.
- Solo Windows: rutas con `\`, instalaciones con `winget`.
- `compose.yaml` es la fuente de verdad: `.env.example` lo refleja. El certificado `*.devtools.localhost` lo genera `traefik-proxy`; aquí no hay scripts.
- Sin gestor de tickets ni worktrees; ids por secuencia del kit.
