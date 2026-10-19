# Claude Code on an OpenCode Go subscription

Run Claude Code against [OpenCode Go](https://opencode.ai/docs/go/) (flat monthly price, open-weight models)
instead of paying Anthropic per token. **Design goal: never hit a limit and never lose access to AI.**
Quality is second. If that is not your priority, pick models by benchmark instead.

> **Status: untested end to end.** Verified from macOS on 2026-10-19: the endpoint exists and
> rejects a bad key with HTTP 401, and it requires an `x-opencode-session` header (without it: HTTP 400
> `MissingSessionID`). Not verified: a real key, a real Claude Code session, Omarchy. Run `ccgo-check` first.

## Setup

1. Subscribe in the OpenCode Console, copy the API key.
2. Save it (not in a shell rc file):
   ```bash
   mkdir -p ~/.config/opencode-go && chmod 700 ~/.config/opencode-go
   read -rs -p "Go key: " k && printf '%s' "$k" > ~/.config/opencode-go/key && chmod 600 ~/.config/opencode-go/key; unset k
   ```
3. Source the script from `~/.bashrc` (zsh: `~/.zshrc`):
   ```bash
   source ~/path/to/practice-omarchy/scripts/ccgo.sh
   ```
4. `ccgo-check` (about four tiny requests), then `ccgo` to start Claude Code. Inside it, `/status` should show the OpenCode URL.

`ccgo` sets its variables for that one process only. Plain `claude` and `cx` keep using your Anthropic login,
which is deliberate (see the fallback ladder). Do **not** put these variables in `~/.claude/settings.json`: that
sends every session through Go and removes your fallback.

## Why these models: budgets, not benchmarks

Claude Code speaks the Anthropic protocol, so only models on Go's Anthropic endpoint work. Go caps **each model
separately** (rolling: 5 hours = 20% of the monthly allowance, week = 50%, month = 100%). Estimated requests
on the $10 plan, from the [official table](https://opencode.ai/docs/go/) read 2026-10-19:

| Model | Per 5 h | Per week | Per month | Role in `ccgo` |
| :--- | ---: | ---: | ---: | :--- |
| `qwen3.8-flash` | 5,400 | 13,500 | 27,000 | Sonnet slot: the default you use all day |
| `qwen3.7-plus` | 4,300 | 10,800 | 21,600 | Haiku slot: frequent small background calls |
| `claude-haiku-5-5` | 3,850 | 9,620 | 19,230 | Subagents, which fan out many requests |
| `minimax-m3` | 3,200 | 8,000 | 16,000 | Opus slot: plan mode and hard tasks |
| `qwen3.8-max` | 160 | 400 | 810 | Not mapped: a few requests per day at most |

Two decisions follow from the "never hit a limit" goal:

- **One model per slot** means four separate budgets instead of one. A busy subagent run cannot eat the
  budget your main session needs.
- **`qwen3.8-max` is left out of the slots on purpose.** It scores highest on SWE-bench Pro among the usable models
  (67.7%, vendor-reported), but its allowance is about 810 requests a month. Use it by hand for one hard problem:
  `ccgo --model qwen3.8-max`.

These estimates assume small requests. Claude Code sends large contexts, so expect to burn through budgets
faster than the table says. **Check the console's usage page after your first week and adjust.**
Quality is a guess until you have used it: the published benchmark scores for these models are vendor-reported
and nobody has published a head-to-head inside Claude Code. No model on this endpoint replaces a top Claude model
for hard design work; that is what rung 3 of the ladder is for.

## Fallback ladder: so you are never without AI

Go down one rung whenever the previous one fails or runs out.

1. **Another model's budget.** `ccgo-check` shows which models are at their limit (HTTP 429). Then run
   `ccgo --model <id>` with a model that still has budget, or `export CCGO_SONNET=minimax-m3` and relaunch.
2. **Pay-as-you-go top-up.** In the console, enable *Use balance* and keep a small credit balance. After
   the limits are reached, Go falls back to the balance instead of blocking requests (per the Go docs).
   This costs real money per token, so keep the balance small.
3. **Your Anthropic account.** Plain `claude`. This is why `ccgo` does not touch your login.
4. **If the plan itself is the problem** (caps hit weekly even with rung 1): Go Plus is $40 a month with
   higher limits.

## Troubleshooting

| Symptom | Likely cause | Fix |
| :--- | :--- | :--- |
| `MissingSessionID` / HTTP 400 | The client did not send a session header. The docs say Claude Code sends its own native one. | `mise upgrade claude` (or `omarchy update`) and retry. If it persists, open an issue upstream. |
| HTTP 401 / 403 | Wrong or revoked key | Re-copy it from the console. |
| HTTP 404 | Wrong endpoint or model id | Compare with the Go docs. IDs are lowercase, e.g. `qwen3.8-flash`. |
| HTTP 429 | That model's 5-hour, weekly or monthly budget is used up | Fallback ladder, rung 1. |
| "API Usage Billing" and a 403 on remote managed settings at startup | Expected when Claude Code points at a non-Anthropic endpoint; the managed-settings fetch fails and Claude Code continues without it | Ignore, or confirm with `/status`. |
| Errors mentioning `claude-opus-*` or `claude-sonnet-*` | A slot variable is unset, so Claude Code asked Go for a model it does not serve | Use `ccgo`, not plain `claude` with a custom base URL. |

## Privacy

Per the Go docs, requests to the Qwen and MiniMax models are not used for training and have 0-day retention. Requests to
`claude-haiku-5-5` are retained for 30 days under Anthropic's data policy. Check the privacy table before
sending anything sensitive.

## Sources

- Go plan, models, endpoints, limits, privacy, validated clients: <https://opencode.ai/docs/go/> (read 2026-10-19)
- Model scores: [SWE-bench Pro leaderboard roundup](https://www.morphllm.com/swe-bench-pro) (vendor-reported, read 2026-10-19)
