# Acquisition Map Production Foundation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Establish a secure, clone-ready production foundation for the standalone `terryfitech/acquisition-map` repository without connecting live external services yet.

**Architecture:** Use a Python `src/` layout with FastAPI as the application API, a Cloudflare Python Worker adapter at the edge, Supabase/PostGIS as the future canonical structured store, R2 as future evidence storage, Firecrawl as a replaceable web-extraction adapter, and Zoho CRM as the future human operating surface. External integrations are represented by explicit connector boundaries and secret contracts; no live credentials or production data are committed.

**Tech Stack:** Python 3.13, FastAPI, Pydantic, Cloudflare Python Workers, uv, pytest, Ruff, Supabase/Postgres/PostGIS, GitHub Actions.

## Global Constraints

- Repository is standalone under `terryfitech/acquisition-map`.
- No TERRYFi repository, package, database, service, naming, governance, secret, or runtime dependency.
- No secrets or credentials in Git.
- No automatic seller outreach, offers, signatures, contracts, or other consequential transaction actions.
- Structured official sources take priority over web extraction.
- Firecrawl is an adapter, never a source of truth.
- Supabase/PostGIS will own canonical structured property intelligence.
- R2 will own raw evidence artifacts.
- Zoho CRM will own human deal operations, not the parcel database.
- Python Workflows remain optional because Cloudflare currently marks Python Workflows beta; do not make v0.1 depend on them.

---

### Task 1: Repository contracts and architecture documents

**Files:**
- Create: `PRODUCT.md`
- Create: `AGENTS.md`
- Create: `MAP.md`
- Create: `ARCHITECTURE.md`
- Create: `SECURITY.md`
- Modify: `README.md`
- Create: `docs/superpowers/specs/2026-08-16-acquisition-map-v0.1-design.md`

**Interfaces:**
- Consumes: approved Acquisition Map v0.1 design from the project conversation.
- Produces: authoritative product, architecture, repository-map, agent, and security contracts.

- [ ] **Step 1:** Write the design specification covering product purpose, component ownership, data flow, trust boundaries, v0.1 scope, and explicit exclusions.
- [ ] **Step 2:** Write `PRODUCT.md`, `MAP.md`, `AGENTS.md`, `ARCHITECTURE.md`, and `SECURITY.md` so each has a single authority: what, where, agent behavior, how, and protection requirements.
- [ ] **Step 3:** Replace the bootstrap `README.md` with clone/setup commands and links to the contracts.
- [ ] **Step 4:** Verify every document states the repository is standalone and contains no TERRYFi runtime dependency.
- [ ] **Step 5:** Commit the documentation foundation.

### Task 2: Python and Cloudflare project configuration

**Files:**
- Create: `pyproject.toml`
- Create: `.python-version`
- Create: `wrangler.jsonc`
- Create: `.gitignore`
- Create: `.editorconfig`
- Create: `.env.example`
- Create: `.dev.vars.example`

**Interfaces:**
- Consumes: Cloudflare Python Workers runtime contract and declared secret names.
- Produces: reproducible local Python configuration and deployable Worker configuration without live credentials.

- [ ] **Step 1:** Configure Python `>=3.13,<3.14` and direct dependencies `fastapi`, `pydantic`, and `httpx`; add development dependencies `workers-py`, `workers-runtime-sdk`, `pytest`, `ruff`, and `pip-audit`.
- [ ] **Step 2:** Configure Ruff and pytest in `pyproject.toml`.
- [ ] **Step 3:** Create `wrangler.jsonc` with `main = "src/acquisition_map/worker.py"`, current compatibility date, `python_workers` compatibility flag, observability enabled, and required secret names only.
- [ ] **Step 4:** Add example environment files containing names but no real values.
- [ ] **Step 5:** Ensure `.env`, `.dev.vars`, local Supabase state, Python caches, and generated credentials are ignored.

### Task 3: FastAPI health baseline using TDD

**Files:**
- Create first: `tests/unit/test_health.py`
- Create after red test: `src/acquisition_map/__init__.py`
- Create after red test: `src/acquisition_map/api/__init__.py`
- Create after red test: `src/acquisition_map/api/routes/__init__.py`
- Create after red test: `src/acquisition_map/api/routes/health.py`
- Create after red test: `src/acquisition_map/app.py`
- Create after red test: `src/acquisition_map/worker.py`

**Interfaces:**
- Produces: `GET /health -> {"status": "ok", "service": "acquisition-map-api"}`.

- [ ] **Step 1:** Write `test_health_endpoint_returns_ok` against `acquisition_map.app.app` using FastAPI TestClient.
- [ ] **Step 2:** Run `uv run pytest tests/unit/test_health.py -v`; expected result before implementation: import/collection failure because `acquisition_map.app` does not exist.
- [ ] **Step 3:** Implement the minimal FastAPI app and health route.
- [ ] **Step 4:** Add a Cloudflare `WorkerEntrypoint` adapter that delegates requests to the FastAPI ASGI app.
- [ ] **Step 5:** Run `uv run pytest tests/unit/test_health.py -v`; expected result: one passing test.

### Task 4: Security baseline and package boundaries

**Files:**
- Create first: `tests/unit/test_security_headers.py`
- Create after red test: `src/acquisition_map/security/__init__.py`
- Create after red test: `src/acquisition_map/security/headers.py`
- Create: `src/acquisition_map/domain/__init__.py`
- Create: `src/acquisition_map/lead_machine/__init__.py`
- Create: `src/acquisition_map/documents/__init__.py`
- Create: `src/acquisition_map/valuation/__init__.py`
- Create: `src/acquisition_map/workflows/__init__.py`
- Create: `src/acquisition_map/connectors/__init__.py`
- Create: `src/acquisition_map/connectors/firecrawl/__init__.py`
- Create: `src/acquisition_map/connectors/hcpa/__init__.py`
- Create: `src/acquisition_map/connectors/hillsborough_clerk/__init__.py`
- Create: `src/acquisition_map/connectors/supabase/__init__.py`
- Create: `src/acquisition_map/connectors/zoho/__init__.py`

**Interfaces:**
- Produces: consistent baseline security headers on API responses and explicit importable package ownership boundaries.

- [ ] **Step 1:** Write a failing test requiring `X-Content-Type-Options: nosniff`, `X-Frame-Options: DENY`, `Referrer-Policy: no-referrer`, and a restrictive Permissions Policy on `/health`.
- [ ] **Step 2:** Run the test and confirm it fails because the headers are absent.
- [ ] **Step 3:** Implement a focused middleware that adds the required headers and register it on the app.
- [ ] **Step 4:** Run both unit tests and confirm they pass.
- [ ] **Step 5:** Add package-boundary `__init__.py` files with responsibility docstrings only; do not invent external integration behavior.

### Task 5: Supabase secure-by-default foundation

**Files:**
- Create: `supabase/config.toml`
- Create: `supabase/seed.sql`
- Create: `supabase/migrations/20260816110000_initial_core.sql`

**Interfaces:**
- Produces: initial schemas/tables for `properties`, `field_observations`, `source_artifacts`, and `audit_events` with RLS enabled and no anonymous/client policies.

- [ ] **Step 1:** Enable `postgis` in the migration.
- [ ] **Step 2:** Create UUID primary keys, timestamps, constrained status/type fields, source-provenance columns, and unique folio where present.
- [ ] **Step 3:** Enable RLS on every application table and define no permissive anonymous policy in v0.1.
- [ ] **Step 4:** Create indexes for folio, status, geospatial point, observation/property relationship, and source artifact relationship.
- [ ] **Step 5:** Keep `seed.sql` synthetic and non-sensitive.

### Task 6: CI, dependency hygiene, and operator setup docs

**Files:**
- Create: `.github/workflows/ci.yml`
- Create: `.github/dependabot.yml`
- Create: `.github/pull_request_template.md`
- Create: `docs/setup/REQUIREMENTS.md`
- Create: `docs/security/SECRET_MATRIX.md`
- Create: `docs/data-sources/SOURCE_REGISTRY.md`
- Create: `infrastructure/cloudflare/README.md`
- Create: `infrastructure/supabase/README.md`
- Create: `infrastructure/zoho/README.md`

**Interfaces:**
- Produces: pull-request quality gate plus an exact list of external accounts/resources the operator must supply later.

- [ ] **Step 1:** Configure CI with read-only GitHub token permissions, Python 3.13, uv, `ruff check`, `pytest`, and `pip-audit`.
- [ ] **Step 2:** Configure Dependabot for GitHub Actions and Python dependencies.
- [ ] **Step 3:** Document required external resources and secret names without values.
- [ ] **Step 4:** Record source authority: HCPA/Clerk/other official structured data before Firecrawl web extraction.
- [ ] **Step 5:** Document manual repository settings still required: make repository private if desired, enable branch protection/ruleset, secret scanning/push protection where available, and require CI before merge.

### Task 7: Lock, verify, and pull request

**Files:**
- Create from tool output: `uv.lock`

**Interfaces:**
- Produces: reproducible dependency resolution and a reviewable setup PR.

- [ ] **Step 1:** Clone/check out `setup/production-foundation` in an isolated local workspace.
- [ ] **Step 2:** Run `uv lock` and commit the generated `uv.lock` exactly as produced.
- [ ] **Step 3:** Run `uv sync --locked --all-groups`.
- [ ] **Step 4:** Run `uv run ruff check .`.
- [ ] **Step 5:** Run `uv run pytest -q`.
- [ ] **Step 6:** Run `uv run pip-audit`.
- [ ] **Step 7:** Search the repository for common credential patterns and verify example secret files contain placeholders only.
- [ ] **Step 8:** Review the diff against this plan and the design spec.
- [ ] **Step 9:** Open a pull request from `setup/production-foundation` to `main`; do not auto-merge.
