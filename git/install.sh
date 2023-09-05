#!/bin/bash

set -euo pipefail

export GIT_CONFIG_HOME=$HOME/.config/git

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration git                              ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

echo "Install git"
sudo apt install git -y

echo "Install dotfiles"
mkdir -p $GIT_CONFIG_HOME
rm -rf $HOME/.gitconfig
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/git/gitconfig -o $GIT_CONFIG_HOME/gitconfig
ln -s $GIT_CONFIG_HOME/gitconfig $HOME/.gitconfig
