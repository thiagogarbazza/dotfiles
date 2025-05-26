#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration tmux                             ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

TMUX_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/tmux"

echo "Install plugins"
git clone --depth=1 https://github.com/tmux-plugins/tpm $TMUX_DATA_HOME/plugins/tpm

