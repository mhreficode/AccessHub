#!/usr/bin/env bash
# Append a timestamped entry to the tool-use log. Used by the pre-tool-use hook.
set -euo pipefail
cd "$(dirname "$0")/.."

mkdir -p .agent/logs
echo "$(date -u +%Y-%m-%dT%H:%M:%SZ) tool-use ${*:-}" >> .agent/logs/tool-use.log
