# machine-types

## Purpose

A machine type is a named blueprint that bundles two things together: **how much hardware a VM gets** (Terraform) and **what software it runs** (Ansible). 
The name — `basic`, `desktop`, `devops`, `ml` — is the shared key that ties these two tools together without either tool depending on the other directly.

Without this directory, the hardware specs would live only in Terraform (`locals.tf`) and the software profile would live only in Ansible (`roles/profiles/`). 
There would be no single place to look up "what is a devops machine?" and no guarantee that the two tools agree on what that means.

## How it works in practice

When you provision a new VM, you pick a machine type. That name flows through two independent pipelines:

**1. Terraform (provisioning)** — The `machine_types` map in `deployment/terraform/environments/*/vms/locals.tf` maps each type name to CPU cores, memory, and disk size. 
Terraform uses these values when cloning the VM from the template.

```hcl
# locals.tf
machine_types = {
  devops = { cpu_cores = 6, memory = 12288, disk_size = 50 }
}

vms = {
  "devops-vm" = { type = "devops", vm_id = 100 }
}
```

**2. Ansible (configuration)** — The `configuration/ansible/roles/profiles/<type>/` role declares which feature roles to apply to a host of that type. 
The playbook targets the host and applies its profile role, which pulls in the correct feature roles transitively.

```yaml
# inventories/dev/hosts.yml
devops-vm:
  ansible_host: 192.168.1.11
  machine_type: devops   # used to select the right profile playbook
```

## What lives here

Each subdirectory is a **human-readable reference** — not a source of truth that the tools actually read from.
The real sources of truth are:

- **Hardware specs** (cpu, memory, disk): the `machine_types` map in `deployment/terraform/environments/*/vms/locals.tf`
- **Software profile** (what gets installed): `configuration/ansible/roles/profiles/<type>/meta/main.yml`

This directory exists so there is one place to look up the full picture of a machine type without having to cross-reference two separate tools. Keeping it in sync with `locals.tf` requires discipline — it is documentation, not automation.

When you change a machine type's spec (e.g. bump the devops memory from 12 GB to 16 GB), you:
1. Update `locals.tf` in the relevant Terraform environment (the actual change)
2. Update the numbers here (to keep the docs accurate)

## Types

| Directory  | CPU      | Memory | Disk   | Ansible profile     |
|------------|----------|--------|--------|---------------------|
| `basic/`   | 1 core   | 1 GB   | 20 GB  | `profiles/basic`    |
| `desktop/` | 4 cores  | 8 GB   | 50 GB  | `profiles/desktop`  |
| `devops/`  | 6 cores  | 12 GB  | 50 GB  | `profiles/devops`   |
| `ml/`      | 8 cores  | 16 GB  | 100 GB | `profiles/ml`       |
