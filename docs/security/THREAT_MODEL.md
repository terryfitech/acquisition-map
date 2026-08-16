# Acquisition Map — Threat Model

## Scope

This threat model covers the v0.1 repository foundation and the planned trust boundaries between the operator, FastAPI/Cloudflare runtime, Supabase/PostGIS, R2 evidence storage, Firecrawl, Zoho CRM, and official/public data sources.

## Protected Assets

Primary assets include:

- provider credentials and OAuth tokens;
- canonical property and ownership intelligence;
- private owner/contact information when later collected;
- raw field photos and source documents;
- title/contract/closing documents when later introduced;
- source provenance and evidence hashes;
- acquisition decisions and audit history;
- proprietary scoring, valuation, and buyer-matching logic.

## Trust Boundaries

```text
Untrusted Internet / external sources
            ↓
Cloudflare edge / FastAPI ingress
            ↓
Application authorization + validation
            ↓
Canonical data / private evidence storage
            ↓
Authorized operator / CRM workflow
```

Firecrawl results, scraped pages, uploaded files, provider webhooks, and all external API responses are treated as untrusted input until validated and reconciled.

## Primary Threats and Controls

### Credential exposure

**Threats:** committed secrets, leaked CI tokens, secrets in logs, credentials copied between environments.

**Controls:** gitignore, example-only env files, provider secret stores, read-only default CI token, high-confidence secret-pattern CI check, separate staging/production credentials, documented rotation process.

### Unauthorized API/data access

**Threats:** public endpoints exposing property intelligence or private documents; overbroad database policies.

**Controls:** only health endpoint is public in bootstrap; non-health routes require explicit auth design before exposure; RLS enabled deny-by-default; service role stays server-side; evidence buckets remain private.

### Injection / malicious source content

**Threats:** scraped pages or uploaded documents containing prompt-like instructions, scripts, malformed data, or payloads intended to alter system behavior.

**Controls:** treat external content as data, never instructions; validate schemas/types; do not execute scraped content; isolate parsers/connectors; preserve source provenance; require human review for material conclusions.

### SSRF / unsafe fetching

**Threats:** future user-supplied URLs targeting internal/private network resources.

**Controls:** no generic arbitrary-URL fetch endpoint in v0.1; future URL ingestion must validate scheme, host, redirect chain, destination classes, and connector purpose before server-side fetch.

### Webhook spoofing/replay

**Threats:** forged or duplicate provider events changing CRM/property state.

**Controls:** verify provider signatures/tokens where supported; schema validation; timestamp/replay checks; idempotency keys; audit events; no consequential transaction action directly from webhook input.

### Data poisoning / source conflict

**Threats:** incorrect listing/web data overriding official parcel/record facts or generating false opportunities.

**Controls:** source precedence registry; Firecrawl is extraction-only; record provenance/confidence; reconcile conflicts instead of silent overwrite; human approval at consequential gates.

### Duplicate/incorrect property identity

**Threats:** address variations merging distinct parcels or duplicate records creating incorrect ownership/deal conclusions.

**Controls:** prefer official folio/parcel identifier; unique folio where present; normalize but do not rely solely on display address; future entity/property resolution must retain evidence/confidence.

### Evidence tampering

**Threats:** overwritten or modified raw records/photos make decisions non-auditable.

**Controls:** immutable-original policy; content hashes where practical; version new artifacts rather than overwrite; private object storage; source-artifact records and audit events.

### Dependency/supply-chain compromise

**Threats:** vulnerable Python dependencies or mutable CI actions.

**Controls:** committed `uv.lock`; `pip-audit`; Dependabot; GitHub Actions pinned to immutable SHAs; minimal dependency policy; PR review before production merge.

### Accidental cross-project coupling

**Threats:** importing another project's secrets, databases, runtime, or governance creates unexpected access and blast radius.

**Controls:** explicit independence contracts in `PRODUCT.md`, `MAP.md`, `ARCHITECTURE.md`, `SECURITY.md`, and PR checklist; dedicated provider resources for Acquisition Map.

## Consequential-Action Boundary

The system may collect, normalize, enrich, reconcile, score, rank, match, summarize, and route. Binding outreach, offers, contracts, signatures, title/legal representations, and closing actions require authorized human control and appropriate professional review.

## Residual Risks Before Production

Production remains blocked until repository visibility is intentionally selected, `main` is protected by a ruleset, provider resources/secrets are isolated, R2 is private, Supabase RLS migrations are applied/tested, non-health authentication is implemented, and live webhook/provider verification is tested.

## Review Trigger

Update this threat model when a new external connector, public endpoint, authentication model, document class, browser/mobile client, autonomous action, or consequential transaction capability is introduced.
