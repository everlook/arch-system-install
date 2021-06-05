#!/bin/bash

# qemu-img create -f qcow2 ubuntu-desktop-18.04.qcow2 10G

# for UEFI boot
#  -bios /usr/share/OVMF/OVMF_CODE.fd \
#  -bios /usr/share/qemu/OVMF.fd \
  
#   -display default,show-cursor=on \

#  -cdrom ~/Backup/ISO/pop-os_20.04_amd64_intel_26.iso \
#  -drive file=popos-desktop.qcow2,if=virtio \

#  -cdrom ~/Backup/ISO/ubuntu-20.04.2-live-server-amd64.iso \
#  -drive file=ubuntu-20.04-server.qcow2,if=virtio \

#  -cdrom ~/Backup/ISO/archlinux-2021.06.01-x86_64.iso \
#  -drive file=arch.qcow2,if=virtio \

#  -cdrom ~/Backup/ISO/archcraft-2021.05.26-x86_64.iso \
#  -drive file=archcraft.qcow2,if=virtio \

# Macbook 16
#  -cpu Nehalem
#  -machine type=q35,accel=hvf \
# Everlook desktop
#  -cpu SandyBridge
#  -machine type=q35,accel=kvm \

qemu-system-x86_64 \
  -m 16G \
  -vga std \
  -display gtk,show-cursor=on \
  -usb \
  -device usb-tablet \
  -machine type=q35,accel=kvm \
  -smp 4 \
  -net user,hostfwd=tcp::3333-:22 -net nic \
  -bios /usr/share/qemu/OVMF.fd \
  -cdrom ~/ISO/archlinux-2021.06.01-x86_64.iso \
  -drive file=./stage/arch.qcow2,if=virtio \
  -cpu SandyBridge \
  -boot menu=on
