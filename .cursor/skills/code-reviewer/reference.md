# FastAPI Backend Standardization — Review Reference

Condensed from **FastAPI Backend Standardization Guide**. Use during reviews when you need section-level detail.

## Project structure

```
project_root/
├── app.py
├── config.py
├── requirements.txt
├── start_service.sh / stop_service.sh
├── keys/.env          # gitignored
├── logs/
├── tests/
└── modules/
    ├── dependencies.py
    ├── api_routes/      # *HandlingRoutes.py, APIResponse.py, APISchemaComponent.py
    ├── api_modules/     # *HandlingComponent.py
    └── service_modules/ # *Manager.py, JWTAuthentication.py
```

| Rule | Rationale |
|------|-----------|
| One file = one responsibility | Small, testable modules |
| PascalCase file names | Distinguish from third-party packages |
| `keys/`, `logs/` gitignored | Secrets and runtime artifacts |
| `__init__.py` in every package | Packaging, pytest, IDE |

## HTTP status map (routes)

| Code | Use |
|------|-----|
| 200 | Success |
| 400 | Business rejection |
| 401 | Auth failed (credentials) |
| 403 | Valid token but forbidden / expired handling per dependency |
| 429 | Rate limit |
| 500 | Unexpected exception (catch-all) |

## Standard result dict (components & services)

```python
{
    "status": True,       # bool
    "message": "...",     # str
    "output": {...},      # payload or None
    "error": "..."        # str, empty on success
}
```

## Standard API response (routes)

```json
{
  "success": true,
  "data": "<payload or null>",
  "message": "Human-readable status"
}
```

Use `APIResponse` + `JSONResponse` + `model_dump()`.

## Rate limits (defaults)

| Endpoint type | Limit |
|---------------|-------|
| Authentication | 5/minute |
| Protected operations | 20/minute |
| Read-only | 60/minute |

Single `limiter` in `config.py`; `app.state.limiter`; import `limiter` in route modules — do not create new `Limiter()` instances.

## Auth pattern

- `HTTPBearer` + `get_current_user` in `dependencies.py`
- JWT create/decode in `JWTAuthentication.py`
- Optional `require_role("admin")` wrapper
- Optional Fernet encryption for PII claims in tokens

Routes receive verified `current_user` dict; never decode JWT in handlers.

## Middleware (registration order)

1. CORS (outermost)
2. Logging (re-inject request body after read)
3. Security headers (`Server: Hidden`, CSP, HSTS, X-Frame-Options, etc.)

## Logging

- Configured in `config.py`: `TimedRotatingFileHandler`, midnight rotation, 30 backups
- Use `logger.info("User %s authenticated", user_id)` — not f-strings
- No secrets at INFO; `logger.exception` in `except` blocks
- Context prefixes e.g. `[Auth]` for cross-cutting logs

## Coding conventions

| Element | Style |
|---------|--------|
| Files / classes | PascalCase |
| Functions / variables | snake_case |
| Constants | UPPER_SNAKE_CASE |
| Route paths | kebab-case |

**Import order:** `config` → stdlib → third-party → local modules.

**Sync vs async:** Default `def` routes and sync business/service code. Middleware uses `async def`. Use `async def` routes only if I/O stack is fully async.

**Docstrings:** Google style with Args/Returns on non-trivial functions.

## Security checklist (§16)

- [ ] All request schemas use `SecureBaseModel`
- [ ] `ConfigDict(extra='forbid')`
- [ ] `SecretStr` for passwords; never log plaintext
- [ ] JWT signing (HS256/RS256); encrypt PII claims if needed
- [ ] Security headers middleware present
- [ ] `@limiter.limit()` on public endpoints
- [ ] CORS from `settings.cors_origins`, not `*`
- [ ] Secrets only in `keys/.env`
- [ ] Client errors: message only, no stack traces
- [ ] `Server: Hidden`

## Testing expectations

- `tests/conftest.py`: `TestClient`, `dependency_overrides` for `get_db_manager`, `get_current_user`
- Unit tests: components without HTTP
- Integration tests: routes via `TestClient` (200/401/403/422 cases)
- Mock managers implement same `{status, message, output, error}` interface

## Deployment notes (informational)

- Gunicorn + `uvicorn.workers.UvicornWorker`
- OpenAPI docs disabled in production (`docs_url=None`)
- Optional `/api/v1` versioning, Docker, CI `pytest`

## Adding a new feature

1. `APISchemaComponent.py` — Pydantic models  
2. `service_modules/<Service>Manager.py` — external I/O  
3. `dependencies.py` — providers (`@lru_cache` for singletons)  
4. `api_modules/<Feature>HandlingComponent.py` — business logic  
5. `api_routes/<Feature>HandlingRoutes.py` — HTTP handlers  
6. `app.py` — `include_router`  
7. `config.py` + `keys/.env` — new settings  

## Anti-patterns to flag

| Anti-pattern | Preferred |
|--------------|-----------|
| Business logic in `app.py` or routes beyond mapping | Move to components |
| FastAPI types in `api_modules/` | Plain Python + result dict |
| YAML config + `eval()` | Pydantic Settings |
| New `Limiter()` per file | Import shared `limiter` |
| Manual Bearer token parsing in routes | `Depends(get_current_user)` |
| Raw dict responses | `APIResponse` wrapper |
| `async def` route + blocking boto3/requests | `def` route or async client throughout |
| f-strings in `logger.*` | `%s` formatting |
