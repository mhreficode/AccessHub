# AccessHub — Advanced GitHub Copilot Workshop Exercises

Hands-on exercises for the *GitHub Copilot — Advanced* session, one file per topic. Each
exercise is grounded in **this codebase**, which ships intentional defects and one
unfinished feature (Expiring Service Access) so you do real work, not toy edits.

## Exercises (in presentation order)

| # | Topic | File | Track |
|---|-------|------|-------|
| 1 | Copilot Hooks | [01-copilot-hooks.md](01-copilot-hooks.md) | Presentation & Demos |
| 2 | Copilot Memory | [02-copilot-memory.md](02-copilot-memory.md) | Presentation & Demos |
| 3 | Subagents | [03-subagents.md](03-subagents.md) | Presentation & Demos |
| 4 | Copilot Spaces | [04-copilot-spaces.md](04-copilot-spaces.md) | Presentation & Demos |
| 5 | APM (Agent Package Manager) | [05-apm.md](05-apm.md) | Presentation & Demos |
| 6 | Copilot CLI | [06-copilot-cli.md](06-copilot-cli.md) | Presentation & Demos |
| 7 | Usage-Based Billing | [07-usage-based-billing.md](07-usage-based-billing.md) | Presentation & Demos |
| 8 | Plan Mode (RPI) | [08-plan-mode.md](08-plan-mode.md) | Advanced Workflows |
| 9 | Ralph Loops | [09-ralph-loops.md](09-ralph-loops.md) | Advanced Workflows |
| 10 | Spec-Driven Development | [10-spec-driven-development.md](10-spec-driven-development.md) | Advanced Workflows |
| ★ | Capstone (chain them) | [99-capstone.md](99-capstone.md) | — |

## How each file is structured

- **🎯 Goal** — what the exercise is about, in one breath.
- **🏆 What you'll achieve** — the concrete "definition of done".
- **🧰 Tools you can use** — the Copilot features and repo assets in play.
- **🔧 The exercise** — where to look, concrete steps, and **💬 ready-to-use prompts** you
  can paste straight into Copilot.
- **💡 Ideas & variations** — extra directions if you finish early.
- **🧠 Your turn — brainstorm** — an open space to invent your own exercise.

## Setup (once)

```bash
npm install
cp .env.example .env
npm run prisma:generate && npm run db:push && npm run db:seed
npm run dev:api    # terminal 1 — API on http://localhost:4000
npm run dev:web    # terminal 2 — dashboard on http://localhost:5173
npm run workshop:validate   # confirm assets are present
```

**Reset between exercises:** `npm run workshop:reset` (database) and `git stash` /
`git checkout -- .` (code).

**Acting as a user** (the frontend sends an `x-user-id` header):

| User id | Role | Team |
|---------|------|------|
| `user-alice` | platform_admin | Platform |
| `user-omar` | service_owner | Payments |
| `user-sara` | service_owner | Identity |
| `user-nina`, `user-leo` | developer | Data |

## The planted-issues map (verified anchors)

What is intentionally wrong/missing and where. Listed ones are in `docs/KNOWN_ISSUES.md`;
*(hidden)* ones are left for discovery.

| # | Issue | Anchor |
|---|-------|--------|
| 1 | Inconsistent API error shapes (ad-hoc `{message}` / `{error:"..."}`) | `apps/api/src/routes/services.routes.ts:31,46`, `apps/api/src/routes/apiKeys.routes.ts:30`; helpers in `apps/api/src/utils/errors.ts` |
| 2 | Approve/reject only blocks developers, never checks team ownership | `apps/api/src/services/accessRequest.service.ts` `approve()`≈L49, `reject()`≈L90; fix uses `assertCanManageService` (`authz.service.ts:42`) |
| 3 | Raw API key logged in dev mode | `apps/api/src/services/apiKey.service.ts:27` |
| 4 | No audit event on access rejection (approval has one) | `accessRequest.service.ts` `approve()` audits ≈L64; `reject()` ≈L84–105 audits nothing |
| 5 | Service-doc markdown rendered unsanitized (XSS) | `apps/web/src/utils/markdown.ts:9` (`renderMarkdownUnsafe`), used in `apps/web/src/routes/ServiceDetail.tsx:75` |
| 6 | Duplicate `reason` validation (route + service) + an **unused** `reason` Zod schema (dead code) *(hidden)* | route `services.routes.ts:44`, service `accessRequest.service.ts:21`, unused `validators/access.validators.ts:4` (`createAccessRequestSchema`) |
| 7 | Usage summary aggregates every event in memory *(hidden)* | `apps/api/src/services/usage.service.ts:16,24` |
| 8 | Identity API docs cite a deprecated endpoint *(hidden)* | seeded `docsMarkdown` in `prisma/seed.ts:76` (`GET /v1/userinfo` → `/v2/users/{id}`) |
| 9 | No test that a revoked key fails `validateKey()` *(hidden)* | `apps/api/src/tests/apiKeys.test.ts:48` (NOTE); `validateKey` at `apiKey.service.ts:75` |
| 10 | Access-expiration feature unbuilt; tests skipped | `apps/api/src/tests/accessExpiration.skip.test.ts` (4 × `it.skip`); backlog `docs/PRD.md`; spec skeleton `specs/access-expiration/` |

## Legend

⏱ time · 🟢 warm-up · 🟡 core · 🔴 stretch
