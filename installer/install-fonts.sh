#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration fonts                            ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

if [[ "$(uname -r| tr '[:upper:]' '[:lower:]')" =~ "microsoft" ]]; then
  echo "No install fonts on WSL."
  exit 0
fi

DIR_FONT="${XDG_DATA_HOME:-HOME/.local/share}/fonts"
#DIR_FONT=$HOME/Library/Fonts

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

echo "Install fonts"
git clone --depth=1 https://github.com/powerline/fonts.git /tmp/powerline-fonts
sh /tmp/powerline-fonts/install.sh
