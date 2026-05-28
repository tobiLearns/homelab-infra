locals {
  machine_types = {
    basic   = { cpu_cores = 1, memory = 1024,  disk_size = 20 }
    desktop = { cpu_cores = 4, memory = 8192,  disk_size = 50 }
    devops  = { cpu_cores = 6, memory = 12288, disk_size = 50 }
    ml      = { cpu_cores = 8, memory = 16384, disk_size = 100 }
  }

  # Add new VMs here. vm_id must be unique across the entire Proxmox host.
  vms = {
    "devops-vm" = { type = "devops", vm_id = 100, tablet_device = true }
  }
}
