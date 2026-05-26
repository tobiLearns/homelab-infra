# environments/dev/firewall

_Stub — optional in dev._

A software firewall VM (OPNsense) for the dev environment. May not be needed if the ISP router suffices.

If implemented, it uses a direct resource — not `modules/vm` or `modules/vm-iso` — because OPNsense requires ISO boot and two NICs (WAN bridge + LAN bridge). 
The Proxmox bridges must be configured at the host level before this component can be applied; see `docs/` for details.
