# Acquisition Map — Source Registry

This registry records source authority and intended access method before connector implementation.

| Source | Purpose | Preferred Access | Authority Level | Notes |
|---|---|---|---|---|
| Hillsborough County Property Appraiser | Parcel, folio, property characteristics, ownership fields | Official structured/bulk source where available | Primary official | Use sale qualification/deed context when interpreting transaction history |
| Hillsborough Clerk | Recorded/civil/public-record signals | Official structured/bulk source where available | Primary official | Implement only specific feeds after verifying current format and retention |
| Firecrawl | Public web extraction and discovery | API adapter | Extraction only | Never authoritative; preserve original page URL and retrieval time |
| Zoho CRM | Active acquisition operations | API/webhooks | Operational system | Not canonical parcel/property intelligence |
| Supabase/PostGIS | Canonical structured property intelligence | Database/API | Internal source of truth | RLS deny-by-default at bootstrap |
| Cloudflare R2 | Raw evidence artifacts | Object storage | Internal evidence store | Private bucket; immutable-original policy |

## Source Precedence

Prefer, when practical:

1. official structured API/feed;
2. official bulk dataset;
3. official webpage;
4. trusted structured third-party source;
5. web extraction;
6. inference.

## Provenance Minimum

For material facts preserve where applicable: source name/type, source URL/reference, retrieval timestamp, effective date, original artifact reference, content hash, extraction method, confidence/review state.

## Connector Acceptance Rule

A source does not become a production connector merely because a page can be scraped. Before implementation, verify the current access method, terms/permission, data shape, rate/refresh behavior, failure modes, and provenance mapping.
