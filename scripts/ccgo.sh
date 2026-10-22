# shellcheck shell=bash
# Run Claude Code on an OpenCode Go subscription, per session, without touching your Anthropic login.
# Source from ~/.bashrc (or ~/.zshrc):  source /path/to/practice-omarchy/scripts/ccgo.sh
#
#   ccgo-check   one tiny request per model: tells you which models and key work (uses ~4 requests)
#   ccgo         start Claude Code on Go; any arguments go to `claude`
#   ccgoy        same as ccgo, with --permission-mode bypassPermissions (no approval prompts)
#
# Design goal: never hit a limit and never lose access. Go caps each model separately, so each
# Claude Code slot uses a different model (separate budgets). See
# docs/reference/claude-code-opencode-go.md for the reasoning and the fallback ladder.
# Each slot is a comma list in fallback order; ccgo probes at launch and uses the first that answers.
# Override any default from your shell:  export CCGO_SONNET=minimax-m3,qwen3.8-flash
#
# Untested on Omarchy. Endpoint and model IDs: https://opencode.ai/docs/go/ (read 2026-10-19).
# ponytail: no automatic failover when a model hits its limit; switch with `ccgo --model <id>`.

CCGO_BASE_URL="${CCGO_BASE_URL:-https://opencode.ai/inference/go/anthropic}"
CCGO_KEY_FILE="${CCGO_KEY_FILE:-$HOME/.config/opencode-go/key}"
CCGO_SONNET="${CCGO_SONNET:-qwen3.8-flash,minimax-m3,qwen3.7-plus}"   # default workhorse: biggest budget of the strong models
CCGO_OPUS="${CCGO_OPUS:-minimax-m3,qwen3.8-max,qwen3.8-flash}"  # plan mode / hard tasks; comma list = fallback order
CCGO_HAIKU="${CCGO_HAIKU:-qwen3.7-plus,qwen3.8-flash,claude-haiku-5-5}"      # frequent background calls: separate budget
CCGO_SUBAGENT="${CCGO_SUBAGENT:-claude-haiku-5-5,qwen3.7-plus,qwen3.8-flash}"  # subagents fan out requests: separate budget

_ccgo_key() {
    if [ -n "${OPENCODE_GO_KEY:-}" ]; then
        printf '%s' "$OPENCODE_GO_KEY"
    elif [ -r "$CCGO_KEY_FILE" ]; then
        cat "$CCGO_KEY_FILE"
    else
        echo "ccgo: no key. Put it in $CCGO_KEY_FILE (chmod 600) or set OPENCODE_GO_KEY." >&2
        return 1
    fi
}

# HTTP status of one tiny request to one model. Key goes through curl's stdin config so it never appears in `ps`.
_ccgo_probe() {
    printf 'header = "x-api-key: %s"\n' "$2" | curl -sS -K - --max-time 30 \
        -o /dev/null -w '%{http_code}' -A "ccgo-check/1.0" \
        -H "x-opencode-session: ccgo-check" \
        -H "anthropic-version: 2023-06-01" -H "content-type: application/json" \
        -d "{\"model\":\"$1\",\"max_tokens\":8,\"messages\":[{\"role\":\"user\",\"content\":\"ok\"}]}" \
        "$CCGO_BASE_URL/v1/messages" 2>&1 || true
}

# First model in a comma list that answers 200; falls back to the first entry if none does.
# ponytail: probes once per launch (1 request per slot); a model that dies mid-session needs a relaunch.
_ccgo_first_ok() {
    local m
    for m in ${1//,/ }; do
        [ "$(_ccgo_probe "$m" "$2")" = 200 ] && { printf '%s' "$m"; return; }
        echo "ccgo: $m unavailable, trying next" >&2
    done
    printf '%s' "${1%%,*}"
}

ccgo() {
    local key sonnet opus haiku sub
    key="$(_ccgo_key)" || return 1
    sonnet="$(_ccgo_first_ok "$CCGO_SONNET" "$key")"
    opus="$(_ccgo_first_ok "$CCGO_OPUS" "$key")"
    haiku="$(_ccgo_first_ok "$CCGO_HAIKU" "$key")"
    sub="$(_ccgo_first_ok "$CCGO_SUBAGENT" "$key")"
    # Variables apply to this one process only. ANTHROPIC_AUTH_TOKEN must be set but empty.
    ANTHROPIC_BASE_URL="$CCGO_BASE_URL" ANTHROPIC_API_KEY="$key" ANTHROPIC_AUTH_TOKEN="" \
    ANTHROPIC_DEFAULT_SONNET_MODEL="$sonnet" ANTHROPIC_DEFAULT_OPUS_MODEL="$opus" \
    ANTHROPIC_DEFAULT_HAIKU_MODEL="$haiku" CLAUDE_CODE_SUBAGENT_MODEL="$sub" \
        claude "$@"
}

# Function, not alias: aliases in ~/.bashrc are invisible to zsh.
ccgoy() { ccgo --permission-mode bypassPermissions "$@"; }

ccgo-check() {
    local key model code failed=0
    key="$(_ccgo_key)" || return 1
    for model in $(printf '%s\n' ${CCGO_SONNET//,/ } ${CCGO_OPUS//,/ } ${CCGO_HAIKU//,/ } ${CCGO_SUBAGENT//,/ } | awk '!seen[$0]++'); do
        code="$(_ccgo_probe "$model" "$key")"
        case "$code" in
            200) echo "ok    $model" ;;
            401|403) failed=1; echo "FAIL  $model  HTTP $code: key rejected. FIX: check the key in the OpenCode console." ;;
            404) failed=1; echo "FAIL  $model  HTTP 404: unknown endpoint or model id. FIX: compare with https://opencode.ai/docs/go/" ;;
            402) failed=1; echo "FAIL  $model  HTTP 402: model unavailable on this plan or account. FIX: ccgo --model <another model>, or check the Console." ;;
            429) failed=1; echo "LIMIT $model  HTTP 429: this model's budget is used up. FIX: ccgo --model <another model>" ;;
            *) failed=1; echo "FAIL  $model  HTTP/curl result: $code" ;;
        esac
    done
    return "$failed"
}
