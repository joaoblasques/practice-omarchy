# shellcheck shell=bash
# Run Claude Code on an OpenCode Go subscription, per session, without touching your Anthropic login.
# Source from ~/.bashrc (or ~/.zshrc):  source /path/to/practice-omarchy/scripts/ccgo.sh
#
#   ccgo-check   one tiny request per model: tells you which models and key work (uses ~4 requests)
#   ccgo         start Claude Code on Go; any arguments go to `claude`
#
# Design goal: never hit a limit and never lose access. Go caps each model separately, so each
# Claude Code slot uses a different model (separate budgets). See
# docs/reference/claude-code-opencode-go.md for the reasoning and the fallback ladder.
# Override any default from your shell:  export CCGO_SONNET=minimax-m3
#
# Untested on Omarchy. Endpoint and model IDs: https://opencode.ai/docs/go/ (read 2026-10-19).
# ponytail: no automatic failover when a model hits its limit; switch with `ccgo --model <id>`.

CCGO_BASE_URL="${CCGO_BASE_URL:-https://opencode.ai/inference/go/anthropic}"
CCGO_KEY_FILE="${CCGO_KEY_FILE:-$HOME/.config/opencode-go/key}"
CCGO_SONNET="${CCGO_SONNET:-qwen3.8-flash}"   # default workhorse: biggest budget of the strong models
CCGO_OPUS="${CCGO_OPUS:-minimax-m3}"          # plan mode / hard tasks: separate budget
CCGO_HAIKU="${CCGO_HAIKU:-qwen3.7-plus}"      # frequent background calls: separate budget
CCGO_SUBAGENT="${CCGO_SUBAGENT:-claude-haiku-5-5}"  # subagents fan out requests: separate budget

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

ccgo() {
    local key
    key="$(_ccgo_key)" || return 1
    # Variables apply to this one process only. ANTHROPIC_AUTH_TOKEN must be set but empty.
    ANTHROPIC_BASE_URL="$CCGO_BASE_URL" ANTHROPIC_API_KEY="$key" ANTHROPIC_AUTH_TOKEN="" \
    ANTHROPIC_DEFAULT_SONNET_MODEL="$CCGO_SONNET" ANTHROPIC_DEFAULT_OPUS_MODEL="$CCGO_OPUS" \
    ANTHROPIC_DEFAULT_HAIKU_MODEL="$CCGO_HAIKU" CLAUDE_CODE_SUBAGENT_MODEL="$CCGO_SUBAGENT" \
        claude "$@"
}

ccgo-check() {
    local key model code
    key="$(_ccgo_key)" || return 1
    for model in "$CCGO_SONNET" "$CCGO_OPUS" "$CCGO_HAIKU" "$CCGO_SUBAGENT"; do
        # key goes through curl's stdin config so it never appears in `ps`
        code="$(printf 'header = "x-api-key: %s"\n' "$key" | curl -sS -K - --max-time 30 \
            -o /dev/null -w '%{http_code}' -A "ccgo-check/1.0" \
            -H "x-opencode-session: ccgo-check" \
            -H "anthropic-version: 2023-06-01" -H "content-type: application/json" \
            -d "{\"model\":\"$model\",\"max_tokens\":8,\"messages\":[{\"role\":\"user\",\"content\":\"ok\"}]}" \
            "$CCGO_BASE_URL/v1/messages" 2>&1)" || true
        case "$code" in
            200) echo "ok    $model" ;;
            401|403) echo "FAIL  $model  HTTP $code: key rejected. FIX: check the key in the OpenCode console." ;;
            404) echo "FAIL  $model  HTTP 404: unknown endpoint or model id. FIX: compare with https://opencode.ai/docs/go/" ;;
            429) echo "LIMIT $model  HTTP 429: this model's budget is used up. FIX: ccgo --model <another model>" ;;
            *) echo "FAIL  $model  HTTP/curl result: $code" ;;
        esac
    done
}
