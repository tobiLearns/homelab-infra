terraform {
  required_version = ">= 1.0"
  required_providers {
    proxmox = {
      # Note: The proxmox provider is also defined in 'global/providers.tf'! All versions should be the same!
      source  = "bpg/proxmox"
      version = "~> 0.107"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_api_url
  api_token = "${var.proxmox_api_token_id}=${var.proxmox_api_token_secret}"
  insecure  = true # Self-signed cert on Proxmox; set to false with a valid cert

  ssh {
    agent = false
  }
}
