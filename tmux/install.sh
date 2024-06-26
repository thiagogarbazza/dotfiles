#!/bin/bash
set -euo pipefail

export TMUX_CONFIG_HOME=$HOME/.config/tmux

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration tmux                             ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

if [ -x "$(command -v tmux)" ]; then
  echo "tmux already installed"
else
  echo "Install tmux"

  case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
    *darwin*)
      brew install tmux
      ;;
    *linux*)
      if [ -x "$(command -v apt)" ]; then
        sudo apt install tmux -y
      elif [ -x "$(command -v pacman)" ]; then
        sudo pacman tmux --sync --noconfirm
      fi
      ;;
    *)
      echo "error: unsupported platform.";
      exit 2;
      ;;
  esac;
fi

echo "Clean old configuration"
rm -rf $HOME/.tmux.conf
rm -rf $TMUX_CONFIG_HOME

echo "Install plugins"
git clone --depth=1 https://github.com/tmux-plugins/tpm $TMUX_CONFIG_HOME/plugins/tpm

echo "Install dotfiles"
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/tmux/tmux.conf -o $TMUX_CONFIG_HOME/tmux.conf
ln -s $TMUX_CONFIG_HOME/tmux.conf $HOME/.tmux.conf
