# configuration/ansible

Ansible project for OS-level configuration of all homelab VMs and LXC containers.

## Layout

| Directory | Purpose |
|-----------|---------|
| `inventories/` | Per-environment host lists and group variables |
| `roles/features/` | Atomic capability roles (docker, desktop, kubectl, …) |
| `roles/profiles/` | Meta-roles that declare which features a machine type needs |
| `playbooks/` | Thin playbooks — one per machine profile |

## Key files (to be created)

| File | Purpose |
|------|---------|
| `ansible.cfg` | Project-level config: inventory path, roles path, remote user, SSH key |
| `requirements.yml` | Collection dependencies (`ansible-galaxy install -r requirements.yml`) |
| `.vault_pass` | Local vault password file (**git-ignored**) |

## Quick start

```bash
ansible-galaxy collection install -r requirements.yml
ansible-playbook -i inventories/dev playbooks/site.yml
```
