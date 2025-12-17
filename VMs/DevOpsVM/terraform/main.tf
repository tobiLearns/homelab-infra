terraform {
  required_version = ">= 1.0"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.70"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_api_url
  
  # API Token as combined String: "USER@REALM!TOKENID=SECRET"
  api_token = "${var.proxmox_api_token_id}=${var.proxmox_api_token_secret}"
  
  insecure = true  # For self-signed certificates; set to false in production with valid certs
  
  # SSH-Configuration (optional)
  ssh {
    agent = false
  }
}

# Clone VM ressource from template
resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  count = var.vm_count
  
  # Basic-Configuration
  name        = "${var.vm_name}-${count.index + 1}"
  node_name   = var.target_node
  
  # Clone template
  clone {
    vm_id = var.template_id  # ID of template-VM in Proxmox
    full  = true
  }
  
  # Set to 'true', if the VM shall start automatically after 'terraform apply':
  started = true
  on_boot = false
  
  # Agent
  agent {
    enabled = true
  }
  
# These settings will be inherited from the template, but they can be overridden
  # If not set, the template values will be used
  
  # CPU (optional - overrides template)
  cpu {
    cores = var.cores
    sockets = 1
    type = "host"
  }
  
  # Memory (optional - overrides template)
  memory {
    dedicated = var.memory
  }
  
  # Disk (optional - overrides or extends template disk)
  disk {
    datastore_id = var.storage_pool
    interface    = "scsi0"
    size         = var.disk_size
    file_format  = "raw"
    discard      = "on"
    ssd          = true
    iothread     = true # Improves I/O performance
  }
  
  vga {
    type = "virtio"
    memory = 256  # Optional, ist eh Default bei VirtIO
  }
  
  # Network (optional - overrides template)
  # network_device {
  #   bridge = "vmbr0"
  #   model  = "virtio"
  # }
  
  # Cloud-Init configuration
  # If the template already has Cloud-Init configured, these values will be used
  # Here, specific values per VM can be set

  # IP configuration (optional)
  initialization {
    # ip_config {
    #   ipv4 {
    #     address = "dhcp"
    #   }
    # }
    # Or static IP:
    # ip_config {
    #   ipv4 {
    #     address = "192.168.1.${100 + count.index}/24"
    #     gateway = "192.168.1.1"
    #   }
    # }
    
    # DNS (optional)
    # dns {
    #   servers = ["8.8.8.8", "8.8.4.4"]
    #   domain  = "local"
    # }
    
    # User-Account (optional)
    user_account {
      username = var.vm_username
      password = var.vm_password
      keys     = var.ssh_public_key != "" ? [var.ssh_public_key] : []
    }
    
    # Datastore for Cloud-Init disk
    # datastore_id = "local-lvm"
  }
  
  # Lifecycle configuration
  lifecycle {
    ignore_changes = [
      network_device,
    ]
  }
}

# Outputs
output "vm_ids" {
  description = "IDs of generated VMs"
  value       = proxmox_virtual_environment_vm.ubuntu_vm[*].vm_id
}

output "vm_names" {
  description = "Names of generated VMs"
  value       = proxmox_virtual_environment_vm.ubuntu_vm[*].name
}

output "vm_ips" {
  description = "IP addresses of VMs (requires VM to be started and agent running)"
  value       = [for vm in proxmox_virtual_environment_vm.ubuntu_vm : 
    vm.started ? try(vm.ipv4_addresses[1][0], "Not available yet") : "VM not started"
  ]
}

output "vm_macs" {
  description = "MAC addresses of VMs (agent must be running for accurate values)"
  value       = proxmox_virtual_environment_vm.ubuntu_vm[*].mac_addresses
}



# SSH-Config: One file per VM
resource "local_file" "ssh_config" {
  # Note: We do NOT wait for guest-agent / IP here. The previous implementation
  # used a temporary wait to let the guest-agent report an IP, but that didn't work.
  # Generated files will therefore contain IP `0.0.0.0` and have to be adjusted manually.
  # The real IPs will be discovered and written later by the pipeline.
  #
  # This keeps VM creation fast and delegates IP discovery to the pipeline.
  count = var.vm_count
  
  filename = pathexpand("~/.ssh/config.d/terraform-vm-${proxmox_virtual_environment_vm.ubuntu_vm[count.index].vm_id}")
  
  content = <<-EOF
    # Managed by Terraform
    # VM ID: ${proxmox_virtual_environment_vm.ubuntu_vm[count.index].vm_id}
    # VM: ${proxmox_virtual_environment_vm.ubuntu_vm[count.index].name}
    # Created: ${timestamp()}

    Host ${proxmox_virtual_environment_vm.ubuntu_vm[count.index].name}
        HostName ${try(proxmox_virtual_environment_vm.ubuntu_vm[count.index].ipv4_addresses[1][0], "0.0.0.0")}
        User ${var.vm_username}
        IdentityFile ~/.ssh/id_ed25519_vm_access
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null
  EOF
  
  file_permission = "0600"
}

# Ansible Inventory: One file for all VMs
resource "local_file" "ansible_inventory" {
  # See ssh_config note above.
  filename = "${path.module}/inventory.ini"
  
  content = <<-EOF
[vms]
${join("\n", [for vm in proxmox_virtual_environment_vm.ubuntu_vm : 
  "${vm.name} ansible_host=${try(vm.ipv4_addresses[1][0], "0.0.0.0")}"
])}

[vms:vars]
ansible_user=${var.vm_username}
ansible_ssh_private_key_file=~/.ssh/id_ed25519_vm_access
ansible_python_interpreter=/usr/bin/python3
  EOF
  
  file_permission = "0644"
}

# Helping Output
output "next_steps" {
  value = <<-EOF
    ✅ Created ${var.vm_count} VMs
    
    SSH Config files:
    ${join("\n    ", [for i in range(var.vm_count) : "~/.ssh/config.d/terraform-vm-${proxmox_virtual_environment_vm.ubuntu_vm[i].vm_id}"])}
    
    Connect via:
    ${join("\n    ", [for vm in proxmox_virtual_environment_vm.ubuntu_vm : "ssh ${vm.name}"])}
    
    Run Ansible:
    cd ${path.module}
    ansible-playbook -i inventory.ini playbook.yml
  EOF
}
