#!/bin/bash
# Generate TLS certificates for dev-tools
# Requires: mkcert (https://github.com/FiloSottile/mkcert)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TRAEFIK_CERTS_PATH="${1:-$SCRIPT_DIR/../../traefik-proxy/certs}"

# Resolve path
TRAEFIK_CERTS_PATH="$(cd "$TRAEFIK_CERTS_PATH" 2>/dev/null && pwd)" || {
    echo "Error: Traefik certs folder not found: $TRAEFIK_CERTS_PATH"
    echo "Make sure traefik-proxy is cloned in the same parent directory"
    exit 1
}

# Check if mkcert is installed
if ! command -v mkcert &> /dev/null; then
    echo "Error: mkcert is not installed"
    echo "Install it with: brew install mkcert (macOS) or see https://github.com/FiloSottile/mkcert"
    exit 1
fi

echo "Generating certificates for dev-tools..."
echo "Output folder: $TRAEFIK_CERTS_PATH"

# Generate wildcard certificate for *.devtools.local
mkcert -cert-file "$TRAEFIK_CERTS_PATH/devtools.local.pem" \
       -key-file "$TRAEFIK_CERTS_PATH/devtools.local-key.pem" \
       "*.devtools.local" "devtools.local"

echo ""
echo "Certificates generated successfully!"
echo "  - $TRAEFIK_CERTS_PATH/devtools.local.pem"
echo "  - $TRAEFIK_CERTS_PATH/devtools.local-key.pem"
echo ""
echo "Domains covered:"
echo "  - *.devtools.local (sonarqube.devtools.local, smtp.devtools.local, etc.)"
echo "  - devtools.local"
