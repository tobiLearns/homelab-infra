# inventories/prod

Production environment inventory.

## Files

| File | Purpose |
|------|---------|
| `hosts.yml` | Production host list, grouped by type (`vms`, `lxcs`) |
| `group_vars/all.yml` | Variables common to all prod hosts |
| `group_vars/vms.yml` | Variables for the `vms` group |
| `group_vars/lxcs.yml` | Variables for the `lxcs` group |

Production group vars typically differ from dev in: IP ranges, domain names, resource limits, and stricter security settings.
