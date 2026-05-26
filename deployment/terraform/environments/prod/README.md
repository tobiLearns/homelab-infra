# environments/prod

Production environment. Same component structure as `dev/`, but with production-scale specs in each `locals.tf` and a manual CI/CD gate on `terraform apply`.

## Components

| Directory | Purpose | Status |
|-----------|---------|--------|
| `vms/` | Production VMs | stub |
| `lxcs/` | Production LXC containers | stub |
| `dns/` | Production DNS LXC | stub |
| `firewall/` | OPNsense VM (WAN + LAN NICs, ISO boot) | stub |

Apply order: `dns → firewall → vms → lxcs` (after `global/` is applied).
