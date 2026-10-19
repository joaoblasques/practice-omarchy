# Configuration reference

What `scripts/practice-omarchy-setup.sh` adds to your machine, and what it deliberately leaves alone.
Target: **Omarchy v4** ([manual](https://omarchy.org/manual/)). The blocks below are kept identical to the
installer by `scripts/check-drift.py`; edit both together.

The installer is **additive**. Every file it edits is backed up first
(`<file>.practice-omarchy.bak.<timestamp>`), each block is wrapped in
`# >>> practice-omarchy:NAME >>>` markers so you can find and remove it, and re-running it is safe.
Preview everything with `--dry-run`.

## What the installer does NOT touch (and why)

| File | Why it is left alone |
| :--- | :--- |
| `~/.config/ghostty/config` | Omarchy generates and themes it. Install Ghostty from the Omarchy menu (Install > Terminal). |
| `~/.config/starship.toml` | Omarchy ships a minimal prompt. A personal example is at the bottom of this page. |
| `~/.config/hypr/*` | Hyprland settings. Change keys in `bindings.lua`, never in Omarchy's own files. |
| `~/.config/tmux/tmux.conf` (existing lines) | Omarchy's tmux config (Ctrl+Space prefix, pane keys). The old repo version ran `unbind-key -a`, which erased them. |

Omarchy's rule of thumb ([dotfiles](https://omarchy.org/manual/dotfiles/)): `~/.config` is yours,
Omarchy's own files are not.

## 1. tmux plugins (appended to `~/.config/tmux/tmux.conf`)

Third-party plugins (SessionX, Floax) via TPM. I did not verify their dependencies; read their READMEs.

<!-- block:tmux -->
```tmux
# Extra plugins via TPM. Omarchy's own tmux config above is left untouched.
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'omerxx/tmux-sessionx'
set -g @plugin 'omerxx/tmux-floax'

# SessionX fuzzy session picker (Prefix + o)
set -g @sessionx-bind 'o'
set -g @sessionx-preview-location 'top'

# Floax floating popup (Prefix + p)
set -g @floax-bind 'p'
set -g @floax-path-tracking 'on'

# TPM must be the last line
if-shell "test -f ~/.tmux/plugins/tpm/tpm" "run '~/.tmux/plugins/tpm/tpm'"
```

## 2. bash (Omarchy's default shell; appended to `~/.bashrc`)

Omarchy's bash already provides fzf (`ff`, `Ctrl+R`), zoxide, starship, mise, eza and the layout
functions. The only addition is Atuin, which replaces fzf's `Ctrl+R`.

<!-- block:bash -->
```bash
# Atuin replaces fzf's Ctrl+R history search with a searchable SQLite history.
eval "$(atuin init bash)"
```

## 3. zsh (opt-in, appended to `~/.zshrc`)

Use this only if you move to zsh (`--shell zsh`). Omarchy's helpers are written for bash, so this block
ports the layout functions and agent aliases. `c`/`cx`/`cy` here are plain launchers; Omarchy's own
aliases start the agents in auto-approve mode.

<!-- block:zsh -->
```zsh
# Port of Omarchy's bash helpers to zsh (Omarchy ships these in bash only).
# Approximation of Omarchy's agent aliases: Omarchy's versions auto-approve; these do not.
alias c='opencode'
alias cx='claude'
alias cy='codex'

tdl() {
    local agent="${1:-c}"
    local agent2="${2:-}"
    tmux new-window -n "dev"
    tmux split-window -h
    if [ -n "$agent2" ]; then
        tmux split-window -v
    fi
    tmux select-pane -t 1
    tmux split-window -v
    tmux select-pane -t 1
    tmux send-keys "${EDITOR:-nvim}" C-m
    tmux select-pane -t 2
    tmux send-keys "$agent" C-m
    if [ -n "$agent2" ]; then
        tmux select-pane -t 3
        tmux send-keys "$agent2" C-m
    fi
}

tds() {
    tmux new-window -n "square"
    tmux split-window -h
    tmux split-window -v
    tmux select-pane -t 1
    tmux split-window -v
    tmux select-pane -t 1 && tmux send-keys "${EDITOR:-nvim}" C-m
    tmux select-pane -t 2 && tmux send-keys "git diff" C-m
    tmux select-pane -t 4 && tmux send-keys "c" C-m
}

tdlm() {
    local agent="${1:-c}"
    for dir in */; do
        if [ -d "$dir" ]; then
            tmux new-window -n "${dir%/}" -c "$dir"
            tdl "$agent"
        fi
    done
}

tsl() {
    local count="${1:-4}"
    local cmd="${2:-c}"
    tmux new-window -n "swarm"
    for ((j=1; j<count; j++)); do
        tmux split-window -t "swarm"
        tmux select-layout -t "swarm" tiled
    done
    for ((j=0; j<count; j++)); do
        tmux select-pane -t "swarm.$j"
        tmux send-keys "$cmd" C-m
    done
}

alias ic="tdl c"
alias icx="tdl c cx"
alias ff="fzf --preview 'bat --style=numbers --color=always --line-range :50 {}'"

eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"
eval "$(mise activate zsh)"
```

## Optional: a personal Starship prompt

Not installed by the script. Copy it into `~/.config/starship.toml` if you want it
(the Go and AWS modules only matter if you use them).

```toml
format = "$directory$git_branch$git_status$golang$aws$line_break$character"

[directory]
style = "bold cyan"

[git_branch]
symbol = "🌱 "
style = "bold magenta"
```
