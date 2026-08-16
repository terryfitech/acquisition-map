# Contributing to Acquisition Map

## Start With the Contracts

Before making a substantial change, read `PRODUCT.md`, `MAP.md`, `ARCHITECTURE.md`, `SECURITY.md`, and `AGENTS.md`.

## Branching

Do not develop directly on `main`. Use a focused branch and open a pull request.

## Local Verification

```bash
uv sync --locked --all-groups
uv run ruff check .
uv run python -m compileall -q src
uv run pytest -q
uv run pip-audit
```

Windows users can run `./scripts/verify.ps1` after dependencies are installed.

## Architecture

Extend the existing ownership boundary before creating a new service/package/integration. If ownership changes, update `MAP.md` and the relevant architecture documentation.

## Database

All schema changes are committed migrations. Do not use manual production schema edits as the source of truth. Review constraints, indexes, RLS, rollback implications, and tests.

## Security

Never commit secrets, credentials, private evidence, or production customer/property documents. Consequential transaction actions must remain human-authorized unless an explicitly approved product requirement says otherwise.

## Pull Requests

Use the repository PR template. Report the exact verification commands run and any external setup that remains manual.
