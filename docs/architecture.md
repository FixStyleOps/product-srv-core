# product-srv Architecture

The product-srv core is a modular, isolated service environment containing
independent components:

## Zones
The system operates with 3 abstract internal zones:

- **alpha** — base layer
- **beta** — mirror layer
- **gamma** — extended layer

These names do not represent real locations and are used only for internal structure.

## Components

### Access Limiter
Entry-level rate control, protecting from traffic bursts.

### Firewall Guard
Lightweight request filter:
- user-agent rules
- basic traffic sanitization

### Web Auth
Minimal entry service for module access.

### Sync Layer
Background zone-to-zone synchronization (randomized external port).

### Backup Layer
Local storage for container-level data.

### Structure


docker/
access-limiter/
firewall-guard/
web-auth/
backup-local/
resource-control/
zone-sync/

installer/
install_step0_cleanup.sh
install_step1_structure.sh
install_step2_compose.sh
install_step3_saz.sh
install_step4_web_auth.sh
install_step5_firewall_guard.sh
install_step6_backup_local.sh
install_step7_ports_map.sh
install_step8_limiters.sh
install_step9_sync.sh
install_step10_finalize.sh

ports/
product-srv-ports.sh


All modules run independently and communicate only through internal docker networks.


