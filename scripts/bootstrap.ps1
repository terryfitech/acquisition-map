$ErrorActionPreference = "Stop"

if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    throw "uv is required. Install uv, then rerun this script."
}

Write-Host "Installing locked Acquisition Map dependencies..."
uv sync --locked --all-groups

Write-Host "Bootstrap complete. Copy .dev.vars.example to .dev.vars only when you are ready to add local/staging secrets."
