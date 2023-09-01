#!/bin/bash

pkgs="
awesome
awesome-extra
alacritty
alsa-utils
arandr
dmenu
lxappearance
i3lock-fancy
materia-theme
nitrogen
network-manager-applet
papirus-icon-theme
pavucontrol
pulseaudio
pulseaudio-alsa
picom
pnmixer
polkit-gnome
rofi
pcmanfm
dunst
xclip
xorg
xorg-xinit
"

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd $HOME
rm -rf yay

# install packages
for p in $pkgs; do
   yay -S --noconfirm $p
done
