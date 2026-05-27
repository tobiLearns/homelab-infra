variable "vm_name" {
  description = "Name of the VM in Proxmox"
  type        = string
}

variable "vm_id" {
  description = "Unique VM ID in Proxmox"
  type        = number
}

variable "target_node" {
  description = "Proxmox node name"
  type        = string
}

variable "template_id" {
  description = "ID of the Proxmox template VM to clone"
  type        = number
}

variable "cpu_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 20
}

variable "storage_pool" {
  description = "Proxmox storage pool for the VM disk"
  type        = string
  default     = "local-zfs"
}

variable "cloud_init_datastore" {
  description = "Datastore for the cloud-init drive"
  type        = string
  default     = "local-zfs"
}

variable "vm_username" {
  description = "Cloud-init username"
  type        = string
  default     = "ubuntu"
}

variable "vm_password" {
  description = "Cloud-init user password (for console access)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "ssh_public_keys" {
  description = "SSH public keys to inject via cloud-init"
  type        = list(string)
  default     = []
}

variable "tablet_device" {
  description = "Enable tablet input device (recommended with desktop environments)"
  type        = bool
  default     = false
}
