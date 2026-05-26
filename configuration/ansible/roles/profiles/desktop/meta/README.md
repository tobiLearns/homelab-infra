# roles/profiles/desktop/meta

Contains `main.yml` declaring feature dependencies for the `desktop` profile. No tasks — profiles are declaration-only.

## Expected content of main.yml

```yaml
dependencies:
  - role: profiles/basic
  - role: features/desktop
  - role: features/vnc
  - role: features/ide
```
