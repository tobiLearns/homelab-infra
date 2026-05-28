# --- Proxmox connection (secrets come from secrets.auto.tfvars, not committed) ---

variable "proxmox_api_url" {
  description = "Proxmox API endpoint URL (e.g. https://10.1.2.10:8006/)"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "Proxmox API token ID — format: USER@REALM!TOKENID"
  type        = string
  sensitive   = true
}

variable "proxmox_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

# --- Proxmox target ---

variable "target_node" {
  description = "Proxmox node name where VMs are created"
  type        = string
}

variable "template_id" {
  description = "ID of the Proxmox template VM to clone (created by deployment/template/create-template.sh)"
  type        = number
  default     = 999
}

variable "storage_pool" {
  description = "Proxmox storage pool for VM disks"
  type        = string
  default     = "local-zfs"
}

variable "cloud_init_datastore" {
  description = "Proxmox datastore for cloud-init drives"
  type        = string
  default     = "local-zfs"
}

# --- Cloud-init credentials (sensitive — provide via secrets.auto.tfvars) ---

variable "vm_username" {
  description = "Cloud-init username created on each VM"
  type        = string
  default     = "ubuntu"
}

variable "vm_password" {
  description = "Cloud-init user password (for console/GUI access)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "ssh_public_key" {
  description = "SSH public key injected via cloud-init (single key string)"
  type        = string
  sensitive   = true
  default     = ""
}
