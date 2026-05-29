# Homelab Infrastructure

This repository defines infrastructure components, which can be deployed on a Proxmox host.
Deployment of VMs is realized with terraform by cloning a VM from a prepared VM-template.
Configuration of the VM is realized with Ansible.

The repository is now structured in deployment/ and configuration/, 
and separates between development and production environment.  

Next step will be to deploy/configure more/different VMs and to make use of the production environment.
Also, a further reduction of code duplication in the terraform directory between the two environments is suitable.
Therefor the usage of terragrunt would be one possibility.
