# Participant Tasks

Hands-on tasks for the workshop. Each maps to one or more advanced Copilot workflows.
Work in small, reviewable changes. When you change behavior, update the docs and tests.

## Task 1 — Understand the codebase

```
Use Copilot to summarize the AccessHub architecture. Identify the frontend entry
points, the backend route structure, the service layer, the repository layer, and the
database models.
```

Expected: you know where things live; Copilot uses the repo instructions and docs.

## Task 2 — Find and fix an API error inconsistency

```
Find endpoints that do not use the standard API error format
{ error: { code, message, details } }. Fix one endpoint and add or update tests.
```

Workflows: codebase search, refactoring, tests, Memory.

## Task 3 — Security review of API key handling

```
Review API key generation, storage, display, and logging. Find any place where raw
keys may be exposed. Fix the issue and add a regression test or script check.
```

Workflows: security review, hooks.

## Task 4 — Backend authorization fix

```
Check whether approving an access request is protected only in the frontend or also in
the backend. Ensure only the owning team's service owners or platform admins can
approve. Add tests for unauthorized users.
```

Workflows: senior-developer security thinking.

## Task 5 — Add the missing audit log

```
Rejected access requests should create audit log entries. Find the approval/rejection
flow, add the missing audit event, and test it.
```

Workflows: business-rule consistency.

## Task 6 — Plan the access expiration feature

```
Use Plan Mode to research and plan the access expiration feature. Do not implement yet.
```

Workflows: research → plan → implement.

## Task 7 — Create or refine the spec

```
Using the existing files in specs/access-expiration, refine the proposal, spec, design,
and tasks for access expiration.
```

Workflows: spec-driven development.

## Task 8 — Implement one access expiration task

```
Pick one task from specs/access-expiration/tasks.md and implement only that task. Run
the relevant tests and update progress notes.
```

Workflows: incremental implementation, Ralph loop.

## Task 9 — Use subagents for review

```
Review the implementation using separate subagents for correctness, security,
architecture, frontend, and tests. Synthesize the findings.
```

Workflows: multi-perspective review.

## Task 10 — Update docs

```
Update DOMAIN_RULES.md, API_GUIDELINES.md, and SECURITY.md to match the final
implementation.
```

Workflows: docs as part of engineering.
