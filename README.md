# Dev Tools

Conjunto de herramientas de desarrollo basadas en Docker para entornos locales.

## Servicios incluidos

| Servicio | Descripcion | URL Local |
|----------|-------------|-----------|
| **SonarQube** | Analisis de calidad de codigo | https://sonarqube.devtools.local |
| **smtp4dev** | Servidor SMTP para pruebas de email | https://smtp.devtools.local |

## Requisitos

- Docker Desktop
- Docker Compose
- [traefik-proxy](https://github.com/pikachumetal/traefik-proxy) ejecutandose
- [mkcert](https://github.com/FiloSottile/mkcert) (para generar certificados TLS)

## Instalacion

1. Asegurate de tener [traefik-proxy](https://github.com/pikachumetal/traefik-proxy) corriendo:
   ```bash
   cd ../traefik-proxy
   docker compose up -d
   ```

2. Clona el repositorio:

   **Bash / PowerShell:**
   ```bash
   git clone https://github.com/pikachumetal/dev-tools.git
   cd dev-tools
   ```

3. Copia el archivo de configuracion:

   **Bash:**
   ```bash
   cp .env.example .env
   ```

   **PowerShell:**
   ```powershell
   Copy-Item .env.example .env
   ```

4. Edita `.env` y configura las rutas segun tu sistema:
   ```env
   COMMON_PATH=C:\Docker\Applications  # Windows
   COMMON_PATH=/opt/docker/apps        # Linux/Mac
   ```

5. Genera los certificados TLS:

   **PowerShell:**
   ```powershell
   .\scripts\generate-certs.ps1
   ```

   **Bash:**
   ```bash
   ./scripts/generate-certs.sh
   ```

6. Configura el archivo hosts:

   **PowerShell (usa gsudo):**
   ```powershell
   .\scripts\setup-hosts.ps1
   ```

   **Bash:**
   ```bash
   ./scripts/setup-hosts.sh
   ```

   Para eliminar las entradas: `.\scripts\setup-hosts.ps1 -Remove` o `./scripts/setup-hosts.sh --remove`

## Uso

### Iniciar todos los servicios

```bash
docker compose up -d
```

### Forzar recreacion

```bash
docker compose up -d --force-recreate
```

### Detener todos los servicios

```bash
docker compose down
```

### Ver logs

```bash
docker compose logs -f [servicio]
```

### Reiniciar un servicio especifico

```bash
docker compose restart sonarqube
```

## Configuracion de servicios

### SonarQube

- **Usuario por defecto**: admin
- **Password por defecto**: admin
- **Puerto interno**: 9000
- **Base de datos**: PostgreSQL (incluida)

### smtp4dev

- **Puerto SMTP**: 25
- **Puerto IMAP**: 143
- **Interfaz web**: Puerto 80 (via Traefik)

## Estructura de volumenes

Los datos persistentes se almacenan en la ruta definida en `COMMON_PATH`:

```
COMMON_PATH/
├── SonarQube/
│   └── volumes/
│       ├── conf/
│       ├── data/
│       ├── db/          # PostgreSQL
│       ├── extensions/
│       └── logs/
└── Smtp4Dev/
    └── volumes/
        ├── data/
        └── keys/
```

## Redes Docker

- `traefik-public`: Red externa compartida con traefik-proxy
- `sonarqube-network`: Red interna para SonarQube y su BD
- `smtp4dev-network`: Red interna para smtp4dev

## Licencia

MIT License - ver archivo [LICENSE](LICENSE)
