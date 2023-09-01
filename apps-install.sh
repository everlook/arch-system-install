#!/bin/bash

pkgs="
1password
brave-bin
pcloud-drive
python
httpie
"

# this assumes yay is installed
# install packages
for p in $pkgs; do
  yay -S --noconfirm $p
done

