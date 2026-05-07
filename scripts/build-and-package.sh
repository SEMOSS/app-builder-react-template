#!/usr/bin/env bash
# Build the client, then package everything inside assets/ into a zip.
# The zip contains the contents of assets/ at its root (no wrapping folder).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
CLIENT_DIR="${REPO_ROOT}/assets/client"
ASSETS_DIR="${REPO_ROOT}/assets"
ZIP_PATH="${REPO_ROOT}/assets.zip"

if ! command -v pnpm >/dev/null 2>&1; then
  echo "Error: pnpm is not installed or not on PATH." >&2
  exit 1
fi

if ! command -v zip >/dev/null 2>&1; then
  echo "Error: zip is not installed or not on PATH." >&2
  exit 1
fi

echo "==> pnpm install (client)"
pnpm --dir "${CLIENT_DIR}" install

echo "==> pnpm run build (client)"
pnpm --dir "${CLIENT_DIR}" run build

echo "==> Removing client/node_modules"
rm -rf "${CLIENT_DIR}/node_modules"

echo "==> Zipping contents of assets/ -> ${ZIP_PATH}"
rm -f "${ZIP_PATH}"
( cd "${ASSETS_DIR}" && zip -r "${ZIP_PATH}" . -x "*.DS_Store" )

echo "==> Reinstalling client dependencies"
pnpm --dir "${CLIENT_DIR}" install

echo "Done. Created ${ZIP_PATH}"
