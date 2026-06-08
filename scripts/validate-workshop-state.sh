#!/usr/bin/env bash
# Validate that the repo is in a usable workshop state:
# dependencies installed, database present, and required docs / Copilot assets exist.
set -uo pipefail
cd "$(dirname "$0")/.."

problems=0
ok()   { echo "✓ $1"; }
warn() { echo "⚠ $1"; problems=$((problems + 1)); }

# Dependencies
if [ -d node_modules ]; then ok "dependencies installed"; else warn "node_modules missing — run: npm install"; fi
if [ -d node_modules/.prisma/client ]; then ok "prisma client generated"; else warn "prisma client missing — run: npm run prisma:generate"; fi

# Database
if [ -f prisma/dev.db ]; then ok "database present (prisma/dev.db)"; else warn "database missing — run: npm run db:push && npm run db:seed"; fi

# Required docs
REQUIRED_DOCS=(
  README.md
  docs/ARCHITECTURE.md docs/DOMAIN_RULES.md docs/API_GUIDELINES.md docs/SECURITY.md
  docs/PRD.md docs/KNOWN_ISSUES.md docs/WORKSHOP_GUIDE.md docs/COPILOT_SPACES_CONTEXT.md
  docs/DEMO_SCRIPT.md
)
for d in "${REQUIRED_DOCS[@]}"; do
  if [ -f "$d" ]; then ok "doc: $d"; else warn "missing doc: $d"; fi
done

# Required Copilot assets
REQUIRED_COPILOT=(
  .github/copilot-instructions.md
  .github/hooks/pre-tool-use.json .github/hooks/session-start.json
  .github/prompts/plan-feature.prompt.md
  .github/agents/security-reviewer.agent.md
  .github/skills/secure-api-key-handling.skill.md
  apm.yml
)
for c in "${REQUIRED_COPILOT[@]}"; do
  if [ -f "$c" ]; then ok "copilot asset: $c"; else warn "missing copilot asset: $c"; fi
done

# Spec skeleton (intentionally incomplete, but must exist)
for s in specs/access-expiration/proposal.md specs/access-expiration/spec.md \
         specs/access-expiration/design.md specs/access-expiration/tasks.md; do
  if [ -f "$s" ]; then ok "spec: $s"; else warn "missing spec: $s"; fi
done

echo "---"
if [ "$problems" -eq 0 ]; then
  echo "workshop state: OK"
  exit 0
fi
echo "workshop state: $problems item(s) need attention"
exit 1
