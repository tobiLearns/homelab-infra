# roles/profiles/basic/meta

Contains `main.yml` — the only file in a profile role. It declares which feature roles this profile depends on via `dependencies:`. 
The profile role itself has no tasks.

## Expected content of main.yml

```yaml
dependencies:
  - role: features/base_packages
```

The `basic` profile is the foundation for all other profiles. Every other profile should declare `basic` as a dependency (directly or transitively).
