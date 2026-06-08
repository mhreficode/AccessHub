# AccessHub

AccessHub is a small internal **developer platform and API catalog**. Engineering
teams use it to discover internal services, read API docs, request access, receive
API keys, monitor usage, and review audit history.

> ⚠️ **Workshop repository.** This codebase is intentionally imperfect. It contains
> realistic defects, missing tests, outdated docs, and incomplete features. It is the
> hands-on project for an advanced **GitHub Copilot** workshop. Do not treat it as a
> reference for production-quality code.

## What's inside

```
apps/web    React + Vite + TypeScript dashboard
apps/api    Express + Prisma (SQLite) + Zod backend
prisma      Schema and seed data
docs        Architecture, domain rules, API guidelines, security, PRD, workshop guide
exercises   Hands-on workshop exercises, one markdown per Copilot topic
specs       Spec-driven workflow for the workshop feature (intentionally incomplete)
scripts     Database, security-check, and workshop helper scripts
.github     Copilot instructions, prompts, agents, skills, hooks, CI
.apm        Example Agent Package Manager package
```

## Prerequisites

Works on macOS, Linux, and Windows. You need:

- **Node.js 20 or newer** (bundled npm 10+ — this repo uses npm workspaces)
- **Git** (to clone the repo)
- No database server to install — the app uses a local SQLite file.

Check your versions:

```bash
node -v   # v20.x or higher
npm -v    # 10.x or higher
```

## Setup (under 5 minutes)

```bash
# 1. Get the code and enter the project
git clone <repository-url> accesshub
cd accesshub
# (if you received a zip instead, unzip it and `cd` into the folder)

# 2. Install dependencies
npm install

# 3. Create your env file (defaults work as-is)
cp .env.example .env        # Windows PowerShell: copy .env.example .env

# 4. Generate the Prisma client, create the SQLite DB, and seed it
npm run prisma:generate
npm run db:push
npm run db:seed

# 5. (optional) Confirm everything is ready
npm run workshop:validate
```

## Run it

Open two terminals (both from the project root):

```bash
# Terminal 1 — backend API on http://localhost:4000
npm run dev:api

# Terminal 2 — frontend on http://localhost:5173
npm run dev:web
```

Then open **http://localhost:5173**. The frontend proxies API calls to the backend, so
you only browse that one URL.

Use the **user switcher** in the top-right to act as different seeded users (a
developer, service owners, and a platform admin). The frontend sends the selected
user's id as the `x-user-id` header — this is the workshop's simplified stand-in for
real authentication.

> Ports: API `4000`, frontend `5173`. To change the API port, set `API_PORT` in `.env`
> **and** update the proxy target in `apps/web/vite.config.ts`.

## Reset and reseed the database

```bash
npm run db:reset        # drops, re-pushes, and reseeds the SQLite DB
npm run workshop:reset  # full reset to the known workshop starting state
```

## Tests, lint, types

```bash
npm test            # api + web test suites
npm run test:api    # backend (Vitest + Supertest)
npm run test:web    # frontend (Vitest + Testing Library)
npm run lint        # ESLint
npm run typecheck   # tsc --noEmit for both apps
```

Some tests are **intentionally skipped** — they describe the workshop feature
(Expiring Service Access) that participants implement. See `docs/PRD.md`.

## Roles

| Role | Can do |
|------|--------|
| `developer` | View services, request access, view own keys and requests |
| `service_owner` | Approve/reject requests and revoke keys for services their team owns |
| `platform_admin` | Manage all services, view all requests and audit logs, revoke any key |

## Workshop exercises

The hands-on exercises live in the [`exercises/`](exercises/) folder — **one markdown
file per Copilot topic** from the advanced session:

| # | Topic | File |
|---|-------|------|
| 1 | Copilot Hooks | [`exercises/01-copilot-hooks.md`](exercises/01-copilot-hooks.md) |
| 2 | Copilot Memory | [`exercises/02-copilot-memory.md`](exercises/02-copilot-memory.md) |
| 3 | Subagents | [`exercises/03-subagents.md`](exercises/03-subagents.md) |
| 4 | Copilot Spaces | [`exercises/04-copilot-spaces.md`](exercises/04-copilot-spaces.md) |
| 5 | APM (Agent Package Manager) | [`exercises/05-apm.md`](exercises/05-apm.md) |
| 6 | Copilot CLI | [`exercises/06-copilot-cli.md`](exercises/06-copilot-cli.md) |
| 7 | Usage-Based Billing | [`exercises/07-usage-based-billing.md`](exercises/07-usage-based-billing.md) |
| 8 | Plan Mode (RPI) | [`exercises/08-plan-mode.md`](exercises/08-plan-mode.md) |
| 9 | Ralph Loops | [`exercises/09-ralph-loops.md`](exercises/09-ralph-loops.md) |
| 10 | Spec-Driven Development | [`exercises/10-spec-driven-development.md`](exercises/10-spec-driven-development.md) |
| ★ | Capstone (chain them) | [`exercises/99-capstone.md`](exercises/99-capstone.md) |

**Start here:** [`exercises/README.md`](exercises/README.md) — it has the setup/reset
cheat-sheet, the seeded users, and a map of every planted issue and where it lives. Each
exercise file gives the goal, what you'll achieve, the tools to use, concrete steps, and
an open space to brainstorm your own ideas.

## Where to start (instructors)

Read `docs/WORKSHOP_GUIDE.md` for the 3-hour agenda and `docs/PARTICIPANT_TASKS.md`
for the hands-on exercises, then hand participants the [`exercises/`](exercises/) folder.
`docs/KNOWN_ISSUES.md` lists *some* of the planted issues — others are left for discovery.
