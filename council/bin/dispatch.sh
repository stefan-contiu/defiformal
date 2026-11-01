#!/usr/bin/env bash
# One sandboxed member per lens. Each gets an empty directory containing only
# the bundle and its own brief, so "do not read any other file" is enforced by
# the filesystem rather than by asking politely. council/bin/members.sh is
# the source of truth for which platform CLI and model each lens uses.
set -uo pipefail

# Invoked as `bash council/bin/dispatch.sh`, so no login profile is sourced
# and PATH can lack the user-local install directories. Set them here.
export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"

cd "$(dirname "$0")/../.." || exit 3
REPO="$(pwd)"
. council/bin/members.sh

# run_member (members.sh) executes its whole case statement inside a
# `( cd "$sb" ... )` subshell -- the sandbox directory, not this script's
# cwd. Any relative path handed in as outjson/outlog therefore resolves
# against the sandbox, not the repo, and the output redirect fails
# before the vendor CLI is ever invoked. OUT and the copied brief source
# must be absolute for that reason.
ROUND="${1:-1}"
# Optional space-separated lens subset (2nd arg), defaulting to all four.
# Exists so a lens that failed for an environment reason before ever
# reaching the vendor CLI (e.g. the PATH bug above) can be re-run alone,
# without re-dispatching -- and re-billing -- a lens that already
# succeeded and validated.
LENSES="${2:-empirical formal significance reproducer}"
OUT="$REPO/council/sprint1/reports"
mkdir -p "$OUT"

B="$REPO/council/sprint1/BUNDLE-blinded.md"
[ -s "$B" ] || { echo "dispatch: BLOCKED - no bundle"; exit 3; }
python3 council/bin/leak-check.py "$B" >/dev/null 2>&1 \
  || { echo "dispatch: BLOCKED - bundle failed the leak check"; exit 3; }

declare -A CLI=( [empirical]=grok [formal]=claude [significance]=codex [reproducer]=agy )

for lens in $LENSES; do
  SB=$(mktemp -d)
  cp "$B" "$SB/bundle.md"
  cp "$REPO/council/sprint1/BRIEF-$lens.md" "$SB/brief.md"
  j="$OUT/R$ROUND-$lens-${CLI[$lens]}.json"
  l="$OUT/R$ROUND-$lens-${CLI[$lens]}.log"
  echo "dispatching $lens (${CLI[$lens]}) ..."
  run_member "$lens" "$SB" "$SB/brief.md" "$j" "$l"
  rc=$?
  echo "  exit=$rc bytes=$(wc -c < "$j" 2>/dev/null || echo 0)"
  rm -rf "$SB"
done

python3 council/bin/validate-reports.py "$OUT"
