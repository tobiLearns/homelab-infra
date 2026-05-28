# deployment/terraform/modules

Reusable Terraform modules. Each module encapsulates one resource type; 
environment components call them via `module` blocks with per-VM or per-container parameters.

## Modules

- `vm/` — Cloud-init VM clone: cpu, memory, disk, cloud-init credentials. Use for all standard VMs provisioned from a cloud image template.
- `lxc/` — LXC container provisioning. _(stub, not yet implemented)_
- `vm-iso/` — ISO-boot VM with no cloud-init. Use for VMs like OPNsense that require an installer ISO and multiple NICs. _(stub, not yet implemented)_

## Conventions

Each module contains: `main.tf`, `variables.tf`, `outputs.tf`.

Do not add ISO-boot or multi-NIC behaviour to `modules/vm` via conditionals — structural differences warrant a separate module.
