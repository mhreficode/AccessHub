# 10. Spec-Driven Development

> Specs come first: a shared, detailed understanding between developer and AI before any
> code. Less ambiguity → less hallucination and rework. Tools like OpenSpec (brownfield,
> lightweight) generate `proposal.md` / `spec.md` / `design.md` / `tasks.md`, then
> implement a few tasks at a time with the developer in the loop.

**Track:** Advanced Workflows · **Time:** ⏱25m · **Level:** 🟡 core — golden path (continues exercise 8)

---

## 🎯 Goal

Turn the intentionally-incomplete access-expiration spec into a complete, consistent one,
then implement **one** task and make a previously-skipped test pass.

## 🏆 What you'll achieve

- `specs/access-expiration/` is internally consistent and consistent with
  `docs/DOMAIN_RULES.md` + `docs/SECURITY.md`.
- One previously-skipped test in `accessExpiration.skip.test.ts` is now active and green.
- `npm run test:api` passes; docs updated for the new behavior.

## 🧰 Tools you can use

- OpenSpec-style flow (`/opsx-propose`, `/opsx-apply`, `/opsx-archive`) or GitHub Spec Kit.
- The repo's spec drivers: `.github/prompts/create-spec.prompt.md` and
  `.github/skills/spec-driven-feature.skill.md`.
- The skeleton in `specs/access-expiration/` (`proposal.md`, `spec.md`, `design.md`,
  `tasks.md`) — intentionally incomplete, with `TODO` markers.

## 🔧 The exercise

**Steps**
1. Run the spec flow (OpenSpec-style, or
   `copilot -p "$(cat .github/prompts/create-spec.prompt.md)"`):
   - resolve the `TODO` markers in `specs/access-expiration/spec.md` with Given/When/Then
     scenarios;
   - in `design.md`, **pick** the lazy-vs-scheduled expiry decision (left open at ~L21–26)
     and justify it;
   - expand `tasks.md` into small, ordered, testable units.
2. Implement **one** task — recommended: *reject API keys tied to expired access* in
   `apps/api/src/services/apiKey.service.ts` `validateKey()` (today it only checks
   `status !== 'active'` at ≈L78), plus the `expiresAt` field and setting it at approval.
3. **Un-skip** the matching case in `apps/api/src/tests/accessExpiration.skip.test.ts`
   (e.g. *"revokes/invalidates API keys for expired access"*) and make it pass.

**Definition of done:** spec files consistent with the domain/security docs; one
previously-skipped test now active and green; `npm run test:api` passes; docs updated.

## 💡 Ideas & variations

- Feed the plan from exercise 8 into the spec, then the spec's `tasks.md` into the Ralph
  loop (exercise 9) — chaining RPI end to end.
- Discuss Spec Kit (greenfield, heavy) vs OpenSpec (brownfield, light) — why this
  brownfield repo suits the lightweight flow.
- Use a reviewer subagent (exercise 3) to check the implementation against the spec.

## 🧠 Your turn — brainstorm

How would spec-first change how you start features?

- Which recent feature would have benefited from a spec before code, and why?
- What belongs in `spec.md` (behavior) vs `design.md` (approach) vs `tasks.md` (steps)?
- How do you keep specs alive as the source of truth instead of stale docs?

> _Where you'd apply spec-driven development:_
> -
> -
