# CLAUDE.md

Informacion del proyecto para Claude Code.

## Descripcion del proyecto

Este proyecto es un conjunto de herramientas de desarrollo (Dev Tools) que se ejecutan en contenedores Docker. Proporciona servicios comunes de desarrollo local.

## Dependencias

- **traefik-proxy**: Este proyecto requiere que el proxy Traefik centralizado este corriendo.
  - Repositorio: https://github.com/pikachumetal/traefik-proxy
  - Red compartida: `traefik-public`

## Arquitectura

### Servicios Docker

- **SonarQube**: Analisis estatico de codigo
  - Accesible via `https://sonarqube.devtools.local`
  - Usa PostgreSQL como base de datos
  - Volumenes persistentes en `${COMMON_PATH}\SonarQube\volumes\`

- **SonarQube-DB**: PostgreSQL para SonarQube
  - Red interna `sonarqube-network`
  - Credenciales en variables de entorno
  - Volumenes en `${COMMON_PATH}\SonarQube\volumes\db\`

- **smtp4dev**: Servidor SMTP falso para pruebas
  - Accesible via `https://smtp.devtools.local`
  - SMTP en puerto 25, IMAP en puerto 143
  - Volumenes en `${COMMON_PATH}\Smtp4Dev\volumes\`

### Redes Docker

- `traefik-public`: Red externa compartida con traefik-proxy
- `sonarqube-network`: Red privada entre SonarQube y PostgreSQL
- `smtp4dev-network`: Red para smtp4dev

## Archivos importantes

| Archivo | Proposito |
|---------|-----------|
| `compose.yaml` | Definicion de todos los servicios |
| `.env` | Variables de entorno (NO subir a git) |
| `.env.example` | Plantilla de variables de entorno |

## Variables de entorno

```
COMMON_PATH         - Ruta base para volumenes Docker
SMTP4DEV_*          - Configuracion de smtp4dev
SONARQUBE_*         - Configuracion de SonarQube
SONARQUBE_POSTGRES_* - Credenciales de PostgreSQL
```

## Comandos utiles

```bash
# Iniciar servicios (requiere traefik-proxy corriendo)
docker compose up -d

# Detener servicios
docker compose down

# Ver logs de un servicio
docker compose logs -f sonarqube

# Reiniciar un servicio
docker compose restart smtp4dev

# Ver estado de contenedores
docker ps

# Inspeccionar un contenedor
docker inspect sonarqube
```

## Notas de desarrollo

- Los volumenes usan rutas de Windows con backslash (\)
- Requiere traefik-proxy para funcionar (red externa traefik-public)
- Los healthchecks estan configurados para todos los servicios
- Limites de CPU y memoria definidos por servicio
