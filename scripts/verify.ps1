$ErrorActionPreference = "Stop"

Write-Host "Running Ruff..."
uv run ruff check .

Write-Host "Compiling Python source..."
uv run python -m compileall -q src

Write-Host "Running tests..."
uv run pytest -q

Write-Host "Auditing dependencies..."
uv run pip-audit

Write-Host "Verification complete."
