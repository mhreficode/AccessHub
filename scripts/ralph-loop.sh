#!/usr/bin/env bash
# Ralph loop: repeatedly run the iteration prompt while unchecked tasks remain in
# docs/PRD.md. Each iteration should pick ONE task, implement it, test it, and update
# progress. See docs/RALPH_LOOP_EXERCISE.md.
#
# Usage: scripts/ralph-loop.sh [max-iterations]
#
# Note: this drives the Copilot CLI (`copilot`). In a live workshop you may prefer to
# run the iteration prompt by hand. It is a workshop artifact and is not run in CI.
set -euo pipefail
cd "$(dirname "$0")/.."

MAX=${1:-8}
i=0

while grep -q '\- \[ \]' docs/PRD.md; do
  i=$((i + 1))
  if [ "$i" -gt "$MAX" ]; then
    echo "Max iterations ($MAX) reached."
    exit 1
  fi

  echo "=== Ralph iteration $i ==="
  copilot --yolo -p "$(cat .github/prompts/ralph-iteration.prompt.md)"
done

echo "All PRD tasks completed."
