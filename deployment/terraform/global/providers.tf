terraform {
  required_version = ">= 1.0"
  required_providers {
    proxmox = {
      # Note: The proxmox provider is also defined in 'environments/.../providers.tf'! All versions should be the same!
      source  = "bpg/proxmox"
      version = "~> 0.107"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = "${var.proxmox_api_token_id}=${var.proxmox_api_token_secret}"
  insecure  = true

  ssh {
    agent = false
  }
}
