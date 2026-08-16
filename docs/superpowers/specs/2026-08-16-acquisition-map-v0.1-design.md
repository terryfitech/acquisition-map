# Acquisition Map v0.1 Design Specification

## Status

Approved direction: production vertical slice, standalone repository, personal GitHub account `terryfitech`.

## Product Goal

Create a low-maintenance real-estate acquisition intelligence system that turns raw property signals into traceable, human-reviewed opportunities without becoming a second full-time platform build.

## Design Principles

1. One repository until scale proves a split is needed.
2. Official structured data before scraping.
3. Firecrawl only for web gaps.
4. Supabase/PostGIS owns canonical structured intelligence.
5. R2 owns raw evidence artifacts.
6. Zoho CRM owns human operating workflow, not parcel truth.
7. FastAPI owns the application API and remains portable.
8. Cloudflare is infrastructure, not the business domain.
9. Human approval remains mandatory for consequential legal/transaction actions.
10. No cross-project runtime dependencies.

## v0.1 Runtime Shape

```text
Field/data signal
      ↓
FastAPI application
      ↓
Cloudflare edge adapter
      ↓
Lead Machine / enrichment boundaries
      ├─ official source adapters
      ├─ Firecrawl adapter
      ├─ evidence/document boundary
      └─ valuation/buyer-fit boundary
      ↓
Supabase/PostGIS
      ↓
Zoho CRM operating subset
      ↓
GO / WATCH / PASS
```

## Initial Repository Shape

```text
src/acquisition_map/
├─ app.py
├─ worker.py
├─ api/
├─ domain/
├─ lead_machine/
├─ connectors/
├─ documents/
├─ valuation/
├─ workflows/
└─ security/
```

Supporting root directories include `tests/`, `supabase/`, `infrastructure/`, `docs/`, and `.github/`.

## Initial Database Core

The bootstrap migration creates the minimum reusable core:

- `properties`
- `field_observations`
- `source_artifacts`
- `audit_events`

RLS is enabled on all application tables with no permissive anonymous policies in the initial foundation.

## Evidence Model

A source artifact is represented by metadata and a future private-object-storage reference. Originals are immutable. Extracted fields never erase the underlying source.

## Security Model

- server-side secrets only;
- separate local/staging/production credentials;
- RLS deny-by-default;
- private evidence storage;
- baseline API security headers;
- strict webhook verification before provider webhooks are accepted;
- no credentials or production data in Git;
- dependency locking/auditing in CI;
- protected production branch before live deployment.

## Cloudflare Decision

FastAPI is supported through the Cloudflare Python Worker ASGI adapter. The application remains decoupled from the runtime. Python Workflows are not a hard v0.1 dependency because they are currently beta; the workflow package defines ownership boundaries without forcing production onto that beta surface.

## External Integrations

### HCPA / public parcel data
Preferred official structured/property source for Hillsborough parcel facts.

### Hillsborough Clerk
Official/public-record connector boundary for recorded/civil signals as specific feeds are implemented.

### Firecrawl
Permitted public-web extraction adapter for pages that lack a better structured source.

### Zoho CRM
Operating surface for active candidate/deal workflows after credentials/module design are supplied.

### Supabase
Canonical structured data store after the project is provisioned and linked.

## Explicit Exclusions From Bootstrap

The initial setup does not implement automated seller outreach, contract execution, e-signature, title conclusions, live valuation/AVM models, commercial underwriting, live CRM synchronization, or live scraping jobs.

## Definition of Ready for the Next Slice

The repository is ready for live connector implementation when it can be cloned reproducibly, dependencies are locked, unit tests and linting pass, the Supabase schema is reproducible locally, the security/secret contracts are documented, and the operator has supplied the required provider resources listed in `docs/setup/REQUIREMENTS.md`.
