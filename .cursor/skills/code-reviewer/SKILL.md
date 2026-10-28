---
name: code-reviewer
description: >-
  Reviews Python FastAPI backend code against the FastAPI Backend Standardization
  Guide (layered architecture, Pydantic settings, JWT auth, APIResponse contract,
  security, logging, and testing). Use when reviewing pull requests, diffs, new
  endpoints, refactors, or when the user asks for a backend code review, FastAPI
  standards check, or architecture compliance.
---

# FastAPI Backend Code Reviewer

Reviews backend changes against the organization **FastAPI Backend Standardization Guide**. Source of truth for detailed rules: [reference.md](reference.md).

## When to apply

- User requests code review, PR review, or standards compliance.
- Changes touch `app.py`, `config.py`, `modules/api_routes/`, `modules/api_modules/`, `modules/service_modules/`, `modules/dependencies.py`, schemas, auth, middleware, or tests.

If the repo does not follow this layout, note deviations first, then review what exists against the closest equivalent layer.

## Review workflow

1. **Scope** — Identify changed files and which layer(s) they belong to (routes, components, services, config, app wiring).
2. **Architecture** — Confirm request flow: Routes → Components → Services. Flag FastAPI imports in `api_modules/` or HTTP concerns in service managers.
3. **Contracts** — Verify standardized result dict in components/services and `APIResponse` + correct HTTP status in routes.
4. **Security & config** — Secrets only in `keys/.env`, Pydantic Settings (no YAML/`eval()`), `SecureBaseModel`, rate limits, auth via `Depends(get_current_user)`.
5. **Quality** — Naming, import order, logging (`%s` not f-strings in log calls), error handling, tests/mocks if behavior changed.
6. **Report** — Use the output template below. Prefer file/line citations when reviewing a real diff.

## Severity labels

| Label | Meaning |
|-------|---------|
| **Critical** | Security issue, secret exposure, broken auth, missing validation, or architecture violation that risks production |
| **Major** | Wrong HTTP mapping, missing rate limit on public route, non-standard response shape, untested critical path |
| **Minor** | Naming, docs, logging style, optional hardening |
| **Nit** | Style preference with low impact |

## Output template

```markdown
## Summary
[1–3 sentences: overall readiness and main themes]

## Architecture & layers
- [Finding with file reference]

## API, schemas & responses
- ...

## Auth, security & config
- ...

## Logging, errors & middleware
- ...

## Tests
- ...

## Checklist (guide §16)
- [ ] Input sanitization (`SecureBaseModel`)
- [ ] Extra fields forbidden
- [ ] Passwords as `SecretStr`, not logged
- [ ] JWT / encryption as appropriate
- [ ] Security headers & CORS from settings
- [ ] Rate limiting on public endpoints
- [ ] No secrets in code; no stack traces to clients

## Verdict
**Approve** | **Approve with comments** | **Request changes**

[Optional: ordered list of must-fix items]
```

## Quick layer rules

### `app.py` only

Wiring only: settings/logger, `FastAPI` instance, rate limiter + handler, exception handlers, middleware (CORS, logging, security headers), `include_router(..., prefix="/api")`, local `uvicorn` entry. **No** business logic, DB calls, schemas, or external API calls.

### `modules/api_routes/` (thin HTTP)

- `APIRouter`, shared `limiter` from `config`, `Request` on rate-limited routes.
- Pydantic body models; delegate to component; map `result["status"]` to status codes (200, 400, 401, 403, 429, 500).
- Protected routes: `Depends(get_current_user)` only — no manual JWT parsing in handlers.
- Wrap in `try/except`; `logger.exception` on unexpected errors; return `APIResponse` via `JSONResponse`.

### `modules/api_modules/` (business logic)

- **No** FastAPI imports. Return only `{status, message, output, error}`.
- Orchestrate managers; log at meaningful business events.

### `modules/service_modules/` (managers)

- One manager per external system; methods return the same result dict.
- Catch service-specific exceptions, then generic `Exception`; `logger.exception` before error returns.
- Singleton deps: `@lru_cache()` in `dependencies.py`; pass managers into components from routes.

### `config.py`

- `AppSettings` + nested settings with `pydantic-settings`; `env_file="keys/.env"`.
- Exports: `settings`, `logger` (timed rotating file), `limiter`.
- Prefer this over YAML + `eval()`.

### Schemas

- Inherit `SecureBaseModel` (`extra='forbid'`, bleach string sanitization).
- `Field(...)`, length limits, `Literal` for enums, `SecretStr` for passwords, `@field_validator` + `check_not_empty` where needed.

## New feature sanity check

When reviewing a new feature, confirm the guide’s add-order (see [reference.md](reference.md#adding-a-new-feature)):

schemas → service manager → dependencies → component → routes → `app.py` router → settings/env.

## Additional resources

- Full section-by-section checklist: [reference.md](reference.md)
- Canonical guide document: `FastAPI_Backend_Standardization_Guide.pdf` (organization standard)
