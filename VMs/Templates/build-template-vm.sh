#!/bin/bash
# create-template.sh
# Run on Ubuntu workstation (NOT on Proxmox - due to libguestfs!)

set -e  # Exit on error

# === CONFIGURATION ===
PROXMOX_HOST="proxmox"
PROXMOX_USER="root"
VM_ID=999
TEMPLATE_NAME="template-vm-ubuntu-2604"
STORAGE="local-zfs"
IMAGE_CACHE_DIR="${HOME}/.cache/proxmox-templates"

IMAGE_URL="https://cloud-images.ubuntu.com/resolute/current/resolute-server-cloudimg-amd64.img"
IMAGE_FILE="ubuntu-cloud.img"
IMAGE_PATH="${IMAGE_CACHE_DIR}/${IMAGE_FILE}"
WORK_IMAGE="${IMAGE_CACHE_DIR}/${TEMPLATE_NAME}-work.img"

# === CHECK PREREQUISITES ===
echo "🔍 Checking prerequisites..."

# Check if virt-customize is available
if ! command -v virt-customize &> /dev/null; then
    echo "❌ ERROR: virt-customize not found!"
    echo ""
    echo "This script requires libguestfs-tools to be installed."
    echo ""
    echo "⚠️  WARNING: Do NOT install this on a Proxmox host!"
    echo "   libguestfs-tools conflicts with Proxmox packages."
    echo ""
    echo "To install on Ubuntu/Debian workstation:"
    echo "   sudo apt-get update"
    echo "   sudo apt-get install libguestfs-tools"
    echo ""
    echo "To install on Fedora/RHEL:"
    echo "   sudo dnf install libguestfs-tools"
    echo ""
    exit 1
fi

# Check if SSH connection to Proxmox is possible
if ! ssh -o BatchMode=yes -o ConnectTimeout=5 "${PROXMOX_USER}@${PROXMOX_HOST}" exit &>/dev/null; then
    echo "❌ ERROR: Cannot connect to Proxmox host via SSH!"
    echo ""
    echo "Please ensure:"
    echo "  1. SSH keys are set up: ssh-copy-id ${PROXMOX_USER}@${PROXMOX_HOST}"
    echo "  2. Host is reachable: ping ${PROXMOX_HOST}"
    echo ""
    exit 1
fi

echo "✅ Prerequisites check passed"
echo ""

# === STEP 1: Download image ===
echo "📥 Downloading Ubuntu Cloud Image..."

# Create cache directory if it doesn't exist
mkdir -p "$IMAGE_CACHE_DIR"

if [ ! -f "$IMAGE_PATH" ]; then
    wget -O "$IMAGE_PATH" "$IMAGE_URL"
    echo "   Downloaded to $IMAGE_PATH"
else
    echo "   Image already exists at $IMAGE_PATH, skipping download"
fi

# Create a working copy for customization
echo "📋 Creating working copy of image..."
cp "$IMAGE_PATH" "$WORK_IMAGE"

# === STEP 2: Customize image with virt-customize ===
echo "🔧 Customizing image..."

sudo virt-customize -a "$WORK_IMAGE" \
  --install qemu-guest-agent \
  --run-command "systemctl enable qemu-guest-agent" \
  --run-command "sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config" \
  --run-command "sed -i 's/^#*PermitRootLogin.*/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config" \
  --run-command "sed -i 's/^#*PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config"

# Clean cloud-init state and remove persistent network/DHCP identifiers.
#
# Rationale:
# When creating a template from a cloud image, files like cloud-init state,
# DHCP lease files and the system `machine-id` can be copied into the template.
# If those artifacts are left in the template, cloned VMs may present identical
# DHCP client identifiers or cached leases and therefore receive the same
# IPv4 address from the DHCP server despite having unique MAC addresses.
#
# The commands below ensure the template image is sanitized so each clone will
# perform a fresh cloud-init run, generate a new instance-id/machine-id and
# request a new DHCP lease on first boot.
sudo virt-customize -a "$WORK_IMAGE" \
  --run-command "[ -x /usr/bin/cloud-init ] && cloud-init clean --logs || true" \
  --run-command "rm -rf /var/lib/cloud/* /var/lib/dhcp/* /var/lib/dhclient/* /var/lib/dhcp3/* /var/lib/NetworkManager/* 2>/dev/null || true" \
  --run-command "truncate -s 0 /etc/machine-id 2>/dev/null || true" \
  --run-command "rm -f /var/lib/dbus/machine-id 2>/dev/null || true"

echo "✅ Image customization complete"

# === STEP 3: Transfer image to Proxmox ===
echo "📤 Transferring image to Proxmox..."
scp "$WORK_IMAGE" "${PROXMOX_USER}@${PROXMOX_HOST}:/tmp/${IMAGE_FILE}"

# === STEP 4: Create template on Proxmox ===
echo "🏗️  Creating template on Proxmox..."

ssh "${PROXMOX_USER}@${PROXMOX_HOST}" bash -s << EOF
set -e

# Check if VM-ID already exists
if qm status ${VM_ID} &>/dev/null; then
    echo "   VM ${VM_ID} already exists. Deleting..."
    qm destroy ${VM_ID} --destroy-unreferenced-disks 1 --purge 1
fi

# Create VM
qm create ${VM_ID} \
  --name "${TEMPLATE_NAME}" \
  --memory 2048 \
  --cores 2 \
  --net0 virtio,bridge=vmbr0

# Import disk
qm importdisk ${VM_ID} /tmp/${IMAGE_FILE} ${STORAGE}

# Configure disk
qm set ${VM_ID} \
  --scsihw virtio-scsi-single \
  --scsi0 ${STORAGE}:vm-${VM_ID}-disk-0,ssd=1,discard=on,iothread=1

# Add Cloud-Init drive
qm set ${VM_ID} --ide2 ${STORAGE}:cloudinit

# Boot configuration
qm set ${VM_ID} \
  --boot order=scsi0 \
  --serial0 socket \
  --vga serial0

# Enable QEMU Guest Agent
qm set ${VM_ID} --agent enabled=1,fstrim_cloned_disks=1

# Cloud-Init defaults (optional, can be overridden per VM)
qm set ${VM_ID} \
  --ciuser ubuntu \
  --cipassword ubuntu \
  --ipconfig0 ip=dhcp

# DNS settings: Using host settings by default
# The VM will inherit DNS configuration from the Proxmox host (/etc/resolv.conf)
# To set explicit values, uncomment and adjust:
# --nameserver 8.8.8.8 \
# --searchdomain local

# Add SSH key (optional - uncomment and adjust)
# qm set ${VM_ID} --sshkeys ~/.ssh/id_rsa.pub

# Convert to template
qm template ${VM_ID}

# Cleanup
rm /tmp/${IMAGE_FILE}

echo "✅ Template ${TEMPLATE_NAME} (ID: ${VM_ID}) created successfully!"
EOF

# Cleanup working copy on local machine
echo "🧹 Cleaning up working copy..."
rm "$WORK_IMAGE"

echo ""
echo "🎉 All done!"
echo ""
echo "Template Details:"
echo "  Name: ${TEMPLATE_NAME}"
echo "  ID:   ${VM_ID}"
echo "  Node: Check Proxmox UI"
echo ""
echo "Next steps:"
echo "  1. Test the template:"
echo "     qm clone ${VM_ID} 100 --name test-vm"
echo ""
echo "  2. Customize Cloud-Init (optional):"
echo "     qm set 100 --ciuser yourname"
echo "     qm set 100 --sshkeys ~/.ssh/id_rsa.pub"
echo "     qm set 100 --ipconfig0 ip=192.168.1.100/24,gw=192.168.1.1"
echo ""
echo "  3. Start VM:"
echo "     qm start 100"
