#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration fonts                            ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

if [[ "$(uname -r| tr '[:upper:]' '[:lower:]')" =~ "microsoft" ]]; then
  echo "No install fonts on WSL."
  #exit 0
fi

DIR_FONT="${XDG_DATA_HOME:-HOME/.local/share}/fonts"
#DIR_FONT=$HOME/Library/Fonts

mkdir -p $DIR_FONT

download_fonts() {
  rm -rf /tmp/font-$1-releases.json /tmp/font-$1.zip /tmp/font-$1

  curl --location --show-error \
    --write-out "Download of %{url} finished\n" \
    --output /tmp/font-$1-releases.json \
    $2
  FONT_URL=$(sed -n 's/.*"browser_download_url": *"\([^"]*\)".*/\1/p' /tmp/font-$1-releases.json)
  curl --location --show-error \
    --write-out "Download of %{url} finished\n" \
    --output /tmp/font-$1.zip \
    $FONT_URL
}

echo "
┌──── Install font: Cascadia Code
└───────────────────────────────────────────────────────────────────────────────
" # https://github.com/microsoft/cascadia-code

find $DIR_FONT -name "CascadiaCode*" -exec rm -rf {} \;
download_fonts cascadia-code 'https://api.github.com/repos/microsoft/cascadia-code/releases/latest'
unzip -qq /tmp/font-cascadia-code.zip -d /tmp/font-cascadia-code
mv /tmp/font-cascadia-code/ttf/*.ttf $DIR_FONT


echo "
┌──── Install font: FiraCode
└───────────────────────────────────────────────────────────────────────────────
" # https://github.com/tonsky/FiraCode

find $DIR_FONT -name "FiraCode*" -exec rm -rf {} \;
download_fonts fira-code https://api.github.com/repos/tonsky/FiraCode/releases/latest
unzip -qq /tmp/font-fira-code.zip -d /tmp/font-fira-code
mv /tmp/font-fira-code/ttf/*.ttf $DIR_FONT


echo "
┌──── Install font: JetBrains Mono
└───────────────────────────────────────────────────────────────────────────────
" # https://www.jetbrains.com/lp/mono/

find $DIR_FONT -name "JetBrain*" -exec rm -rf {} \;
download_fonts jetbrains-mono https://api.github.com/repos/JetBrains/JetBrainsMono/releases/latest
unzip -qq /tmp/font-jetbrains-mono.zip -d /tmp/font-jetbrains-mono
mv /tmp/font-jetbrains-mono/fonts/ttf/*.ttf $DIR_FONT
