#!/bin/bash

# This assumes Oh My Zsh is installed
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

go_version=1.16.5
node_version=14.17.0

pkgs="
clang
fzf
htop
neovim
python-pip
qemu
ripgrep
tmux
tree
unzip
wget
ctags
neofetch
"

# install packages
for p in $pkgs; do
  sudo pacman -S --noconfirm $p
done

# clone configs
git clone https://github.com/everlook/configs.git
cp $HOME/configs/zshrc $HOME/.zshrc
cp $HOME/configs/tmux.conf $HOME/.tmux.conf
cp $HOME/configs/gitconfig $HOME/

# neovim
mkdir -p $HOME/.config
cp -r $HOME/configs/nvim $HOME/.config/

# Golang
wget https://golang.org/dl/go${go_version}.linux-amd64.tar.gz
tar xvf go${go_version}.linux-amd64.tar.gz
rm go${go_version}.linux-amd64.tar.gz

# NodeJs
wget https://nodejs.org/dist/v${node_version}/node-v${node_version}-linux-x64.tar.xz
tar xvf node-v${node_version}-linux-x64.tar.xz
mv node-v${node_version}-linux-x64 node
rm node-v${node_version}-linux-x64.tar.xz

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install nerd fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
mkdir -p $HOME/.local/share/fonts/Hack/
unzip Hack.zip -d $HOME/.local/share/fonts/Hack/
rm Hack.zip

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
mkdir -p $HOME/.local/share/fonts/JetBrainsMono/
unzip JetBrainsMono.zip -d $HOME/.local/share/fonts/JetBrainsMono/
rm JetBrainsMono.zip

fc-cache

# Install pynvim for neovim
pip install pynvim

# tmux theme
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# launch nvim and run PlugInstall
echo "source ~/.zshrc to continue"
