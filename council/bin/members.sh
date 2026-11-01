#!/usr/bin/env bash
# Council member invocation table. Each lens runs one platform CLI directly,
# headless, from its own sandbox directory, with stdin closed and an outer
# `timeout`. The recipes and model pins follow the codex, grok, agy and
# claude skills in ~/workflowskills/skills. council/bin/smoke-members.sh
# checks each entry with one small real call.
#
#   empirical    grok   grok-4.7
#   formal       claude claude-opus-5-5, effort medium
#   significance codex  gpt-6.1-sol, read-only sandbox
#   reproducer   agy    gemini-4-argon-high, shell and writes denied
#   decider      claude claude-opus-5-5, effort medium
#
# Every prompt is short and positional (or a prompt file for grok). It names
# the brief the member reads from its own sandbox.
TIMEOUT="${COUNCIL_TIMEOUT:-900}"

# Run a command with stdin closed and a hard outer timeout. Exit 124 means
# the timeout stopped it.
_launch () {  # $1=outfile (stdout) $2=outlog (stderr) ; rest = command
  local out="$1" log="$2"; shift 2
  timeout -k 10 "$TIMEOUT" "$@" >"$out" 2>"$log" </dev/null
}

run_member () {  # $1=lens $2=sandbox $3=brief $4=outjson $5=outlog
  local lens="$1" sb="$2" brief="$3" out="$4" log="$5"
  # The member may read the bundle beside the brief, so the prompt forbids
  # reads outside the sandbox, not a second read.
  local ask="Read ./$(basename "$brief") in full and follow it exactly. Do not read any file outside this directory. Output only the JSON object it specifies: no narration of what you are about to do or did, no markdown fences, nothing before or after the JSON."
  ( cd "$sb" || exit 125
    case "$lens" in
      # grok: a prompt file avoids argv truncation. --always-approve stops
      # the Read tool from waiting on a prompt that closed stdin cannot
      # answer. Plain output can carry a narration lead-in before the JSON;
      # extract-json.py handles that at the validation layer.
      empirical)
        local promptfile="$sb/.grok-prompt.txt"
        printf '%s' "$ask" > "$promptfile"
        _launch "$out" "$log" grok -m grok-4.7 --reasoning-effort high \
          --prompt-file "$promptfile" --cwd "$sb" --always-approve \
          --no-subagents --disable-web-search --no-auto-update --max-turns 10
        ;;
      # claude: print mode allows Read without a permission flag.
      formal|decider)
        _launch "$out" "$log" claude -p --model claude-opus-5-5 --effort medium "$ask"
        ;;
      # codex: read-only sandbox, no session file, and the sandbox is not a
      # git repo. -o writes only the final message; progress goes to the log.
      significance)
        timeout -k 10 "$TIMEOUT" codex exec -m gpt-6.1-sol -c model_reasoning_effort=high \
          -s read-only --ephemeral --skip-git-repo-check -C "$sb" -o "$out" \
          "$ask" >"$log" 2>&1 </dev/null
        ;;
      # agy: headless agy can run shell commands and write files unless a
      # deny rule is passed per run. Reads inside the workspace stay allowed.
      reproducer)
        _launch "$out" "$log" agy --model gemini-4-argon-high --disable-slash-commands \
          --settings '{"permissions":{"deny":["command(*)","write_file(*)","execute_url(*)","mcp(*)"]}}' \
          --print-timeout "${TIMEOUT}s" --print="$ask"
        ;;
      *) echo "unknown lens: $lens" >&2; exit 125 ;;
    esac )
}
