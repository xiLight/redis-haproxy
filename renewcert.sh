#!/bin/bash
set -e

if ! command -v certbot &> /dev/null; then
  echo "Certbot is not installed. Please install it with: sudo apt install certbot"
  exit 1
fi

if [ ! -f .env ]; then
  echo ".env file is missing! Please create it from .env.example."
  exit 1
fi

export $(grep -v '^#' .env | xargs)

certbot certonly --standalone -d "$DOMAIN" --email "$EMAIL" --agree-tos --non-interactive
cat "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" "/etc/letsencrypt/live/$DOMAIN/privkey.pem" > "./certs/$DOMAIN.pem"
docker compose up -d
