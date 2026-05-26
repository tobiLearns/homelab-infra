# deployment

Infrastructure provisioning for the homelab.

## Contents

- `templates/` — Shell scripts for creating the Proxmox VM template that Terraform clones from. Run these manually once before any `terraform apply`.
- `terraform/` — Terraform modules and per-environment root modules for VM and LXC provisioning.
