#!/bin/bash
set -euo pipefail

echo "
┌──────────────────────────────────────────────────────────────────────────────┐
├───────── Install and configuration dev kit node                     ─────────┤
└──────────────────────────────────────────────────────────────────────────────┘
"

echo "Install volta.sh"
## For more information see https://docs.volta.sh/guide/getting-started
export VOLTA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/volta"
curl -fsSL https://get.volta.sh | bash

echo "Configure XDG Base Directory specification"
