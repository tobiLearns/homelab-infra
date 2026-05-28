# environments/dev/vms

Provisions development VMs by calling `modules/vm` for each entry in `locals.vms`.

## Files

| File                          | Purpose                                                                    |
|-------------------------------|----------------------------------------------------------------------------|
| `providers.tf`                | Provider requirements and `proxmox` provider config                        |
| `backend.tf`                  | Local state backend (commented GitLab HTTP migration path included)        |
| `locals.tf`                   | `machine_types` map and `vms` map — **add new VMs here**                   |
| `variables.tf`                | Input variables: Proxmox connection + cloud-init credentials               |
| `main.tf`                     | Calls `modules/vm` for each VM; generates SSH config and Ansible inventory |
| `outputs.tf`                  | VM IDs, IPs, MACs                                                          |
| `terraform.tfvars`            | Non-secret values (committed)                                              |
| `secrets.auto.tfvars`         | Proxmox API token + VM password + SSH key (**git-ignored, never commit**)  |
| `secrets.auto.tfvars.example` | Documents required secrets (committed)                                     |

## Adding a VM

Edit `locals.tf` and add an entry to the `vms` map:

```hcl
vms = {
  "devops-vm" = { type = "devops", vm_id = 100, tablet_device = true }
  "my-new-vm" = { type = "desktop", vm_id = 101 }
}
```

## First-time setup

```bash
cp secrets.auto.tfvars.example secrets.auto.tfvars
# fill in API token and credentials
terraform init
terraform plan
terraform apply
```
