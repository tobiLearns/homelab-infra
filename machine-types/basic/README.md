# machine-types/basic

Bdlueprint for a minimal machine: base system, hardened SSH, NTP, common packages. No desktop environment, no container runtime.

## Terraform specs (defined in `environments/*/vms/locals.tf`)

| Resource | Value |
|----------|-------|
| CPU cores | 1 |
| Memory | 1 GB |
| Disk | 20 GB |

## Ansible profile

`roles/profiles/basic` — applies `features/base_packages` only.
