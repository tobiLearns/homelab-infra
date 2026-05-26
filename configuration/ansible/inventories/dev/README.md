# inventories/dev

Development environment inventory.

## Files

| File | Purpose |
|------|---------|
| `hosts.yml` | Dev host list, grouped by type (`vms`, `lxcs`) |
| `group_vars/all.yml` | Variables common to all dev hosts |
| `group_vars/vms.yml` | Variables for the `vms` group |
| `group_vars/lxcs.yml` | Variables for the `lxcs` group |

## hosts.yml structure

```yaml
all:
  children:
    vms:
      hosts:
        devops-vm:
          ansible_host: 192.168.x.x
    lxcs:
      hosts: {}
```
