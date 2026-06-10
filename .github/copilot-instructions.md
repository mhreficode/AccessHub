# Copilot Instructions for AccessHub

You are assisting in the AccessHub repository, a TypeScript internal developer platform
and API catalog (React + Vite frontend, Express + Prisma + SQLite backend, npm
workspaces). This repository is intentionally imperfect — it is used for an advanced
Copilot workshop.

## Architecture rules

- Keep business logic in `apps/api/src/services`.
- Keep database access in `apps/api/src/repositories`. Services must not import Prisma
  directly; the client lives in `apps/api/src/db.ts`.
- Keep route handlers thin (`apps/api/src/routes`): parse, call one service, respond.
- Validate request bodies with Zod schemas in `apps/api/src/validators`, at the route
  boundary. Do not duplicate the same validation in the service layer.
- Enforce authorization on the backend using `apps/api/src/services/authz.service.ts`,
  even when the frontend hides an action.
- Do not put business rules directly in React components.

## API rules

All API errors must use this shape:

```
{ "error": { "code": "ERROR_CODE", "message": "Human readable message", "details": {} } }
```

Produce them via the helpers in `apps/api/src/utils/errors.ts`. See
`docs/API_GUIDELINES.md`.

## Security rules

- Never log raw API keys.
- Never store raw API keys; store only a prefix and a SHA-256 hash.
- Never expose `keyHash` in an API response (use the masked serializer).
- Never put secrets in audit logs.
- Sanitize rendered markdown.
- Authorization must be enforced in backend services or middleware.

## Testing rules

- Add tests for service-layer business logic.
- Add API tests for authorization-sensitive endpoints.
- Include the happy path and at least one edge case.
- Do not delete or weaken existing tests to make a task pass.

## Workshop rules

- This repository intentionally contains defects and one incomplete feature
  (Expiring Service Access — see `docs/PRD.md` and `specs/access-expiration/`).
- Prefer small, reviewable changes.
- Update the relevant docs when you change behavior.

## Required Execution Workflow

- Always run the `planner` agent first for implementation tasks.
- Present the planner output for review before making code changes.
- Start implementation only after plan review using the `executer` agent.
- If the scope changes materially, stop execution, rerun `planner`, and repeat review.
