set -euo pipefail

[[ -x "$(command -v git)" ]] && { echo "[git] installed successfully"; } || { echo "[git] not installed."; exit 1; }
[[ "$(git config --global user.name)" == "Thiago Garbazza" ]] && { echo "[git] configured successfully"; } || { echo "[git] configuration is incorrect."; exit 1; }
