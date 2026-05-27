variable "proxmox_api_url" {
  description = "Proxmox API endpoint URL"
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
