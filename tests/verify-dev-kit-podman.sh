set -euo pipefail

[[ -x "$(command -v podman)" ]] && { echo "[podman] installed successfully"; } || { echo "[podman] not installed."; exit 1; }
