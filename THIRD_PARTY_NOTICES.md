# Third-Party Notices

Acquisition Map uses third-party libraries and hosted services. Each third-party component remains governed by its own license and terms.

## Dependency Policy

- Python dependencies are declared in `pyproject.toml` and resolved in `uv.lock`.
- GitHub Actions are pinned to immutable commit SHAs in CI.
- Before distributing packaged software, produce/review the dependency license inventory from the exact lockfile used for that release.
- Hosted-service terms are reviewed separately from open-source package licenses.
- No third-party license overrides the proprietary license applied to original Acquisition Map source code.

## Current Direct Python Dependencies

See `pyproject.toml` for the authoritative direct dependency list and `uv.lock` for the exact resolved dependency graph.

## Current Service Boundaries

Cloudflare, Supabase, Firecrawl, and Zoho are external service boundaries. Their service terms and data-processing requirements must be reviewed before production credentials/data are enabled.

This file is an operational notice, not a substitute for release-specific license review.
