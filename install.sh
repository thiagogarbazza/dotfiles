#!/bin/bash
set -euo pipefail

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state

echo "Remove old directories"
rm -rf \
  $XDG_CONFIG_HOME \
  $XDG_CACHE_HOME \
  $XDG_DATA_HOME \
  $XDG_STATE_HOME \
  $HOME/projects/my \
  $HOME/projects/pocs

echo "Create directories"
mkdir -p \
  $XDG_CACHE_HOME \
  $XDG_DATA_HOME \
  $XDG_STATE_HOME \
  $HOME/projects/my \
  $HOME/projects/pocs

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration tools                            ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

echo "Copying configuration files"
cp --recursive --force --archive config $XDG_CONFIG_HOME

case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
  *darwin*)
    brew install curl git tmux unzip wget zip zsh
    #bash installer/install-apps-macos.sh
    #bash installer/install-theme-macos.sh
    ;;
  *linux*)
    if [ -x "$(command -v apt)" ]; then
      sudo apt update
      sudo apt install --assume-yes curl git make tmux unzip wget zip zsh \
        build-essential libbz2-dev libffi-dev liblzma-dev libncursesw5-dev \
        libreadline-dev libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev \
        tk-dev xz-utils zlib1g-dev
    elif [ -x "$(command -v pacman)" ]; then
      sudo pacman --sync --noconfirm curl git tmux unzip wget zip zsh
    else
      echo "error: unsupported linux distribution."
      exit 3
    fi

    #bash installer/install-apps-linux.sh
    #bash installer/install-theme-linux.sh
    ;;
  *)
    echo "error: unsupported platform."
    exit 2
    ;;
esac;

bash installer/install-fonts.sh
bash installer/install-dev-kit-docker.sh
bash installer/install-dev-kit-java.sh
bash installer/install-dev-kit-node.sh
bash installer/install-dev-kit-podman.sh
bash installer/install-dev-kit-python.sh
bash installer/install-ssh.sh
bash installer/install-tmux.sh
bash installer/install-zsh.sh
