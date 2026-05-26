# environments/prod/firewall

_Stub — not yet implemented._

OPNsense VM: ISO boot, two NICs (WAN bridge + LAN bridge), no cloud-init. Defined as a direct resource rather than through a shared module — its block structure (CDROM, multi-NIC) is too different from `modules/vm`.

**Prerequisite:** Proxmox bridge configuration (`vmbr0` for WAN, `vmbr1` for LAN) must be done at the Proxmox host level before applying this component. See `docs/` for details.
