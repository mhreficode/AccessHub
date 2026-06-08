# Demo Script

Step-by-step prompts and commands for the live demo. Adapt freely; exact Copilot CLI
commands vary by environment.

## 0. Setup

```bash
npm install && cp .env.example .env
npm run prisma:generate && npm run db:push && npm run db:seed
npm run dev:api &   # http://localhost:4000
npm run dev:web     # http://localhost:5173
```

Show the dashboard, switch users, open a service detail panel.

## 1. Context grounding

In chat:

```
Read .github/copilot-instructions.md and docs/DOMAIN_RULES.md. Who is allowed to
approve an access request in AccessHub, and where should that check live?
```

Then create a Space (see `docs/SPACES_EXERCISE.md`) and re-ask to compare grounding.

## 2. Hooks + security

```
Add a console.log of the raw key in apiKey.service.ts for debugging.
```

Run the check and show it is caught:

```bash
bash scripts/security-check.sh
```

Then:

```
Remove that log and explain why logging raw keys is unsafe. Then improve
scripts/security-check.sh so it also flags console.log lines containing
key, token, secret, or password.
```

## 3. Memory + error standardization

```
Find one endpoint that does not return the standard error shape and fix it to use the
helpers in apps/api/src/utils/errors.ts. Then remember that AccessHub API errors must
use { error: { code, message, details } }.
```

## 4. Copilot CLI (terminal)

```bash
copilot -p "Summarize the backend routes and identify inconsistent error responses."
copilot -p "Find where API keys are generated, stored, logged, or displayed. List risks."
copilot -p "Inspect the skipped access expiration tests and propose an implementation plan."
```

## 5. Plan Mode + spec

```
Use Plan Mode to plan the Expiring Service Access feature. Research first, list affected
files, ask clarifying questions, then produce atomic tasks. Do not implement yet.
```

Refine `specs/access-expiration/` with Copilot.

## 6. Ralph loop

```bash
# Dry run the iteration prompt manually first, then:
bash scripts/ralph-loop.sh 2
```

Show `.agent/progress.md` after iterations.

## 7. Subagents review

```
Review the access-expiration changes using five perspectives — correctness, security,
API architecture, frontend, tests — keeping each isolated, then synthesize a
prioritized review.
```

## Reset

```bash
npm run workshop:reset
git checkout -- .
```
