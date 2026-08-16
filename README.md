# Acquisition Map

Standalone real-estate acquisition intelligence and lead-qualification system.

## Start Here

Read these contracts before changing the repository:

1. [`PRODUCT.md`](./PRODUCT.md) — product purpose and boundaries
2. [`MAP.md`](./MAP.md) — component ownership and repository navigation
3. [`ARCHITECTURE.md`](./ARCHITECTURE.md) — technical design
4. [`SECURITY.md`](./SECURITY.md) — security requirements
5. [`AGENTS.md`](./AGENTS.md) — coding-agent rules

Security operations are documented in [`docs/security/`](./docs/security/), including the threat model, secret matrix, and incident-response runbook.

## Stack

- Python 3.13
- FastAPI
- Cloudflare Python Workers edge adapter
- Supabase/Postgres/PostGIS
- Cloudflare R2 for future raw evidence storage
- Firecrawl connector for permitted public-web extraction
- Zoho CRM for future human acquisition operations
- uv + pytest + Ruff + GitHub Actions

## Clone the Setup Branch

Until the production-foundation PR is merged, clone and switch to the setup branch:

```bash
git clone https://github.com/terryfitech/acquisition-map.git
cd acquisition-map
git switch setup/production-foundation
```

### Windows / PowerShell

```powershell
./scripts/bootstrap.ps1
./scripts/verify.ps1
```

### Direct commands

```bash
uv sync --locked --all-groups
uv run ruff check .
uv run python -m compileall -q src
uv run pytest -q
uv run pip-audit
```

Cloudflare local development only after local/staging secrets are configured:

```bash
cp .dev.vars.example .dev.vars
uv run pywrangler dev
```

Never commit `.dev.vars` or `.env`.

## External Resources

The repository intentionally contains no live credentials. See [`docs/setup/REQUIREMENTS.md`](./docs/setup/REQUIREMENTS.md) for the exact Cloudflare, Supabase, Firecrawl, and Zoho resources needed for the next implementation slice.

## Current Scope

The production foundation provides repository contracts, security controls, a minimal FastAPI/Worker health surface, secure-by-default database migrations, connector boundaries, CI, and setup documentation.

Live scraping, CRM sync, property enrichment, seller outreach, contract execution, and valuation models are not enabled by the bootstrap.

## Independence

This project is independent. It has no TERRYFi repository, database, service, package, governance, secret, or runtime dependency.
