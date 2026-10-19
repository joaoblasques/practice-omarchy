# Warp-style inline AI for zsh (works in any terminal, incl. Ghostty).
# Type what you want, press Ctrl+G: the line is replaced by a command. Nothing runs
# until you press Enter. Source from ~/.zshrc:  source /path/to/scripts/ai-shell.zsh
#
# Backend: any CLI that reads a prompt on stdin and prints the answer on stdout.
# Default is Claude Code in print mode (no tools, no session saved). Examples:
#   export AI_SHELL_CMD='opencode run'     export AI_SHELL_CMD='aichat'
# ponytail: Ctrl+G is a blocking call (Haiku via claude -p is a couple of seconds).
# ponytail: no "explain" or "fix last command" widget; add when you miss them.

# --setting-sources project skips user hooks/plugins: ~3s instead of ~10s. Don't use --bare:
# it ignores subscription login and needs an API key.
: "${AI_SHELL_CMD:=claude -p --model haiku --tools '' --no-session-persistence --setting-sources project --strict-mcp-config --disable-slash-commands}"

# Pure function so it can be tested without a line editor: ai-shell-suggest "<request>"
ai-shell-suggest() {
  local prompt out
  prompt="Reply with exactly one $(basename "${SHELL:-zsh}") command for $(uname -s), no markdown, no explanation. Request: $*"
  out=$(print -r -- "$prompt" | eval "$AI_SHELL_CMD") || return 1
  # strip code fences if the model adds them, keep the first non-empty line
  print -r -- "$out" | sed -e '/^```/d' | sed -e '/^[[:space:]]*$/d' | head -n 1
}

_ai_shell_widget() {
  [[ -z $BUFFER ]] && return
  local req=$BUFFER cmd
  BUFFER="# thinking: $req"; zle -R
  if cmd=$(ai-shell-suggest "$req") && [[ -n $cmd ]]; then
    BUFFER=$cmd
  else
    BUFFER=$req
    zle -M "ai-shell: no suggestion (check AI_SHELL_CMD)"
  fi
  CURSOR=${#BUFFER}
}
zle -N _ai_shell_widget
bindkey '^G' _ai_shell_widget
