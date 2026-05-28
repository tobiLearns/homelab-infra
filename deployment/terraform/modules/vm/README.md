# modules/vm

Provisions a Proxmox VM by cloning a cloud-init template. All standard VMs (basic, desktop, devops, ml types) use this module.

## Files

| File | Purpose |
|------|---------|
| `main.tf` | `proxmox_virtual_environment_vm` resource |
| `variables.tf` | All module inputs (see below) |
| `outputs.tf` | `vm_id`, `ipv4_address`, `name`, `mac_addresses` |

## Inputs

| Variable | Type | Description |
|----------|------|-------------|
| `vm_name` | string | VM name in Proxmox |
| `vm_id` | number | Unique VM ID (must not clash with other VMs on the host) |
| `target_node` | string | Proxmox node name |
| `template_id` | number | ID of the template to clone (created by `deployment/templates/`) |
| `cpu_cores` | number | CPU cores |
| `memory` | number | Memory in MB |
| `disk_size` | number | Disk size in GB |
| `storage_pool` | string | Proxmox storage pool for the disk |
| `cloud_init_datastore` | string | Datastore for the cloud-init drive |
| `vm_username` | string | Cloud-init username |
| `vm_password` | string | Cloud-init password (sensitive) |
| `ssh_public_keys` | list(string) | SSH public keys injected via cloud-init |
| `tablet_device` | bool | Enable tablet input (recommended for desktop VMs) |

## Usage

```hcl
module "vm" {
  source   = "../../../modules/vm"
  for_each = local.vms

  vm_name   = each.key
  vm_id     = each.value.vm_id
  cpu_cores = local.machine_types[each.value.type].cpu_cores
  memory    = local.machine_types[each.value.type].memory
  disk_size = local.machine_types[each.value.type].disk_size
  # ... other vars from variables.tf
}
```
