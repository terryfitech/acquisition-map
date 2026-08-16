# Acquisition Map — External Setup Requirements

This repository is intentionally clone-ready without live credentials. The following resources are required before enabling live integrations.

## 1. GitHub

Repository: `terryfitech/acquisition-map`

Owner actions before production merge/deploy:

- Decide whether the repository remains public or becomes private. Private is recommended before proprietary implementation or operational data is introduced.
- Add a ruleset/branch protection for `main`.
- Require pull requests before merge.
- Require the CI workflow to pass before merge.
- Block force pushes and branch deletion on `main`.
- Enable secret scanning and push protection where available.
- Keep GitHub Actions permissions read-only by default; grant write permissions only to workflows that explicitly need them.

## 2. Cloudflare

Create dedicated Acquisition Map resources, separate from every other project:

- Worker/application name: `acquisition-map-api`
- Staging Worker/resource set
- Production Worker/resource set
- Private R2 bucket for raw evidence, suggested names:
  - `acquisition-map-evidence-staging`
  - `acquisition-map-evidence-production`
- Cloudflare API token for CI deployment with the narrowest required permissions

Do not send the Cloudflare API token in chat or commit it to Git. Store deployment credentials in GitHub Actions secrets and application credentials as Cloudflare Worker secrets.

## 3. Supabase

Create separate Acquisition Map projects/resources:

- staging project
- production project
- PostGIS enabled through the committed migration
- database backups configured appropriately for production

Needed references/secrets:

- `SUPABASE_PROJECT_REF`
- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY`
- local/staging database password for CLI linking when required

The service-role key must remain server-side only.

## 4. Firecrawl

Create/use a dedicated API key for Acquisition Map.

Needed secret:

- `FIRECRAWL_API_KEY`

Initial allowed purpose: permitted public-web extraction only when an official structured source is unavailable or insufficient.

## 5. Zoho CRM

Prepare a dedicated Acquisition Map integration/application and determine the Zoho data-center URLs for the account.

Needed values:

- `ZOHO_CLIENT_ID`
- `ZOHO_CLIENT_SECRET`
- `ZOHO_REFRESH_TOKEN`
- `ZOHO_ACCOUNTS_BASE_URL`
- `ZOHO_API_BASE_URL`

Before live sync, define/confirm the CRM modules and external-ID fields for active acquisition properties and buyer criteria. Do not mirror the full parcel database into Zoho.

## 6. Official/Public Data Sources

No credential should be added until the exact source and permitted access method are confirmed.

Initial source boundaries:

- Hillsborough County Property Appraiser — parcel/property facts
- Hillsborough Clerk — applicable public/official records
- other official structured feeds added only after source contract and provenance fields are documented

## 7. Local Developer Tools

Recommended local requirements:

- Git
- Python 3.13
- uv
- Docker-compatible runtime for the Supabase local stack
- Supabase CLI
- Cloudflare Wrangler/Pywrangler through the project dependency environment

After cloning:

```bash
uv sync --all-groups
uv run pytest
uv run ruff check .
```

For Supabase local development, initialize/start with the Supabase CLI after installing it, then verify the committed migration with `supabase db reset`.

## 8. Do Not Send or Commit

Do not place any of the following in GitHub issues, PR descriptions, screenshots, chat messages, fixture files, or repository commits:

- API keys
- OAuth client secrets
- refresh tokens
- Supabase service-role keys
- database passwords
- private title/closing documents
- private owner/customer contact information
- production evidence files

When the resources above are ready, only report the resource names/project references needed for configuration. Enter secrets directly into the appropriate provider secret store.
