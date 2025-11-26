#!/bin/bash
# product-srv – install_step2_compose.sh
# Generate docker-compose.yml for selected zone (alpha / beta / gamma)

echo "==========================================="
echo " product-srv – Step 2: Docker Compose Generator"
echo "==========================================="

ZONE=$(cat /opt/product-srv-zone)
BASE="/opt/product-srv-core/$ZONE/docker"
COMPOSE="$BASE/docker-compose.yml"

echo "Zone: $ZONE"
echo "Compose file: $COMPOSE"

mkdir -p $BASE

# Randomized external ports by zone
case "$ZONE" in
    "alpha") SYNC_PORT=52148;;
    "beta")  SYNC_PORT=53792;;
    "gamma") SYNC_PORT=56411;;
    *) SYNC_PORT=$((30000 + RANDOM % 20000));;
esac

cat > $COMPOSE <<EOF
services:

  product-limiter:
    container_name: product-${ZONE}-limiter
    build: ./access-limiter
    ports:
      - "80:80"
    restart: always

  product-firewall:
    container_name: product-${ZONE}-firewall
    build: ./firewall-guard
    restart: always

  product-auth:
    container_name: product-${ZONE}-auth
    build: ./web-auth
    ports:
      - "8080:8080"
    restart: always

  product-alert:
    container_name: product-${ZONE}-alert
    build: ./alert
    restart: always

  product-backup:
    container_name: product-${ZONE}-backup
    build: ./backup-local
    volumes:
      - /opt/product-srv-core/$ZONE/backup:/data
    restart: always

  product-resource:
    container_name: product-${ZONE}-resource
    build: ./resource-control
    restart: always

  product-sync:
    container_name: product-${ZONE}-sync
    build: ./zone-sync
    ports:
      - "$SYNC_PORT:9060"
    restart: always
EOF

echo ""
echo "[OK] Docker Compose generated."
echo "[OK] External sync port: $SYNC_PORT"
echo "[OK] File created: $COMPOSE"
echo ""

