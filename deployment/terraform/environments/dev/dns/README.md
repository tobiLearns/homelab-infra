# environments/dev/dns

_Stub — not yet implemented._

Will provision a single LXC for DNS in the dev environment (Technitium or BIND). Terraform provisions the container shell only; Ansible (`configuration/ansible`) configures the DNS server software.

Apply this component before `vms/` and `lxcs/` — hosts depend on DNS resolution.
