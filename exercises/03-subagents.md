# 3. Subagents

> Hand subtasks to subagents that run in parallel, are specialized to a task, and work in
> an **isolated context** — so they don't pollute the main agent's context and each
> perspective stays independent.

**Track:** Presentation & Demos · **Time:** ⏱20–30m · **Level:** 🟡 core (🔴 for coordinator/worker)

---

## 🎯 Goal

Use the **multi-perspective review** pattern: review one file through several independent
lenses in parallel, then synthesize — and see issues surface that a single pass would miss.

## 🏆 What you'll achieve

- A single prioritized review of `accessRequest.service.ts` that independently surfaces
  **three** distinct, real issues — each visible only through a different lens.
- A feel for when to let Copilot spin up subagents vs prompt one explicitly.

## 🧰 Tools you can use

- The shipped agents in `.github/agents/`: `thorough-reviewer`, `security-reviewer`,
  `api-architect`, `frontend-reviewer`, `test-engineer`.
- The `#runSubagent` tool (must be enabled) and parallel/agent-initiated subagents.
- Orchestration patterns from the deck: *multi-perspective review* and
  *coordinator/worker (Feature Builder)*.

## 🔧 The exercise

**Where to look:** `apps/api/src/services/accessRequest.service.ts` deliberately hides
three issues, each caught by a different lens.

**Steps**
1. Prompt:
   > *Review `apps/api/src/services/accessRequest.service.ts` using parallel subagents —
   > a security reviewer, an API-architecture reviewer, and a correctness/business-rule
   > reviewer — then synthesize a single prioritized review.*
2. Confirm the synthesis independently surfaces all three:
   - **Security:** `approve()` (≈L49) and `reject()` (≈L90) only block developers; they
     never call `assertCanManageService`, so an owner of a *different* team can
     approve/reject (issue 2).
   - **Correctness/business:** `reject()` writes no audit event, though `approve()` does
     (issue 4).
   - **Architecture:** `reason` is validated in both the route (`services.routes.ts:44`)
     and the service (`accessRequest.service.ts:21`); plus the `reason` Zod schema in
     `validators/access.validators.ts:4` is **defined but never used** — dead code (issue 6).

**Definition of done:** the merged review lists all three with file/line and a suggested
fix, ranked by severity.

## 💡 Ideas & variations  🔴

- **Coordinator/worker:** build a Feature-Builder-style coordinator (Planner → Architect →
  Implementer → Reviewer) and take one backlog item end-to-end (see exercise 8/9).
- Add a 4th lens (a frontend reviewer) and point it at `apps/web/src/routes/ServiceDetail.tsx`
  to catch the unsafe markdown (issue 5).
- Compare a single-pass review of the same file against the multi-subagent review — what
  did the single pass miss?

## 🧠 Your turn — brainstorm

What review perspectives matter most for *your* codebase?

- Which lenses would you run in parallel, and what's each one's narrow mandate?
- When is context isolation worth the overhead vs a single careful pass?
- Could a subagent own a recurring chore (dependency audit, dead-code sweep)?

> _Your subagent / orchestration ideas:_
> -
> -
