# configuration/ansible/playbooks

Thin Ansible playbooks — one per machine profile. Playbooks map host groups to profile roles; the actual work is done in `roles/features/`.

## Planned files

| File | Purpose |
|------|---------|
| `site.yml` | Master playbook: applies the correct profile to all hosts |
| `basic.yml` | Targets hosts in the `basic` profile group |
| `desktop.yml` | Targets hosts in the `desktop` profile group |
| `devops.yml` | Targets hosts in the `devops` profile group |
| `ml.yml` | Targets hosts in the `ml` profile group |

## Usage

```bash
# Apply to all hosts:
ansible-playbook -i inventories/dev playbooks/site.yml

# Apply to one profile:
ansible-playbook -i inventories/dev playbooks/devops.yml
```
