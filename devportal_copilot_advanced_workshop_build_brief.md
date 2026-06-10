# DevPortal Workshop Codebase Build Brief

## 1. Purpose of This Document

This document is a complete implementation brief for building a workshop-ready codebase using Claude Code or another coding agent.

The codebase will be used in a 3-hour **GitHub Copilot Advanced Workshop**. The goal is not to build a production SaaS product. The goal is to create a realistic, medium-sized, intentionally imperfect brownfield codebase that lets workshop participants experience how a senior developer can use GitHub Copilot across advanced workflows.

The workshop should demonstrate Copilot as more than autocomplete:

- Understanding a codebase
- Following repository instructions
- Working with domain documentation
- Using hooks to control or validate agent behavior
- Using prompt files and reusable skills
- Using Copilot Spaces for shared domain context
- Using Copilot Memory for repository conventions
- Using APM/Agent Package Manager style assets
- Using Copilot CLI
- Using Plan Mode
- Using Ralph Loops
- Using Spec-Driven Development
- Using subagents for isolated review perspectives
- Fixing bugs, adding tests, updating docs, and improving architecture

The app idea is intentionally different from a task manager or incident-management app.

---

## 2. App Concept

# DevPortal: Internal Developer Platform and API Catalog

DevPortal is a small internal platform for engineering teams.

A company has many internal APIs and services. Developers use DevPortal to:

- Discover internal services
- Read API documentation
- Request access to services
- Get API keys after approval
- See usage and rate-limit information
- Review audit history
- Manage service ownership and access

The whole application should feel like a simple internal dashboard used by developers and platform engineers.

The simplest mental model:

> DevPortal is a mini internal developer portal where developers can find services, request access, receive API keys, and monitor usage/security activity.

---

## 3. Workshop Goal

The codebase must support advanced Copilot demonstrations.

Participants should receive the repository and follow the instructor through hands-on exercises. The project must contain enough real code, structure, documentation, defects, and missing features for Copilot to be useful.

The project should feel like a realistic brownfield codebase:

- Some things are implemented well
- Some things are inconsistent
- Some tests are missing
- Some docs are outdated
- Some security weaknesses are intentionally present
- Some TODOs are left for participants
- Some Copilot configuration exists already
- Some Copilot assets are intentionally missing and should be created during the workshop

The instructor should be able to say:

> “This is a real-looking codebase. We will now use Copilot like a senior developer: inspect it, understand its rules, fix problems, add a feature, write tests, update docs, and use agentic workflows safely.”

---

## 4. Target Complexity

The codebase should be **medium-small**, not a toy and not a large enterprise system.

Recommended size:

- 2 apps: frontend and backend
- 2,500–5,000 lines of application code
- 20–35 source files
- 10–20 test files
- 8–12 intentionally prepared workshop issues
- 6–10 markdown documentation files
- 5–10 Copilot-related files
- SQLite database with seeded data
- One main dashboard with tabs
- A few detail/admin pages or tab panels

The codebase should be runnable locally in less than 5 minutes.

Do not overbuild. The purpose is to create good Copilot exercises, not a full product.

---

## 5. Recommended Tech Stack

Use a familiar TypeScript stack:

```txt
Frontend:
- React
- TypeScript
- Vite
- React Router or simple tab-based routing
- Fetch API or TanStack Query
- Basic CSS modules or Tailwind

Backend:
- Node.js
- TypeScript
- Express or Fastify
- Prisma ORM
- SQLite database
- Zod for validation

Testing:
- Vitest for unit tests
- Supertest for API tests
- Playwright for one or two frontend/e2e tests

Tooling:
- npm workspaces or pnpm workspaces
- ESLint
- Prettier
- TypeScript strict mode
- GitHub Actions CI workflow
```

Prefer clarity over cleverness. The code should be easy for participants to navigate.

---

## 6. User Roles

Implement simple role-based behavior.

Roles:

1. `developer`
   - Can view services
   - Can request access
   - Can view own API keys
   - Can see own access requests

2. `service_owner`
   - Can approve/reject access requests for services they own
   - Can revoke API keys for their services
   - Can view service audit logs

3. `platform_admin`
   - Can manage all services
   - Can view all access requests
   - Can view all audit logs
   - Can rotate/revoke API keys

Authentication can be simplified. It does not need real login.

Recommended approach:

- Use a seeded user selector in the UI
- Send `x-user-id` header to the backend
- Middleware loads the current user
- This gives enough realism for authorization demos without building full auth

---

## 7. Main UI Design

Most of the app should happen in one dashboard.

Recommended UI:

```txt
DevPortal Dashboard
|
|-- Services tab
|   |-- Service cards/list
|   |-- Search/filter by tag/status/owner
|   |-- Click service to open detail panel/page
|
|-- Access Requests tab
|   |-- Pending requests
|   |-- Approved/rejected requests
|   |-- Approve/reject actions for owners/admins
|
|-- API Keys tab
|   |-- Active keys
|   |-- Masked key values
|   |-- Revoke key action
|
|-- Usage tab
|   |-- Requests per service
|   |-- Failed requests
|   |-- Rate-limit warning indicators
|
|-- Audit Log tab
|   |-- Recent security and access events
```

There may also be a simple Service Detail page or modal:

```txt
Service Detail
|
|-- Service overview
|-- API documentation
|-- Example endpoint list
|-- Request access button
|-- Current access status
|-- Usage summary
```

Keep UI clean and simple. It only needs enough polish for a workshop.

---

## 8. Core Product Features to Build Before the Workshop

These should be implemented before participants receive the repo.

### 8.1 Service Catalog

Each service should have:

- id
- name
- slug
- description
- owner team
- status: `active`, `deprecated`, `maintenance`
- tags
- base URL
- documentation markdown
- created date
- updated date

Example services:

- Payments API
- Identity API
- Notification API
- Analytics API
- Inventory API
- Search API

### 8.2 Access Requests

Developers can request access to a service.

Fields:

- id
- service id
- requester user id
- reason
- status: `pending`, `approved`, `rejected`
- requestedAt
- reviewedAt
- reviewedBy
- rejectionReason

### 8.3 API Keys

When access is approved, the system can create an API key.

Fields:

- id
- service id
- user id
- keyPrefix
- keyHash
- label
- status: `active`, `revoked`
- createdAt
- revokedAt
- lastUsedAt

Important security rule:

- Never store raw API keys.
- Only show the raw key once when created.
- Store only a hash and a prefix.
- In the intentionally flawed starting codebase, include one controlled bug where a raw key is accidentally logged or exposed in a dev-only path. This is for the workshop security demo.

### 8.4 Usage Events

Seed fake API usage data.

Fields:

- id
- service id
- apiKey id
- timestamp
- statusCode
- latencyMs
- endpoint
- success

Use this for a usage dashboard.

### 8.5 Audit Log

Audit events should be recorded for:

- Access requested
- Access approved
- Access rejected
- API key generated
- API key revoked
- Service updated

Fields:

- id
- actorUserId
- action
- entityType
- entityId
- message
- metadata JSON
- createdAt

Do not make this too complex.

---

## 9. Main Feature Reserved for Workshop

Do **not** fully implement this feature before the workshop.

The main golden-path feature participants will implement is:

# Expiring Service Access

Business requirements:

- Approved service access should expire after 30 days.
- Service owners and platform admins can extend access.
- Expired access should disable or invalidate API keys.
- Dashboard should show access that is expiring soon.
- Audit log should record expiration and extension events.
- Tests should cover active, expired, extended, and revoked access.
- Documentation should be updated.

This feature is ideal because it touches:

- database schema
- backend services
- authorization
- frontend dashboard
- tests
- docs
- security review
- domain rules
- spec-driven workflow
- Plan Mode
- Ralph Loops
- Copilot CLI
- subagents

Before the workshop, include:

- A product requirement in `docs/PRD.md`
- A partial TODO in code
- Failing or skipped tests
- A placeholder spec folder
- One or two incomplete backend functions
- No final implementation

The instructor should be able to ask participants to implement it with Copilot.

---

## 10. Intentionally Injected Issues

The repo should contain realistic defects. They must be safe, controlled, and easy to fix during a workshop.

Create a file:

```txt
docs/KNOWN_ISSUES.md
```

List only some issues there. Do not reveal every bug; leave some for Copilot discovery exercises.

Recommended issues:

### Issue 1: Inconsistent API Error Responses

Some endpoints return:

```json
{ "message": "Not found" }
```

Others return:

```json
{ "error": "Not found" }
```

The desired standard should be:

```json
{
  "error": {
    "code": "SERVICE_NOT_FOUND",
    "message": "Service not found",
    "details": {}
  }
}
```

Use this for refactoring, Copilot Memory, tests, and instructions demos.

### Issue 2: Frontend-Only Authorization Check

The UI hides the approve button for unauthorized users, but the backend endpoint does not fully verify ownership/admin role.

Use this for security review and bug fixing.

### Issue 3: Raw API Key Accidentally Logged

One service function logs a raw API key in development mode.

Use this for hooks, secret scanning, and security subagent demos.

### Issue 4: Missing Audit Log on Rejected Access

Approving access logs an audit event, but rejecting access does not.

Use this for test generation and feature consistency.

### Issue 5: Duplicate Validation Logic

Validation is duplicated in route handlers and service functions.

Use this for refactoring and architecture demos.

### Issue 6: Inefficient Usage Dashboard Query

The dashboard fetches all usage events and aggregates in memory.

Use this for Copilot CLI analysis and performance improvement.

### Issue 7: Incomplete Tests for API Key Revocation

Some tests exist but do not cover revoked keys being rejected.

Use this for Copilot-generated tests.

### Issue 8: Outdated API Documentation

The docs mention an old endpoint path.

Use this for Spaces and documentation grounding.

### Issue 9: Markdown Documentation Security Risk

Service docs render markdown but allow raw HTML.

Use this for frontend security review.

### Issue 10: Skipped Tests for Access Expiration

Add skipped tests for the workshop feature:

```ts
it.skip("marks approved access as expired after 30 days", async () => {});
it.skip("revokes API keys for expired access", async () => {});
it.skip("allows service owners to extend access", async () => {});
```

These should become active during the workshop.

---

## 11. Required Repository Structure

Build the repo with a structure similar to this:

```txt
devportal/
  README.md
  package.json
  pnpm-workspace.yaml or package-lock.json
  tsconfig.base.json
  eslint.config.js
  prettier.config.js

  apps/
    web/
      package.json
      index.html
      src/
        main.tsx
        App.tsx
        routes/
          Dashboard.tsx
          ServiceDetail.tsx
        components/
          ServiceCard.tsx
          ServiceList.tsx
          AccessRequestsTable.tsx
          ApiKeysTable.tsx
          UsageSummary.tsx
          AuditLogTable.tsx
          UserSwitcher.tsx
        hooks/
          useServices.ts
          useAccessRequests.ts
          useApiKeys.ts
          useUsage.ts
        api/
          client.ts
          servicesApi.ts
          accessApi.ts
          keysApi.ts
        utils/
          formatters.ts
          permissions.ts
        tests/
          Dashboard.test.tsx
          permissions.test.ts
      vite.config.ts

    api/
      package.json
      src/
        server.ts
        app.ts
        db.ts
        routes/
          services.routes.ts
          accessRequests.routes.ts
          apiKeys.routes.ts
          usage.routes.ts
          audit.routes.ts
        services/
          serviceCatalog.service.ts
          accessRequest.service.ts
          apiKey.service.ts
          usage.service.ts
          auditLog.service.ts
          authz.service.ts
        repositories/
          service.repository.ts
          accessRequest.repository.ts
          apiKey.repository.ts
          usage.repository.ts
          auditLog.repository.ts
        middleware/
          currentUser.ts
          errorHandler.ts
        validators/
          service.validators.ts
          access.validators.ts
        utils/
          errors.ts
          crypto.ts
          dates.ts
        tests/
          services.test.ts
          accessRequests.test.ts
          apiKeys.test.ts
          auditLog.test.ts
          authz.test.ts
          accessExpiration.skip.test.ts

  prisma/
    schema.prisma
    seed.ts

  docs/
    ARCHITECTURE.md
    DOMAIN_RULES.md
    API_GUIDELINES.md
    SECURITY.md
    PRD.md
    KNOWN_ISSUES.md
    WORKSHOP_GUIDE.md
    COPILOT_SPACES_CONTEXT.md
    DEMO_SCRIPT.md

  specs/
    access-expiration/
      proposal.md
      spec.md
      design.md
      tasks.md

  scripts/
    detect-secrets.sh
    security-check.sh
    validate-workshop-state.sh
    log-tool-use.sh
    ralph-loop.sh
    reset-db.sh
    seed-demo-data.sh

  .github/
    workflows/
      ci.yml
    copilot-instructions.md
    hooks/
      pre-tool-use.json
      session-start.json
    prompts/
      review-api.prompt.md
      generate-tests.prompt.md
      plan-feature.prompt.md
      security-review.prompt.md
      create-spec.prompt.md
      ralph-iteration.prompt.md
    agents/
      thorough-reviewer.agent.md
      api-architect.agent.md
      security-reviewer.agent.md
      test-engineer.agent.md
      frontend-reviewer.agent.md
    skills/
      api-error-standardization.skill.md
      secure-api-key-handling.skill.md
      audit-log-consistency.skill.md
      test-generation.skill.md
      spec-driven-feature.skill.md

  apm.yml
  .apm/
    README.md
    packages/
      devportal-copilot-pack/
        apm.yml
        instructions/
          api-style.instructions.md
          security.instructions.md
        prompts/
          service-review.prompt.md
          test-generation.prompt.md
        skills/
          secure-api-key-handling.skill.md
          api-error-standardization.skill.md
        agents/
          security-reviewer.agent.md
```

---

## 12. Documentation Files to Create

### 12.1 `README.md`

Should include:

- What DevPortal is
- How to install dependencies
- How to run frontend/backend
- How to reset and seed database
- How to run tests
- Workshop context
- Warning that the repo intentionally contains issues

### 12.2 `docs/ARCHITECTURE.md`

Should explain:

- Frontend/backend split
- API route structure
- Service layer pattern
- Repository layer pattern
- Prisma schema
- Error handling
- Authorization flow
- Testing strategy

### 12.3 `docs/DOMAIN_RULES.md`

Should explain business rules:

- Who can request access
- Who can approve access
- How API keys are generated
- How API keys are revoked
- How audit logs work
- How service ownership works
- Future rule: access expiration after 30 days

### 12.4 `docs/API_GUIDELINES.md`

Should define:

- REST API conventions
- Error response format
- Validation rules
- Pagination convention
- Naming convention
- Status code convention

### 12.5 `docs/SECURITY.md`

Should explain:

- Raw API keys must never be stored
- Raw API keys must never be logged
- Only hashes are stored
- Authorization must happen on backend
- Markdown docs must be sanitized
- Audit logs must not contain secrets

### 12.6 `docs/PRD.md`

Should contain the workshop backlog with checkboxes.

Example:

```md
# DevPortal Workshop PRD

## Main Feature: Expiring Service Access

- [ ] Add expiration date to approved access
- [ ] Show expiring access on dashboard
- [ ] Disable API keys for expired access
- [ ] Allow service owners to extend access
- [ ] Add audit log events for expiration and extension
- [ ] Add backend tests
- [ ] Add frontend tests
- [ ] Update documentation
```

### 12.7 `docs/KNOWN_ISSUES.md`

Should list selected known issues, not every hidden issue.

### 12.8 `docs/WORKSHOP_GUIDE.md`

Should be instructor-facing.

Include:

- Suggested 3-hour agenda
- Demo sequence
- Exercise descriptions
- Expected participant tasks
- How to reset repo between demos
- Which issues to reveal and when

### 12.9 `docs/COPILOT_SPACES_CONTEXT.md`

This should be a curated document that instructors can add to Copilot Spaces.

It should summarize:

- Product purpose
- Domain rules
- Architecture
- API style
- Security rules
- Workshop feature scope

### 12.10 `docs/DEMO_SCRIPT.md`

Should give step-by-step demo commands and prompts.

---

## 13. Copilot Instruction Files

Create:

```txt
.github/copilot-instructions.md
```

This file should be prebuilt in the repo.

It should instruct Copilot to follow repository conventions.

Suggested content:

```md
# Copilot Instructions for DevPortal

You are assisting in the DevPortal repository, a TypeScript internal developer platform.

## Architecture Rules

- Keep business logic in `apps/api/src/services`.
- Keep database access in `apps/api/src/repositories`.
- Keep route handlers thin.
- Use Zod validators for request validation.
- Use the shared error helpers from `apps/api/src/utils/errors.ts`.
- Use backend authorization checks even if the frontend hides actions.
- Do not put business rules directly in React components.

## API Rules

All API errors must use this format:

{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message",
    "details": {}
  }
}

## Security Rules

- Never log raw API keys.
- Never store raw API keys.
- Store only API key hashes and prefixes.
- Never expose secrets in audit logs.
- Sanitize rendered markdown.
- Authorization must be enforced in backend services or middleware.

## Testing Rules

- Add tests for service-layer business logic.
- Add API tests for authorization-sensitive endpoints.
- Include happy path and at least one edge case.
- Do not remove existing tests to make a task pass.

## Workshop Rules

This repository intentionally contains some defects and incomplete features.
When fixing issues, prefer small, reviewable changes.
Update docs when changing behavior.
```

---

## 14. Prompt Files

Create prompt files in:

```txt
.github/prompts/
```

Prompt files should be plain markdown and reusable during the workshop.

### 14.1 `review-api.prompt.md`

Purpose: review backend API consistency.

Content should ask Copilot to:

- inspect route handlers
- compare error response formats
- find endpoints missing validation
- identify authorization gaps
- propose small fixes

### 14.2 `generate-tests.prompt.md`

Purpose: generate missing tests.

Content should ask Copilot to:

- inspect related implementation
- identify missing cases
- add tests before changing production code
- keep test names readable
- avoid over-mocking

### 14.3 `plan-feature.prompt.md`

Purpose: drive Plan Mode or agent planning.

Content should ask Copilot to:

- research current implementation
- summarize affected files
- ask clarifying questions if needed
- propose implementation plan
- split work into atomic tasks
- wait for approval before implementation

### 14.4 `security-review.prompt.md`

Purpose: security review.

Content should ask Copilot to check:

- API key handling
- logging
- authorization
- audit logs
- markdown rendering
- data leakage

### 14.5 `create-spec.prompt.md`

Purpose: spec-driven development.

Content should ask Copilot to generate:

- proposal.md
- spec.md
- design.md
- tasks.md

for the access expiration feature.

### 14.6 `ralph-iteration.prompt.md`

Purpose: repeated CLI/agent loop.

Content should ask Copilot to:

- read `docs/PRD.md`
- pick the next unchecked task
- implement only that task
- run relevant tests
- update progress notes
- mark task complete only if tests pass

---

## 15. Custom Agents

Create markdown-based custom agent definitions in:

```txt
.github/agents/
```

These are workshop assets. They do not need to be perfect, but they should be realistic and useful.

### 15.1 `thorough-reviewer.agent.md`

Purpose: multi-perspective review coordinator.

Should instruct the agent to review from these perspectives:

- correctness
- security
- architecture
- test coverage
- maintainability

### 15.2 `api-architect.agent.md`

Purpose: backend architecture review.

Focus on:

- service/repository separation
- route handler thinness
- validation consistency
- error format
- database access patterns

### 15.3 `security-reviewer.agent.md`

Purpose: security review.

Focus on:

- API key leakage
- authorization bypasses
- audit log secrets
- unsafe markdown
- excessive data exposure

### 15.4 `test-engineer.agent.md`

Purpose: testing strategy.

Focus on:

- missing service tests
- missing API authorization tests
- edge cases
- regression tests
- skipped tests

### 15.5 `frontend-reviewer.agent.md`

Purpose: frontend review.

Focus on:

- permission UI
- stale state
- unsafe markdown rendering
- error display
- component duplication

---

## 16. Skills

Create reusable skill documents in:

```txt
.github/skills/
```

These can be markdown files that define how Copilot should perform common tasks in this repo.

### 16.1 `api-error-standardization.skill.md`

Describe how to find and standardize inconsistent API errors.

### 16.2 `secure-api-key-handling.skill.md`

Describe rules for generating, hashing, masking, storing, and displaying API keys.

### 16.3 `audit-log-consistency.skill.md`

Describe when audit logs must be created and what they must not include.

### 16.4 `test-generation.skill.md`

Describe testing style, naming, scope, and examples.

### 16.5 `spec-driven-feature.skill.md`

Describe the expected spec workflow:

1. Proposal
2. Requirements
3. Design
4. Tasks
5. Implementation
6. Archive/update docs

---

## 17. Copilot Hooks

Create hook examples in:

```txt
.github/hooks/
```

The workshop includes Copilot Hooks, so the repo should contain working examples or realistic placeholders.

### 17.1 `pre-tool-use.json`

Example purpose:

- run a security check before tool use
- block or warn if sensitive files are touched
- detect raw API keys
- log activity

Suggested file:

```json
{
  "version": 1,
  "hooks": {
    "preToolUse": [
      {
        "type": "command",
        "bash": "./scripts/security-check.sh",
        "powershell": "./scripts/security-check.ps1",
        "cwd": ".",
        "timeoutSec": 15
      },
      {
        "type": "command",
        "bash": "./scripts/log-tool-use.sh",
        "powershell": "./scripts/log-tool-use.ps1",
        "cwd": ".",
        "timeoutSec": 10
      }
    ]
  }
}
```

### 17.2 `session-start.json`

Example purpose:

- print workshop context
- validate dependencies
- remind agent of key repo rules

Suggested file:

```json
{
  "version": 1,
  "hooks": {
    "sessionStart": [
      {
        "type": "command",
        "bash": "./scripts/validate-workshop-state.sh",
        "powershell": "./scripts/validate-workshop-state.ps1",
        "cwd": ".",
        "timeoutSec": 20
      }
    ]
  }
}
```

---

## 18. Hook Scripts

Create scripts in:

```txt
scripts/
```

Make them simple and readable.

### 18.1 `security-check.sh`

Should check for:

- raw API key patterns
- accidental `.env` changes
- suspicious `console.log` of secret/key/token
- direct exposure of `keyHash`
- unsafe markdown rendering imports or patterns

It can warn instead of hard-failing by default. Add a config flag to make it strict.

### 18.2 `detect-secrets.sh`

Can be used by `security-check.sh`.

Should scan changed files or the repo for suspicious patterns.

### 18.3 `log-tool-use.sh`

Should append a timestamped entry to:

```txt
.agent/logs/tool-use.log
```

### 18.4 `validate-workshop-state.sh`

Should check:

- dependencies installed
- database exists
- seed data exists
- required docs exist
- required Copilot files exist

### 18.5 `reset-db.sh`

Should reset SQLite database and reseed.

### 18.6 `ralph-loop.sh`

Should implement a simple loop around Copilot CLI.

Pseudo implementation:

```bash
#!/usr/bin/env bash
set -euo pipefail

MAX=${1:-8}
i=0

while grep -q '\- \[ \]' docs/PRD.md; do
  i=$((i + 1))
  if [ "$i" -gt "$MAX" ]; then
    echo "Max iterations reached."
    exit 1
  fi

  copilot --yolo -p "$(cat .github/prompts/ralph-iteration.prompt.md)"
done

echo "All PRD tasks completed."
```

This script may be a workshop artifact and does not need to be run automatically in CI.

---

## 19. APM / Agent Package Manager Assets

Create both a project-level `apm.yml` and a local example package.

### 19.1 Root `apm.yml`

Suggested purpose:

- represent project dependencies on reusable agent assets
- show how a project could consume shared skills, prompts, and agents

Example:

```yaml
name: devportal
version: 1.0.0
description: DevPortal workshop project for advanced GitHub Copilot workflows.

dependencies:
  apm:
    - ./apm-packages/devportal-copilot-pack
```

### 19.2 Local APM Package

Create:

```txt
.apm/packages/devportal-copilot-pack/
```

Include:

```txt
apm.yml
instructions/
prompts/
skills/
agents/
```

The package should contain reusable assets such as:

- API style instructions
- Security instructions
- API key handling skill
- Test generation prompt
- Security reviewer agent

This should help demonstrate:

> Teams can package and share agentic setup across repositories.

---

## 20. Copilot Spaces Material

Copilot Spaces itself is not stored fully inside the repo, but the repo should include curated files that are ideal to add to a Space.

Create:

```txt
docs/COPILOT_SPACES_CONTEXT.md
```

This should be the main document to add to a Copilot Space.

It should include:

- Product summary
- User roles
- Domain rules
- Architecture overview
- API error format
- Security rules
- Workshop feature scope
- Known conventions

Also mention in `docs/WORKSHOP_GUIDE.md` which files should be added to the Space:

```txt
Recommended files for Copilot Space:
- docs/COPILOT_SPACES_CONTEXT.md
- docs/DOMAIN_RULES.md
- docs/ARCHITECTURE.md
- docs/API_GUIDELINES.md
- docs/SECURITY.md
- docs/PRD.md
- .github/copilot-instructions.md
```

---

## 21. Copilot Memory Exercise Material

Copilot Memory is repository-scoped and cannot be fully prebuilt as a static file in the repo.

However, create a file:

```txt
docs/MEMORY_EXERCISE.md
```

This file should tell the instructor and participants which memories to establish during the workshop.

Suggested memories to create through Copilot activity:

1. Business logic belongs in service classes, not route handlers.
2. API errors must use the standard `{ error: { code, message, details } }` shape.
3. Raw API keys must never be logged or stored.
4. Every access approval/rejection/revocation must create an audit event.
5. Tests should cover both role authorization and domain edge cases.

Also include prompt examples:

```md
Ask Copilot:
"Remember that this repository keeps business rules in services and database access in repositories."

Ask Copilot:
"Remember that every access lifecycle event must produce an audit log entry."

Ask Copilot:
"Remember that raw API keys are only shown once and must never be logged."
```

---

## 22. Spec-Driven Development Material

Create:

```txt
specs/access-expiration/
  proposal.md
  spec.md
  design.md
  tasks.md
```

Before workshop:

- These files should exist but be incomplete.
- Leave useful TODOs.
- Include enough structure for participants to refine with Copilot.

### 22.1 `proposal.md`

Should explain intent:

> Add expiration dates to approved service access so access is automatically considered expired after 30 days unless extended by a service owner or platform admin.

### 22.2 `spec.md`

Should include requirements with some missing details.

Example:

```md
## Requirements

### Requirement: Approved access expires
Approved access must expire after a configured number of days.

#### Scenario: Access expires after 30 days
Given a developer has approved access to a service
When 30 days have passed
Then the access should be marked as expired
And related API keys should no longer be valid
```

### 22.3 `design.md`

Should describe possible schema and service changes but leave final decision open.

### 22.4 `tasks.md`

Should contain unchecked tasks:

```md
- [ ] Add expiration fields to access request/access model
- [ ] Add service function to determine expiration state
- [ ] Update API key validation to check access expiration
- [ ] Add dashboard expiring access warning
- [ ] Add audit events for expiration and extension
- [ ] Add backend tests
- [ ] Add frontend tests
- [ ] Update docs
```

---

## 23. Plan Mode Exercise

Create a section in `docs/WORKSHOP_GUIDE.md` called:

```md
## Exercise: Plan Mode for Access Expiration
```

The instructor prompt:

```md
We need to add expiring service access to DevPortal.

Use Plan Mode. First research the current codebase. Identify the files, data model, services, endpoints, tests, and docs affected by this feature. Then create an implementation plan with atomic tasks. Do not implement until I approve the plan.
```

Expected Copilot output:

- summary of current access flow
- affected files
- missing details or clarifying questions
- implementation plan
- test plan
- risks
- docs to update

---

## 24. Ralph Loop Exercise

Create `docs/RALPH_LOOP_EXERCISE.md`.

The exercise should use `docs/PRD.md` and `.github/prompts/ralph-iteration.prompt.md`.

Goal:

- Show how a CLI loop can repeatedly pick one small task
- Keep context fresh
- Make incremental changes
- Update progress notes

Create:

```txt
.agent/progress.md
```

with starter content:

```md
# Agent Progress Notes

This file is updated by the Ralph loop exercise.

## Iterations
```

The Ralph iteration prompt should tell Copilot:

- pick only one unchecked task
- implement minimal change
- run tests
- update progress
- do not continue to the next task in the same iteration

---

## 25. Subagent Exercise

Create `docs/SUBAGENTS_EXERCISE.md`.

Instructor prompt:

```md
Review the access expiration implementation using separate perspectives:
1. Correctness reviewer
2. Security reviewer
3. API architecture reviewer
4. Frontend reviewer
5. Test coverage reviewer

Keep each perspective isolated. Then synthesize the findings into a prioritized review.
```

Expected review categories:

- Critical issues
- Important issues
- Nice-to-have improvements
- What the implementation does well
- Suggested next steps

The custom agents in `.github/agents/` should support this exercise.

---

## 26. CLI Exercise

Create `docs/CLI_EXERCISE.md`.

Example Copilot CLI prompts:

```bash
copilot -p "Summarize the backend routes in this repository and identify inconsistent error responses."

copilot -p "Find where API keys are generated, stored, logged, or displayed. Identify security risks."

copilot -p "Inspect the skipped access expiration tests and propose an implementation plan."

copilot -p "Find the most likely reason the API key revocation test is incomplete and suggest missing test cases."

copilot -p "Update docs/DOMAIN_RULES.md to include the access expiration behavior based on the implementation."
```

Include a note that actual supported CLI commands may vary by environment. The repo should provide the prompts and scripts, but the instructor can adapt commands during the live demo.

---

## 27. Hooks Exercise

Create `docs/HOOKS_EXERCISE.md`.

Exercise flow:

1. Show `.github/hooks/pre-tool-use.json`
2. Show `scripts/security-check.sh`
3. Ask Copilot to make a change that accidentally logs an API key
4. Run the hook/security script
5. Let Copilot fix the issue
6. Improve the hook script with a new rule

Instructor prompt:

```md
Inspect the current Copilot hook configuration and the security-check script.
Improve the script so it detects any console.log statement that includes key, token, secret, or password.
Keep the script simple and cross-platform friendly where possible.
```

---

## 28. APM Exercise

Create `docs/APM_EXERCISE.md`.

Exercise flow:

1. Show root `apm.yml`
2. Show `.apm/packages/devportal-copilot-pack`
3. Explain that teams can share prompts, skills, agents, and instructions
4. Ask participants to add a reusable skill or prompt
5. Optionally install or copy it into `.github/skills`

Instructor task:

```md
Create a reusable skill called `access-expiration-review.skill.md`.
The skill should tell Copilot how to review access expiration implementations for correctness, security, auditability, and tests.
```

---

## 29. Spaces Exercise

Create `docs/SPACES_EXERCISE.md`.

Exercise flow:

1. Create or open a Copilot Space
2. Add curated docs:
   - `docs/COPILOT_SPACES_CONTEXT.md`
   - `docs/DOMAIN_RULES.md`
   - `docs/ARCHITECTURE.md`
   - `docs/API_GUIDELINES.md`
   - `docs/SECURITY.md`
   - `docs/PRD.md`
3. Ask questions grounded in the Space
4. Compare answers with and without Space context

Example prompts:

```md
Using the DevPortal space, explain who is allowed to approve access requests.

Using the DevPortal space, where should access expiration logic be implemented?

Using the DevPortal space, what files should be updated when API key lifecycle rules change?
```

---

## 30. Workshop Tasks for Participants

Create a participant-facing file:

```txt
docs/PARTICIPANT_TASKS.md
```

Include the following tasks.

### Task 1: Understand the Codebase

Prompt:

```md
Use Copilot to summarize the DevPortal architecture.
Identify the frontend entry points, backend route structure, service layer, repository layer, and database models.
```

Expected result:

- Participants know where things live.
- Copilot uses repo instructions and docs.

### Task 2: Find and Fix an API Error Inconsistency

Prompt:

```md
Find endpoints that do not use the standard API error format.
Fix one endpoint and add or update tests.
```

Expected result:

- Demonstrates codebase search, refactoring, tests, and memory.

### Task 3: Security Review of API Key Handling

Prompt:

```md
Review API key generation, storage, display, and logging.
Find any place where raw keys may be exposed.
Fix the issue and add a regression test or script check.
```

Expected result:

- Demonstrates security review and hooks.

### Task 4: Backend Authorization Fix

Prompt:

```md
Find whether access approval is protected only in the frontend or also in the backend.
Ensure only service owners or platform admins can approve requests.
Add tests for unauthorized users.
```

Expected result:

- Demonstrates senior developer security thinking.

### Task 5: Add Missing Audit Log

Prompt:

```md
Rejected access requests should create audit log entries.
Find the approval/rejection flow, add the missing audit event, and test it.
```

Expected result:

- Demonstrates business rule consistency.

### Task 6: Plan the Access Expiration Feature

Prompt:

```md
Use Plan Mode to research and plan the access expiration feature.
Do not implement yet.
```

Expected result:

- Demonstrates research-plan-implement workflow.

### Task 7: Create or Refine the Spec

Prompt:

```md
Using the existing files in specs/access-expiration, refine the proposal, spec, design, and tasks for access expiration.
```

Expected result:

- Demonstrates spec-driven development.

### Task 8: Implement One Access Expiration Task

Prompt:

```md
Pick one task from specs/access-expiration/tasks.md and implement only that task.
Run relevant tests and update progress notes.
```

Expected result:

- Demonstrates incremental implementation.

### Task 9: Use Subagents for Review

Prompt:

```md
Review the implementation using separate subagents for correctness, security, architecture, frontend, and tests.
Synthesize the findings.
```

Expected result:

- Demonstrates multi-perspective code review.

### Task 10: Update Docs

Prompt:

```md
Update DOMAIN_RULES.md, API_GUIDELINES.md, and SECURITY.md to match the final implementation.
```

Expected result:

- Demonstrates docs as part of engineering workflow.

---

## 31. Suggested 3-Hour Workshop Agenda

Create this in `docs/WORKSHOP_GUIDE.md`.

### 0:00–0:10 — Intro and Repo Setup

- Explain DevPortal
- Run app
- Show dashboard
- Explain that repo intentionally has defects and missing features

### 0:10–0:35 — Copilot Context and Spaces

- Show docs
- Show `.github/copilot-instructions.md`
- Add selected docs to Copilot Space
- Ask Copilot domain questions

### 0:35–1:00 — Hooks and Security Guardrails

- Show hook config
- Show security script
- Detect raw API key logging
- Improve hook rule

### 1:00–1:25 — Memory and Repository Conventions

- Standardize error format
- Ask Copilot to remember conventions
- Show how repeated prompting becomes shorter

### 1:25–1:40 — APM and Shared Agent Assets

- Show local APM package
- Explain reusable prompts/skills/agents
- Add or modify one skill

### 1:40–1:50 — Break

### 1:50–2:15 — Copilot CLI

- Use CLI to summarize routes
- Find skipped tests
- Analyze API key handling
- Update docs or propose plan

### 2:15–2:40 — Plan Mode and Spec-Driven Development

- Plan access expiration feature
- Refine `specs/access-expiration`
- Human reviews and approves plan

### 2:40–2:55 — Ralph Loop

- Show PRD checklist
- Run one or two loop iterations
- Review progress notes

### 2:55–3:00 — Subagents and Wrap-Up

- Run multi-perspective review
- Summarize what changed
- Explain how this maps to senior developer work

---

## 32. Prebuilt vs Participant-Built Assets

This distinction is very important.

### 32.1 Must Be Prebuilt by Claude Code

Claude Code should create these before the workshop:

- Working frontend dashboard
- Working backend API
- Prisma schema and seed data
- Basic tests
- Documentation files
- Some Copilot instruction files
- Some prompt files
- Some custom agent files
- Some skill files
- Hook config examples
- Hook scripts
- APM skeleton
- Spec skeleton
- PRD/backlog
- Known issues
- Workshop guide
- Demo scripts

### 32.2 Must Be Left for Participants

Do not fully complete these:

- Access expiration feature
- All standard error refactoring
- All authorization fixes
- All security fixes
- All audit log consistency fixes
- All tests
- All documentation updates
- All hook improvements
- All APM skills
- Full spec finalization

Participants should have meaningful work to do.

### 32.3 Should Be Intentionally Partial

These should exist but be incomplete:

- `specs/access-expiration/*`
- `docs/PRD.md`
- `.github/prompts/create-spec.prompt.md`
- `.github/skills/spec-driven-feature.skill.md`
- `scripts/security-check.sh`
- `apps/api/src/tests/accessExpiration.skip.test.ts`
- Some API error tests
- Some audit log tests
- Some frontend permission tests

---

## 33. Database Schema Guidance

Use Prisma with SQLite.

Suggested models:

```prisma
model User {
  id        String   @id @default(cuid())
  name      String
  email     String   @unique
  role      String
  teamId    String?
  team      Team?    @relation(fields: [teamId], references: [id])
  createdAt DateTime @default(now())
}

model Team {
  id        String    @id @default(cuid())
  name      String
  slug      String    @unique
  services  Service[]
  users     User[]
}

model Service {
  id          String   @id @default(cuid())
  name        String
  slug        String   @unique
  description String
  status      String
  baseUrl     String
  docsMarkdown String
  ownerTeamId String
  ownerTeam   Team     @relation(fields: [ownerTeamId], references: [id])
  createdAt   DateTime @default(now())
  updatedAt   DateTime @updatedAt
}

model AccessRequest {
  id              String   @id @default(cuid())
  serviceId       String
  service         Service  @relation(fields: [serviceId], references: [id])
  requesterUserId String
  requester       User     @relation(fields: [requesterUserId], references: [id])
  reason          String
  status          String
  reviewedById    String?
  reviewedAt      DateTime?
  rejectionReason String?
  createdAt       DateTime @default(now())

  // Workshop feature fields may be added later:
  // expiresAt DateTime?
  // extendedAt DateTime?
  // extendedById String?
}

model ApiKey {
  id        String   @id @default(cuid())
  serviceId String
  service   Service  @relation(fields: [serviceId], references: [id])
  userId    String
  user      User     @relation(fields: [userId], references: [id])
  keyPrefix String
  keyHash   String
  label     String
  status    String
  createdAt DateTime @default(now())
  revokedAt DateTime?
  lastUsedAt DateTime?
}

model UsageEvent {
  id        String   @id @default(cuid())
  serviceId String
  apiKeyId  String?
  endpoint  String
  statusCode Int
  latencyMs Int
  success   Boolean
  timestamp DateTime @default(now())
}

model AuditLog {
  id          String   @id @default(cuid())
  actorUserId String?
  action      String
  entityType  String
  entityId    String
  message     String
  metadata    Json?
  createdAt   DateTime @default(now())
}
```

Adjust relation names as needed to satisfy Prisma.

---

## 34. API Endpoints

Build these endpoints:

```txt
GET    /api/me
GET    /api/services
GET    /api/services/:id
POST   /api/services/:id/access-requests
GET    /api/access-requests
POST   /api/access-requests/:id/approve
POST   /api/access-requests/:id/reject
GET    /api/api-keys
POST   /api/api-keys/:id/revoke
GET    /api/usage/summary
GET    /api/audit-log
```

Optional endpoints for workshop feature:

```txt
GET    /api/access/expiring
POST   /api/access-requests/:id/extend
```

These optional endpoints can be left unimplemented or partially implemented for participants.

---

## 35. Frontend Requirements

The frontend should be simple but realistic.

Required:

- Dashboard layout
- User selector
- Services tab
- Access Requests tab
- API Keys tab
- Usage tab
- Audit Log tab
- Service detail view
- Basic loading/error states
- Permission-based button visibility

Intentional frontend issue:

- Some permission checks exist only in frontend.
- Backend must be fixed during workshop.

Security issue:

- Markdown rendering should initially be naive or partially unsafe.
- Include a TODO and test opportunity for sanitization.

---

## 36. Testing Requirements

Before the workshop, include enough tests that participants trust the repo.

Minimum tests:

- service listing API
- access request creation
- access approval happy path
- API key generation
- API key revocation basic case
- audit log created on approval
- frontend renders service list
- frontend hides approval button for developers

Intentional test gaps:

- unauthorized approval should fail
- rejection should create audit log
- revoked keys should not validate
- access expiration tests skipped
- markdown sanitization missing

Add `npm test` or `pnpm test` at root.

Add `npm run test:api`, `npm run test:web`, `npm run lint`, `npm run typecheck`.

---

## 37. GitHub Actions

Create:

```txt
.github/workflows/ci.yml
```

CI should run:

- install dependencies
- generate Prisma client
- run lint
- run typecheck
- run tests

It does not need deployment.

---

## 38. Workshop Reset Support

Add scripts:

```bash
npm run reset
npm run seed
npm run workshop:reset
npm run workshop:validate
```

Purpose:

- restore database
- seed known data
- validate workshop files exist
- ensure exercises start from expected state

---

## 39. Seed Data

Create realistic seed data.

Teams:

- Platform Team
- Payments Team
- Identity Team
- Data Team

Users:

- Alice Admin, platform_admin
- Omar Owner, service_owner, Payments Team
- Sara Owner, service_owner, Identity Team
- Nina Developer, developer
- Leo Developer, developer

Services:

- Payments API
- Identity API
- Notifications API
- Analytics API
- Inventory API
- Search API

Access requests:

- 2 pending
- 2 approved
- 1 rejected

API keys:

- 2 active
- 1 revoked

Usage events:

- enough to populate dashboard charts/tables

Audit logs:

- approval
- key generation
- key revocation
- service update

---

## 40. Quality Bar

The repo should:

- run locally
- be understandable
- include realistic domain names
- have meaningful tests
- include TODOs and intentional defects
- contain rich documentation
- contain Copilot assets
- not require external paid services
- not require Docker unless optional
- avoid overly complex auth
- avoid a huge UI framework
- avoid hidden magic

The code should be clean enough that Copilot can reason about it, but imperfect enough to create meaningful workshop exercises.

---

## 41. Acceptance Criteria for Claude Code

The generated repository is acceptable when:

1. `README.md` explains setup and workshop purpose.
2. Frontend dashboard runs and displays seeded data.
3. Backend API runs and serves all core endpoints.
4. SQLite/Prisma setup works.
5. Tests run, with some passing and some intentionally skipped.
6. `docs/` includes all required workshop documentation.
7. `.github/copilot-instructions.md` exists.
8. `.github/hooks/` contains hook JSON examples.
9. `scripts/` contains hook and workshop scripts.
10. `.github/prompts/` contains reusable prompt files.
11. `.github/agents/` contains custom agent definitions.
12. `.github/skills/` contains reusable skill documents.
13. `apm.yml` and `.apm/` package skeleton exist.
14. `specs/access-expiration/` exists and is intentionally incomplete.
15. `docs/PRD.md` includes workshop tasks.
16. There are 8–12 intentional issues suitable for Copilot exercises.
17. The access expiration feature is not fully implemented.
18. The repo can be reset to a known state.
19. No real secrets or credentials are included.
20. The overall complexity fits a 3-hour advanced workshop.

---

## 42. Final Instruction to Claude Code

Build this as a complete workshop repository, not as a production app.

Prioritize:

1. Workshop usefulness
2. Clear codebase structure
3. Good Copilot demonstration opportunities
4. Realistic defects and TODOs
5. Documentation quality
6. Easy local setup

Do not fully solve every issue. The repository must give participants meaningful work to do during the advanced GitHub Copilot workshop.

The final result should feel like a professional internal developer platform that is 70–80% complete and intentionally prepared for advanced Copilot training.
