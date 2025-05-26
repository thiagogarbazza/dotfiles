#!/bin/bash
set -euo pipefail


echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration zsh                              ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

export OH_MY_ZSH_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/"
export ZSH_PLUGINS_HOME="$OH_MY_ZSH_HOME/ohmyzsh/custom/plugins"
export ZSH_THEME_HOME="$OH_MY_ZSH_HOME/ohmyzsh/custom/themes"
export ZDOTDIR="$OH_MY_ZSH_HOME"

echo "Clean old instalation and configuration"
rm -rf $OH_MY_ZSH_HOME/ohmyzsh

echo " Install Oh My ZSH!"
## For more information see https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

echo "Install pluins"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions         $ZSH_PLUGINS_HOME/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_PLUGINS_HOME/zsh-syntax-highlighting

echo "Install themes"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_THEME_HOME/powerlevel10k
curl -fsSl https://raw.githubusercontent.com/dracula/zsh-syntax-highlighting/master/zsh-syntax-highlighting.sh -o $ZSH_THEME_HOME/zsh-syntax-highlighting.sh

echo "Clean"
rm -rf \
  $HOME/.zshenv \
  $HOME/.zshrc \
  $HOME/.zprofile \
  $HOME/.zsh_history \
  $HOME/.zsh_sessions \
  $HOME/.zcompdump

echo "Configure XDG Base Directory specification"
ln -s "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/zshenv $HOME/.zshenv
mkdir -p $HOME/.local/state/zsh/
touch $HOME/.local/state/zsh/history

echo "Define ZSH by default"
sudo usermod -s $(which zsh) $(whoami)
