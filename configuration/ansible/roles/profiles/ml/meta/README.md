# roles/profiles/ml/meta

Contains `main.yml` declaring feature dependencies for the `ml` (machine learning) profile. No tasks — profiles are declaration-only.

## Expected content of main.yml

```yaml
dependencies:
  - role: profiles/basic
  - role: features/docker
  - role: features/desktop   # optional: for GUI tooling
  # add ml-specific feature roles here (e.g. features/cuda, features/jupyter)
```
