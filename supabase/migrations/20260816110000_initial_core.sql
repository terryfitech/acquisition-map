create schema if not exists extensions;

create extension if not exists pgcrypto with schema extensions;
create extension if not exists postgis with schema extensions;

create table if not exists public.properties (
    id uuid primary key default gen_random_uuid(),
    folio text unique,
    address_line1 text,
    address_line2 text,
    city text,
    state text,
    postal_code text,
    county text,
    property_type text,
    status text not null default 'NEW'
        check (status in (
            'NEW', 'RESEARCHING', 'WATCH', 'GO', 'PASS',
            'CONTRACTED', 'DISPOSITION', 'CLOSING', 'CLOSED', 'DEAD'
        )),
    location extensions.geography(POINT, 4326),
    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now()
);

create table if not exists public.field_observations (
    id uuid primary key default gen_random_uuid(),
    property_id uuid references public.properties(id) on delete set null,
    observed_at timestamptz not null default now(),
    latitude numeric(9, 6),
    longitude numeric(9, 6),
    signal_type text not null
        check (signal_type in (
            'FOR_SALE', 'COMING_SOON', 'FOR_LEASE', 'DISTRESSED',
            'COMMERCIAL', 'LAND', 'OTHER'
        )),
    notes text,
    created_at timestamptz not null default now(),
    check (latitude is null or latitude between -90 and 90),
    check (longitude is null or longitude between -180 and 180)
);

create table if not exists public.source_artifacts (
    id uuid primary key default gen_random_uuid(),
    property_id uuid references public.properties(id) on delete set null,
    observation_id uuid references public.field_observations(id) on delete set null,
    source_type text not null,
    source_name text not null,
    source_url text,
    source_reference text,
    retrieved_at timestamptz not null default now(),
    effective_at timestamptz,
    content_hash text,
    r2_object_key text unique,
    mime_type text,
    original_filename text,
    review_status text not null default 'UNREVIEWED'
        check (review_status in ('UNREVIEWED', 'REVIEWED', 'REJECTED')),
    metadata jsonb not null default '{}'::jsonb,
    created_at timestamptz not null default now()
);

create table if not exists public.audit_events (
    id uuid primary key default gen_random_uuid(),
    actor_type text not null,
    actor_id text,
    action text not null,
    entity_type text not null,
    entity_id text,
    request_id text,
    details jsonb not null default '{}'::jsonb,
    created_at timestamptz not null default now()
);

create index if not exists properties_status_idx on public.properties(status);
create index if not exists properties_location_gix on public.properties using gist(location);
create index if not exists observations_property_id_idx on public.field_observations(property_id);
create index if not exists observations_observed_at_idx on public.field_observations(observed_at desc);
create index if not exists source_artifacts_property_id_idx on public.source_artifacts(property_id);
create index if not exists source_artifacts_observation_id_idx on public.source_artifacts(observation_id);
create index if not exists source_artifacts_content_hash_idx on public.source_artifacts(content_hash);
create index if not exists audit_events_entity_idx on public.audit_events(entity_type, entity_id);
create index if not exists audit_events_request_id_idx on public.audit_events(request_id);

alter table public.properties enable row level security;
alter table public.field_observations enable row level security;
alter table public.source_artifacts enable row level security;
alter table public.audit_events enable row level security;

-- v0.1 intentionally defines no permissive RLS policies.
-- Direct anon/authenticated access is therefore denied by default.
-- Server-side service-role access remains outside RLS and must stay private.
