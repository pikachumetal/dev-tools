---
release: v1.0.1
title: Dev Tools v1.0.1 — smtp4dev más ligero y con versión fija
created: 2026-11-25
---

# Dev Tools v1.0.1 — smtp4dev más ligero y con versión fija

*25 de noviembre de 2026*

## Resumen

El servidor de correo de pruebas reserva mucha menos memoria del PC y ya no cambia de versión por sorpresa al actualizar.

## Novedades

- **Para tu PC**: smtp4dev deja de reservar 1 GB de RAM; ahora reserva 128 MB y tiene un tope de 512 MB, de sobra para los ~75 MB que usa.
- **Estabilidad**: la versión de smtp4dev queda fija (3.15.0); un `pull` ya no trae otra sin que lo decidas.
- **Configuración más corta**: `.env` solo necesita `COMMON_PATH`.

## Problemas conocidos

_Ninguno_

## Fuera de alcance de esta entrega

_Nada_

## Próximos pasos

- Por nuestra parte: nada pendiente en el roadmap.
- Por vuestra parte: puedes borrar de tu `.env` la línea `SMTP4DEV_SERVER_OPTIONS__URLS`, que ya no se usa.
