# Operations — Dev Tools

## Comandos

- **Build**: no aplica (imágenes publicadas; `docker compose pull` para actualizarlas).
- **Arrancar**: `docker compose up -d` (requiere `traefik-proxy` levantado). Parar: `docker compose down`.

## Testing

Sin tests automáticos: validación del compose y prueba de humo manual.

- **Suites**: `smoke` · `docker compose up -d`, después `docker compose ps` con smtp4dev en `healthy` y `https://smtp.devtools.local` cargando · pendiente · integración
- **Lo afectado**: no aplica; se corre la suite entera.
- **Gate de cierre**: la suite `smoke` entera.
- **Gate de merge**: `docker compose config --quiet`
- **Sin filtro**: `compose.yaml`, `.env.example`
- **Lint**: `docker compose config --quiet` (sintaxis e interpolación del `.env`) al editar `compose.yaml`.
- **CI de la base**: `ninguna`
- **Acceso a la aplicación**: `sin login` (la UI de smtp4dev en `https://smtp.devtools.local`).
- **Motor de producción**: no aplica.
- **Temporales**: `smoke` · `no declarado`

- **Camino crítico**: `ninguno`
