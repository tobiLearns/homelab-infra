# HomeLabIaC_DevOps-VM

# DevOps VM Infrastructure

Terraform configuration to create a DevOps workstation VM on Proxmox.

### Requirements
- Proxmox API credentials
- A cloud-init-enabled template
- SSH key pair available in `~/.ssh/id_ed25519.pub`

### Usage
```bash
cd terraform
terraform init
terraform plan
terraform apply

Homelab/
├── README.md
│
├── Deployment/                     # Infrastruktur-Erzeugung (Terraform)
│   └── terraform/
│       ├── modules/                # Wiederverwendbare Terraform-Module
│       │   ├── proxmox_vm/
│       │   │   ├── main.tf
│       │   │   ├── variables.tf
│       │   │   └── outputs.tf
│       │   │
│       │   ├── lxc/
│       │   │   ├── main.tf
│       │   │   ├── variables.tf
│       │   │   └── outputs.tf
│       │   │
│       │   └── network/
│       │
│       └── stacks/                 # Konkrete Instanzen (= eigene tfstates)
│           ├── devops_vm_01/
│           │   ├── main.tf
│           │   ├── terraform.tfvars
│           │   └── backend.tf       # optional (remote state)
│           │
│           ├── devops_vm_02/
│           │   ├── main.tf
│           │   └── terraform.tfvars
│           │
│           ├── desktop_vm_01/
│           └── lxc_ci_01/
│
├── Configuration/                  # Zielzustand der Systeme (Ansible)
│   └── ansible/
│       ├── ansible.cfg
│       │
│       ├── inventories/
│       │   ├── homelab.yml          # z.B. dynamisch generiert
│       │   ├── dev.yml
│       │   └── prod.yml
│       │
│       ├── playbooks/               # Nach Maschinentyp / Profil
│       │   ├── basic.yml
│       │   ├── desktop.yml
│       │   ├── devops.yml
│       │   └── ml.yml
│       │
│       └── roles/
│           ├── features/            # Kleine, technische Bausteine
│           │   ├── base_packages/
│           │   ├── snap_removal/
│           │   ├── docker/
│           │   ├── kubectl/
│           │   ├── vscode/
│           │   ├── xfce/
│           │   └── vnc/
│           │
│           └── profiles/            # Meta-Roles (Role-Sets)
│               ├── basic/
│               │   └── meta/main.yml
│               ├── desktop/
│               │   └── meta/main.yml
│               ├── devops/
│               │   └── meta/main.yml
│               └── ml/
│                   └── meta/main.yml
│
├── machine-types/                  # Abstrakte Baupläne (keine States!)
│   ├── basic/
│   │   ├── terraform.tfvars         # CPU/RAM/Disk/OS Defaults
│   │   └── README.md
│   │
│   ├── desktop/
│   │   ├── terraform.tfvars
│   │   └── README.md
│   │
│   ├── devops/
│   │   ├── terraform.tfvars
│   │   ├── ansible-vars.yml         # optionale Feature-Toggles
│   │   └── README.md
│   │
│   └── ml/
│       ├── terraform.tfvars
│       └── README.md
│
└── docs/                           # Architektur, Entscheidungen, Notizen
    ├── architecture.md
    ├── naming.md
    └── decisions.md