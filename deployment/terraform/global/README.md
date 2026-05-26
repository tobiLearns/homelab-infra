# deployment/terraform/global

Proxmox-level resources shared across all environments: resource pools (`dev-pool`, `prod-pool`).

**Apply this component first** — pools must exist before any VM or LXC is assigned to them.

## Files

| File | Purpose |
|------|---------|
| `main.tf` | `proxmox_virtual_environment_pool` resources for dev and prod |
| `providers.tf` | Provider requirements and `proxmox` provider config |
| `backend.tf` | Local state backend (state key: `global`) |
| `variables.tf` | Proxmox connection variables |
| `terraform.tfvars` | Non-secret values: API URL (committed) |
| `secrets.auto.tfvars` | API token (**git-ignored, never commit**) |

## Usage

```bash
cp ../environments/dev/vms/secrets.auto.tfvars.example secrets.auto.tfvars
# fill in API token
terraform init
terraform apply
```
