set -euo pipefail

for f in tests/verify-*.sh; do
  echo "Run test: $f"
  $f
done
