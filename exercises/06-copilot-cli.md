# 6. Copilot CLI

> Use Copilot directly from the terminal — interactive or piped — to analyze, script,
> and reach features not in the IDE. The home of command-line agentic workflows (and
> where Ralph loops live).

**Track:** Presentation & Demos · **Time:** ⏱20m · **Level:** 🟡 core

---

## 🎯 Goal

Drive Copilot from the terminal to map and audit the codebase, surface hidden defects,
and capture the analysis to a file.

## 🏆 What you'll achieve

- You've located at least issues 1, 3, and 9 **from the terminal**.
- A shared analysis file produced with `/share`.
- Comfort mixing shell and Copilot in one session (`!`, `Ctrl+Z`/`fg`).

## 🧰 Tools you can use

- `copilot -p "<prompt>"` (one-shot / piped) and the interactive TUI.
- Built-ins: `/share` (save chat to a file),
  `/chronicle` (usage insights), `!` to run bash inline, `Ctrl+Z` then `fg` to hop out and
  back.
- Repo scripts you can run inline: `scripts/security-check.sh`, `scripts/detect-secrets.sh`.

## 🔧 The exercise

**Steps (read-only first):**
```bash
copilot -p "Summarize the backend routes in apps/api/src/routes and flag any that don't return { error: { code, message, details } }."   # finds issue 1
copilot -p "Find where API keys are generated, stored, logged, or displayed, and list the security risks."                                # finds issue 3
copilot -p "Inspect apps/api/src/tests/accessExpiration.skip.test.ts and propose an implementation plan for the feature."                  # feeds exercise 8
copilot -p "Why is the API key revocation test incomplete? See apps/api/src/tests/apiKeys.test.ts and suggest the missing case."           # finds issue 9
```
Then, inside an interactive session: run `!bash scripts/security-check.sh`, and use
`/share` to drop the analysis into a markdown file.

### 💬 Prompts / commands to use with Copilot

The four `copilot -p "..."` lines above are the read-only analyses to copy. Inside an
interactive `copilot` session, also try:
```text
!bash scripts/security-check.sh          # run a shell command without leaving Copilot
/share cli-analysis.md                   # save the conversation/analysis to a file
```

**Definition of done:** a shared analysis file exists, and you've located issues 1, 3,
and 9 from the terminal.

## 💡 Ideas & variations

- Pipe a prompt in via stdin and post-process the output with `jq`/`grep` in a script.
- Note which models/features differ from your IDE — and when the CLI unlocks something
  the IDE can't do.

## 🧠 Your turn — brainstorm

Where would terminal-native Copilot fit your daily flow?

- Which repetitive analysis would you turn into a saved `copilot -p` one-liner?
- Where could the CLI slot into a GitHub Actions or local pre-push workflow?
- What's a task where staying in the terminal beats switching to the IDE?

> _Your CLI one-liners / workflows:_
> -
> -
