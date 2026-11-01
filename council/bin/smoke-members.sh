#!/usr/bin/env bash
# One small real call per platform CLI. Each member runs from an empty
# sandbox with stdin closed and must return stdout that contains a balanced
# JSON object with a "verdict" key. council/bin/extract-json.py extracts it,
# because a member can narrate before its final answer (see members.sh,
# empirical lens). extract-json.py fails closed when no balanced object
# exists, so a member that returns no JSON still fails this check.
# COUNCIL_TIMEOUT bounds each call (default 900 s).
set -uo pipefail
# Resolved from this file's own location; DEFIFORMAL_ROOT overrides and
# says so -- mirrors the formal/v3/*.py pattern (e.g. verify-structure.py)
# rather than the brief's original bare `cd .../..`, per the plan's own
# Global Constraints, which every sibling script in the repo honours.
_SELF="$(cd "$(dirname "$0")/../.." && pwd)" || exit 3
_REPO="${DEFIFORMAL_ROOT:-$_SELF}"
if [ "$_REPO" != "$_SELF" ]; then
  echo "smoke-members.sh: NOTE - reading $_REPO (DEFIFORMAL_ROOT), not $_SELF" >&2
fi
cd "$_REPO" || exit 3
export PATH="$HOME/.local/bin:$HOME/.npm-global/bin:$PATH"
[ -f council/bin/members.sh ] || { echo "members.sh absent"; exit 3; }
. council/bin/members.sh

pass=0; fail=0
for lens in empirical formal significance reproducer; do
  SB=$(mktemp -d)
  cp council/bin/smoke-fixture.md "$SB/bundle.md"
  cat > "$SB/brief.md" <<'BRIEF'
Read ./bundle.md. Decide whether the claim under review is sound.
Output ONLY a single JSON object, no prose, no markdown fences:
{"lens":"smoke","verdict":"approved","summary":"<=20 words"}
BRIEF
  out="$SB/out.json"; log="$SB/out.log"
  run_member "$lens" "$SB" "$SB/brief.md" "$out" "$log"; rc=$?
  extract_log="$SB/extract.log"
  if python3 council/bin/extract-json.py --require-key verdict "$out" >/dev/null 2>"$extract_log"; then
    note=$(tail -n1 "$extract_log")
    echo "  ok   $lens (exit $rc) [$note]"; pass=$((pass+1))
  else
    echo "  FAIL $lens (exit $rc): $(head -c 120 "$log" 2>/dev/null)"; fail=$((fail+1))
  fi
  rm -rf "$SB"
done
echo "members smoke: $pass ok, $fail failed"
[ "$fail" -eq 0 ]
