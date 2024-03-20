#!/bin/bash
set -euo pipefail

export SDKMAN_CONFIG_HOME=$HOME/.config/sdkman
export SDKMAN_DIR=$HOME/.config/sdkman

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration dev kit java                     ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

echo "Install tools"
if [ -x "$(command -v apt)" ]; then
  sudo apt install zip unzip -y
elif [ -x "$(command -v pacman)" ]; then
  sudo pacman zip unzip --sync --noconfirm
fi

echo "Install sdkman"
## For more information see https://sdkman.io/install
curl -fsSL "https://get.sdkman.io" | bash

set +eu # disable exitting on error temporarily
source "${SDKMAN_DIR}/bin/sdkman-init.sh"

echo "Install jdk"
sdk install java

echo "Install maven"
sdk install maven
