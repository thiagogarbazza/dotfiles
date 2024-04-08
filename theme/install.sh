#!/bin/bash
set -euo pipefail

export DIR_THEME=/usr/share/themes/dracula
export DIR_ICON_THEME=/usr/share/icons/dracula

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration theme                            ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

# No install theme on WSL.
if [ "${$(uname -r):l}" =~ "microsoft" ]; then
  exit 0
fi

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

