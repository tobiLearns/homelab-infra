# deployment/terraform/environments

Per-environment Terraform root modules. Each subdirectory is fully independent: its own provider config, backend, and state file.

## Environments

- `dev/` — Development environment. Used for testing changes before promoting to prod.
- `prod/` — Production environment. Applies require a manual CI/CD gate.

## Component apply order (per environment)

```
global/ → dns/ → firewall/ → vms/ → lxcs/
```

Run `terraform init` and `terraform apply` from within a specific component directory (e.g. `dev/vms/`), not from here.
