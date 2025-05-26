set -euo pipefail

[[ -x "$(command -v git)" ]] || { echo "[git] not installed."; exit 1; }
[[ "$(git config --global user.name)" == "Thiago Garbazza" ]] || { echo "[git] configuration is incorrect."; exit 1; }
