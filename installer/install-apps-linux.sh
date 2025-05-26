#!/bin/bash
set -euo pipefail

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration apps                             ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

if [[ "$(uname -r | tr '[:upper:]' '[:lower:]')" =~ "microsoft" ]]; then
  echo "No install apps on WSL."
  exit 0
fi

echo "Install flatpak"
if [ -x "$(command -v apt)" ]; then
  sudo apt install --assume-yes flatpak
elif [ -x "$(command -v pacman)" ]; then
  sudo pacman flatpak --sync --noconfirm
else
  echo "error: unsupported linux distribution."
  exit 3
fi

echo "Configuration flatpak remotes"
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

echo "Install apps"
flatpak install flathub com.visualstudio.code -y
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community -y
flatpak install flathub io.dbeaver.DBeaverCommunity -y
flatpak install flathub io.podman_desktop.PodmanDesktop -y
