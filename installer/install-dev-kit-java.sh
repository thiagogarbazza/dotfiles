#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration dev kit java                     ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

echo "Install sdkman"
## For more information see https://sdkman.io/install
export SDKMAN_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/sdkman"
curl -fsSL "https://get.sdkman.io?rcupdate=false" | bash

echo "Configure XDG Base Directory specification"
mkdir -p $HOME/.m2
ln --symbolic --force ${XDG_CONFIG_HOME:-$HOME/.config}/maven/settings.xml $HOME/.m2/settings.xml
ln --symbolic --force ${XDG_CACHE_HOME:-$HOME/.cache}/maven/repository     $HOME/.m2/repository
ln --symbolic --force ${XDG_CACHE_HOME:-$HOME/.cache}/maven/wrapper        $HOME/.m2/wrapper
