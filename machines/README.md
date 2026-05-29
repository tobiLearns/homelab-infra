# machines

Documentation of deployed VM instances. Each file describes one VM: what hardware Terraform provisioned and what software Ansible configured.

## Why this exists

A deployed VM is defined by two independent dimensions:

- **Hardware** — CPU, memory, disk; defined as named types in `deployment/terraform/environments/*/vms/locals.tf`
- **Software** — what playbook and profiles were applied; defined in `configuration/ansible/playbooks/`

Neither tool has a complete picture on its own. This directory is the single place to look up the full configuration of a running VM without cross-referencing both tools.

## Terraform hardware types

Defined in `deployment/terraform/environments/*/vms/locals.tf`. Referenced here by name only — the authoritative numbers live there.

| Type     | CPU     | Memory | Disk   | Typical use                          |
|----------|---------|--------|--------|--------------------------------------|
| small    | 2 cores | 4 GB   | 20 GB  | try-out VMs, LXCs, k8s control plane |
| medium   | 4 cores | 8 GB   | 50 GB  | k8s workers, desktop VMs             |
| large    | 6 cores | 12 GB  | 50 GB  | devops workstation                   |
| xlarge   | 8 cores | 16 GB  | 100 GB | ML workloads                         |

## Ansible profiles

Defined in `configuration/ansible/roles/profiles/`. Each profile composes a set of feature roles.

| Profile            | Features included                                                  |
|--------------------|--------------------------------------------------------------------|
| `profiles/basic`   | `snap_removal`, `base_packages`                                    |
| `profiles/desktop` | `basic` + `desktop`, `vnc`, `ide`                                  |
| `profiles/devops`  | `basic` + `docker`, `kubectl`, `iac_tools`, `git`                  |
| `profiles/ml`      | `basic` + `docker`, `desktop`                                      |

## Ansible feature roles

Defined in `configuration/ansible/roles/features/`. Building blocks consumed by profiles.

| Feature                  | What it installs / configures                              |
|--------------------------|------------------------------------------------------------|
| `features/snap_removal`  | Removes snapd; adds Mozilla APT repo for Firefox           |
| `features/base_packages` | Essential CLI tools installed on every host                |
| `features/desktop`       | XFCE desktop, LightDM, user XFCE settings                  |
| `features/vnc`           | TigerVNC server + systemd service                          |
| `features/ide`           | VS Code (with extensions), IntelliJ IDEA                   |
| `features/docker`        | Docker container runtime                                   |
| `features/kubectl`       | kubectl, Helm, k9s                                         |
| `features/iac_tools`     | Terraform, Ansible                                         |
| `features/git`           | Git configuration for the workstation user                 |
| `features/user_config`   | Shell aliases, vim/tmux dotfiles, workspace directories    |
| `features/nfs_mounts`    | NFS home directories configured in fstab                   |

## Deployed VMs

| File                            | Environment | Terraform type | Ansible playbook      |
|---------------------------------|-------------|----------------|-----------------------|
| [devops-vm.md](devops-vm.md)    | dev         | large          | playbooks/devops.yml  |
