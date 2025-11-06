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

variable "ssh_public_key" {
  description = "SSH Public Key für Cloud-Init"
  type        = string
  default     = ""
}

variable "template_name" {
  description = "Name of the VM template to clone from"
  type        = string
  default     = "ubuntu-cloud-template"
}

variable "target_node" {
  description = "Name of the Proxmox node where the VM will be created"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM to be created"
  type        = string
  default     = "devops-vm"
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
  description = "Disk size in GB (must end with G, M, or K)"
  type        = string
  default     = "32G"
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
