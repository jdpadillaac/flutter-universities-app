#!/usr/bin/env bash
# Stop hook: run coverage when Dart sources changed since the last pass.
set -euo pipefail

cd "$(dirname "$0")/../.."

# Consume the stop-event payload.
cat >/dev/null

stamp="coverage/.gate_stamp"
needs_run=0

if [[ ! -f "$stamp" ]]; then
  needs_run=1
else
  newer="$(find lib test -name '*.dart' -newer "$stamp" -print -quit)"
  if [[ -n "$newer" ]]; then
    needs_run=1
  fi
fi

if [[ "$needs_run" -eq 0 ]]; then
  printf '%s\n' '{}'
  exit 0
fi

if ! output="$(tool/coverage.sh 2>&1)"; then
  jq -n --arg details "$output" '{
    followup_message: ("La compuerta de coverage falló. Corrige los tests o sube el coverage global al menos a 90%.\n\n" + $details)
  }'
  exit 0
fi

mkdir -p coverage
touch "$stamp"
printf '%s\n' '{}'
