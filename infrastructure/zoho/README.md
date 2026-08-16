# Zoho CRM Integration Boundary

Zoho CRM is the future human operating surface for active Acquisition Map opportunities.

## Intended Scope

- active acquisition properties
- owner/agent/buyer contacts needed for operations
- buyer buy boxes
- tasks and activities
- transaction/deal stages

## Explicit Boundary

Zoho is not the canonical parcel/property database. Full property history, source provenance, evidence metadata, valuation inputs, and ownership intelligence remain in Supabase/PostGIS.

## Sync Rule

Use stable internal property IDs and official folio/parcel identifiers where available. Sync must be idempotent and use explicit external-ID fields before live writes are enabled.

## Security

OAuth client secrets and refresh tokens are server-side secrets only. Webhooks must be authenticated/verified where supported and deduplicated before processing.
