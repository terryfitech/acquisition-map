# Acquisition Map — Agent Instructions

## Mission

You are operating inside `terryfitech/acquisition-map`, a standalone real-estate acquisition intelligence system.

Your job is to extend, test, debug, document, and maintain this repository without creating unnecessary architecture or cross-project dependencies.

## Required Context Order

Before substantial work, read:

1. `PRODUCT.md`
2. `MAP.md`
3. `ARCHITECTURE.md`
4. `SECURITY.md`
5. relevant ADRs/specs/plans under `docs/`
6. current implementation
7. current tests

## Authority Order

- Product behavior: `PRODUCT.md`
- Component ownership/navigation: `MAP.md`
- Technical architecture: `ARCHITECTURE.md`
- Security requirements: `SECURITY.md`
- Accepted decisions/specs: `docs/`
- Executable reality: merged code and tests

If documentation and implementation conflict, surface the conflict. Do not silently choose one.

## Independence Rule

This repository must remain independent. Do not import or depend on TERRYFi repositories, services, databases, packages, agents, governance, secrets, runtime resources, or branding.

## Architecture Rule

Before creating a new service, directory, package, workflow, connector, table, queue, API, integration, abstraction, or framework:

1. Check `MAP.md`.
2. Inspect the existing owning boundary.
3. Extend the existing boundary when appropriate.
4. Prefer an adapter over a new platform.
5. Create a new component only when no existing component owns the responsibility.
6. Update `MAP.md` and architecture docs when ownership changes.

## Core Boundaries

### FastAPI
Owns HTTP API contracts, request validation, auth enforcement, application services, OpenAPI, and workflow initiation.

### Cloudflare
Owns edge execution, R2 evidence storage, scheduled/webhook entry points, and future durable workflows. Do not bury domain rules inside runtime adapters.

### Supabase/PostGIS
Owns canonical structured property intelligence.

### Zoho CRM
Owns human acquisition operations. It is not the canonical parcel/property database.

### Firecrawl
Owns public-web extraction only where a better structured source is unavailable. Map extracted data into internal contracts and preserve provenance.

## Lead Machine Boundary

`lead_machine` owns intake, normalization, qualification coordination, scoring coordination, and routing. It does not own source-specific parsing, document storage, CRM implementation, or valuation algorithms.

## Property Identity

Prefer stable official parcel/folio identifiers when available. Never merge property records solely because display addresses look similar.

## Provenance Requirement

Any externally derived fact capable of affecting an acquisition decision must be traceable where applicable to source ID, source URL/reference, source type, retrieval timestamp, effective date, original artifact, content hash, extraction method, confidence, and review state.

## Document Rule

Raw originals are immutable evidence. Revised source documents are new versions. Generated documents must remain distinguishable from source documents.

## Data Source Rule

Prefer sources in this order when practical:

1. official structured API/feed
2. official bulk dataset
3. official webpage
4. trusted structured third-party source
5. web extraction
6. inference

Do not scrape a website when an appropriate structured official dataset already exists.

## Automation Safety

The system may automatically ingest, normalize, extract, enrich, reconcile, score, rank, match, summarize, route, and prepare.

Human authorization is required before material outreach, offers, contracts, signatures, title representations, or legal conclusions.

## Database Changes

All schema changes use version-controlled migrations. Production schema changes are never implemented manually as the source of truth. Review constraints, indexes, RLS, rollback implications, and tests.

## API Rules

Application endpoints are versioned under `/v1` except health/readiness endpoints. Use explicit Pydantic request/response models. Do not expose raw database tables as the API contract.

## Connector Reliability

External connectors must handle timeout, rate limit, unavailable source, malformed payload, source-schema change, duplicate delivery, partial response, and authentication failure. Make replayable operations idempotent where practical.

## Observability

Important executions should carry structured identifiers such as `request_id`, `workflow_id`, `property_id`, `folio`, `source_run_id`, and `document_id` when relevant. Never log secrets.

## Secrets

Never commit API keys, OAuth secrets, service-role keys, tokens, cookies, database passwords, or production credentials. Example files contain names/placeholders only. Actual values belong in approved secret stores.

## Testing

Use unit tests for domain/application behavior, connector contract tests, parser fixtures, API tests, database/RLS tests, workflow tests, and integration tests where appropriate.

Do not claim production-ready, deployed, integrated, verified, or passing without evidence.

## Agent Execution Format

Before substantial implementation, report:

- **UNDERSTOOD** — requested change
- **CURRENT STATE** — relevant existing components
- **PLAN** — files/components expected to change
- **RISKS** — architecture, security, data, or regression concerns

After execution, report:

- **CHANGED** — files modified
- **VERIFIED** — commands/tests actually run and results
- **REMAINING** — anything requiring human action or unavailable credentials

## Final Rule

Keep Acquisition Map small, traceable, secure, and replaceable at the edges. Automate repetitive research; preserve evidence; put only worthwhile decisions in front of the operator.
