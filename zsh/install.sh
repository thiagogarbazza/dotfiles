#!/bin/bash
set -euo pipefail

export ZSH_CONFIG_HOME=$HOME/.config/zsh
export ZSH_PLUGINS_HOME=$HOME/.config/zsh/ohmyzsh/custom/plugins
export ZSH_THEME_HOME=$HOME/.config/zsh/ohmyzsh/custom/themes
export ZDOTDIR=$ZSH_CONFIG_HOME

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration zsh                              ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

if [ -x "$(command -v zsh)" ]; then
  echo "zsh already installed"
else
  echo "Install zsh"

  case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
    *darwin*)
      brew install zsh
      ;;
    *linux*)
      if [ -x "$(command -v apt)" ]; then
        sudo apt install zsh -y
      elif [ -x "$(command -v pacman)" ]; then
        sudo pacman zsh --sync --noconfirm
      fi
      ;;
    *)
      echo "error: unsupported platform.";
      exit 2;
      ;;
  esac;
fi

echo "Clean old configuration"
rm -rf $ZSH_CONFIG_HOME \
       $HOME/.zshenv

echo "Install fonts"
git clone --depth=1 https://github.com/powerline/fonts.git /tmp/powerline-fonts
sh /tmp/powerline-fonts/install.sh

echo " Install Oh My ZSH!"
## For more information see https://ohmyz.sh/#install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc

echo "Install pluins"
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ZSH_PLUGINS_HOME/zsh-autosuggestions
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_PLUGINS_HOME/zsh-syntax-highlighting

echo "Install themes"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_THEME_HOME/powerlevel10k
curl -fsSl https://raw.githubusercontent.com/dracula/zsh-syntax-highlighting/master/zsh-syntax-highlighting.sh -o $ZSH_THEME_HOME/zsh-syntax-highlighting.sh

echo "Install dotfiles"
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/zsh/zshenv -o $ZSH_CONFIG_HOME/.zshenv
ln -s $ZSH_CONFIG_HOME/.zshenv $HOME/.zshenv
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/zsh/zshrc -o $ZSH_CONFIG_HOME/.zshrc
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/zsh/p10k.zsh -o $ZSH_CONFIG_HOME/p10k.zsh
mkdir -p $HOME/.local/share/zsh/
touch $HOME/.local/share/zsh/history

echo "Clean"
rm -rf /tmp/powerline-fonts \
       $HOME/.zshrc \
       $HOME/.zprofile \
       $HOME/.zsh_history \
       $HOME/.zsh_sessions \
       $HOME/.zcompdump*

echo "Define ZSH by default"
sudo usermod -s $(which zsh) $(whoami)
