# 4. Copilot Spaces

> Make Copilot a subject-matter expert of your domain: organize context into a Space,
> ground prompts in it, and get more relevant, context-aware answers you can share with
> your team.

**Track:** Presentation & Demos · **Time:** ⏱15m · **Level:** 🟡 core

---

## 🎯 Goal

Build a Space from this repo's curated docs and feel the difference between grounded and
ungrounded answers — including discovering a hidden documentation defect along the way.

## 🏆 What you'll achieve

- A reusable AccessHub Space your team could share.
- Grounded answers that cite the right rules and layers.
- You discover issue 8 (a deprecated endpoint still in the docs) by *asking*, not grepping.

## 🧰 Tools you can use

- GitHub Copilot Spaces (on github.com) and the GitHub MCP to reach Space context from the IDE.
- Curated context files: `docs/COPILOT_SPACES_CONTEXT.md`, `docs/DOMAIN_RULES.md`,
  `docs/ARCHITECTURE.md`, `docs/API_GUIDELINES.md`, `docs/SECURITY.md`, `docs/PRD.md`,
  `.github/copilot-instructions.md`.
- A Space accepts instructions, source files, linked PRs/issues, and arbitrary uploads.

## 🔧 The exercise

**Steps**
1. Create a Space and add the curated docs listed above.
2. Ask grounded questions:
   - *"Who is allowed to approve an access request, and which layer must enforce it?"*
     → expect: the owning team's owner or a `platform_admin`; enforced in
     `apps/api/src/services/authz.service.ts`.
   - *"The Identity API documentation references a deprecated endpoint — which one, and
     what replaces it?"* → expect: `GET /v1/userinfo` → `/v2/users/{id}` (issue 8, seeded
     in `prisma/seed.ts:76`).
3. Ask the same questions in a plain chat **without** the Space and compare specificity.

### 💬 Prompts to use with Copilot

Ask each of these **inside the Space**, then again in a plain chat **without** it, and
compare:
> Using the AccessHub space: who is allowed to approve an access request, and which layer
> of the code must enforce that check?
> Using the AccessHub space: the Identity API documentation references a deprecated
> endpoint — which one is it, and what should be used instead?
> Using the AccessHub space: which files should I update if the API-key lifecycle rules
> change?

**Definition of done:** the Space answers cite the domain rules and the correct
files/layers, and correctly name the deprecated endpoint and its replacement.

## 💡 Ideas & variations

- Add `docs/KNOWN_ISSUES.md` to the Space and ask Copilot to propose a fix order.
- Link a (hypothetical) PR for the expiration feature and ask the Space to critique it
  against `docs/DOMAIN_RULES.md`.
- Build a *second*, narrower Space (security-only) and compare answer quality on a
  security question.

## 🧠 Your turn — brainstorm

What would a Space for *your* product contain?

- Which 5–7 documents would make Copilot a credible expert on your domain?
- What questions does your team ask repeatedly that a Space could answer consistently?
- Source files vs prose docs vs uploaded specs — what mix grounds best?

> _Your Space contents / questions to test:_
> -
> -
