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

variable "vm_count" {
  description = "Anzahl der zu erstellenden VMs"
  type        = number
  default     = 1
}

# Clone VM ressource from template
resource "proxmox_virtual_environment_vm" "ubuntu_vm" {
  count = var.vm_count
  
  # Basic-Configuration
  name        = "${var.vm_name}-${count.index + 1}"
  node_name   = var.target_node
  
  # Clone template
  clone {
    vm_id = 9000  # ID of template-VM in Proxmox
    full  = true
  }
  
  # Set to 'true', if the VM shall start automatically after 'terraform apply':
  started = false
  on_boot = false
  
  # Agent
  agent {
    enabled = true
  }
  
# These settings will be inherited from the template, but they can be overridden
  # If not set, the template values will be used
  
  # CPU (optional - overrides template)
  # cpu {
  #   cores = 2
  #   sockets = 1
  #   type = "host"
  # }
  
  # Memory (optional - overrides template)
  # memory {
  #   dedicated = 2048
  # }
  
  # Disk (optional - overrides or extends template disk)
  # disk {
  #   datastore_id = "local-lvm"
  #   interface    = "scsi0"
  #   size         = 20
  #   file_format  = "raw"
  #   discard      = "on"
  #   ssd          = true
  #   iothread     = true
  # }
  
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
    # user_account {
    #   username = "ubuntu"
    #   password = var.vm_password
    #   keys     = var.ssh_public_key != "" ? [var.ssh_public_key] : []
    # }
    
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
  description = "IP addresses of VMs (if available via Proxmox Agent)"
  value       = [for vm in proxmox_virtual_environment_vm.ubuntu_vm : try(vm.ipv4_addresses[1][0], "N/A")]
}