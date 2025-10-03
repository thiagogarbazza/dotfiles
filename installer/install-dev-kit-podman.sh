#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration dev kit podman                   ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
  *darwin*)
    brew install podman
    ;;
  *linux*)
    if [ -x "$(command -v apt)" ]; then
      sudo apt install --assume-yes podman
    elif [ -x "$(command -v pacman)" ]; then
      sudo pacman --sync --noconfirm podman
    else
      echo "error: unsupported linux distribution."
      exit 3
    fi
    ;;
  *)
    echo "error: unsupported platform."
    exit 2
    ;;
esac;
