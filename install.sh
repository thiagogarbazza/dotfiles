#!/bin/bash

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

echo "┌──────────────────────────────────────────────────────────────────────────────┐"
echo "├───────── Create directories                                         ─────────┤"
echo "└──────────────────────────────────────────────────────────────────────────────┘"

mkdir -p $HOME/.config
mkdir -p $HOME/.cache
mkdir -p $HOME/.local/share
mkdir -p $HOME/.local/state

mkdir -p $HOME/workspace/projects
mkdir -p $HOME/workspace/pocs

echo "┌──────────────────────────────────────────────────────────────────────────────┐"
echo "├───────── Update and upgrade distro                                  ─────────┤"
echo "└──────────────────────────────────────────────────────────────────────────────┘"

echo "Removing apt locks"
sudo rm -rf /var/lib/dpkg/lock-frontend
sudo rm -rf /var/cache/apt/archives/lock

echo "Update and upgrade distro"
sudo apt update -y && sudo apt full-upgrade -y

echo "┌──────────────────────────────────────────────────────────────────────────────┐"
echo "├───────── Install and configuration tools                            ─────────┤"
echo "└──────────────────────────────────────────────────────────────────────────────┘"

sudo apt install \
zip \
unzip \
curl \
wget \
-y

sh -c "$(curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/dev-kit-java/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/dev-kit-node/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/git/install.sh)"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/thiagogarbazza/dotfiles/main/zsh/install.sh)"
