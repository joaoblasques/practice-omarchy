#!/usr/bin/env bash
# practice-omarchy:summary=Copy ~/.claude/commands and ~/.claude/skills from this Mac to a ThinkPad over SSH, then verify counts match.
# practice-omarchy:args=--host <jonas@ip-or-hostname>
#
# Only `commands/` and `skills/` are portable across machines. The script
# refuses to copy session data, credentials, or other per-machine state.

set -euo pipefail

HOST=""
while [ $# -gt 0 ]; do
    case "$1" in
        --host) HOST="${2:-}"; shift ;;
        -h|--help) sed -n '2,5p' "$0"; exit 0 ;;
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
# find -L: scp -r copies symlink targets, so count them too or the remote count never matches.
src_cmd_count=$(find -L "$src_cmds" -type f -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
src_skill_count=$(find -L "$src_skills" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')
say "Source counts: commands=$src_cmd_count, skills=$src_skill_count"

ssh "$HOST" 'mkdir -p ~/.claude/commands ~/.claude/skills'

if [ "$src_cmd_count" -gt 0 ]; then
    scp -rpq "$src_cmds/." "$HOST:.claude/commands/"
fi
if [ "$src_skill_count" -gt 0 ]; then
    scp -rpq "$src_skills/." "$HOST:.claude/skills/"
fi

remote_cmd_count=$(ssh "$HOST" "find ~/.claude/commands -type f -name '*.md' 2>/dev/null | wc -l" | tr -d ' ')
remote_skill_count=$(ssh "$HOST" "find ~/.claude/skills -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l" | tr -d ' ')

say "Remote counts after copy: commands=$remote_cmd_count, skills=$remote_skill_count"

if [ "$src_cmd_count" != "$remote_cmd_count" ]; then
    printf 'FAIL: command count mismatch (source=%s remote=%s).\n' "$src_cmd_count" "$remote_cmd_count" >&2
    exit 1
fi
if [ "$src_skill_count" != "$remote_skill_count" ]; then
    printf 'FAIL: skill count mismatch (source=%s remote=%s).\n' "$src_skill_count" "$remote_skill_count" >&2
    exit 1
fi

say "ok: counts match. Open Claude Code on $HOST and try /<command> for each one."
