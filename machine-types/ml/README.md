# machine-types/ml

Blueprint for a machine learning workstation: Docker (for GPU-enabled containers), optional desktop environment, ML tooling.

## Terraform specs (defined in `environments/*/vms/locals.tf`)

| Resource | Value |
|----------|-------|
| CPU cores | 8 |
| Memory | 16 GB |
| Disk | 100 GB |

## Ansible profile

`roles/profiles/ml` — applies `basic` + `features/docker` + ml-specific feature roles (to be defined).
