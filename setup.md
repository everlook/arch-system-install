### Arch Install with UEFI and Encrypted Root

* Set variables for install
```bash
export USER=username
export DRIVE=/dev/vda
export HOST_NAME=vm1
```

* Setup wifi for laptop install
```bash
wifi-menu
ping -c 5 archlinux.org
```
* Enable ssh and set root password so we can ssh in for install.
```bash
systemctl start sshd
passwd
```

* Update the system clock
```bash
timedatectl set-ntp true
```

* For EFI boot create first partion as an EFI System
  * 100M
  * For an EFI Partition use FAT32 (mkfs.vfat -F32 ${DRIVE}1)

* For an encrypted root create second partition for grub
  *  512MB
  * Format as linux(83)

* Rest of disk ${DRIVE}3 linux(83)
```bash
NAME          MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
vda           254:0    0    20G  0 disk
├─vda1        254:1    0   100M  0 part  /boot/efi
├─vda2        254:2    0   512M  0 part  /boot
└─vda3        254:3    0  19.4G  0 part
  └─cryptroot 253:0    0  19.4G  0 crypt /
```

* Partition the disk
```bash
lsblk
cfdisk ${DRIVE}
```

* Encrypt root parition
```bash
cryptsetup -y --use-random luksFormat ${DRIVE}3
```

* Open encrypted disk
```bash
cryptsetup open ${DRIVE}3 cryptroot
```

* Format partitions
```bash
mkfs.fat -F32 ${DRIVE}1
mkfs.ext4 ${DRIVE}2
mkfs.ext4 /dev/mapper/cryptroot
```

* Mount partitions
```bash
mount /dev/mapper/cryptroot /mnt
mkdir -p /mnt/boot
mount ${DRIVE}2 /mnt/boot
mkdir -p /mnt/boot/efi
mount ${DRIVE}1 /mnt/boot/efi
lsblk
```

* Install base system
```bash
pacstrap /mnt linux linux-firmware base base-devel grub \
  efibootmgr vim git intel-ucode networkmanager
```

* Generate fastab
```bash
genfstab -U -p /mnt >> /mnt/etc/fstab
```

* Chroot
```bash
arch-chroot /mnt
```
* Set local time
```bash
ln -sf /usr/share/zoneinfo/PST8PDT /etc/localtime
hwclock --systohc
```

* Uncomment locale in /etc/locale.gen
```bash
vim /etc/locale.gen
```

* Generate locale
```bash
locale-gen
```

* Create /etc/locale.conf
```bash
echo LANG=en_US.UTF-8 > /etc/locale.conf
```

* Add hostname
```bash
echo ${HOST_NAME} > /etc/hostname
```

* Add to /etc/hosts
```bash
echo "127.0.0.1   localhost" >> /etc/hosts
echo "::1         localhost" >> /etc/hosts
echo "127.0.1.1   ${HOST_NAME}.localdomain  ${HOST_NAME}" >> /etc/hosts
```

* Change root password
```bash
passwd
```

* Add additional core packages
```bash
pacman -S man-db man-pages texinfo inetutils dhcpcd networkmanager openssh \
  wpa_supplicant dialog linux-headers network-manager-applet zsh grub os-prober mtools
```

* Add user
```bash
useradd -m -G wheel,games,power,optical,storage,scanner,lp,audio,video -s /usr/bin/zsh ${USER}
passwd ${USER}
```

* Run visudo, uncomment out the wheel group
```bash
visudo
%wheel ALL=(ALL) ALL
```

* Update /etc/default/grub
* Find UUID for root
```
  blkid
```
* GRUB_CMDLINE_LINUX="cryptdevice=UUID=[use blkid]:cryptroot root=/dev/mapper/cryptroot"

* Edit /etc/mkinitcpio.conf. Make sure encrypt is before filesystems
```bash
vim /etc/mkinitcpio.conf
HOOKS=(base udev autodetect keyboard modconf block encrypt filesystems fsck)
```

* Buikd the initcpio
```bash
mkinitcpio -p linux
```

* Install grub
```bash
grub-install --target=x86_64-efi --bootloader-id=ArchLinux --recheck
grub-mkconfig --output /boot/grub/grub.cfg
```

* Enable networkmanager
```bash
systemctl enable NetworkManager
systemctl enable sshd
```

* Exit and reboot
```bash
exit
umount -R /mnt
cryptsetup close cryptroot
reboot
```

* Post install, copy over ssh keys
```
scp -P 3333 ~/.ssh/id_rsa.pub user@localhost:.ssh/authorized_keys
```


