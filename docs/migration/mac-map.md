# Mac to Omarchy map

Where your Mac tools and habits go. **Source** says how I know: `manual` means it is stated in the
[Omarchy manual](https://omarchy.org/manual/) (read 2026-10-19); `inferred` means I reasoned it
from other facts and you should check it on your machine.

## Habits

| On the Mac | On Omarchy | Source |
| :--- | :--- | :--- |
| Cmd as the main modifier | `Super` (the Windows key) is the anchor for almost every binding | manual: coming-from-mac |
| Spotlight / Raycast | `Super + Space` (Omarchy menu) | manual: coming-from-mac |
| Cmd+C / Cmd+V everywhere | `Super + C` / `Super + V`, also in the terminal | manual: coming-from-mac |
| Cmd+Q, Cmd+W | `Super + W` closes the window. `Super + Q` is not a default Omarchy binding (the manual lists it; verify on your version). | manual: coming-from-mac |
| Cmd+Tab | `Alt + Tab` cycles windows on the workspace | manual: hotkeys |
| Spaces / Mission Control | Workspaces: `Super + 1/2/3/4` | manual: coming-from-mac |
| Window snapping (Rectangle, Magnet) | Not needed: windows tile themselves; `Super + T` floats one | manual: coming-from-mac |
| Cmd+Shift+4 screenshot | `Print Screen` | manual: coming-from-mac |
| Notification Center | `Super + Shift + Alt + ,` notification history | manual: coming-from-mac |
| AirDrop | LocalSend, `Super + Ctrl + S` | manual: coming-from-mac |
| Time Machine | Automatic snapshots on every update | manual: coming-from-mac |
| App Store / downloaded installers | Omarchy menu > Install, or `omarchy pkg add <name>` | manual: other-packages |
| System Settings | Omarchy menu > Setup, which edits plain config files | manual: coming-from-mac |
| Raycast clipboard history | `Super + Ctrl + V` | manual: hotkeys |
| Alfred / TextExpander snippets | `~/.XCompose` (CapsLock is the compose key) | manual: hotkeys |

## Tools

| Mac tool | Omarchy equivalent | Ships by default? | Source |
| :--- | :--- | :--- | :--- |
| Terminal / iTerm2 / Warp | Foot (default); Ghostty, Alacritty, Kitty via Install > Terminal | Foot yes, Ghostty optional | manual: terminal |
| Warp AI command search | `scripts/ai-shell.zsh` (Ctrl+G) | no, this repo | docs/reference/ai-shell.md |
| Homebrew | pacman + AUR via `omarchy pkg add` / Install > AUR | yes | manual: other-packages |
| tmux | tmux with Omarchy's config, `Ctrl + Space` prefix | yes | manual: hotkeys |
| Neovim / LazyVim | Neovim with LazyVim | yes | manual: hotkeys |
| fzf, ripgrep, fd, bat, eza, zoxide | same tools; `ls` is aliased to eza, `cd` to zoxide in bash | yes | manual: shell-tools |
| starship | Minimal Starship prompt | yes | manual: v3 prompt page; inferred for v4 |
| mise (replaces nvm, pyenv, rbenv) | mise manages the agent CLIs' Node | yes | manual: ai |
| Claude Code, OpenCode, Codex | `claude`, `opencode`, `codex` launchers (lazy-installed) | yes | manual: ai |
| GitHub Copilot CLI | `copilot` launcher | yes | manual: ai |
| lazygit / lazydocker | LazyGit in Neovim (`Space G G`); LazyDocker `Super + Shift + D` | yes | manual: hotkeys, tuis |
| htop / Activity Monitor | btop, `Super + Ctrl + T` | yes | manual: hotkeys |
| 1Password | `Super + Shift + /` | yes | manual: hotkeys |
| Obsidian | `Super + Shift + O` | yes | manual: hotkeys |
| Spotify | `Super + Shift + M` | yes | manual: hotkeys |
| VS Code / Cursor / Zed | Omarchy menu > Install > Editor | optional | manual: v3 development-tools; inferred for v4 |
| Atuin | `atuin` (Arch `extra`) | no, installer adds it | arch package page, 2026-10-19 |
| Television (`tv`) | `television` (Arch `extra`, v0.15.8) | no, installer adds it | arch package page, 2026-10-19 |
| Superfile | `superfile` (Arch `extra`) | no, installer adds it | arch package page, 2026-10-19 |
| sesh | `sesh-bin` (AUR only) | no, installer adds it | AUR page, 2026-10-19 |
| Docker Desktop | Docker engine + LazyDocker; check Install > Development | unverified for v4 | inferred |
| Karabiner-Elements | `~/.config/hypr/input.lua` (`kb_options`, e.g. `compose:caps`) | n/a | manual: dotfiles, v3 keyboard page |

## Package check (installer)

Verified in Arch repos on 2026-10-19:
[atuin](https://www.archlinux.de/packages/x86_64/atuin) extra,
[superfile](https://archlinux.org/packages/extra/x86_64/superfile) extra,
[television](https://www.archlinux.org/packages/extra/x86_64/television) extra,
[sesh-bin](https://aur.archlinux.org/packages/sesh-bin) AUR. Mirror pages can lag; the installer uses
`--needed`, so a version difference is harmless.
