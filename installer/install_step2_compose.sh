#!/bin/bash
# product-srv – install_step2_compose.sh
# Generate docker-compose.yml for selected zone

echo "==========================================="
echo " product-srv – Step 2: Docker Compose Generator"
echo "==========================================="

ZONE=$(cat /opt/product-srv-zone)
BASE="/opt/product-srv-core/$ZONE/docker"
COMPOSE="$BASE/docker-compose.yml"

echo "Zone: $ZONE"
echo "Compose file: $COMPOSE"

mkdir -p $BASE

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
      - "$( [[ "$ZONE" == "io" ]] && echo "9060" || ([[ "$ZONE" == "kz" ]] && echo "9061" || echo "9062") ):9060"
    restart: always
EOF

echo ""
echo "[OK] Docker Compose generated."
echo "[OK] File created: $COMPOSE"
echo ""
