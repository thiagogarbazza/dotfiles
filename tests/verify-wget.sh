set -euo pipefail

[[ -x "$(command -v wget)" ]] && { echo "[wget] installed successfully"; } || { echo "[wget] not installed."; exit 1; }
