# Changelog

All notable Acquisition Map changes are recorded here.

## [Unreleased]

### Added

- Standalone repository product, architecture, security, map, and agent contracts.
- FastAPI application foundation and Cloudflare Python Worker adapter.
- Health endpoint and baseline defensive response headers.
- Lead Machine, domain, document, valuation, workflow, and connector package boundaries.
- Initial Supabase/PostGIS schema with RLS deny-by-default.
- CI with locked dependency install, lint, compile, tests, dependency audit, and secret-pattern sanity check.
- Dependency update automation and code ownership.
- External setup, source-registry, secret-matrix, and infrastructure documentation.

### Security

- Production credentials prohibited from source control.
- Private evidence-storage requirement documented.
- Human approval gates established for consequential transaction actions.
