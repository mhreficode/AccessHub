# 1. Copilot Hooks

> A hook is a small script Copilot runs automatically at a certain moment — when a
> session starts, **before** the agent uses a tool, or **after** it does. Hooks are how
> you put guardrails around the agent so it can't quietly do something you don't want.

**Track:** Presentation & Demos · **Time:** ⏱20–30m · **Level:** 🟡 core

---

## 🎯 Goal

Learn the three guardrail moments and build them yourself:

- **session start** → remind the agent of the rules before it does anything,
- **before a tool runs (`preToolUse`)** → a bouncer that can **block** a risky action,
- **after a tool runs (`postToolUse`)** → an inspector that **catches and reports**
  problems that slipped through.

You'll use a real, easy-to-understand security bug in this repo as the thing your
guardrails protect against.

## The bug you're protecting against (in plain words)

An **API key is like a password.** In `apps/api/src/services/apiKey.service.ts:27` the
code prints the *raw* key into the console "just for debugging":

```ts
console.log(`[dev] issued API key ${raw} for service ${params.serviceId}`);
```

Why that's dangerous: once a secret is written to a log, **anyone who can see the logs**
(teammates, the log server, an error tracker, a screen share) can copy it and call the
API pretending to be that user — and you can't "un-log" it. So the rule is simple:
**secrets must never be written to logs.** Hooks let you enforce that rule
automatically, instead of hoping a human notices it in review.

## 🏆 What you'll achieve

- A **postToolUse** hook that scans a file right after Copilot edits it and warns when a
  secret was logged (catch-after).
- A **preToolUse** hook that **blocks** an edit that would log a secret before it ever
  lands (stop-before).
- A **sessionStart** hook that greets the agent with the repo's rules.
- A clear sense of when to *warn* vs when to *block*.

## 🧰 Tools you can use

- Hook config files in `.github/hooks/*.json` (format: `{ "version": 1, "hooks": { ... } }`).
- The shipped hooks: `pre-tool-use.json` (runs the security check + a logger) and
  `session-start.json` (validates the workshop state).
- Scripts: `scripts/security-check.sh` (warns by default; `STRICT=1` makes it fail),
  `scripts/detect-secrets.sh`, `scripts/log-tool-use.sh`, `scripts/validate-workshop-state.sh`.
- Copilot Chat / agent to write the hook configs and edit the script.
- The audit trail at `.agent/logs/tool-use.log`.

> How a `preToolUse` hook decides: it can print a JSON decision to stdout
> (`{"permissionDecision":"allow"|"deny"|"ask","permissionDecisionReason":"..."}`), or a
> command hook can simply **exit with code `2` to deny**. `preToolUse` is *fail-closed*:
> if it errors, times out, or exits non-zero, the tool call is denied — safe by default.

## 🔧 The exercise

### Part A — Catch it *after* (postToolUse) 🟢
Goal: the moment Copilot edits a file, automatically check it for logged secrets.

1. Look at `scripts/security-check.sh` and run it once by hand:
   `bash scripts/security-check.sh`. It already flags the raw-key log on line 27 and the
   unsafe markdown render in `apps/web/src/utils/markdown.ts`.
2. Add a **`postToolUse`** hook (a new `.github/hooks/post-tool-use.json`) that runs
   `scripts/security-check.sh` after edit/write tools. Now ask Copilot to *"add a
   `console.log` of the raw key in apiKey.service.ts for debugging"* — and watch the
   post-hook immediately report the problem.
3. Ask Copilot to remove the log and explain the risk. Re-run — the warning is gone.

### Part B — Stop it *before* (preToolUse) 🟡
Goal: don't just report a secret-in-a-log — **prevent** it.

1. Make `scripts/security-check.sh` fail (exit non-zero) under `STRICT=1` when it finds a
   `console.*` containing `key`, `token`, `secret`, or `password`.
2. Wire a **`preToolUse`** hook that runs it with `STRICT=1`, so a non-zero exit (or exit
   `2`) **denies** the edit before it lands.
3. Try again: ask Copilot to log a raw key. This time the action is blocked, with a
   reason, and the bad line never enters the file.

### Part C — Recall the rules at the start (sessionStart) 🟢
The shipped `session-start.json` runs `scripts/validate-workshop-state.sh`. Extend it (or
add a second sessionStart command) to **print the repo's top security rules** ("never log
or store raw keys; enforce authz in the backend; sanitize rendered markdown") so every
new session starts with the rules fresh in context.

**Definition of done:** Part A reports the planted secret after an edit; Part B blocks a
new secret-log before it lands (`STRICT=1 bash scripts/security-check.sh` exits non-zero
while the bug exists, `0` once fixed); Part C prints the rules at session start.

## 💡 Ideas & variations

- **Warn vs block:** discuss when each is right. A `postToolUse` warning gives fast
  feedback without getting in the way; a `preToolUse` block is for lines you must never
  cross (logging secrets, editing `prisma/schema.prisma`, touching `.env`).
- Have the `postToolUse` hook append a richer entry to `.agent/logs/tool-use.log` (which
  tool, which file).
- Add a rule that denies any edit that puts `keyHash` into a file under
  `apps/api/src/routes/` (internal field that must not reach responses).

## 🧠 Your turn — brainstorm

You've used three events. Copilot Agent Hooks fire on **many** more — what guardrail
would you hang on each? Sketch one idea per event:

- `sessionStart` / `sessionEnd` — set up / tear down, or log who worked when.
- `preToolUse` — block dangerous commands (`rm -rf`, force-push) before they run.
- `postToolUse` / `postToolUseFailure` — audit results; alert when a tool fails.
- `userPromptSubmitted` — scan the prompt itself (e.g. reject a pasted secret).
- `errorOccurred` — capture context for debugging when the agent hits an error.
- `agentStop` / `subagentStop` — run tests or a lint pass before the agent calls it done.
- `preCompact` — save important notes before the context is summarized.
- `permissionRequest` / `notification` — route approvals or pings to your team's chat.

Questions to spark your own:
- Which of these would you *block* on vs merely *warn/log* on, and why?
- Where in your real pipeline (pre-commit, CI, PR checks) does each guardrail belong?
- Could a hook auto-run your test suite at `agentStop` so "done" always means "tests pass"?

> _Your own hook ideas (event → what it guards):_
> -
> -
