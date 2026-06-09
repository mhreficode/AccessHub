# 2. Copilot Memory

> Persistent, repository-scoped memory that captures conventions and facts learned from
> working in a repo — so you repeat yourself less and Copilot stays aligned with house
> style. (Currently in the cloud agent, code review, and **Copilot CLI** — do this there,
> not the IDE.)

**Track:** Presentation & Demos · **Time:** ⏱15–20m · **Level:** 🟡 core

---

## 🎯 Goal

Teach Copilot a repo convention once, then watch a later task get easier because Copilot
already holds it.

## 🏆 What you'll achieve

- Two endpoints now return the standard error shape `{ error: { code, message, details } }`.
- Copilot has remembered the error-shape and layering conventions (with citations).
- The second fix needed materially **less** prompting than the first.

## 🧰 Tools you can use

- Copilot CLI or the cloud agent (where memory is supported).
- "Remember that …" prompts to create memories; ask Copilot what it remembers.
- The standard helpers in `apps/api/src/utils/errors.ts`
  (`badRequest`, `unauthorized`, `forbidden`, `notFound`, `conflict`).
- `.github/copilot-instructions.md` for comparison (always-on vs learned memory).

## 🔧 The exercise

**Where to look:** ad-hoc error shapes live at `apps/api/src/routes/services.routes.ts:31`
(`{ message: 'Service not found' }`) and `apps/api/src/routes/apiKeys.routes.ts:30`
(`{ error: 'API key not found' }`).

**Steps**
1. Fix the first one: throw `notFound('SERVICE_NOT_FOUND', 'Service not found')` from
   `utils/errors.ts` and let the central error handler serialize it. Run
   `npm run test:api`.
2. Tell Copilot to remember:
   > *Remember that AccessHub API errors must use `{ error: { code, message, details } }`
   > via `apps/api/src/utils/errors.ts`, and that business logic lives in services while
   > database access lives in repositories.*
3. Now fix `apiKeys.routes.ts:30` with a **short** prompt (e.g. *"standardize this
   endpoint's error"*). Notice Copilot applies the remembered convention unprompted.

### 💬 Prompts to use with Copilot

**Step 1 — fix the first endpoint:**
> In `apps/api/src/routes/services.routes.ts`, the not-found response returns
> `{ message: 'Service not found' }`. Refactor it to throw
> `notFound('SERVICE_NOT_FOUND', 'Service not found')` from `apps/api/src/utils/errors.ts`
> so the central error handler emits the standard `{ error: { code, message, details } }`
> shape. Then run `npm run test:api`.

**Step 2 — create the memory** (run in Copilot CLI or the cloud agent, where memory lives):
> Remember that AccessHub API errors must always use the shape
> `{ error: { code, message, details } }` produced via `apps/api/src/utils/errors.ts`, and
> that business logic lives in services while database access lives in repositories.

**Step 3 — reuse it with a short prompt:**
> Standardize the error response in `apps/api/src/routes/apiKeys.routes.ts`.

**Definition of done:** both endpoints return the standard shape; `npm run test:api`
passes; you can show the second fix took less context.

## 💡 Ideas & variations

- Establish a memory for the audit rule ("every lifecycle event writes exactly one audit
  entry") and use it while doing exercise 3 or 9.
- Compare a memory (learned, citation-backed, auto-expires ~28 days) against putting the
  same rule in `.github/copilot-instructions.md` (always loaded). When is each better?

## 🧠 Your turn — brainstorm

Which of *your* repo's conventions are worth turning into memory vs an instruction file?

- What's a convention you re-explain to Copilot (or teammates) over and over?
- How would you verify a memory is actually being applied?
- What's the risk of a stale memory, and how does the 28-day expiry help?

> _Conventions you'd have Copilot remember:_
> -
> -
