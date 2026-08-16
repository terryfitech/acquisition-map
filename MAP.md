# Acquisition Map — Repository Map

**Repository:** `terryfitech/acquisition-map`  
**Purpose:** Fast navigation and ownership map for humans and coding agents.

## System Flow

```text
Property Signals
├─ Field capture
├─ HCPA / parcel data
├─ Hillsborough Clerk / public records
├─ Listing and market pages
├─ Firecrawl web extraction where needed
└─ Future distress/commercial/land signals
        ↓
Lead Machine
        ↓
Property Intelligence + Provenance
        ↓
Valuation / Buyer Fit
        ↓
GO / WATCH / PASS
        ↓
Zoho CRM human operations
```

## Runtime Ownership

```text
FastAPI application
    ↓
Cloudflare Python Worker adapter
    ├─ future R2 evidence binding
    ├─ future workflow/schedule bindings
    └─ external connector calls
    ↓
Supabase/PostGIS canonical structured data
    ↓
Zoho CRM active acquisition operations
```

## Repository Map

```text
acquisition-map/
├─ README.md
├─ PRODUCT.md
├─ AGENTS.md
├─ MAP.md
├─ ARCHITECTURE.md
├─ SECURITY.md
├─ CONTRIBUTING.md
├─ CHANGELOG.md
├─ LICENSE
├─ THIRD_PARTY_NOTICES.md
├─ pyproject.toml
├─ uv.lock
├─ wrangler.jsonc
├─ .env.example
├─ .dev.vars.example
│
├─ src/acquisition_map/
│  ├─ app.py                  # FastAPI application composition
│  ├─ worker.py               # Cloudflare Worker/ASGI adapter
│  ├─ api/                    # HTTP routes/contracts
│  ├─ domain/                 # Canonical business concepts/rules
│  ├─ lead_machine/           # Intake, qualification coordination, routing
│  ├─ connectors/             # External-source adapters
│  │  ├─ hcpa/
│  │  ├─ hillsborough_clerk/
│  │  ├─ firecrawl/
│  │  ├─ supabase/
│  │  └─ zoho/
│  ├─ documents/              # Evidence/document lifecycle
│  ├─ valuation/              # Future valuation methods
│  ├─ workflows/              # Durable-process definitions/interfaces
│  └─ security/               # API/security controls
│
├─ scripts/                   # Windows/Unix bootstrap and verification helpers
├─ tests/                     # Unit/integration/contract tests
├─ supabase/                  # Local config, migrations, seed, future DB tests
├─ infrastructure/            # Provider setup/runbook docs
├─ docs/
│  ├─ data-sources/           # Source authority/precedence
│  ├─ security/               # Threat model, secrets, incident response
│  ├─ setup/                  # External resources and clone/setup needs
│  └─ superpowers/            # Approved design and execution plans
└─ .github/                   # CI, CODEOWNERS, dependency updates, PR controls
```

## Source-of-Truth Matrix

| Domain | Authority |
|---|---|
| Product behavior | `PRODUCT.md` |
| Component ownership | `MAP.md` |
| Technical design | `ARCHITECTURE.md` |
| Security requirements | `SECURITY.md` |
| Source code | GitHub repository |
| Canonical structured property intelligence | Supabase/PostGIS |
| Raw evidence artifacts | Cloudflare R2 when provisioned |
| Human acquisition/deal operations | Zoho CRM when provisioned |
| Web extraction | Firecrawl adapter output + original source provenance |
| Human consequential decisions | Authorized operator action |

## Ownership Rules

- Zoho is not the parcel database.
- R2 is not the structured database.
- Firecrawl is not authoritative source data.
- Cloudflare runtime code does not own business rules.
- FastAPI does not own long-running durable orchestration.
- Connector packages translate external representations into internal contracts.

## Lead Machine

```text
SIGNAL
→ INTAKE
→ RESOLVE PROPERTY
→ ENRICH
→ VERIFY OWNER / ENTITY
→ ATTACH SOURCES
→ QUALIFY
→ VALUE / BUYER FIT
→ SCORE
→ GO / WATCH / PASS
```

## Document Flow

```text
Source artifact
→ validate
→ hash
→ immutable raw storage
→ document metadata/provenance
→ property/owner/deal link
→ extraction
→ human review when material
→ approved structured intelligence
→ dossier/brief
```

## v0.1 Boundary

The first release establishes secure intake/API, evidence/provenance boundaries, property-record boundaries, connector contracts, a reproducible Supabase schema, and the future Zoho/Firecrawl/Cloudflare integration points. Live external credentials are not committed.

## Engineering Rule

Before creating a new component: check this map, identify the existing owner, extend it when appropriate, and update this file when architecture changes. No duplicate systems and no mystery services.
