#!/usr/bin/env bash
# Sync skills from SEMOSS/Platform-Skills (main) into assets/client/.claude/skills.
# Wipes the target directory and replaces it with the contents of the repo.

set -euo pipefail

REPO="SEMOSS/Platform-Skills"
BRANCH="main"
TARBALL_URL="https://github.com/${REPO}/archive/refs/heads/${BRANCH}.tar.gz"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
TARGET_DIR="${REPO_ROOT}/assets/client/.claude/skills"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

echo "Downloading ${REPO}@${BRANCH}..."
curl -fsSL "${TARBALL_URL}" | tar -xz -C "${TMP_DIR}"

EXTRACTED_DIR="$(find "${TMP_DIR}" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
if [[ -z "${EXTRACTED_DIR}" ]]; then
  echo "Error: could not find extracted directory in ${TMP_DIR}" >&2
  exit 1
fi

echo "Clearing ${TARGET_DIR}..."
rm -rf "${TARGET_DIR}"
mkdir -p "${TARGET_DIR}"

echo "Copying skills..."
if command -v rsync >/dev/null 2>&1; then
  rsync -a \
    --exclude='.git' \
    --exclude='.gitignore' \
    --exclude='.DS_Store' \
    "${EXTRACTED_DIR}/" "${TARGET_DIR}/"
else
  cp -R "${EXTRACTED_DIR}/." "${TARGET_DIR}/"
  find "${TARGET_DIR}" -name '.DS_Store' -delete
  rm -rf "${TARGET_DIR}/.git" "${TARGET_DIR}/.gitignore"
fi

echo "Done. Skills synced to ${TARGET_DIR}"
