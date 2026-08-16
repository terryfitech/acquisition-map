#!/usr/bin/env bash
set -euo pipefail

echo "Running Ruff..."
uv run ruff check .

echo "Compiling Python source..."
uv run python -m compileall -q src

echo "Running tests..."
uv run pytest -q

echo "Auditing dependencies..."
uv run pip-audit

echo "Verification complete."
