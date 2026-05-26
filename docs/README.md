# docs

Architecture decisions, runbooks, and notes that don't belong in code comments.

## Planned documents

- `proxmox-bridge-setup.md` — How to configure `vmbr0` (WAN) and `vmbr1` (LAN) on the Proxmox host before applying `environments/*/firewall/`. 
   This is a Terraform prerequisite that must be done manually.
- `naming-conventions.md` — VM names, IP ranges, pool names, and other naming decisions.
- `state-migration.md` — How to migrate Terraform state from local backend to GitLab HTTP backend when the GitLab/Forgejo instance is running.
- `apply-order.md` — Full apply order across all components with dependency rationale.
