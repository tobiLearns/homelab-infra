module "vm" {
  source   = "../../../modules/vm"
  for_each = local.vms

  vm_name      = each.key
  vm_id        = each.value.vm_id
  target_node  = var.target_node
  template_id  = var.template_id
  cpu_cores    = local.machine_types[each.value.type].cpu_cores
  memory       = local.machine_types[each.value.type].memory
  disk_size    = local.machine_types[each.value.type].disk_size
  storage_pool = var.storage_pool
  cloud_init_datastore = var.cloud_init_datastore
  vm_username  = var.vm_username
  vm_password  = var.vm_password
  ssh_public_keys      = var.ssh_public_key != "" ? [var.ssh_public_key] : []
  tablet_device        = try(each.value.tablet_device, false)
}

resource "local_file" "ssh_config" {
  # IPs are not available immediately after VM creation — the guest agent must start first.
  # Files are written with 0.0.0.0 as a placeholder; update manually or via the pipeline.
  for_each = local.vms

  filename = pathexpand("~/.ssh/config.d/terraform-vm-${module.vm[each.key].vm_id}")

  content = <<-EOF
    # Managed by Terraform — do not edit manually
    # VM ID: ${module.vm[each.key].vm_id}

    Host ${each.key}
        HostName ${coalesce(module.vm[each.key].ipv4_address, "0.0.0.0")}
        User ${var.vm_username}
        IdentityFile ~/.ssh/id_ed25519_vm_access
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null
  EOF

  file_permission = "0600"
}

resource "local_file" "ansible_inventory" {
  # See ssh_config note above — IPs may be 0.0.0.0 until the guest agent reports them.
  filename = "${path.module}/inventory.ini"

  content = <<-EOF
[vms]
${join("\n", [for name, vm in module.vm :
  "${name} ansible_host=${coalesce(vm.ipv4_address, "0.0.0.0")}"
])}

[vms:vars]
ansible_user=${var.vm_username}
ansible_ssh_private_key_file=~/.ssh/id_ed25519_vm_access
ansible_python_interpreter=/usr/bin/python3
  EOF

  file_permission = "0644"
}
