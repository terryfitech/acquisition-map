# Acquisition Map — Secret Matrix

| Secret / Value | Owner | Environment | Storage | Exposure Rule |
|---|---|---|---|---|
| `SUPABASE_URL` | Supabase | staging/production | Cloudflare Worker secret or approved env store | Server-side config only |
| `SUPABASE_SERVICE_ROLE_KEY` | Supabase | staging/production | Cloudflare Worker secret | Never client-side; never logged |
| `FIRECRAWL_API_KEY` | Firecrawl | staging/production | Cloudflare Worker secret | Connector-only use |
| `ZOHO_CLIENT_ID` | Zoho | staging/production | Cloudflare Worker secret | Server-side only |
| `ZOHO_CLIENT_SECRET` | Zoho | staging/production | Cloudflare Worker secret | Never client-side; never logged |
| `ZOHO_REFRESH_TOKEN` | Zoho | staging/production | Cloudflare Worker secret | Treat as long-lived credential |
| `ZOHO_ACCOUNTS_BASE_URL` | Zoho | staging/production | Config/secret binding | Non-secret value, environment-specific |
| `ZOHO_API_BASE_URL` | Zoho | staging/production | Config/secret binding | Non-secret value, environment-specific |
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare | CI/deploy | GitHub Actions variable/secret as appropriate | Do not hardcode in source |
| Cloudflare deploy token | Cloudflare | CI/deploy | GitHub Actions secret | Narrowest deployment permissions |
| `SUPABASE_PROJECT_REF` | Supabase | CI/local | GitHub Actions variable / local env | Non-secret reference; do not confuse with service key |
| Supabase DB password | Supabase | local/CI as needed | Local secret/GitHub Actions secret | Never commit |

## Rotation Rule

Rotate a secret immediately after confirmed or suspected exposure. Update the provider first, then the consuming environment. Do not reuse production credentials in local or staging environments.

## Logging Rule

Never log secret values, authorization headers, OAuth tokens, database passwords, or full provider error payloads that may echo credentials.
