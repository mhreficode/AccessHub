# Ralph Loop Exercise

A "Ralph loop" repeatedly runs the same focused prompt so an agent picks one small task
at a time, keeps context fresh, and makes incremental progress.

## Inputs

- `docs/PRD.md` — the checklist of tasks (unchecked = `- [ ]`).
- `.github/prompts/ralph-iteration.prompt.md` — the per-iteration instructions.
- `.agent/progress.md` — progress notes the loop appends to.
- `scripts/ralph-loop.sh` — the driver script.

## How it works

Each iteration the agent must:

1. Read `docs/PRD.md` and pick the **next single unchecked task**.
2. Implement only that task — the smallest reasonable change.
3. Run the relevant tests.
4. Append a note to `.agent/progress.md`.
5. Mark the task complete in `docs/PRD.md` **only if** tests pass.
6. Stop — do not continue to the next task in the same iteration.

## Run it

```bash
# Run at most 2 iterations
bash scripts/ralph-loop.sh 2
```

The script loops while unchecked items remain in `docs/PRD.md`, invoking Copilot CLI
with the iteration prompt. In a live workshop you may instead run the iteration prompt
by hand to keep control.

## Discussion points

- Why one task per iteration keeps the change reviewable.
- How progress notes give the next iteration its bearings.
- When to stop the loop and review before continuing.
