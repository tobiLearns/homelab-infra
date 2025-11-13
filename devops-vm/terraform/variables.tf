variable "proxmox_api_url" {
  description = "The URL of the Proxmox API"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "Token ID for Proxmox API authentication"
  type        = string
  sensitive   = true
}

variable "proxmox_api_token_secret" {
  description = "Token secret for Proxmox API authentication"
  type        = string
  sensitive   = true
}

variable "vm_count" {
  description = "Anzahl der zu erstellenden VMs"
  type        = number
  default     = 1
}

variable "vm_name" {
  description = "Name of the VM to be created"
  type        = string
  default     = "devops-vm"
}

variable "target_node" {
  description = "Name of the Proxmox node where the VM will be created"
  type        = string
}

variable "template_id" {
  description = "Template VM ID"
  type        = number
  default     = 7000
}

variable "vm_username" {
  description = "Name of the user to be created"
  type        = string
  default     = "ubuntu"
}

variable "vm_password" {
  description = "Password for VM user (for console/GUI access)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "ssh_public_key" {
  description = "SSH Public Key für Cloud-Init"
  type        = string
  default     = ""
}

variable "vm_description" {
  description = "Description of the VM"
  type        = string
  default     = "DevOps VM created by Terraform"
}

variable "memory" {
  description = "Amount of memory in MB"
  type        = number
  default     = 4096
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = string
  default     = "32"
}

variable "storage_pool" {
  description = "Name of the storage pool"
  type        = string
  default     = "local-lvm"
}

variable "vmid" {
  description = "The ID for the VM in Proxmox (must be unique)"
  type        = number
  default     = 200  # You might want to override this in your tfvars file
}
