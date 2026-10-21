#!/usr/bin/env bash
# practice-omarchy:summary=Copy ~/.claude/commands and ~/.claude/skills from this Mac to a ThinkPad over SSH, then verify every source name exists remotely.
# practice-omarchy:args=--host <jonas@ip-or-hostname> [--overwrite]
#
# Only `commands/` and `skills/` are portable across machines. The script
# refuses to copy session data, credentials, or other per-machine state.

set -euo pipefail

HOST=""
OVERWRITE=0
while [ $# -gt 0 ]; do
    case "$1" in
        --host) HOST="${2:-}"; shift ;;
        --overwrite) OVERWRITE=1 ;;
        -h|--help) sed -n '2,3p' "$0"; exit 0 ;;
        *) printf 'ERROR: unknown option %s. FIX: pass --host <jonas@ip|hostname>.\n' "$1" >&2; exit 2 ;;
    esac
    shift
done

if [ -z "$HOST" ]; then
    printf 'ERROR: --host <jonas@ip|hostname> required.\n' >&2
    exit 2
fi

LOCAL_HOME="${HOME:-$(getent passwd "$(id -un)" | cut -d: -f6)}"

say() { printf '%s\n' "$*"; }

WARN_DIRS=(sessions projects cache history.jsonl file-history paste-cache shell-snapshots .credentials.json settings.json backups)
say "WARNING: only ~/.claude/commands and ~/.claude/skills are portable. Skipping: ${WARN_DIRS[*]}."

src_cmds="$LOCAL_HOME/.claude/commands"
src_skills="$LOCAL_HOME/.claude/skills"

# Names, not totals: the ThinkPad holds its own skills, so totals differ by design.
# find -L: scp -r copies symlink targets, so list them too.
names() { # $1=dir $2=cmds|skills
    if [ "$2" = cmds ]; then (cd "$1" 2>/dev/null && find -L . -type f -name '*.md' | sort)
    else (cd "$1" 2>/dev/null && find -L . -mindepth 1 -maxdepth 1 -type d | sort); fi
}
find_remote() { ssh "$HOST" "cd ~/.claude/$1 2>/dev/null && find -L . $2 | sort" || true; }

src_cmd_names=$(names "$src_cmds" cmds)
src_skill_names=$(names "$src_skills" skills)
say "Source: commands=$(printf '%s' "$src_cmd_names" | grep -c . || true), skills=$(printf '%s' "$src_skill_names" | grep -c . || true)"

rem_cmd_names=$(find_remote commands "-type f -name '*.md'")
rem_skill_names=$(find_remote skills "-mindepth 1 -maxdepth 1 -type d")
overlap=$({ comm -12 <(printf '%s\n' "$src_cmd_names") <(printf '%s\n' "$rem_cmd_names")
            comm -12 <(printf '%s\n' "$src_skill_names") <(printf '%s\n' "$rem_skill_names"); } | grep . || true)
if [ -n "$overlap" ]; then
    say "OVERLAP (scp would overwrite these on $HOST):"; say "$overlap"
    if [ "$OVERWRITE" != 1 ]; then
        printf 'STOP: review the overlap, then re-run with --overwrite.\n' >&2
        exit 3
    fi
fi

ssh "$HOST" 'mkdir -p ~/.claude/commands ~/.claude/skills'
[ -n "$src_cmd_names" ] && scp -rpq "$src_cmds/." "$HOST:.claude/commands/"
[ -n "$src_skill_names" ] && scp -rpq "$src_skills/." "$HOST:.claude/skills/"

rem_cmd_names=$(find_remote commands "-type f -name '*.md'")
rem_skill_names=$(find_remote skills "-mindepth 1 -maxdepth 1 -type d")
missing=$({ comm -23 <(printf '%s\n' "$src_cmd_names") <(printf '%s\n' "$rem_cmd_names")
            comm -23 <(printf '%s\n' "$src_skill_names") <(printf '%s\n' "$rem_skill_names"); } | grep . || true)
if [ -n "$missing" ]; then
    printf 'FAIL: missing on %s:\n%s\n' "$HOST" "$missing" >&2
    exit 1
fi

say "ok: every source name exists on $HOST. Open Claude Code there and try /<command> for each one."
