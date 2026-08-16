# Supabase Infrastructure

Supabase/PostGIS is the canonical structured-data store for Acquisition Map.

## Environments

Use separate staging and production projects. Local development uses the Supabase CLI stack and the committed `supabase/` directory.

## Schema Management

- All schema changes are version-controlled migrations.
- `supabase db reset` is the local reproducibility check.
- Production changes are applied from reviewed migrations, not ad-hoc Dashboard edits as the source of truth.
- RLS is enabled on every application table exposed through Supabase APIs.

## Security

The bootstrap schema defines no permissive anon/authenticated policies. Service-role credentials remain server-side only. Future client access requires explicit, tested RLS policies.

## PostGIS

The initial migration enables PostGIS and stores property location as a geospatial point suitable for later map, distance, and cluster queries.
