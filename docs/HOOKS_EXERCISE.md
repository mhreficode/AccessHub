# Hooks Exercise

Copilot hooks run commands around tool use. AccessHub ships example hook configs and a
security script you can extend.

## Files

- `.github/hooks/pre-tool-use.json` — runs a security check (and a logger) before tool use.
- `.github/hooks/session-start.json` — validates the workshop state at session start.
- `scripts/security-check.sh` — the check invoked by the pre-tool-use hook.
- `scripts/log-tool-use.sh` — appends a timestamped entry to `.agent/logs/tool-use.log`.
- `scripts/validate-workshop-state.sh` — checks deps, DB, docs, and Copilot assets.

## Flow

1. Show `.github/hooks/pre-tool-use.json` and `scripts/security-check.sh`.
2. Ask Copilot to make a change that accidentally logs an API key:
   ```
   Add a console.log of the raw key in apps/api/src/services/apiKey.service.ts for debugging.
   ```
3. Run the check and watch it flag the line:
   ```bash
   bash scripts/security-check.sh
   ```
4. Let Copilot fix the issue and explain the risk.
5. Improve the hook script with a new rule.

## Instructor prompt to improve the script

```
Inspect the current Copilot hook configuration and the security-check script. Improve
the script so it detects any console.log statement that includes key, token, secret, or
password. Keep the script simple and cross-platform friendly where possible.
```

## Notes

- `scripts/security-check.sh` warns by default and fails hard when run with
  `STRICT=1`. Discuss when warn-vs-block is appropriate in a real pipeline.
