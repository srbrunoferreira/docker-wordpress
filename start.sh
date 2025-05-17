#!/bin/bash

set -e

if [[ $EUID -ne 0 ]]; then
  echo "🟡 🔐 This script requires sudo privileges. You may be prompted for your password..."
  sudo -v
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

CERT_DIR="./wordpress/apache/certs"
CERT_FILE="$CERT_DIR/wordpress.local.pem"
KEY_FILE="$CERT_DIR/wordpress.local.key.pem"
DOMAIN="wordpress.local"
PMA_PORT=${PHPMYADMIN_PORT:-3022}

OS=$(uname -s)
echo "🟡 Detected OS: $OS"

add_host_entry() {
  HOSTS_LINE="127.0.0.1       $DOMAIN"
  IPV6_LINE="::1             $DOMAIN"

  if ! grep -q "$DOMAIN" /etc/hosts; then
    echo "🟡 Adding $DOMAIN to /etc/hosts..."
    echo -e "$HOSTS_LINE\n$IPV6_LINE" | sudo tee -a /etc/hosts
  else
    echo "🟡 $DOMAIN already present in /etc/hosts"
  fi
}

generate_cert() {
  echo "🟡 Generating self-signed cert with mkcert..."

  docker run --rm -v "$(pwd)/wordpress/apache/certs:/certs" alpine/mkcert \
    -cert-file /certs/wordpress.local.pem \
    -key-file /certs/wordpress.local.key.pem \
    wordpress.local localhost 127.0.0.1 ::1
}

trust_cert() {
  case "$OS" in
    Darwin)
      echo "🟡 Trusting cert on macOS..."
      sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain "$CERT_FILE"
      echo "🟡 Cert added but you still have to manually trust it on Keychain..."
      ;;
    Linux)
      echo "🟡 Trusting cert on Linux..."
      sudo cp "$CERT_FILE" /usr/local/share/ca-certificates/wordpress.local.crt
      sudo update-ca-certificates
      ;;
    *)
      echo "🟡 ⚠️ Unsupported OS: $OS. Please trust the cert manually."
      ;;
  esac
}

start_docker() {
  echo "🟡 Starting docker-compose..."
  docker-compose up -d --build
}

print_urls() {
  echo "========================================"
  echo "🔗 WordPress:     https://$DOMAIN"
  echo "🔗 phpMyAdmin:    https://$DOMAIN:$PMA_PORT"
  echo "========================================"
}

add_host_entry

if [[ -f "$CERT_FILE" && -f "$KEY_FILE" ]]; then
  echo "🟡 Certificate and key already exist, skipping generation and trust steps."
else
  generate_cert
  trust_cert
fi

start_docker
print_urls

echo "🟢 Script finished!"
