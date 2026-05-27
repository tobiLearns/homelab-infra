output "vm_ids" {
  description = "Proxmox VM IDs keyed by VM name"
  value       = { for name, vm in module.vm : name => vm.vm_id }
}

output "vm_ips" {
  description = "IPv4 addresses keyed by VM name (requires VM started and guest agent running)"
  value       = { for name, vm in module.vm : name => coalesce(vm.ipv4_address, "not available yet") }
}

output "vm_macs" {
  description = "MAC addresses keyed by VM name"
  value       = { for name, vm in module.vm : name => vm.mac_addresses }
}

output "next_steps" {
  value = <<-EOF
    VMs provisioned: ${join(", ", keys(local.vms))}

    Connect via SSH (after guest agent is running):
    ${join("\n    ", [for name in keys(local.vms) : "ssh ${name}"])}

    Run Ansible:
    ansible-playbook -i deployment/terraform/environments/dev/vms/inventory.ini <playbook>
  EOF
}
