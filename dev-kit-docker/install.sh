#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration dev kit docker                   ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

USERNAME=$(whoami)

curl -fsSL https://get.docker.com | bash
sudo usermod -aG docker $USERNAME
