## Summary

Describe the change and why it belongs in Acquisition Map.

## Architecture / Ownership

- [ ] I checked `PRODUCT.md`, `MAP.md`, `ARCHITECTURE.md`, `SECURITY.md`, and `AGENTS.md`.
- [ ] I extended an existing ownership boundary where appropriate instead of creating a duplicate system.
- [ ] Any architecture ownership change is reflected in `MAP.md` / relevant docs.
- [ ] This change introduces no TERRYFi repository, service, database, secret, package, governance, or runtime dependency.

## Security / Data

- [ ] No secrets, tokens, private credentials, or production evidence are committed.
- [ ] External facts preserve appropriate source provenance.
- [ ] Database changes are migrations and RLS/security implications were reviewed.
- [ ] Consequential legal/transaction actions remain behind human authorization.

## Verification

List the exact commands run and their results.

```text
uv run ruff check .
uv run pytest -q
uv run pip-audit
```

## Remaining Manual Actions

List provider setup, credentials, migrations, or deployment actions that were not performed in this PR.
