#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration dev kit docker                   ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

if [ -x "$(command -v docker)" ]; then
  echo "Docker already installed"
else
  echo "Install docker"

  case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
    *darwin*)
      brew install --cask docker
      ;;
    *linux*)
      curl -fsSL https://get.docker.com | bash
      ;;
    *)
      echo "error: unsupported platform.";
      exit 2;
      ;;
  esac;
fi

echo "User configuration"
sudo usermod -aG docker $(whoami)
