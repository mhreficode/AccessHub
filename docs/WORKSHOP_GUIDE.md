# Workshop Guide (Instructor)

A 3-hour advanced GitHub Copilot workshop built around AccessHub. The goal is to show
Copilot as a senior-developer tool: understanding a codebase, following repository
instructions and domain docs, using hooks, prompts, skills, Spaces, Memory, APM, CLI,
Plan Mode, Ralph loops, spec-driven development, and subagents.

## Before the session

```bash
npm install
cp .env.example .env
npm run prisma:generate && npm run db:push && npm run db:seed
npm run dev:api    # terminal 1
npm run dev:web    # terminal 2
```

Confirm the dashboard loads at http://localhost:5173 and tests run with `npm test`.

Optionally validate the workshop assets are present:

```bash
npm run workshop:validate
```

## Suggested 3-hour agenda

### 0:00–0:10 — Intro and repo setup
- Explain AccessHub (internal developer platform / API catalog).
- Run the app, show the dashboard and user switcher.
- Stress that the repo intentionally contains defects and an unfinished feature.

### 0:10–0:35 — Copilot context and Spaces
- Walk through `docs/` and `.github/copilot-instructions.md`.
- Add the curated docs to a Copilot Space (see `docs/SPACES_EXERCISE.md`).
- Ask domain questions and compare answers with/without the Space.

### 0:35–1:00 — Hooks and security guardrails
- Show `.github/hooks/pre-tool-use.json` and `scripts/security-check.sh`.
- Have Copilot make a change that logs an API key; run the check; let Copilot fix it.
- Improve the hook rule. See `docs/HOOKS_EXERCISE.md`.

### 1:00–1:25 — Memory and repository conventions
- Standardize one inconsistent error response.
- Ask Copilot to remember the conventions; show prompts getting shorter.
- See `docs/MEMORY_EXERCISE.md`.

### 1:25–1:40 — APM and shared agent assets
- Show `apm.yml` and `.apm/packages/accesshub-copilot-pack`.
- Add or modify one skill. See `docs/APM_EXERCISE.md`.

### 1:40–1:50 — Break

### 1:50–2:15 — Copilot CLI
- Summarize routes, find skipped tests, analyze API key handling, update a doc.
- See `docs/CLI_EXERCISE.md`.

### 2:15–2:40 — Plan Mode and spec-driven development
- Plan the access-expiration feature; refine `specs/access-expiration/`.
- Human reviews and approves the plan before any code.

### 2:40–2:55 — Ralph loop
- Show the `docs/PRD.md` checklist; run one or two loop iterations.
- Review `.agent/progress.md`. See `docs/RALPH_LOOP_EXERCISE.md`.

### 2:55–3:00 — Subagents and wrap-up
- Run a multi-perspective review. See `docs/SUBAGENTS_EXERCISE.md`.
- Summarize what changed and how it maps to senior-developer work.

## Exercise: Plan Mode for Access Expiration

Instructor prompt:

```
We need to add expiring service access to AccessHub.

Use Plan Mode. First research the current codebase. Identify the files, data model,
services, endpoints, tests, and docs affected by this feature. Then create an
implementation plan with atomic tasks. Do not implement until I approve the plan.
```

Expected Copilot output: a summary of the current access flow, the affected files,
clarifying questions, an implementation plan, a test plan, risks, and the docs to
update.

## Which issues to reveal, and when

- Reveal issues #1–#5 from `docs/KNOWN_ISSUES.md` as you reach the matching segment.
- Keep the undocumented issues hidden; use them for the CLI/review discovery exercises.

## Recommended files for a Copilot Space

```
docs/COPILOT_SPACES_CONTEXT.md
docs/DOMAIN_RULES.md
docs/ARCHITECTURE.md
docs/API_GUIDELINES.md
docs/SECURITY.md
docs/PRD.md
.github/copilot-instructions.md
```

## Reset between demos

```bash
npm run workshop:reset   # reset + reseed the database to the known starting state
git stash                # or discard code changes between groups
```
