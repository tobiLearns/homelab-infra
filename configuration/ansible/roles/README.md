# configuration/ansible/roles

Two-layer role architecture:

- `features/` — Atomic technical roles, one capability each. These contain actual tasks and are reusable across machine types.
- `profiles/` — Meta-roles with no tasks. They declare which feature roles a machine type depends on via `meta/main.yml`.

## Why two layers

Feature roles stay small and focused: `docker` installs Docker the same way on any host. Profile roles define machine types without duplicating role lists: adding a new feature to the `devops` profile is one line in `profiles/devops/meta/main.yml`, and it propagates to every devops host automatically.
