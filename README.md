# Dev Tools

Conjunto de herramientas de desarrollo basadas en Docker para entornos locales.

## Servicios incluidos

| Servicio | Descripcion | URL Local |
|----------|-------------|-----------|
| **Traefik** | Proxy reverso y dashboard | http://localhost:8080 |
| **SonarQube** | Analisis de calidad de codigo | http://sonarqube.localhost |
| **smtp4dev** | Servidor SMTP para pruebas de email | http://smtp.localhost |

## Requisitos

- Docker Desktop
- Docker Compose

## Instalacion

1. Clona el repositorio:
   ```bash
   git clone https://github.com/pikachumetal/dev-tools.git
   cd dev-tools
   ```

2. Copia el archivo de configuracion:
   ```bash
   cp .env.example .env
   ```

3. Edita `.env` y configura las rutas segun tu sistema:
   ```env
   COMMON_PATH=C:\Docker\Applications  # Windows
   COMMON_PATH=/opt/docker/apps        # Linux/Mac
   ```

## Uso

### Iniciar todos los servicios

```bash
docker compose up -d
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

### Traefik

- **Dashboard**: http://localhost:8080
- **Proxy HTTP**: Puerto 80

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

> **Nota**: Traefik no requiere volumenes de datos, solo accede al socket de Docker.

## Redes Docker

- `traefik-network`: Red principal para acceso via proxy
- `sonarqube-network`: Red interna para SonarQube y su BD
- `smtp4dev-network`: Red interna para smtp4dev

## Licencia

MIT License - ver archivo [LICENSE](LICENSE)
