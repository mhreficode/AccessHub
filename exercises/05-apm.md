# 5. APM — Agent Package Manager

> "npm for agent context." Package agentic setup — instructions, prompts, skills,
> agents — as versioned packages and consume them across many projects instead of
> copy-pasting.

**Track:** Presentation & Demos · **Time:** ⏱15–20m · **Level:** 🟡 core

---

## 🎯 Goal

Understand the package layout, then author a new reusable skill in the local pack and
"install" it into this repo.

## 🏆 What you'll achieve

- You can explain `apm.yml`, dependency declarations, and the package layout
  (`instructions/`, `prompts/`, `skills/`, `agents/`).
- A new `access-expiration-review` skill exists in the pack and is usable from
  `.github/skills/`.

## 🧰 Tools you can use

- The project manifest `apm.yml` and the local pack
  `.apm/packages/accesshub-copilot-pack/`.
- The APM CLI (`apm install` / declaring deps in `apm.yml`).
- The existing skills under `.github/skills/` as templates.

## 🔧 The exercise

**Where to look:** `apm.yml` declares a dependency on the local pack at
`.apm/packages/accesshub-copilot-pack/` (which contains `instructions/`, `prompts/`,
`skills/`, `agents/`).

**Steps**
1. Read `apm.yml` and the pack layout; note how a team could publish this pack and
   consume it from many repos.
2. Create a new skill `access-expiration-review.skill.md` under
   `.apm/packages/accesshub-copilot-pack/skills/`. It should tell Copilot how to review an
   access-expiration implementation for **correctness, security, auditability, and tests**.
3. "Install" it locally by copying it into `.github/skills/`, then use it to review any
   change from exercise 8/10.

**Definition of done:** the new skill exists in the pack, works from `.github/skills/`,
and produces a focused review checklist for the expiration feature.

## 💡 Ideas & variations

- Add the `security-reviewer` agent from `.github/agents/` to the pack and version it.
- Declare a dependency on an external pack in `apm.yml` and discuss versioning/pinning.
- Decide what belongs in a shared org pack vs a single repo's `.github/`.

## 🧠 Your turn — brainstorm

What agentic setup does your org duplicate across repos today?

- Which instructions/prompts/skills/agents would you publish as a shared pack first?
- How would you version and roll out changes without breaking consuming repos?
- What governance do you want around who can change a shared pack?

> _Assets you'd package and share:_
> -
> -
