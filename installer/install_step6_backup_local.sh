#!/bin/bash
# product-srv – install_step6_backup_local.sh

ZONE=$(cat /opt/product-srv-zone)
BASE="/opt/product-srv-core/$ZONE/docker/backup-local"

mkdir -p $BASE

cat > $BASE/Dockerfile <<EOF
FROM alpine
CMD ["sh", "-c", "mkdir -p /data && sleep infinity"]
EOF

echo "[OK] backup-local created"
