# roles/profiles/devops

DevOps workstation profile: container runtime, Kubernetes tooling, IaC tools, Git.

Contains only `meta/main.yml` with role dependencies. No tasks.

## Dependencies

- `profiles/basic`
- `features/docker`
- `features/kubectl`
- `features/iac_tools` — Terraform, Ansible
- `features/git`

## Corresponding machine type

`machine-types/devops/` — 6 cores, 12 GB RAM, 50 GB disk.
