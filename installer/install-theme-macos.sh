#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration theme                            ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

if [[ "$(uname -r| tr '[:upper:]' '[:lower:]')" =~ "microsoft" ]]; then
  echo "No install fonts on WSL."
  exit 0
fi


echo "Install theme on Terminal.app"
rm -rf $XDG_CONFIG_HOME/theme/Dracula.terminal
mkdir -p $XDG_CONFIG_HOME/theme
curl -fsSl https://raw.githubusercontent.com/dracula/terminal-app/master/Dracula.terminal -o $XDG_CONFIG_HOME/theme/Dracula.terminal
defaults write com.apple.Terminal "Window Settings" -dict-add "Dracula" "$(cat $XDG_CONFIG_HOME/theme/Dracula.terminal)"
defaults write com.apple.Terminal "Default Window Settings" "Dracula"
defaults write com.apple.Terminal "Startup Window Settings" "Dracula"
