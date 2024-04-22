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
if [[ "$(uname -r| tr '[:upper:]' '[:lower:]')" =~ "microsoft" ]]; then
  echo "No install theme on WSL."
  #exit 0
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
    mkdir -p $HOME/.local/share/gedit/styles/
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


mkdir -p $DIR_FONT

echo "Install font Cascadia Code" # https://github.com/microsoft/cascadia-code
rm -rf /tmp/cascadia-code.zip /tmp/cascadia-code
find $DIR_FONT -name "CascadiaCode*" -exec rm -rf {} \;
FONT_VERSION=$(curl -s "https://api.github.com/repos/microsoft/cascadia-code/releases/latest" | sed -n 's|.*"tag_name": "v\([^"]*\)".*|\1|p')
curl -sSLo /tmp/cascadia-code.zip https://github.com/microsoft/cascadia-code/releases/download/v$FONT_VERSION/CascadiaCode-$FONT_VERSION.zip
unzip -qq /tmp/cascadia-code.zip -d /tmp/cascadia-code
mv /tmp/cascadia-code/ttf/*.ttf $DIR_FONT

echo "Install font FiraCode" # https://github.com/tonsky/FiraCode
rm -rf /tmp/firacode.zip /tmp/firacode
find $DIR_FONT -name "FiraCode*" -exec rm -rf {} \;
FONT_VERSION=$(curl -s "https://api.github.com/repos/tonsky/FiraCode/releases/latest" | sed -n 's|.*"tag_name": "\([^"]*\)".*|\1|p')
curl -sSLo /tmp/firacode.zip https://github.com/tonsky/FiraCode/releases/download/$FONT_VERSION/Fira_Code_v$FONT_VERSION.zip
unzip -qq /tmp/firacode.zip -d /tmp/firacode
mv /tmp/firacode/ttf/*.ttf $DIR_FONT

echo "Install font Hack" # https://sourcefoundry.org/hack/
rm -rf /tmp/hack.zip /tmp/hack
find $DIR_FONT -name "Hack*" -exec rm -rf {} \;
FONT_VERSION=$(curl -s "https://api.github.com/repos/source-foundry/Hack/releases/latest" | sed -n 's|.*"tag_name": "\([^"]*\)".*|\1|p')
curl -sSLo /tmp/hack.zip https://github.com/source-foundry/Hack/releases/download/$FONT_VERSION/Hack-$FONT_VERSION-ttf.zip
unzip -qq /tmp/hack.zip -d /tmp/hack
mv /tmp/hack/ttf/*.ttf $DIR_FONT

echo "Install font JetBrains Mono" # https://www.jetbrains.com/lp/mono/
rm -rf /tmp/jetbrains-mono.zip /tmp/jetbrains-mono
find $DIR_FONT -name "JetBrain*" -exec rm -rf {} \;
FONT_VERSION=$(curl -s "https://api.github.com/repos/JetBrains/JetBrainsMono/releases/latest" | sed -n 's|.*"tag_name": "v\([^"]*\)".*|\1|p')
curl -sSLo /tmp/jetbrains-mono.zip https://download.jetbrains.com/fonts/JetBrainsMono-$FONT_VERSION.zip
unzip -qq /tmp/jetbrains-mono.zip -d /tmp/jetbrains-mono
mv /tmp/jetbrains-mono/fonts/ttf/*.ttf $DIR_FONT
