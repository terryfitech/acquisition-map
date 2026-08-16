# Acquisition Map — Product Contract

**Repository:** `terryfitech/acquisition-map`  
**Status:** v0.1 production foundation

## Purpose

Acquisition Map is a standalone real-estate acquisition intelligence system that reduces large volumes of property signals into a small number of verified, human-reviewed opportunities.

The system combines field observations, parcel and ownership records, public-record signals, listing/market context, valuation evidence, buyer criteria, and document provenance into a canonical property intelligence record.

Primary operator outcome: **GO / WATCH / PASS**.

## Product Principle

The operator should spend time on opportunities, not repetitive research.

```text
Signal
→ Intake
→ Property resolution
→ Enrichment
→ Evidence/provenance
→ Qualification
→ Valuation/buyer fit
→ GO / WATCH / PASS
→ Human action
```

## Lead Machine

The Lead Machine is the front door of Acquisition Map. It owns intake, normalization, qualification coordination, scoring coordination, and routing.

Initial signal classes include field observations, For Sale/Coming Soon, stale or price-reduced listings, absentee/entity ownership, professional SFR ownership, foreclosure/lis-pendens, probate/estate, tax/code distress, vacancy, commercial, and land/development signals.

## Core Technology Boundaries

- **FastAPI:** application API, validation, authorization, application services, OpenAPI, workflow invocation.
- **Cloudflare:** edge runtime, future durable automation, R2 evidence storage, schedules/webhooks.
- **Supabase/PostGIS:** canonical structured property intelligence.
- **Zoho CRM:** human acquisition operations; never the parcel database.
- **Firecrawl:** replaceable public-web extraction adapter; never a source of truth.
- **GitHub:** source, review, CI, architecture history.

## Documents and Evidence

Material facts must be traceable to evidence. Raw originals are immutable. Structured extractions do not replace the source artifact.

Examples include field photos, property-appraiser records, deeds, mortgages, liens, foreclosure records, probate records, tax/code records, entity records, listing evidence, title reports, contracts, and closing documents.

## Decision States

`NEW`, `RESEARCHING`, `WATCH`, `GO`, `PASS`, `CONTRACTED`, `DISPOSITION`, `CLOSING`, `CLOSED`, `DEAD`.

A `GO` state does not authorize automatic outreach, offers, contracts, signatures, or legal conclusions.

## v0.1 Scope

v0.1 proves one secure production vertical slice:

```text
Field observation
→ evidence
→ address/folio resolution boundary
→ canonical property record
→ owner/source enrichment boundary
→ provenance
→ Zoho synchronization boundary
→ GO / WATCH / PASS
```

Live connector credentials and consequential transaction automation are outside the initial repository bootstrap.

## Success Criteria

The foundation is ready for implementation when a developer can clone the repository, install locked dependencies, run tests, understand component ownership, configure local secrets without committing them, recreate the local database from migrations, and see exactly which external resources are still required.

## Explicit Non-Goals

Acquisition Map v0.1 is not a generic CRM, MLS replacement, title company, autonomous real-estate agent, generalized scraping platform, document-signing platform, or collection of unrelated microservices.

## Independence

Acquisition Map is an independent side project. It must not depend on any TERRYFi repository, internal service, database, package, agent, governance framework, secret, deployment resource, or branding. Any future cross-project integration must use an explicit external interface.

## Product Rule

Automation may collect, normalize, enrich, reconcile, score, rank, match, summarize, route, and prepare. Humans retain control of consequential legal and transaction decisions.
