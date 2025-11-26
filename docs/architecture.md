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

