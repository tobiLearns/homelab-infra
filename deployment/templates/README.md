# deployment/templates

Proxmox VM template creation scripts. The VM template is a hard prerequisite for all Terraform VM provisioning — `modules/vm` clones from it, so it must exist on the Proxmox host before any `terraform apply`.

## Files

- `build-template-vm.sh` — Downloads a cloud image (Ubuntu), creates a Proxmox VM, attaches the image, configures a cloud-init drive, and converts the VM to a template.
- `build-pbs-template.sh` — Variant for Proxmox Backup Server template creation.

## Usage

Run once on (or directed at) the Proxmox host:

```bash
./build-template-vm.sh
```

The resulting template VM ID must match the `template_id` variable in
`deployment/terraform/environments/*/vms/terraform.tfvars`.
