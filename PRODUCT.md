# Dev Tools

## Users

- **Desarrollador (único usuario)**: levanta en su PC Windows las herramientas de desarrollo locales que necesitan sus proyectos.

## Product Purpose

Un `compose.yaml` con las herramientas de desarrollo locales, accesibles por HTTPS bajo `*.devtools.local` a través de `traefik-proxy`, del que depende para el enrutado y los certificados. Hoy contiene un solo servicio: smtp4dev, un servidor SMTP/IMAP falso para probar el envío de correo. Funciona cuando `docker compose up -d` deja smtp4dev en `healthy` y `https://smtp.devtools.local` responde.

## Capabilities and Constraints

- **Es**: el `compose` de smtp4dev con sus volúmenes bajo `COMMON_PATH`, más los scripts de PowerShell que preparan el PC: entradas del fichero hosts y certificado wildcard `*.devtools.local` en `traefik-proxy`. Solo para Windows.
- **No es**: SonarQube, Qodana, soporte para Linux o macOS, ni un entorno compartido con otras personas o equipos.

## Terminology

Sin términos propios fijados todavía.
