#!/usr/bin/env bash
# Read-only: list your Homebrew tools and a hint for where each lands on Omarchy.
# Writes nothing. Redirect to a file OUTSIDE this repo:  ./mac-inventory.sh > ~/mac-inventory.txt
# Hints are guesses from docs/migration/mac-map.md, not verified per package.
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
    echo "ERROR: Homebrew not found. FIX: run this on the Mac you are migrating from." >&2
    exit 1
fi

hint() {
    case "$1" in
        git|neovim|nvim|tmux|ripgrep|fd|bat|eza|fzf|zoxide|starship|mise|lazygit|lazydocker|btop|htop|jq|curl|wget)
            echo "ships with Omarchy" ;;
        node|python|python@*|ruby|go|rust|nvm|pyenv|rbenv|asdf)
            echo "use mise (ships with Omarchy)" ;;
        atuin|television|superfile) echo "added by practice-omarchy-setup.sh (Arch extra)" ;;
        sesh) echo "added by practice-omarchy-setup.sh (AUR sesh-bin)" ;;
        gh) echo "omarchy pkg add github-cli" ;;
        iterm2|warp|alacritty|kitty|ghostty) echo "Foot default; Ghostty/Kitty/Alacritty via Install > Terminal" ;;
        raycast|alfred) echo "Super + Space (Omarchy menu)" ;;
        rectangle|magnet|amethyst|yabai|aerospace) echo "not needed: Hyprland tiles windows" ;;
        1password|1password-cli) echo "ships with Omarchy (Super + Shift + /)" ;;
        obsidian) echo "ships with Omarchy (Super + Shift + O)" ;;
        spotify) echo "ships with Omarchy (Super + Shift + M)" ;;
        visual-studio-code|cursor|zed) echo "Omarchy menu > Install > Editor" ;;
        docker|docker-desktop) echo "Docker engine + LazyDocker; check Install > Development" ;;
        karabiner-elements) echo "hypr input.lua (kb_options)" ;;
        *) echo "search: omarchy pkg add $1  (else Install > AUR)" ;;
    esac
}

echo "# Mac inventory $(date +%F). Do not commit this file."
echo
echo "## Formulae (installed on request)"
brew leaves | while read -r name; do printf '%-28s %s\n' "$name" "$(hint "$name")"; done
echo
echo "## Casks"
brew list --cask | while read -r name; do printf '%-28s %s\n' "$name" "$(hint "$name")"; done
