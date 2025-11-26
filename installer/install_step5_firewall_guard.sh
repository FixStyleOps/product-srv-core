#!/bin/bash
# product-srv – install_step5_firewall_guard.sh

ZONE=$(cat /opt/product-srv-zone)
BASE="/opt/product-srv-core/$ZONE/docker/firewall-guard"

mkdir -p $BASE

cat > $BASE/Dockerfile <<EOF
FROM nginx:alpine
COPY firewall.conf /etc/nginx/conf.d/default.conf
EOF

cat > $BASE/firewall.conf <<EOF
server {
    listen 80;

    if (\$http_user_agent ~* "curl|sqlmap|nmap|bot|crawler") {
        return 403;
    }

    location / {
        proxy_pass http://product-auth:8080;
    }
}
EOF

echo "[OK] firewall-guard created"
