#!/bin/bash
set -euo pipefail

export GIT_CONFIG_HOME=$HOME/.config/git

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration git                              ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

if [ -x "$(command -v git)" ]; then
  echo "Git already installed"
else
  echo "Install git"

  case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
    *darwin*)
      brew install git
      ;;
    *linux*)
      if [ -x "$(command -v apt)" ]; then
        sudo apt install git -y
      elif [ -x "$(command -v pacman)" ]; then
        sudo pacman git --sync --noconfirm
      fi
      ;;
    *)
      echo "error: unsupported platform.";
      exit 2;
      ;;
  esac;
fi

echo "Clean old configuration"
rm -rf $HOME/.gitconfig
rm -rf $GIT_CONFIG_HOME

echo "Install dotfiles"
mkdir -p $GIT_CONFIG_HOME
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/git/gitconfig -o $GIT_CONFIG_HOME/gitconfig
ln -s $GIT_CONFIG_HOME/gitconfig $HOME/.gitconfig
