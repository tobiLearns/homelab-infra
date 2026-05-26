# environments/dev

Development environment. Each subdirectory is an independent Terraform root module with its own state file.

## Components

| Directory   | Purpose                                     | Status      |
|-------------|---------------------------------------------|-------------|
| `vms/`      | General-purpose VMs (devops, desktop, etc.) | implemented |
| `lxcs/`     | LXC containers                              | stub        |
| `dns/`      | DNS server LXC (Technitium or BIND)         | stub        |
| `firewall/` | Software firewall VM (optional in dev)      | stub        |

Apply order: `dns → firewall → vms → lxcs` (after `global/` is applied).
