#!/bin/bash

# sudo lscpu | grep Virtualization
# sudo systemctl enable --now libvirtd
# sudo systemctl status libvirtd
# sudo nvim /etc/libvirt/libvirtd.conf
# - unix_sock_group = "libvirt"
# - unix_sock_rw_perms = "0770"
# sudo usermod -a -G libvirt $(whoami)
# sudo systemctl restart libvirtd


pkgs="
  qemu
  virt-manager
  virt-viewer
  libvirt
  dnsmasq
  vde2
  bridge-utils
  openbsd-netcat
  ebtables
  libguestfs
  dmidecode
"

# install packages
for p in $pkgs; do
  sudo pacman -S --noconfirm $p
done

