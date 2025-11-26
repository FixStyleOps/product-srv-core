#!/bin/bash
# product-srv – install_step4_web_auth.sh

ZONE=$(cat /opt/product-srv-zone)
BASE="/opt/product-srv-core/$ZONE/docker/web-auth"

mkdir -p $BASE

cat > $BASE/Dockerfile <<EOF
FROM python:3.11-alpine
WORKDIR /app
COPY app.py /app/app.py
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
CMD ["python3", "app.py"]
EOF

cat > $BASE/requirements.txt <<EOF
flask
EOF

cat > $BASE/app.py <<EOF
from flask import Flask
app = Flask(__name__)

@app.route("/")
def index():
    return "product-auth online"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
EOF

echo "[OK] web-auth created"
