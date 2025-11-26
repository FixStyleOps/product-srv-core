#!/bin/bash
# product-srv – install_step8_limiters.sh

ZONE=$(cat /opt/product-srv-zone)
DEST="/opt/product-srv-core/$ZONE/config/limiters.conf"

cat > $DEST <<EOF
[limits]
requests_per_second=5
burst=10
EOF

echo "[OK] limiters config created"
