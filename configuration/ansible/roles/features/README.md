# roles/features

Atomic Ansible feature roles — one capability each. These roles are reusable across machine types and are the implementation layer; profile roles (`roles/profiles/`) declare which features to apply.

## Conventions

Each role follows the standard Ansible layout:

```
<role>/
├── defaults/main.yml   # Overridable defaults (lowest precedence)
├── tasks/main.yml      # Role tasks
├── handlers/main.yml   # Handlers triggered by notify
├── templates/          # Jinja2 templates
├── files/              # Static files
├── vars/main.yml       # Internal role variables (not meant for override)
└── meta/main.yml       # Role metadata and dependencies
```

## Planned roles

| Role | Purpose |
|------|---------|
| `base_packages` | Common packages, user accounts, SSH hardening, NTP |
| `docker` | Docker / container runtime |
| `kubectl` | Kubernetes CLI tooling |
| `desktop` | XFCE desktop environment |
| `vnc` | VNC server for remote desktop access |
| `ide` | IDE setup (VS Code, etc.) |
| `snap_removal` | Remove snapd |
| `git` | Git configuration |
| `iac_tools` | Terraform, Ansible, and related tooling |
