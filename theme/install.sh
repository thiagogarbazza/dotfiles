#!/bin/bash
set -euo pipefail

export XDG_CONFIG_HOME=$HOME/.config
export DIR_THEME=/usr/share/themes/dracula
export DIR_ICON_THEME=/usr/share/icons/dracula
export DIR_FONT="$HOME/.local/share/fonts"

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration theme                            ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

# No install theme on WSL.
if [ "${$(uname -r):l}" =~ "microsoft" ]; then
  echo "No install theme on WSL."
  exit 0
fi

case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
  *darwin*)
    DIR_FONT=$HOME/Library/Fonts

    echo "Install theme on Terminal.app"
    rm -rf $XDG_CONFIG_HOME/theme/Dracula.terminal
    curl -fsSl https://raw.githubusercontent.com/dracula/terminal-app/master/Dracula.terminal -o $XDG_CONFIG_HOME/theme/Dracula.terminal
    defaults write com.apple.Terminal "Window Settings" -dict-add "Dracula" "$(cat $XDG_CONFIG_HOME/theme/Dracula.terminal)"
    defaults write com.apple.Terminal "Default Window Settings" "Dracula"
	  defaults write com.apple.Terminal "Startup Window Settings" "Dracula"
    ;;
  *linux*)
    DIR_FONT="$HOME/.local/share/fonts"

    echo "Install theme on Gedit"
    curl -fsSl https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml -o $HOME/.local/share/gedit/styles/Dracula.xml

    echo "Install theme"
    curl -sSLo dracula-theme.zip https://github.com/dracula/gtk/archive/master.zip
    unzip -qq dracula-theme.zip -d dracula-theme
    sudo rm -rf $DIR_THEME
    sudo mkdir -p $DIR_THEME
    sudo mv --force dracula-theme/gtk-master/* $DIR_THEME
    rm -rf dracula-theme.zip dracula-theme

    echo "Activating theme"
    gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
    gsettings set org.gnome.desktop.wm.preferences theme "Dracula"


    echo "Install icon theme"
    curl -sSLo dracula-icon-theme.zip https://github.com/dracula/gtk/files/5214870/Dracula.zip
    unzip -qq dracula-icon-theme.zip -d dracula-icon-theme
    sudo rm -rf $DIR_ICON_THEME
    sudo mkdir -p $DIR_ICON_THEME
    sudo mv --force dracula-icon-theme/Dracula/* $DIR_ICON_THEME
    rm -rf dracula-icon-theme.zip dracula-icon-theme

    echo "Activating icon theme"
    gsettings set org.gnome.desktop.interface icon-theme "Dracula"
    ;;
  *)
    echo "error: unsupported platform.";
    exit 2;
    ;;
esac;
