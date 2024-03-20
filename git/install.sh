#!/bin/bash
set -euo pipefail

export GIT_CONFIG_HOME=$HOME/.config/git

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration git                              ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

echo "Install git"
if [ -x "$(command -v apt)" ]; then
  sudo apt install git --assume-yes --quiet
elif [ -x "$(command -v pacman)" ]; then
  sudo pacman git --sync --noconfirm
fi

echo "Install dotfiles"
mkdir -p $GIT_CONFIG_HOME
rm -rf $HOME/.gitconfig
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/git/gitconfig -o $GIT_CONFIG_HOME/gitconfig
ln -s $GIT_CONFIG_HOME/gitconfig $HOME/.gitconfig
