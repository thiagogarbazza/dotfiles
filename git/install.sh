#!/bin/bash

export GIT_CONFIG_HOME=$HOME/.config/git

echo "┌──────────────────────────────────────────────────────────────────────────────┐"
echo "├───────── Install and configuration of git                           ─────────┤"
echo "└──────────────────────────────────────────────────────────────────────────────┘"

echo "Install git"
sudo apt install git -y

echo "Install dotfiles"
curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/git/gitconfig -o $GIT_CONFIG_HOME/gitconfig
ln -s $GIT_CONFIG_HOME/gitconfig $HOME/.gitconfig
