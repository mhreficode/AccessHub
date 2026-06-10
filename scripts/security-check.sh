#!/usr/bin/env bash
# Lightweight security check for the AccessHub codebase.
#
# By default it WARNS (exit 0) so it does not block work during the workshop.
# Run with STRICT=1 to make secret-in-console findings fail (exit 2) — useful in
# a preToolUse hook or CI gate.
#
# Usage:
#   scripts/security-check.sh
#   STRICT=1 scripts/security-check.sh
set -uo pipefail
cd "$(dirname "$0")/.."

STRICT="${STRICT:-0}"
findings=0
blocking_findings=0

note() {
  echo "⚠  $1"
  findings=$((findings + 1))
}

block() {
  echo "BLOCK $1"
  findings=$((findings + 1))
  blocking_findings=$((blocking_findings + 1))
}

# Source files to inspect (skip seed/fixtures with fake placeholder values).
mapfile -t SRC < <(git ls-files 'apps/**/*.ts' 'apps/**/*.tsx' 2>/dev/null \
  | grep -vE '(prisma/seed\.ts|/tests/helpers\.ts)')
if [ "${#SRC[@]}" -eq 0 ]; then
  mapfile -t SRC < <(find apps -type f \( -name '*.ts' -o -name '*.tsx' \) 2>/dev/null \
    | grep -vE '(prisma/seed\.ts|/tests/helpers\.ts)')
fi

for f in "${SRC[@]}"; do
  [ -f "$f" ] || continue

  # 1. console.* of something that looks like a secret should be blocking.
  if grep -nEH 'console\.(log|error|info|debug)\([^)]*(key|token|secret|password)' "$f"; then
    block "possible secret in a console log: $f"
  fi

  # 2. The stored hash should never be put into an API response.
  case "$f" in
    apps/api/src/routes/*)
      if grep -nEH 'keyHash' "$f"; then
        note "keyHash referenced in a route (do not expose it): $f"
      fi
      ;;
  esac

  # 3. Unsanitized HTML rendering on the frontend.
  if grep -nEH 'dangerouslySetInnerHTML' "$f"; then
    note "dangerouslySetInnerHTML used (ensure the input is sanitized): $f"
  fi
done

# 4. Run the secret pattern scan.
if ! bash scripts/detect-secrets.sh >/dev/null 2>&1; then
  note "detect-secrets found a suspicious pattern (run scripts/detect-secrets.sh)"
fi

# 5. Accidental .env staging.
if git diff --cached --name-only 2>/dev/null | grep -qE '(^|/)\.env$'; then
  note ".env is staged for commit — it must stay out of version control"
fi

echo "---"
if [ "$findings" -eq 0 ]; then
  echo "security-check: no findings."
  exit 0
fi

echo "security-check: $findings finding(s)."
if [ "$STRICT" = "1" ] && [ "$blocking_findings" -gt 0 ]; then
  echo "security-check: blocking finding(s) detected."
  exit 2
fi
exit 0
