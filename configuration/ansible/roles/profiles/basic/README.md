# roles/profiles/basic

Foundation profile — applied to every machine type, directly or as a transitive dependency.

Contains only `meta/main.yml` with role dependencies. No tasks.

## Dependencies

- `features/base_packages` — packages, user accounts, SSH hardening, NTP

## Corresponding machine type

`machine-types/basic/` — 1 core, 1 GB RAM, 20 GB disk.
