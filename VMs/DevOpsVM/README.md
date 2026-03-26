# DevOps VM

Terraform configuration to create a DevOps workstation VM on Proxmox.

### Requirements
- Proxmox API credentials
- A cloud-init-enabled template
- SSH key pair available in `~/.ssh/id_ed25519.pub`

### Usage
```bash
cd terraform
terraform init
terraform plan
terraform apply
