#!/bin/bash
# product-srv – install_step10_finalize.sh

ZONE=$(cat /opt/product-srv-zone)

echo "product-srv installer finished for zone: $ZONE"
echo "Run docker compose:"
echo "cd /opt/product-srv-core/$ZONE/docker && docker compose up -d"
