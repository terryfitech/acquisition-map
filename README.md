# Acquisition Map

Standalone real-estate acquisition intelligence and lead-qualification system.

## Start Here

Read these contracts before changing the repository:

1. [`PRODUCT.md`](./PRODUCT.md) — product purpose and boundaries
2. [`MAP.md`](./MAP.md) — component ownership and repository navigation
3. [`ARCHITECTURE.md`](./ARCHITECTURE.md) — technical design
4. [`SECURITY.md`](./SECURITY.md) — security requirements
5. [`AGENTS.md`](./AGENTS.md) — coding-agent rules

## Stack

- Python 3.13
- FastAPI
- Cloudflare Python Workers edge adapter
- Supabase/Postgres/PostGIS
- Cloudflare R2 for future raw evidence storage
- Firecrawl connector for permitted public-web extraction
- Zoho CRM for future human acquisition operations
- uv + pytest + Ruff + GitHub Actions

## Local Setup

```bash
git clone https://github.com/terryfitech/acquisition-map.git
cd acquisition-map
uv sync --all-groups
uv run pytest
uv run ruff check .
```

Cloudflare local development after secrets are configured:

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
