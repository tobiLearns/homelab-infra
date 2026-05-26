# roles/profiles/desktop

Desktop profile for VMs accessed via VNC with a graphical environment.

Contains only `meta/main.yml` with role dependencies. No tasks.

## Dependencies

- `profiles/basic`
- `features/desktop` — XFCE environment
- `features/vnc` — VNC server for remote access
- `features/ide` — IDE setup

## Corresponding machine type

`machine-types/desktop/` — 4 cores, 8 GB RAM, 50 GB disk.
