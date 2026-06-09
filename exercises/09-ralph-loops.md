# 9. Ralph Loops

> A simple bash loop around Copilot CLI: pick the next task, make changes, save notes,
> repeat — each iteration with a **fresh context**. Small AI work sessions chained
> together with a script, so long-session drift and stale assumptions don't accumulate.

**Track:** Advanced Workflows · **Time:** ⏱20m · **Level:** 🟡 core

---

## 🎯 Goal

Run an autonomous loop over the repo's backlog and watch it make incremental, tested,
self-documented progress — one task per iteration, fresh context each time.

## 🏆 What you'll achieve

- After N iterations: N backlog boxes checked in `docs/PRD.md`, matching notes in
  `.agent/progress.md`, and `npm test` still green.
- A clear sense of *why* fresh context per iteration beats one long session.

## 🧰 Tools you can use

- `scripts/ralph-loop.sh` (loops while `- [ ]` remains in `docs/PRD.md`).
- The per-iteration prompt `.github/prompts/ralph-iteration.prompt.md`.
- The backlog `docs/PRD.md` and the progress log `.agent/progress.md`.
- `copilot --yolo -p "..."` for the unattended iteration.

## 🔧 The exercise

**Where to look:** the `docs/PRD.md` "Supporting backlog" lists nine well-scoped,
single-task items that map exactly to the planted issues (standardize error responses,
enforce ownership on approve/reject, remove the raw key log, audit rejection, de-duplicate
reason validation, grouped usage query, revoked-key test, fix the Identity doc, sanitize
markdown).

**Steps**
1. **Dry run first (recommended):** run one iteration by hand to see what it does —
   `copilot -p "$(cat .github/prompts/ralph-iteration.prompt.md)"`.
2. Then let the loop run a bounded number of times:
   ```bash
   bash scripts/ralph-loop.sh 2      # at most 2 iterations
   ```
3. Watch each iteration: pick **one** unchecked task → make the change → run tests →
   append to `.agent/progress.md` → check the box in `docs/PRD.md` only if tests pass.

### 💬 Prompts to use with Copilot

**Run one iteration by hand first** (this is exactly what `scripts/ralph-loop.sh` feeds
Copilot each loop, from `.github/prompts/ralph-iteration.prompt.md`):
> Read `docs/PRD.md` and pick the next single unchecked task (`- [ ]`, top-down).
> Implement only that one task with the smallest reasonable change. Run the relevant tests
> (`npm run test:api` / `npm run test:web`). Append a short note to `.agent/progress.md`
> (the task, what changed, the test result). Check the box in `docs/PRD.md` only if the
> tests pass. Then stop — do not start the next task.

```bash
copilot -p "$(cat .github/prompts/ralph-iteration.prompt.md)"   # one manual iteration
bash scripts/ralph-loop.sh 2                                     # then the bounded loop
```

**Definition of done:** N boxes checked, `.agent/progress.md` notes match, and
`npm test` passes. Reset afterward with `npm run workshop:reset` + `git checkout -- .`.

## 💡 Ideas & variations

- Improve `.github/prompts/ralph-iteration.prompt.md` so each iteration also runs the
  security hook before checking a box.
- Cap iterations low and review the diff after each — when would you stop the loop?
- Point the loop at the *main* feature backlog (Expiring Service Access) instead of the
  supporting one and compare how well single-task scoping holds up.

## 🧠 Your turn — brainstorm

Where would a Ralph loop help — and where would it be risky — in your work?

- What backlog is "loop-able" (small, testable, ordered) vs needs a human per step?
- What guardrails (max iterations, required tests, protected paths) would you add before
  running `--yolo`?
- How do progress notes help the *next* iteration, and your future self?

> _Loop candidates & guardrails:_
> -
> -
