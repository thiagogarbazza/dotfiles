#!/bin/bash

export SDKMAN_CONFIG_HOME=$HOME/.config/sdkman
export SDKMAN_DIR=$HOME/.config/sdkman

echo "┌──────────────────────────────────────────────────────────────────────────────┐"
echo "├───────── Install and configuration dev kit java                     ─────────┤"
echo "└──────────────────────────────────────────────────────────────────────────────┘"

echo "Install tools"
sudo apt install zip unzip -y

echo "Install sdkman"
## For more information see https://sdkman.io/install
curl -s "https://get.sdkman.io?rcupdate=false" | bash

source "${SDKMAN_DIR}/bin/sdkman-init.sh"

echo "Install jdk"
sdk install java 8.0.382-tem
sdk install java 20.0.2-tem

sdk default java 20.0.2-tem

echo "Install maven"
sdk install maven