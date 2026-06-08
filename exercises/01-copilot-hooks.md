# 1. Copilot Hooks

> Run custom shell commands at strategic points in an agent's workflow — at session
> start, before tool use — to validate, guard, and audit what the agent does.

**Track:** Presentation & Demos · **Time:** ⏱20–30m · **Level:** 🟡 core (🔴 for the blocking part)

---

## 🎯 Goal

Use a hook as an automated guardrail: let it catch a real security defect this repo
ships, then strengthen it so the agent is *blocked* from re-introducing the problem.

## 🏆 What you'll achieve

- You can read and explain `.github/hooks/*.json` and the scripts they call.
- The planted raw-key log is removed and the security check is clean.
- (Stretch) The pre-tool-use hook **hard-blocks** any attempt to log a secret, proven by
  watching it stop a deliberate bad edit.

## 🧰 Tools you can use

- Hook configs: `.github/hooks/pre-tool-use.json`, `.github/hooks/session-start.json`.
- Scripts: `scripts/security-check.sh` (warns by default; `STRICT=1` to fail),
  `scripts/log-tool-use.sh`, `scripts/detect-secrets.sh`, `scripts/validate-workshop-state.sh`.
- Copilot Chat / agent to make and explain the edits.
- The `.agent/logs/tool-use.log` file (written by the logger hook).

## 🔧 The exercise

**Where to look:** `apps/api/src/services/apiKey.service.ts:27` ships a dev-only
`console.log` of the **raw** API key — exactly the kind of thing a security hook should
catch.

**Steps**
1. Inspect `.github/hooks/pre-tool-use.json` and `scripts/security-check.sh`. Note it
   runs before tool use and currently *warns*.
2. Run it now: `bash scripts/security-check.sh`. It flags the raw-key log and the
   unsanitized markdown render (`apps/web/src/utils/markdown.ts`).
3. Ask Copilot: *"Remove the dev-only raw API key log in apiKey.service.ts and explain
   why logging raw keys is unsafe."* Re-run the check — that finding is gone.
4. **(Stretch) Make it block.** Prompt Copilot:
   > *Improve `scripts/security-check.sh` to flag any `console.*` containing key, token,
   > secret, or password, and make the pre-tool-use hook run it with `STRICT=1` so the
   > agent is blocked from introducing such a log. Keep it cross-platform friendly.*
   Then ask Copilot to add a debug key log again and watch the hook refuse it.

**Definition of done:** `STRICT=1 bash scripts/security-check.sh` exits non-zero while a
secret-log exists and `0` after the fix; a deliberate re-introduction is blocked by the hook.

## 💡 Ideas & variations

- Add a `session-start` reminder that prints the repo's top 3 security rules.
- Have the logger hook record the *tool name* and *target file* for a richer audit trail.
- Add a rule that warns when `keyHash` appears in any file under `apps/api/src/routes/`.

## 🧠 Your turn — brainstorm

What else would you want a hook to enforce on a team like yours?

- Which action would you *block* vs merely *warn* on, and why?
- Where in your real pipeline (pre-commit, CI, PR) would each of these hooks live?
- Could a hook auto-run tests or a linter before the agent edits a protected path?

> _Your own hook ideas:_
> -
> -
