# Copilot CLI Exercise

Use the Copilot CLI to inspect and improve AccessHub from the terminal. Supported
commands and flags vary by environment — adapt as needed during the live demo.

## Example prompts

```bash
copilot -p "Summarize the backend routes in this repository and identify inconsistent error responses."

copilot -p "Find where API keys are generated, stored, logged, or displayed. Identify security risks."

copilot -p "Inspect the skipped access expiration tests and propose an implementation plan."

copilot -p "Find the most likely reason the API key revocation test is incomplete and suggest missing test cases."

copilot -p "Update docs/DOMAIN_RULES.md to include the access expiration behavior based on the implementation."
```

## Suggested flow

1. **Map the surface.** Ask for a route summary; compare with `docs/API_GUIDELINES.md`.
2. **Hunt risks.** Ask about API key handling; cross-check `docs/SECURITY.md`.
3. **Find the gaps.** Ask about skipped/weak tests; confirm against
   `apps/api/src/tests`.
4. **Plan, don't implement.** Ask for an implementation plan for one PRD item.
5. **Document.** Ask for a docs update reflecting an actual change you made.

## Note

The repository provides the prompts and scripts; the instructor adapts the exact CLI
invocation to the available tooling.
