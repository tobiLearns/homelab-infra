# configuration/ansible/inventories

Per-environment inventory directories. Each environment has its own `hosts.yml` and `group_vars/`, which enforces strict variable isolation — dev variables cannot leak into prod.

## Environments

- `dev/` — Development hosts: test VMs and LXCs.
- `prod/` — Production hosts: real VMs and LXCs.

## Usage

```bash
# Target dev:
ansible-playbook -i inventories/dev playbooks/site.yml

# Target prod:
ansible-playbook -i inventories/prod playbooks/site.yml
```
