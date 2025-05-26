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

if [[ "$(uname -r| tr '[:upper:]' '[:lower:]')" =~ "microsoft" ]]; then
  echo "No install apps on WSL."
  exit 0
fi

brew install --cask visual-studio-code
brew install --cask intellij-idea-ce
brew install --cask dbeaver-community
brew install --cask podman-desktop
