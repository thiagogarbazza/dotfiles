#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration dev kit                          ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

## Install fonts
## For more information see https://www.jetbrains.com/lp/mono/#how-to-install
echo "Install font jetbrains-mono"
FONT_VERSION=$(curl -s "https://api.github.com/repos/JetBrains/JetBrainsMono/releases/latest" | grep -Po '"tag_name": "v\K[0-9.]+')
curl -sSLo jetbrains-mono.zip https://download.jetbrains.com/fonts/JetBrainsMono-$FONT_VERSION.zip
unzip -qq jetbrains-mono.zip -d jetbrains-mono
sudo mkdir /usr/share/fonts/truetype/jetbrains-mono
sudo mv jetbrains-mono/fonts/ttf/*.ttf /usr/share/fonts/truetype/jetbrains-mono
rm -rf jetbrains-mono.zip jetbrains-mono
