#!/bin/bash
# product-srv – install_step0_cleanup.sh
# System check, cleanup, pre-install diagnostics

echo "=============================================="
echo " product-srv – Step 0: Environment Cleanup & Checks "
echo "=============================================="

LOG="/opt/product-srv-installer/install_step0.log"
mkdir -p /opt/product-srv-installer
touch $LOG

log() {
    echo "[INFO] $1"
    echo "[INFO] $1" >> $LOG
}

warn() {
    echo "[WARN] $1"
    echo "[WARN] $1" >> $LOG
}

error() {
    echo "[ERROR] $1"
    echo "[ERROR] $1" >> $LOG
}

log "Starting system diagnostics..."

# --- CPU / RAM / DISK ---
log "Checking system resources..."
RAM=$(free -m | awk '/Mem:/ {print $2}')
DISK=$(df -h / | awk 'NR==2 {print $4}')
CPU=$(nproc)

log "CPU cores: $CPU"
log "RAM total: ${RAM}MB"
log "Disk free: ${DISK}"

# --- Basic tools ---
log "Checking required tools..."

for tool in docker docker-compose ss systemctl cron jq curl wget; do
    if ! command -v $tool >/dev/null 2>&1; then
        warn "$tool is not installed"
    else
        log "$tool OK"
    fi
done

# --- Firewall ---
log "Checking firewall rules..."

if ss -tulpn | grep ":80 "; then
    warn "Port 80 is already in use"
fi

if ss -tulpn | grep ":443 "; then
    warn "Port 443 is already in use"
fi

# --- System Update ---
log "Checking for updates..."
apt update -y >> $LOG 2>&1
apt upgrade -y >> $LOG 2>&1

log "System update completed."

log "Diagnostics finished. Log: $LOG"


