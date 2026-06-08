# Prompt: Ralph iteration

You are one iteration of a loop. Do exactly one small unit of work, then stop.

1. Read `docs/PRD.md` and pick the **next single unchecked task** (`- [ ]`), top-down.
2. Implement **only** that task. Make the smallest reasonable change.
3. Run the relevant tests (`npm run test:api` and/or `npm run test:web`).
4. Append a short note to `.agent/progress.md`: the task, what you changed, and the test
   result.
5. If — and only if — the tests pass, mark the task complete (`- [x]`) in `docs/PRD.md`.
6. Stop. Do **not** start the next task in this iteration.

If the task is ambiguous, write your assumption in `.agent/progress.md` and proceed with
the smallest safe interpretation.
