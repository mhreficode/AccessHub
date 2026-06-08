# Subagents Exercise

Use separate review perspectives (subagents) to review a change, then synthesize the
findings. The custom agents in `.github/agents/` support this exercise.

## Instructor prompt

```
Review the access expiration implementation using separate perspectives, kept isolated:
1. Correctness reviewer
2. Security reviewer
3. API architecture reviewer
4. Frontend reviewer
5. Test coverage reviewer

Then synthesize the findings into a single prioritized review.
```

## Available agents

| Agent | Focus |
|-------|-------|
| `.github/agents/thorough-reviewer.agent.md` | Coordinates all perspectives |
| `.github/agents/security-reviewer.agent.md` | Key leakage, authz, audit secrets, unsafe markdown |
| `.github/agents/api-architect.agent.md` | Layering, validation, error format |
| `.github/agents/frontend-reviewer.agent.md` | Permission UI, stale state, unsafe rendering |
| `.github/agents/test-engineer.agent.md` | Missing tests, edge cases, skipped tests |

## Expected output shape

- Critical issues
- Important issues
- Nice-to-have improvements
- What the implementation does well
- Suggested next steps

## Discussion points

- Why isolated perspectives surface issues a single pass misses.
- How to merge overlapping findings and rank by risk.
