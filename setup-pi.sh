#!/bin/bash


# ################################################################
# 
#     Setup Script for a Raspberry Pi in my Cluster at home
#
# ################################################################
#
# After the execution a couple of manual steps are required:
# 
#   * Add public key authentication with ssh-copy-id
#   * Add Wireguard configuration /etc/wireguard/wg0.conf
#
# ################################################################


# ################################
# Pre work
# ################################

do_help() {
    echo "Raspberry Pi Setup Script"
    echo ""
    echo "Usage: $0 HOSTNAME USERNAME"
    echo ""
    echo "Script is supposed to minimize the setup time of a Raspberry Pi"
    echo "Applied configurations meet the demands of the developers needs"
    echo ""
    echo "  -h, --help       display this help and exit"
    echo ""
    echo "Examples"
    echo "  $0 stack00 max"
    echo ""
    echo "Written by Max Resing, <https://www.maxresing.de>"
    echo "Questions or feedback appreciated."
}

if [[ -z "$1" || "$1" == "-h" || "$1" == "--help" || "$1" == "help" ]] ; then
    do_help
    exit 0
fi

if [[ -z "$2" ]] ; then
    do_help
    exit 0
fi

#
# Initialize variables
#
echo "Initialize variables"
HOST=${1:-stack00}
USER=${2:-max}


# ################################
# Main setup
# ################################

#
# Update package list
#
echo "Update system"
apt-get -y update
apt-get -y dist-upgrade
apt-get -y autoremove

#
# Setup hostname
#
echo "Change hostname to $HOST"
echo "$HOST" > /etc/hostname


#
# Setup user
#
echo "Setup user $USER"
useradd --create-home --shell /bin/bash $USER
usermod -aG sudo $USER

echo "Setup password for $USER."
passwd $USER


#
# Raspi-config
#
echo "Raspi-config -> Boot Options -> Console"
raspi-config nonint do_boot_behaviour B1
echo "Raspi-config -> Expand File System"
raspi-config nonint do_expand_rootfs


#
# Setup SSH
#
echo "Setup SSH configuration"
echo "" >> /etc/ssh/sshd_config
echo "# Setup script" >> /etc/ssh/sshd_config
echo "AllowUsers $USER" >> /etc/ssh/sshd_config
#echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config
#echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config


#
# Install general set of packages
#
echo "Install packages"
apt-get -y update
apt-get -y install vim
apt-get -y install libelf-dev raspberrypi-kernel-headers build-essential pkg-config git
apt-get -y install openvpn
apt-get -y install unattended-upgrades apt-listchanges
apt-get -y install nfs-common

# Load openvpn connection
# (expects a configuration file on reboot: /etc/openvpn/clients/maxresing.conf
systemctl enable openvpn-client@maxresing.service


#
# Setup unattended upgrades
#
echo "Setup unattended upgrades"
#printf "APT::Periodic::Update-Package-Lists \"1\";\nAPT::Periodic::Unattended-Upgrade \"1\";" > /etc/apt/apt.conf.d/20auto-upgrades
echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean true | debconf-set-selections
dpkg-reconfigure -f noninteractive unattended-upgrades


#
# Setup nfs
#
# TODO: Ensure that NFS server does not mount it's own shared NFS dirs
echo "Create and mount NFS"
mkdir -p /mnt/data
echo "" >> /etc/fstab
echo "# setup-pi script" >> /etc/fstab
echo "10.10.10.16:/mnt/data/share /mnt/data nfs rw,soft,retrans=4,timeo=15,intr 0 0" >> /etc/fstab
echo "" >> /etc/fstab
mount /mnt/data


#
# .bashrc creation for $USER and podman if exists
#
echo "Create symlinks for .bashrc"
# Global bashrc
rm /etc/bash.bashrc
ln -s /mnt/data/all/bashrc/etc/bash.bashrc /etc/bash.bashrc
# $USER bashrc
rm /home/$USER/.bashrc
ln -s /mnt/data/all/bashrc/bashrc /home/$USER/.bashrc

# If podman user exists, also replace their .bashrc
if id "podman" &>/dev/null; then
  rm /home/podman/.bashrc
  ln -s /mnt/data/all/bashrc/bashrc /home/podman/.bashrc
fi


# ################################
# Post work
# ################################

#
# Delete user 'pi'
#
echo "Delete insecure user accounts"
userdel -f pi
rm -R /home/pi/

# Reboot
echo "Rebooting"
reboot
