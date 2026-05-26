# modules/lxc

_Stub — not yet implemented._

Will provision a Proxmox LXC container via `proxmox_virtual_environment_container`.

## Planned files

- `main.tf` — `proxmox_virtual_environment_container` resource
- `variables.tf` — Inputs: `container_name`, `vm_id`, `target_node`, `ostemplate`, `cpu`, `memory`, `rootfs_size`, `storage_pool`, network config
- `outputs.tf` — `vm_id`, `ipv4_address`, `name`
