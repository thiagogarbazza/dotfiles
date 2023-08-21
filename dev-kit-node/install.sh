#!/bin/bash

export VOLTA_HOME=$HOME/.config/volta

echo "┌──────────────────────────────────────────────────────────────────────────────┐"
echo "├───────── Install and configuration dev kit node                     ─────────┤"
echo "└──────────────────────────────────────────────────────────────────────────────┘"

echo "Install Volta"
## For more information see https://docs.volta.sh/guide/getting-started
curl -s https://get.volta.sh | bash

export PATH="$VOLTA_HOME/bin:$PATH"

echo "Install Nodejs"
volta install node
