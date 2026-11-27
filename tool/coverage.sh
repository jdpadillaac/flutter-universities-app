#!/usr/bin/env bash
# Runs the test suite and fails when global line coverage is under MIN_COVERAGE.
set -euo pipefail

cd "$(dirname "$0")/.."

export LC_ALL=C

MIN_COVERAGE="${MIN_COVERAGE:-90}"

if [[ -n "${FLUTTER:-}" ]]; then
  # Intentional split so FLUTTER="fvm flutter" or FLUTTER="flutter" both work.
  read -r -a flutter_cmd <<< "$FLUTTER"
else
  flutter_cmd=(fvm flutter)
fi

"${flutter_cmd[@]}" test --coverage

lcov --ignore-errors unused,unused,empty,empty \
  --remove coverage/lcov.info \
  '*.g.dart' \
  '*.freezed.dart' \
  '*.config.dart' \
  'lib/main.dart' \
  --output-file coverage/lcov.info

summary="$(
  lcov --ignore-errors empty,empty --summary coverage/lcov.info 2>&1 || true
)"
printf '%s\n' "$summary"

percent="$(
  printf '%s\n' "$summary" |
    sed -n 's/.*lines\.*:[[:space:]]*\([0-9.][0-9.]*\)%.*/\1/p' |
    head -n 1
)"

if [[ -z "$percent" ]]; then
  echo "Could not read the line coverage from lcov --summary." >&2
  exit 1
fi

printf 'Line coverage: %s%% (minimum %s%%).\n' "$percent" "$MIN_COVERAGE"
echo "Files under ${MIN_COVERAGE}%:"
awk -v min="$MIN_COVERAGE" '
  /^SF:/ {
    file = substr($0, 4)
    hit = 0
    total = 0
    next
  }
  /^DA:/ {
    total++
    split($0, parts, ",")
    if (parts[2] + 0 > 0) hit++
    next
  }
  /^end_of_record/ {
    if (total > 0) {
      pct = (100 * hit) / total
      if (pct < min + 0) {
        printf "  %s %.2f%% (%d/%d)\n", file, pct, hit, total
        found = 1
      }
    }
  }
  END {
    if (!found) print "  (none)"
  }
' coverage/lcov.info

awk -v percent="$percent" -v min="$MIN_COVERAGE" \
  'BEGIN { exit (percent + 0 >= min + 0) ? 0 : 1 }'
