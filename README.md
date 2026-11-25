# Dev Tools

Conjunto de herramientas de desarrollo basadas en Docker para entornos locales.

## Servicios incluidos

| Servicio | Descripción | URL local |
|----------|-------------|-----------|
| **smtp4dev** | Servidor SMTP para pruebas de email | https://smtp.devtools.localhost |

## Requisitos

- Docker Desktop
- Docker Compose
- [traefik-proxy](https://github.com/pikachumetal/traefik-proxy) clonado en la misma carpeta padre y ejecutándose
- Node 22 o superior (para el script de certificados de traefik-proxy)
- [mkcert](https://github.com/FiloSottile/mkcert) (`winget install FiloSottile.mkcert`), con `mkcert -install` hecho una vez

## Instalación

1. Asegúrate de tener [traefik-proxy](https://github.com/pikachumetal/traefik-proxy) corriendo:
   ```powershell
   cd ..\traefik-proxy
   docker compose up -d
   ```

2. Clona el repositorio:
   ```powershell
   git clone https://github.com/pikachumetal/dev-tools.git
   cd dev-tools
   ```

3. Copia el archivo de configuración:
   ```powershell
   Copy-Item .env.example .env
   ```

4. Edita `.env` y configura la ruta de los volúmenes:
   ```env
   COMMON_PATH=C:\Docker\Applications
   ```

5. Genera el certificado `*.devtools.localhost` con el script de traefik-proxy y reinicia el proxy para que lo recoja:
   ```powershell
   node ../traefik-proxy/scripts/add-project-cert.mjs devtools
   docker compose -f ../traefik-proxy/compose.yaml restart
   ```

   No hace falta tocar el archivo hosts: `*.localhost` resuelve a `127.0.0.1`. Más detalle en el README de traefik-proxy, sección «Conectar un proyecto».

## Uso

### Iniciar todos los servicios

```powershell
docker compose up -d
```

### Forzar recreación

```powershell
docker compose up -d --force-recreate
```

### Detener todos los servicios

```powershell
docker compose down
```

### Ver logs

```powershell
docker compose logs -f [servicio]
```

### Reiniciar un servicio específico

```powershell
docker compose restart smtp4dev
```

## Configuración de servicios

### smtp4dev

- **Puerto SMTP**: 25 (solo en `127.0.0.1`)
- **Puerto IMAP**: 143 (solo en `127.0.0.1`)
- **Interfaz web**: puerto 80 (vía Traefik)

## Estructura de volúmenes

Los datos persistentes se almacenan en la ruta definida en `COMMON_PATH`:

```
COMMON_PATH\
└── Smtp4Dev\
    └── volumes\
        ├── data\
        └── keys\
```

## Redes Docker

- `traefik-public`: red externa compartida con traefik-proxy
- `smtp4dev-network`: red interna para smtp4dev

## Licencia

MIT License - ver archivo [LICENSE](LICENSE)
