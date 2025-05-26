#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration dev kit python                   ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

echo "Install pyenv"
## For more information see https://github.com/pyenv/pyenv
export PYENV_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/pyenv"
curl -fsSL "https://pyenv.run" | bash

echo "Configure XDG Base Directory specification"
