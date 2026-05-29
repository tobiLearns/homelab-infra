# devops-vm

|                      |                                         |
|----------------------|-----------------------------------------|
| **Environment**      | dev                                     |
| **IP**               | 10.1.2.164                              |
| **VM ID**            | 100                                     |
| **Terraform type**   | large (6 cores, 12 GB RAM, 50 GB disk) |
| **Ansible playbook** | `playbooks/devops.yml`                  |

## Ansible profiles applied

| Role                   | Provides                                                           |
|------------------------|--------------------------------------------------------------------|
| `profiles/desktop`     | snap removal, base packages, XFCE, LightDM, VNC, VS Code, IntelliJ |
| `profiles/devops`      | Docker, kubectl, Helm, k9s, Terraform, Ansible, Git                |
| `features/user_config` | shell config, dotfiles, SSH keys                                   |
| `features/nfs_mounts`  | NFS home directories mounted at boot                               |
