#!/bin/bash

export XDG_CONFIG_HOME=$HOME/.config

echo "┌──────────────────────────────────────────────────────────────────────────────┐"
echo "├───────── Install and configuration of Zsh                           ─────────┤"
echo "└──────────────────────────────────────────────────────────────────────────────┘"

mkdir -p $XDG_CONFIG_HOME/zsh
export ZDOTDIR=$XDG_CONFIG_HOME/zsh

echo "Install fonts"
sudo apt install fonts-font-awesome -y
git clone --depth=1 https://github.com/powerline/fonts.git /tmp/powerline-fonts
sh /tmp/powerline-fonts/install.sh
rm -rf /tmp/powerline-fonts

echo "Install ZSH"
## For mor information see https://www.zsh.org/
sudo apt install zsh -y
zsh --version
chsh -s $(which zsh)

echo " Install Oh My ZSH!"
### For more information see https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Install pluins"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZDOTDIR/ohmyzsh/custom/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZDOTDIR/ohmyzsh/custom/plugins/zsh-syntax-highlighting

echo "Install powerline10k theme"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZDOTDIR/ohmyzsh/custom/themes/powerlevel10k

echo "Install dotfiles"
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/zsh/zshrc -o $ZDOTDIR/.zshrc
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/zsh/p10k.zsh -o $ZDOTDIR/.p10k.zsh
cp $ZDOTDIR/.zshrc $HOME/.zshrc
