locals {
  machine_types = {
    small  = { cpu_cores = 2, memory = 4096,  disk_size = 20  }
    medium = { cpu_cores = 4, memory = 8192,  disk_size = 50  }
    large  = { cpu_cores = 6, memory = 12288, disk_size = 50  }
    xlarge = { cpu_cores = 8, memory = 16384, disk_size = 100 }
  }

  # Add new VMs here. vm_id must be unique across the entire Proxmox host.
  vms = {
    "devops-vm" = { type = "large", vm_id = 100, tablet_device = true }
  }
}
