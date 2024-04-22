#!/bin/bash
set -euo pipefail

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

echo "Create directories"
mkdir -p \
  $XDG_CONFIG_HOME \
  $XDG_CACHE_HOME \
  $XDG_DATA_HOME \
  $XDG_STATE_HOME \
  $HOME/projects/my \
  $HOME/projects/pocs

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration tools                            ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
  *darwin*)
    brew install zip unzip curl wget
    ;;
  *linux*)
    if [ -x "$(command -v apt)" ]; then
      sudo apt install zip unzip curl wget -y
    elif [ -x "$(command -v pacman)" ]; then
      sudo pacman zip unzip curl wget --sync --noconfirm
    fi
    ;;
  *)
    echo "error: unsupported platform.";
    exit 2;
    ;;
esac;

curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/git/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/dev-kit-docker/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/dev-kit-java/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/dev-kit-node/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/tmux/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/zsh/install.sh | bash

curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/theme/install.sh | bash
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/apps/install.sh | bash
