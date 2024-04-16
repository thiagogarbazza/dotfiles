#!/bin/bash
set -euo pipefail

export SDKMAN_CONFIG_HOME=$HOME/.config/sdkman
export SDKMAN_DIR=$HOME/.config/sdkman

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration dev kit java                     ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

if [ -x "$(command -v zip)" ]; then
  echo "zip and unzip already installed"
else
  echo "Install dependency packages: zip unzip"

  case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
    *darwin*)
      brew install zip unzip
      ;;
    *linux*)
      if [ -x "$(command -v apt)" ]; then
        sudo apt install zip unzip -y
      elif [ -x "$(command -v pacman)" ]; then
        sudo pacman zip unzip --sync --noconfirm
      fi
      ;;
    *)
      echo "error: unsupported platform.";
      exit 2;
      ;;
  esac;
fi

echo "Install sdkman"
## For more information see https://sdkman.io/install
curl -fsSL "https://get.sdkman.io?rcupdate=false" | bash

set +eu # disable exitting on error temporarily
source "${SDKMAN_DIR}/bin/sdkman-init.sh"

echo "Install jdk"
sdk install java

echo "Install maven"
sdk install maven
