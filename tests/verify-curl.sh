set -euo pipefail

[[ -x "$(command -v curl)" ]] && { echo "[curl] installed successfully"; } || { echo "[curl] not installed."; exit 1; }
