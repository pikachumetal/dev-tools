# CLAUDE.md

Informacion del proyecto para Claude Code.

## Descripcion del proyecto

Este proyecto es un conjunto de herramientas de desarrollo (Dev Tools) que se ejecutan en contenedores Docker. Proporciona servicios comunes de desarrollo local.

## Arquitectura

### Servicios Docker

- **Traefik**: Proxy reverso que enruta el trafico a los diferentes servicios
  - Dashboard en puerto 8080
  - Proxy HTTP en puerto 80
  - Usa labels de Docker para descubrir servicios

- **SonarQube**: Analisis estatico de codigo
  - Accesible via `sonarqube.localhost`
  - Usa PostgreSQL como base de datos
  - Volumenes persistentes en `${COMMON_PATH}\SonarQube\volumes\`

- **SonarQube-DB**: PostgreSQL para SonarQube
  - Red interna `sonarqube-network`
  - Credenciales en variables de entorno
  - Volumenes en `${COMMON_PATH}\SonarQube\volumes\db\`

- **smtp4dev**: Servidor SMTP falso para pruebas
  - Accesible via `smtp.localhost`
  - SMTP en puerto 25, IMAP en puerto 143
  - Volumenes en `${COMMON_PATH}\Smtp4Dev\volumes\`

### Redes Docker

- `traefik-network`: Red publica para acceso via proxy
- `sonarqube-network`: Red privada entre SonarQube y PostgreSQL
- `smtp4dev-network`: Red para smtp4dev

## Archivos importantes

| Archivo | Proposito |
|---------|-----------|
| `docker-compose.yml` | Definicion de todos los servicios |
| `.env` | Variables de entorno (NO subir a git) |
| `.env.example` | Plantilla de variables de entorno |

## Variables de entorno

```
COMMON_PATH         - Ruta base para volumenes Docker
SMTP4DEV_*          - Configuracion de smtp4dev
SONARQUBE_*         - Configuracion de SonarQube
SONARQUBE_POSTGRES_* - Credenciales de PostgreSQL
QODANA_*            - Configuracion de Qodana (futuro)
```

## Comandos utiles

```bash
# Iniciar servicios
docker compose up -d

# Detener servicios
docker compose down

# Ver logs de un servicio
docker compose logs -f sonarqube

# Reiniciar un servicio
docker compose restart traefik

# Ver estado de contenedores
docker ps

# Inspeccionar un contenedor
docker inspect sonarqube
```

## Notas de desarrollo

- Los volumenes usan rutas de Windows con backslash (\)
- Traefik usa Docker provider para autodescubrimiento
- Los healthchecks estan configurados para todos los servicios
- Limites de CPU y memoria definidos por servicio
