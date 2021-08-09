#!/bin/bash

pkgs="
xorg
xorg-xinit
bspwm
picom
dmenu
sxhkd
chromium
nitrogen
xfce4-terminal
arandr
rofi
alacritty
pavucontrol
pulseaudio
pulseaudio-alsa
lxappearance
materia-gtk-theme
pcmanfm
ttf-ubuntu-font-family
"
# install packages
for p in $pkgs; do
  sudo pacman -S --noconfirm $p
done

# this assumes base-install was run
cp -r $HOME/configs/sxhkd $HOME/.config/
cp -r $HOME/configs/bspwm $HOME/.config/
cp -r $HOME/configs/alacritty $HOME/.config/
cp -r $HOME/configs/xinitrc $HOME/.xinitrc

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si
cd $HOME
rm -rf yay

yay -S polybar
cp -r $HOME/configs/polybar $HOME/.config/

yay nordic-theme
yay pcloud-drive
