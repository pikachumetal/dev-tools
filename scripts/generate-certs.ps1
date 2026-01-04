# Generate TLS certificates for dev-tools
# Requires: mkcert (https://github.com/FiloSottile/mkcert)

param(
    [string]$TraefikCertsPath = "$PSScriptRoot\..\..\traefik-proxy\certs"
)

$ErrorActionPreference = "Stop"

# Check if mkcert is installed
if (-not (Get-Command mkcert -ErrorAction SilentlyContinue)) {
    Write-Error "mkcert is not installed. Install it with: choco install mkcert"
    exit 1
}

# Resolve path
$TraefikCertsPath = [System.IO.Path]::GetFullPath($TraefikCertsPath)

# Check if traefik-proxy certs folder exists
if (-not (Test-Path $TraefikCertsPath)) {
    Write-Error "Traefik certs folder not found: $TraefikCertsPath"
    Write-Host "Make sure traefik-proxy is cloned in the same parent directory"
    exit 1
}

Write-Host "Generating certificates for dev-tools..." -ForegroundColor Cyan
Write-Host "Output folder: $TraefikCertsPath" -ForegroundColor Gray

# Generate wildcard certificate for *.devtools.local
$certFile = Join-Path $TraefikCertsPath "devtools.local.pem"
$keyFile = Join-Path $TraefikCertsPath "devtools.local-key.pem"

mkcert -cert-file $certFile -key-file $keyFile "*.devtools.local" "devtools.local"

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Certificates generated successfully!" -ForegroundColor Green
    Write-Host "  - $certFile"
    Write-Host "  - $keyFile"
    Write-Host ""
    Write-Host "Domains covered:" -ForegroundColor Yellow
    Write-Host "  - *.devtools.local (sonarqube.devtools.local, smtp.devtools.local, etc.)"
    Write-Host "  - devtools.local"
} else {
    Write-Error "Failed to generate certificates"
    exit 1
}
