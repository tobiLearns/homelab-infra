# deployment/terraform

Terraform configuration for Proxmox infrastructure provisioning.

## Layout

- `modules/` — Reusable resource modules. Defined once; called from environment components.
- `environments/` — Per-environment root modules, each with its own Terraform state file.
- `global/` — Proxmox-level resources shared across all environments (resource pools).

## Apply order

```
global → dns → firewall → vms → lxcs
```

Each directory under `environments/` is an independent Terraform root module. 
Run `terraform init` and `terraform apply` from within the target component directory, not from here.

## Secrets

Each component keeps secrets in `secrets.auto.tfvars` (git-ignored). 
Copy `secrets.auto.tfvars.example` and fill in values before the first `terraform init`.
