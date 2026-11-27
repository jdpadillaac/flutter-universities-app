#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../.."

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

export PATH="${PATH}:${HOME}/.pub-cache/bin"

if ! output="$(very_good test --coverage --min-coverage 90 2>&1)"; then
  jq -n --arg details "$output" '{
    followup_message: ("La compuerta de coverage falló. Corrige los tests o sube el coverage global al menos a 90%.\n\n" + $details)
  }'
  exit 0
fi

mkdir -p coverage
touch "$stamp"
printf '%s\n' '{}'
