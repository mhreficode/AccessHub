# ★ Capstone — Chain the workflow end to end

> Put the pieces together on a single feature, mirroring the AI-driven RPI lifecycle from
> the deck: Research → Plan → Implement, with humans at the hand-off points.

**Track:** — · **Time:** ⏱30m+ · **Level:** 🔴 stretch

---

## 🎯 Goal

Take **Expiring Service Access** from idea to a tested slice using several Copilot
capabilities in sequence — the way a senior developer actually combines them.

## 🏆 What you'll achieve

- An approved plan, a refined spec, at least one implemented + tested task, a
  multi-perspective review, and a hook that prevents regressions — all on one feature.

## 🧰 Tools you can use

Everything from exercises 1, 3, 8, 9, 10 — Plan Mode, spec drivers, the Ralph loop, the
review subagents, and the security hook.

## 🔧 The exercise

1. **Plan (exercise 8):** Plan Mode → research + atomic tasks for access expiration.
   Approve the plan.
2. **Spec (exercise 10):** refine `specs/access-expiration/` from the plan; resolve the
   lazy-vs-scheduled decision.
3. **Implement (exercise 9):** run the Ralph loop over the spec's `tasks.md` (or implement
   one task by hand), un-skipping tests as you go.
4. **Review (exercise 3):** run a multi-perspective subagent review of the result.
5. **Guard (exercise 1):** harden `scripts/security-check.sh` / the hook so the planted
   defects (raw-key log, unsafe markdown, missing audit) can't reappear.

### 💬 Prompts to use with Copilot

Each step reuses the prompts from its own exercise file (1, 3, 8, 9, 10). A single
end-to-end kickoff you can paste into Plan Mode to start:
> Use Plan Mode. We're going to ship "Expiring Service Access" in AccessHub end to end.
> First research the codebase and write an atomic plan. After I approve, refine the spec
> in `specs/access-expiration/`, then implement the tasks one at a time (un-skipping the
> tests in `apps/api/src/tests/accessExpiration.skip.test.ts` as they pass), and finally
> review the result from security, architecture, and test-coverage perspectives. Do not
> implement until I approve the plan.

**Definition of done:** at least one expiration task is implemented with a passing
(previously-skipped) test, reviewed by subagents, and protected by the hook; the spec and
docs reflect the change.

## 💡 Ideas & variations

- Swap the Ralph loop for fully manual implementation and compare effort/quality.
- Add `access.expired` / `access.extended` audit events and a `GET /api/access/expiring`
  endpoint, then surface "expiring soon" on the dashboard.

## 🧠 Your turn — brainstorm

Design your *own* end-to-end run on a feature from your backlog.

- Which capabilities would you chain, in what order, for your team's workflow?
- Where are the human approval gates that matter most?
- What would "done" look like, and how would you prove it?

> _Your end-to-end plan:_
> -
> -
