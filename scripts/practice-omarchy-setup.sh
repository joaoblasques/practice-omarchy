#!/usr/bin/env bash
# Practice Omarchy installer. ADDITIVE: it installs what Omarchy does not ship and appends
# clearly marked blocks to your shell and tmux config. It never overwrites a file, never
# touches Omarchy-generated configs (Ghostty, Starship, Hyprland), and backs up any file
# before appending. Target: Omarchy v4 (https://omarchy.org/manual/).
#
#   ./practice-omarchy-setup.sh --dry-run            show everything, change nothing
#   ./practice-omarchy-setup.sh                      bash (Omarchy default shell)
#   ./practice-omarchy-setup.sh --shell zsh          also install zsh + the zsh port
#   flags: --skip-packages  --skip-tpm
set -euo pipefail

DRY=0
SHELL_CHOICE=bash
SKIP_PACKAGES=0
SKIP_TPM=0

while [ $# -gt 0 ]; do
    case "$1" in
        --dry-run) DRY=1 ;;
        --shell) SHELL_CHOICE="${2:-}"; shift ;;
        --skip-packages) SKIP_PACKAGES=1 ;;
        --skip-tpm) SKIP_TPM=1 ;;
        -h|--help) sed -n '2,12p' "$0"; exit 0 ;;
        *) echo "ERROR: unknown option '$1'. FIX: run with --help." >&2; exit 2 ;;
    esac
    shift
done
case "$SHELL_CHOICE" in bash|zsh) ;; *) echo "ERROR: --shell must be bash or zsh." >&2; exit 2 ;; esac

say() { printf '%s\n' "$*"; }
act() { if [ "$DRY" = 1 ]; then say "[dry-run] $*"; else "$@"; fi; }

# add_block <file> <name> < body : append a marked block once; back up the file first.
add_block() {
    local file="$1" name="$2" body begin end
    body="$(cat)"
    begin="# >>> practice-omarchy:$name >>>"
    end="# <<< practice-omarchy:$name <<<"
    if [ -f "$file" ] && grep -qF "$begin" "$file"; then
        say "skip: block '$name' already in $file (delete the marked block to reinstall)"
        return
    fi
    if [ "$DRY" = 1 ]; then
        say "[dry-run] append block '$name' ($(printf '%s\n' "$body" | wc -l | tr -d ' ') lines) to $file"
        return
    fi
    mkdir -p "$(dirname "$file")"
    if [ -f "$file" ]; then
        cp -p "$file" "$file.practice-omarchy.bak.$(date +%Y%m%d%H%M%S)"
    fi
    printf '\n%s\n%s\n%s\n' "$begin" "$body" "$end" >> "$file"
    say "ok: appended block '$name' to $file"
}

# 1. Packages ---------------------------------------------------------------------------
if [ "$SKIP_PACKAGES" = 0 ]; then
    if [ "$DRY" = 0 ] && ! command -v pacman >/dev/null 2>&1; then
        echo "ERROR: pacman not found, so this is not Arch/Omarchy." >&2
        echo "FIX: run on Omarchy, or use --dry-run / --skip-packages." >&2
        exit 1
    fi
    # Not shipped by Omarchy. Verified in Arch 'extra' 2026-10-19 (see docs/migration/mac-map.md).
    repo_pkgs=(atuin television superfile)
    [ "$SHELL_CHOICE" = zsh ] && repo_pkgs+=(zsh)
    say "== packages (repo): ${repo_pkgs[*]}"
    for pkg in "${repo_pkgs[@]}"; do
        if command -v omarchy >/dev/null 2>&1; then
            act omarchy pkg add "$pkg"
        else
            act sudo pacman -S --needed --noconfirm "$pkg"
        fi
    done
    say "== packages (AUR): sesh-bin"
    if command -v yay >/dev/null 2>&1 || [ "$DRY" = 1 ]; then
        act yay -S --needed --noconfirm sesh-bin
    else
        say "skip: yay not found. FIX: Omarchy menu > Install > AUR > sesh-bin"
    fi
fi
say "== terminal: this installer does not install Ghostty. Omarchy themes it for you:"
say "   Omarchy menu (Super + Space) > Install > Terminal > Ghostty"

# 2. tmux plugins (Omarchy owns the rest of ~/.config/tmux/tmux.conf) ----------------------
TMUX_CONF="$HOME/.config/tmux/tmux.conf"
add_block "$TMUX_CONF" tmux <<'EOF'
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
EOF

if [ "$SKIP_TPM" = 0 ]; then
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        act git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi
    say "next: inside tmux press Prefix + I (capital i) to fetch the plugins"
fi

# 3. Shell ----------------------------------------------------------------------------------
if [ "$SHELL_CHOICE" = bash ]; then
    # Omarchy's bash already has fzf, zoxide, starship, mise, eza and the tdl/tds/tdlm/tsl layouts.
    add_block "$HOME/.bashrc" bash <<'EOF'
# Atuin replaces fzf's Ctrl+R history search with a searchable SQLite history.
eval "$(atuin init bash)"
EOF
else
    add_block "$HOME/.zshrc" zsh <<'EOF'
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
EOF
    say "next: make zsh your login shell with:  chsh -s \"\$(command -v zsh)\"  (this script does not)"
    say "optional: source scripts/ai-shell.zsh from ~/.zshrc for Ctrl+G inline AI (docs/reference/ai-shell.md)"
fi

say "done. Backups, if any, sit next to each edited file as *.practice-omarchy.bak.<timestamp>."
