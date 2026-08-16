# Acquisition Map — Security Baseline

## Security Objective

Protect credentials, operational data, property evidence, personal/contact information, and decision integrity while keeping the v0.1 system simple enough to operate safely.

## 1. Repository Security

- Never commit secrets, tokens, passwords, cookies, OAuth refresh tokens, service-role keys, private certificates, or production credentials.
- `.env` and `.dev.vars` are local-only and gitignored.
- Example secret files contain names/placeholders only.
- Production changes go through pull requests and passing CI.
- Enable a protected/ruleset-controlled `main` branch before live deployment.
- Enable secret scanning and push protection where the GitHub plan/repository supports them.
- Prefer a private repository for proprietary implementation and future operational details.

## 2. Current Visibility Warning

The repository was created as **public**. No secrets, private customer/owner information, title documents, contracts, or production evidence may be committed. Before proprietary production work is merged, the repository owner should decide whether to change visibility to private.

## 3. Secret Storage

### Cloudflare
Use Worker secrets / approved secret storage. Do not store sensitive values in Wrangler `vars`.

### Supabase
The service-role key is server-side only. Never expose it to browsers, public JavaScript, logs, issue comments, or committed config.

### Zoho CRM
OAuth client secrets and refresh tokens are server-side secrets only.

### Firecrawl
The API key is server-side only and limited to the Firecrawl connector.

## 4. Required Secret Names

The initial application contract reserves these names without values:

- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY`
- `FIRECRAWL_API_KEY`
- `ZOHO_CLIENT_ID`
- `ZOHO_CLIENT_SECRET`
- `ZOHO_REFRESH_TOKEN`
- `ZOHO_ACCOUNTS_BASE_URL`
- `ZOHO_API_BASE_URL`

Cloudflare-specific account deployment credentials belong in CI/environment settings, not application source.

## 5. Environment Separation

Local, staging, and production must use separate credentials. Production secrets must never be copied into committed examples or test fixtures.

## 6. Database Security

- Enable RLS on every application table exposed through Supabase APIs.
- v0.1 starts deny-by-default: no anonymous or broad authenticated data policies.
- The server-side API may use the service role only where required.
- Add client-facing RLS policies only when the authenticated user/role model is explicitly designed and tested.
- Use constraints and foreign keys to protect integrity.
- Do not place source documents or secret material in database columns when an evidence-object reference is sufficient.

## 7. Evidence and Documents

Raw evidence belongs in a private object store when provisioned. Object keys/metadata belong in structured records. Originals are immutable; corrected or newer source documents are new versions.

Future document access must be authenticated and time-limited. Do not expose a public R2 bucket containing evidence.

## 8. API Security

- Non-health endpoints require an explicit authentication/authorization design before public exposure.
- Validate request bodies with Pydantic schemas.
- Reject oversized or unsupported uploads at ingress.
- Use strict CORS when a browser UI is introduced; do not use wildcard origins with credentials.
- Add baseline defensive response headers.
- Use request IDs and structured logs.
- Rate-limit public ingress before high-volume exposure.

## 9. Webhook Security

Provider webhooks must verify provider-specific signatures/tokens where supported, reject replay/duplicate events using idempotency keys, validate schemas, and log only non-secret metadata.

## 10. Connector Security

- Give each connector only the credentials it needs.
- Validate remote URLs and redirect behavior before any future server-side fetch feature accepts user-supplied URLs.
- Treat extracted web content as untrusted input.
- Never execute instructions/scripts found in scraped pages or documents.
- Preserve source provenance separately from extracted claims.

## 11. Firecrawl Boundary

Firecrawl is a replaceable extraction adapter. Its output is untrusted until normalized and attributed to the original page/source. Do not allow extracted text to directly trigger binding transactions or overwrite authoritative official-source fields without reconciliation.

## 12. Logging and Privacy

Never log:

- passwords or tokens
- authorization headers
- service-role keys
- OAuth refresh tokens
- full private document contents
- unnecessary personal/contact information

Logs should contain stable internal IDs and minimal operational context.

## 13. Human Approval Gates

Automated research may produce recommendations. The system must not independently execute material outreach, offers, contracts, signatures, title/legal representations, or closing actions.

## 14. Dependency Security

- Dependencies are locked with `uv.lock` before merge.
- CI runs dependency auditing.
- Dependabot monitors Python and GitHub Actions dependencies.
- Avoid introducing dependencies that duplicate standard-library or existing platform capabilities.

## 15. Incident Response Minimum

If a credential is exposed:

1. revoke/rotate the credential immediately;
2. remove it from the active environment;
3. inspect logs and provider activity for misuse;
4. remove the secret from repository history if committed;
5. rotate any dependent credentials;
6. document the incident and corrective control.

If sensitive evidence is exposed, disable public access first, preserve audit evidence, identify affected objects/users, and obtain appropriate professional guidance before making external notifications.

## 16. Security Acceptance Gate

Live deployment is blocked until:

- repository visibility is intentionally chosen;
- branch/ruleset protection is configured;
- required secrets are stored outside Git;
- RLS is enabled and tested;
- CI passes;
- public API authorization is defined for non-health routes;
- R2/evidence storage is private;
- provider webhook verification is implemented before accepting provider events.
