#!/usr/bin/env bash
# One-shot setup for ccgo (Claude Code on OpenCode Go). Replaces Parts C to F of
# docs/migration/thinkpad-setup.md. Asks before it changes anything.
#   1. finds old ANTHROPIC settings and (with your OK) comments them out
#   2. saves your Go API key (chmod 600)
#   3. adds one `source` line to your shell rc file
#   4. runs ccgo-check
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
key_dir="$HOME/.config/opencode-go"
key_file="${CCGO_KEY_FILE:-$key_dir/key}"
case "${SHELL:-}" in *zsh) rc="$HOME/.zshrc" ;; *) rc="$HOME/.bashrc" ;; esac
say() { printf '%s\n' "$*"; }
ask() { local a; read -r -p "$1 [y/N] " a || a=n; [ "$a" = y ] || [ "$a" = Y ]; }

say "== 1/4 Check old ANTHROPIC settings"
settings="$HOME/.claude/settings.json"
if [ -f "$settings" ] && grep -q 'ANTHROPIC' "$settings"; then
    say "STOP: $settings has ANTHROPIC lines:"
    grep -n 'ANTHROPIC' "$settings" | sed -E 's/("ANTHROPIC_[A-Z_]*"[[:space:]]*:[[:space:]]*)"[^"]*"/\1"<hidden>"/g' || true
    say "FIX: open the file. Delete these lines from the env block. Then run this script again."
    exit 1
fi
for f in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile" "$HOME/.zprofile"; do
    [ -f "$f" ] || continue
    if grep -Eq '^[[:space:]]*(export[[:space:]]+)?ANTHROPIC_' "$f"; then
        say "Found in $f:"
        grep -nE '^[[:space:]]*(export[[:space:]]+)?ANTHROPIC_' "$f" | sed 's/=.*/=<hidden>/'
        if ask "Comment out these lines? A backup is saved."; then
            cp -p "$f" "$f.ccgo-setup.bak"
            tmp="$(mktemp)"
            awk '/^[[:space:]]*(export[[:space:]]+)?ANTHROPIC_/ {print "# disabled by ccgo-setup: " $0; next} {print}' "$f" > "$tmp"
            cat "$tmp" > "$f"; rm -f "$tmp"
            say "ok: lines disabled. Backup: $f.ccgo-setup.bak"
        else
            say "STOP: remove those lines yourself. Then run this script again."
            exit 1
        fi
    fi
done
if env | grep -q '^ANTHROPIC_'; then
    say "NOTE: this terminal still has ANTHROPIC variables. Open a new terminal after this script."
fi

say "== 2/4 Save the Go API key"
mkdir -p "$(dirname "$key_file")" && chmod 700 "$(dirname "$key_file")"
if [ -s "$key_file" ] && ! ask "A key file exists. Replace it?"; then
    say "skip: keeping the existing key"
else
    read -r -s -p "Paste the Go API key, then press Enter (the screen shows nothing): " k || k=""
    echo
    if [ -z "$k" ]; then say "STOP: no key entered."; exit 1; fi
    printf '%s' "$k" > "$key_file"; chmod 600 "$key_file"; unset k
    say "ok: key saved to $key_file"
fi

say "== 3/4 Load ccgo from $rc"
line="source \"$here/ccgo.sh\""
if grep -qF "scripts/ccgo.sh" "$rc" 2>/dev/null; then
    say "skip: $rc already loads ccgo.sh"
else
    [ -f "$rc" ] && cp -p "$rc" "$rc.ccgo-setup.bak"
    printf '\n# ccgo: Claude Code on OpenCode Go\n%s\n' "$line" >> "$rc"
    say "ok: added the source line to $rc"
fi

say "== 4/4 Test the key and the four models"
# shellcheck source=ccgo.sh
. "$here/ccgo.sh"
CCGO_KEY_FILE="$key_file"
if ccgo-check; then
    say "Result: all four models work."
    say "Next: open a NEW terminal. Type: mkdir -p ~/Work/test && cd ~/Work/test && ccgo"
else
    say "Result: a check failed. Read the FIX text above. Then run this script again."
    exit 1
fi
