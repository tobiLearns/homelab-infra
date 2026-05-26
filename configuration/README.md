# configuration

System configuration for all homelab machines. Separate from `deployment/` (which provisions infrastructure) — Terraform creates the VMs and LXCs; this directory configures what runs on them.

## Contents

- `ansible/` — Ansible roles, playbooks, and inventories for OS-level configuration.

The `configuration/` wrapper is intentionally generic: future tools (Kubernetes manifests, Helm charts, etc.) would sit alongside `ansible/` here without restructuring the monorepo.
