#!/usr/bin/env bash
set -euo pipefail

if ! command -v uv >/dev/null 2>&1; then
  echo "uv is required. Install uv, then rerun this script." >&2
  exit 1
fi

echo "Installing locked Acquisition Map dependencies..."
uv sync --locked --all-groups

echo "Bootstrap complete. Copy .dev.vars.example to .dev.vars only when you are ready to add local/staging secrets."
