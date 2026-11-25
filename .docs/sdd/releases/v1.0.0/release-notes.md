---
release: v1.0.0
title: Dev Tools v1.0.0 — smtp4dev listo, cerrado a la red y sin preparación del PC
created: 2026-11-25
---

# Dev Tools v1.0.0 — smtp4dev listo, cerrado a la red y sin preparación del PC

*25 de noviembre de 2026*

## Resumen

Primera versión estable de tus herramientas de desarrollo locales. El servidor de correo de pruebas se abre en `https://smtp.devtools.localhost`, solo es accesible desde tu PC y ya no hace falta tocar el fichero hosts ni generar certificados desde este repo.

## Novedades

- **Para probar correo**: la interfaz de smtp4dev está en `https://smtp.devtools.localhost`, con candado y sin avisos del navegador.
- **Seguridad**: el buzón (SMTP y IMAP) solo acepta conexiones desde tu propio PC; nadie de la red puede mandar ni leer correo de pruebas.
- **Puesta en marcha más corta**: el certificado lo genera traefik-proxy con un solo comando y los dominios `.localhost` funcionan sin editar el fichero hosts.
- **Repo más limpio**: fuera SonarQube, Qodana y las instrucciones para Linux y Mac; todo está pensado para Windows y PowerShell.

## Problemas conocidos

- `curl.exe` de Windows necesita `--ssl-no-revoke` para abrir la interfaz desde la terminal; el navegador funciona sin más.

## Fuera de alcance de esta entrega

- SonarQube y Qodana.
- Linux y macOS.

## Próximos pasos

- Por nuestra parte: nada pendiente en el roadmap.
- Por vuestra parte: si vienes de una versión anterior, abre la interfaz en la dirección nueva (`.localhost`); la antigua (`.local`) ya no responde.
