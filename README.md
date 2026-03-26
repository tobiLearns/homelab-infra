# Homelab Infrastructure

This repository defines infrastructure components, which can be deployed on a Proxmox host.
Deployment of VMs is realized with terraform by cloning a VM from a prepared VM-template.
Configuration of the VM is realized with Ansible.

Next step will be to restructure the repo to obtain a better reusability of certain modules 
and to organize code for different types of VMs and LXCs.
