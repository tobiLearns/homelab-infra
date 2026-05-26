# roles/profiles/devops/meta

Contains `main.yml` declaring feature dependencies for the `devops` profile. No tasks — profiles are declaration-only.

## Expected content of main.yml

```yaml
dependencies:
  - role: profiles/basic
  - role: features/docker
  - role: features/kubectl
  - role: features/iac_tools
  - role: features/git
```
