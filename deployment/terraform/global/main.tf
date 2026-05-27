# Proxmox resource pools — apply this component before any environment component.
# Apply order: global → dns → firewall → vms → lxcs

resource "proxmox_virtual_environment_pool" "dev" {
  pool_id = "dev-pool"
}

resource "proxmox_virtual_environment_pool" "prod" {
  pool_id = "prod-pool"
}
