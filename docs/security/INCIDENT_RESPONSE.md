# Acquisition Map — Incident Response Runbook

## Purpose

Provide a minimal, repeatable response for credential, data, dependency, and provider incidents without improvising during an event.

## Severity

- **SEV-1:** confirmed production credential compromise, unauthorized private-data/evidence access, destructive database/object-store action, or unauthorized consequential transaction action.
- **SEV-2:** suspected compromise, material provider outage/data corruption, failed authorization boundary, or significant source-data poisoning.
- **SEV-3:** non-sensitive service failure, recoverable sync problem, low-impact dependency/security finding.

## Immediate Response

1. Stop the exposure or unsafe execution path first.
2. Preserve relevant audit/log evidence; do not delete evidence needed to understand the incident.
3. Revoke/rotate exposed credentials at the provider.
4. Disable affected integration, route, token, webhook, or deployment if necessary.
5. Determine affected environment, time window, resources, records, and users.
6. Restore only after the failing control has been corrected and verified.

## Credential Exposure

- Rotate the credential at its source provider.
- Update the consuming environment through the approved secret store.
- Inspect provider audit/activity logs for unauthorized use.
- If committed to Git, treat history as exposed even after file deletion; remove the secret from repository history where appropriate and rotate it regardless.
- Rotate related credentials when compromise could enable lateral access.

## Data / Evidence Exposure

- Disable public/object access immediately.
- Identify affected object keys/records and access window.
- Preserve access logs and audit events.
- Verify current bucket/database policies before reopening access.
- Obtain appropriate professional/legal guidance for any notification duties; do not guess reporting obligations from automation.

## Database Integrity Incident

- Stop writes if continued writes could worsen corruption.
- Record the suspected bad migration/query/source run.
- Preserve a snapshot/backup where available.
- Reconcile against source artifacts and audit events.
- Restore/replay only after validating the recovery point and migration state.

## External Source / Data Poisoning

- Quarantine the affected source run.
- Do not overwrite canonical facts with disputed data.
- Mark affected extracted claims for review.
- Compare against higher-authority sources from `docs/data-sources/SOURCE_REGISTRY.md`.
- Re-run enrichment only after the connector/parser issue is fixed.

## Dependency Incident

- Confirm affected locked version.
- Upgrade to the fixed version or remove the dependency.
- Regenerate `uv.lock`.
- Run lint, compile, full tests, and `pip-audit`.
- Merge only after CI is clean.

## Recovery Gate

Before re-enabling an affected production path, verify:

- credential rotation is complete where applicable;
- authorization/RLS/object permissions are correct;
- the root cause is addressed;
- tests/CI pass;
- affected records/artifacts are reconciled;
- monitoring/logging can detect recurrence.

## Post-Incident Record

Record: date/time, severity, affected systems/data, detection method, containment, root cause, credentials rotated, recovery steps, verification evidence, and preventive follow-up. Do not place live secrets or unnecessary private data in the incident record.
