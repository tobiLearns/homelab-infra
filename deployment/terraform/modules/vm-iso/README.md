# modules/vm-iso

_Stub — not yet implemented._

Intended for VMs that boot from an ISO installer rather than a cloud-init template clone. The canonical use case is OPNsense, which requires:

- A `cdrom` block instead of `initialization` (no cloud-init)
- Multiple network interfaces (WAN bridge + LAN bridge)
- ISO attachment for the installer

These structural differences mean ISO-boot VMs cannot share `modules/vm` via conditionals — a separate module is the correct approach.

## Planned files

- `main.tf` — `proxmox_virtual_environment_vm` resource with ISO/CDROM and multi-NIC layout
- `variables.tf` — Inputs: `vm_name`, `vm_id`, `target_node`, `iso_file`, `wan_bridge`, `lan_bridge`, `cpu_cores`, `memory`, `disk_size`, `storage_pool`
- `outputs.tf` — `vm_id`, `name`
