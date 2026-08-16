# Cloudflare Infrastructure

Acquisition Map uses Cloudflare as edge/runtime infrastructure, not as the domain source of truth.

## Planned Dedicated Resources

- `acquisition-map-api` Worker
- staging and production environments/resources
- private R2 evidence buckets
- future workflow/schedule bindings only after the relevant runtime is approved

## Deployment Rule

Use provider-managed secrets. `wrangler.jsonc` declares required application secret names but contains no secret values.

## Python Runtime Note

The FastAPI app is kept portable behind `src/acquisition_map/app.py`. `worker.py` is the Cloudflare-specific adapter. If the Python Worker/runtime path changes, the application/domain packages should not require a rewrite.

## R2 Rule

Evidence buckets must be private. Raw source artifacts are immutable; structured metadata belongs in Supabase.
