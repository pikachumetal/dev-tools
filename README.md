# Dev Tools

Conjunto de herramientas de desarrollo basadas en Docker para entornos locales.

## Servicios incluidos

| Servicio | Descripción | URL local |
|----------|-------------|-----------|
| **smtp4dev** | Servidor SMTP para pruebas de email | https://smtp.devtools.local |

## Requisitos

- Docker Desktop
- Docker Compose
- [traefik-proxy](https://github.com/pikachumetal/traefik-proxy) ejecutándose
- [mkcert](https://github.com/FiloSottile/mkcert) (para generar certificados TLS)

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

5. Genera los certificados TLS:
   ```powershell
   .\scripts\generate-certs.ps1
   ```

6. Configura el archivo hosts (usa gsudo):
   ```powershell
   .\scripts\setup-hosts.ps1
   ```

   Para eliminar las entradas: `.\scripts\setup-hosts.ps1 -Remove`

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
