# Acquisition Map — Architecture

## 1. Architecture Goals

Acquisition Map is designed for a small operating footprint, explicit source provenance, replaceable external adapters, secure-by-default data handling, and a short path from raw property signal to human-reviewed opportunity.

## 2. Context

```text
Operator / field capture
        ↓
Acquisition Map API
        ↓
Lead Machine + Property Intelligence
        ├─ Official structured sources
        ├─ Firecrawl web extraction adapter
        ├─ Document/evidence pipeline
        └─ Valuation / buyer-fit modules
        ↓
Supabase/PostGIS canonical data
        ↓
Zoho CRM active operations
```

Cloudflare sits at the edge around the API and future asynchronous automation. R2 stores raw evidence once provisioned.

## 3. Application Structure

### FastAPI

FastAPI is the application boundary. It owns route composition, validation, authorization hooks, response schemas, OpenAPI, request correlation, and initiation of application/workflow services.

The FastAPI app is kept independent from Cloudflare-specific code so the application can move to another ASGI runtime if required.

### Cloudflare Worker Adapter

`src/acquisition_map/worker.py` is an edge adapter. It translates Cloudflare Worker requests into the FastAPI ASGI application. Cloudflare-specific bindings must not leak through the domain layer.

### Durable Automation

Long-running enrichment, retries, waits, schedules, and external-service coordination belong behind workflow interfaces. Python Workflows are not a hard v0.1 dependency because the current Cloudflare Python Workflows implementation is beta. The domain/application API must remain portable if that runtime changes.

## 4. Data Ownership

### Supabase/PostGIS

Canonical structured data includes properties, observations, source artifacts, ownership/entity links, signals, valuation runs, buyer criteria/matches, workflow state, and audit records as those capabilities are introduced.

Initial migration starts with the minimum core: properties, field observations, source artifacts, and audit events.

### R2

R2 will store immutable raw evidence such as photos, PDFs, source files, and generated dossiers. Structured metadata and relationships remain in Supabase.

### Zoho CRM

Zoho receives only active/watch/go operating records and contacts needed for human work. Full parcel history and canonical property intelligence remain outside the CRM.

## 5. Connector Architecture

Every external system is behind an adapter package. Connectors return internal contracts rather than leaking provider-specific payloads into the domain.

Initial connector boundaries:

- HCPA/property-appraiser data
- Hillsborough Clerk/public records
- Firecrawl public-web extraction
- Supabase persistence
- Zoho CRM operating synchronization

Structured official sources are preferred over extraction.

## 6. Lead Machine

The Lead Machine coordinates:

```text
intake
→ normalization
→ property resolution
→ enrichment
→ qualification
→ scoring coordination
→ buyer-fit coordination
→ routing
```

It does not become a duplicate database, web scraper, CRM, or valuation implementation.

## 7. Documents and Provenance

Every material external fact should be attributable to evidence. Source artifacts carry source identity/reference, retrieval time, content hash when available, MIME/media type, storage reference, and review state.

Raw originals are never silently overwritten.

## 8. API Boundary

Health endpoints remain unversioned. Application endpoints use `/v1/...`.

Planned API families include observations, properties, documents, decisions, valuations, buyer matches, and provider webhooks. Only implemented endpoints belong in the generated OpenAPI contract.

## 9. Security Boundary

Public traffic terminates at the edge. The API must enforce authorization before access to non-public property intelligence or operational data. Service credentials are server-side secrets only. Direct anonymous database access is denied by default through RLS.

## 10. Observability

Logs should be structured and correlate requests/actions using identifiers such as request ID, property ID, folio, source run, workflow instance, and document ID. Secrets and sensitive payloads are excluded from logs.

## 11. Failure Model

External sources are expected to fail, rate-limit, change shape, return partial data, or duplicate deliveries. Connector and workflow boundaries must support retries, idempotency, source-version detection, and manual review when confidence is insufficient.

## 12. Human Approval Gates

Automation may research, extract, normalize, enrich, score, rank, match, summarize, and route. Binding outreach, offers, contracts, signatures, title representations, and legal conclusions require authorized human action and appropriate professional review.

## 13. Deployment Environments

Use three logical environments:

- local — disposable developer environment
- staging — integration verification with non-production credentials/data
- production — live runtime with isolated secrets/resources

Do not share production service-role keys, OAuth refresh tokens, or R2 credentials with local/staging environments.

## 14. Independence

Acquisition Map has no TERRYFi runtime or repository dependency. Shared technology vendors do not imply shared accounts, projects, databases, buckets, tokens, or code.
