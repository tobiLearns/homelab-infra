# machine-types/desktop

Blueprint for a desktop machine: XFCE environment, VNC server for remote access, IDE.

## Terraform specs (defined in `environments/*/vms/locals.tf`)

| Resource | Value |
|----------|-------|
| CPU cores | 4 |
| Memory | 8 GB |
| Disk | 50 GB |

## Ansible profile

`roles/profiles/desktop` — applies `basic` + `features/desktop` + `features/vnc` + `features/ide`.
