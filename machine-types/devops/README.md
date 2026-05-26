# machine-types/devops

Blueprint for a DevOps workstation: Docker, kubectl, Terraform, Ansible, Git, and IDE tooling.

## Terraform specs (defined in `environments/*/vms/locals.tf`)

| Resource | Value |
|----------|-------|
| CPU cores | 6 |
| Memory | 12 GB |
| Disk | 50 GB |

## Ansible profile

`roles/profiles/devops` — applies `basic` + `features/docker` + `features/kubectl` + `features/iac_tools` + `features/git`.
