output "vm_id" {
  description = "Proxmox VM ID"
  value       = proxmox_virtual_environment_vm.this.vm_id
}

output "ipv4_address" {
  description = "First non-loopback IPv4 address reported by the guest agent (null until agent is running)"
  value       = try(proxmox_virtual_environment_vm.this.ipv4_addresses[1][0], null)
}

output "name" {
  description = "VM name"
  value       = proxmox_virtual_environment_vm.this.name
}

output "mac_addresses" {
  description = "MAC addresses of all network interfaces"
  value       = proxmox_virtual_environment_vm.this.mac_addresses
}
