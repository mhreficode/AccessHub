# 8. Plan Mode (Research → Plan → Implement)

> Plan Mode implements the **R** and **P** of RPI: it researches the codebase and writes
> an atomic-task plan, asks clarifying questions, and only hands off to the agent for
> implementation after you approve. One bad planning decision ripples into thousands of
> lines — so the plan is where careful review pays off most.

**Track:** Advanced Workflows · **Time:** ⏱25m · **Level:** 🟡 core — golden path

---

## 🎯 Goal

Plan the repo's golden-path feature, **Expiring Service Access**, without writing code —
and judge the plan's quality against the real codebase and the existing spec.

## 🏆 What you'll achieve

- A research summary + atomic task plan that names the real files the feature touches.
- At least one genuine clarifying question raised (lazy vs scheduled expiry).
- A plan you can compare to `specs/access-expiration/` and `docs/PRD.md`.

## 🧰 Tools you can use

- Plan Mode in the IDE (researches, asks via the question tool, hands off to the Agent).
- Subagents to keep research/planning phases in isolated contexts.
- Context files: `docs/PRD.md`, `docs/DOMAIN_RULES.md`, `specs/access-expiration/`,
  the skipped tests in `apps/api/src/tests/accessExpiration.skip.test.ts`.

## 🔧 The exercise

**Prompt (stay in Plan Mode — do not implement):**
> *Use Plan Mode. We need to add expiring service access to AccessHub. Research the
> current code first, identify every file the feature touches, ask clarifying questions,
> then produce an atomic task plan. Do not implement until I approve.*

**A good plan identifies the real touch-points, e.g.:**
- schema: add `expiresAt` / `extendedAt` / `extendedById` to `AccessRequest`
  (`prisma/schema.prisma`);
- set `expiresAt = approval time + 30 days` in `accessRequest.service.ts` `approve()`;
- reject keys tied to expired access in `apiKey.service.ts` `validateKey()` — which today
  only checks `status !== 'active'` (≈L78);
- new `GET /api/access/expiring` + an extend endpoint + dashboard surfacing;
- `access.expired` / `access.extended` audit events;
- un-skip `apps/api/src/tests/accessExpiration.skip.test.ts`; update `docs/`.
- **Clarifying question it should raise:** lazy (compute on read) vs scheduled (job)
  expiry? (This is genuinely left open in `specs/access-expiration/design.md`.)

**Definition of done:** the plan hits the real touch-points and raises the lazy-vs-scheduled
question; you've compared it to `specs/access-expiration/` and `docs/PRD.md`. No code yet —
exercise 10 implements.

## 💡 Ideas & variations

- Use `/rubberduck` (CLI) or a reviewer subagent to critique the plan before approving.
- Deliberately give a vague one-line request and see what clarifying questions Plan Mode
  asks — discuss the "impact hierarchy" (a bad plan = 1,000+ bad lines).

## 🧠 Your turn — brainstorm

How would you use Plan Mode on your own backlog?

- What's a feature in your repo where research-first would have saved rework?
- Which decisions must a human approve before any code is written?
- How do you keep a plan "atomic" enough to review meaningfully?

> _Features you'd plan this way:_
> -
> -
