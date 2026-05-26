# roles/profiles

Meta-roles that define machine types. Each profile role contains only `meta/main.yml` with a `dependencies:` list — no tasks. Applying a profile to a host pulls in the correct feature roles transitively.

## Profiles

| Profile | Intended machine |
|---------|-----------------|
| `basic/` | Minimal VM: base packages, SSH hardening, NTP |
| `desktop/` | Desktop VM: XFCE + VNC + IDE |
| `devops/` | DevOps workstation: Docker + kubectl + IaC tools |
| `ml/` | ML workstation: Docker + GPU tooling |

## Adding a new profile

Create a directory with a single `meta/main.yml`:

```bash
mkdir -p roles/profiles/<name>/meta
```

```yaml
# meta/main.yml
dependencies:
  - role: profiles/basic
  - role: features/<feature>
```

Then add a matching playbook in `playbooks/` and a machine-type spec in `machine-types/`.
