#!/bin/bash
# product-srv – install_step9_sync.sh

ZONE=$(cat /opt/product-srv-zone)
BASE="/opt/product-srv-core/$ZONE/docker/zone-sync"

mkdir -p $BASE

cat > $BASE/Dockerfile <<EOF
FROM python:3.11-slim
WORKDIR /app
COPY sync.py /app/sync.py
CMD ["python3", "sync.py"]
EOF

cat > $BASE/sync.py <<EOF
import time
while True:
    time.sleep(5)
EOF

echo "[OK] sync service created"
