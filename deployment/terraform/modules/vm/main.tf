resource "proxmox_virtual_environment_vm" "this" {
  name      = var.vm_name
  node_name = var.target_node
  vm_id     = var.vm_id

  clone {
    vm_id = var.template_id
    full  = true
  }

  started       = false
  on_boot       = false
  tablet_device = var.tablet_device

  agent {
    enabled = true
    trim    = true
  }

  cpu {
    cores   = var.cpu_cores
    sockets = 1
    type    = "host"
  }

  memory {
    dedicated = var.memory
  }

  # virtio-scsi-single gives each disk its own controller and IOThread,
  # which reduces latency under heavy I/O compared to shared virtio-scsi.
  scsi_hardware = "virtio-scsi-single"

  disk {
    datastore_id = var.storage_pool
    interface    = "scsi0"
    size         = var.disk_size
    file_format  = "raw"
    discard      = "on"
    ssd          = true
    iothread     = true
  }

  vga {
    type   = "virtio"
    memory = 256
  }

  initialization {
    user_account {
      username = var.vm_username
      password = var.vm_password
      keys     = var.ssh_public_keys
    }
    datastore_id = var.cloud_init_datastore
    interface    = "ide2"
  }

  lifecycle {
    ignore_changes = [network_device]
  }
}
