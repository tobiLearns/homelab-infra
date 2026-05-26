# inventories/dev/group_vars

Ansible group variables for the dev environment. These override `all.yml` for specific host groups.

## Files

| File | Applies to |
|------|-----------|
| `all.yml` | All dev hosts |
| `vms.yml` | `vms` group only (dev) |
| `lxcs.yml` | `lxcs` group only (dev) |

Variables here override defaults set in role `defaults/main.yml` but are overridden by host vars and extra vars.
