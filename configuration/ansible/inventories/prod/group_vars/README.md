# inventories/prod/group_vars

Ansible group variables for the prod environment. Same structure as `dev/group_vars/` but with production values (IPs, domain names, resource limits).

## Files

| File | Applies to |
|------|-----------|
| `all.yml` | All prod hosts |
| `vms.yml` | `vms` group only (prod) |
| `lxcs.yml` | `lxcs` group only (prod) |
