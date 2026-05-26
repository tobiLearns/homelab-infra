# roles/profiles/ml

Machine learning workstation profile: Docker for GPU-enabled containers, optional desktop.

Contains only `meta/main.yml` with role dependencies. No tasks.

## Dependencies

- `profiles/basic`
- `features/docker`
- _(add ML-specific feature roles here, e.g. `features/cuda`, `features/jupyter`)_

## Corresponding machine type

`machine-types/ml/` — 8 cores, 16 GB RAM, 100 GB disk.
