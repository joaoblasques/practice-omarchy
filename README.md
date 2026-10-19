# Practice Omarchy

**Move from macOS to [Omarchy](https://omarchy.org/) (Arch Linux + Hyprland) and build the muscle memory to stay there.**
A migration checklist, a safe installer for the extra terminal tools, and a four-week keyboard-first practice plan with a quiz.

> **Status.** Written and tested on macOS (dry runs, a fake-`$HOME` install, the quiz). The Omarchy-side steps
> are being validated on a ThinkPad; see the open items in [`feature_list.json`](feature_list.json).
> Facts are checked against the official [Omarchy manual](https://omarchy.org/manual/) (v4, read 2026-10-19).
> Found something wrong? Open an issue.

## Who this is for

Developers who live in a terminal on a Mac and want the Omarchy workflow, plus the extras many of them run:
Ghostty, Atuin, tmux plugins, and AI agents (Claude Code, OpenCode, Codex) in tmux layouts.
Omarchy already ships most of the modern CLI stack, so this repo adds only what is missing, without
overwriting Omarchy's own configs.

## Quick start

```bash
git clone https://github.com/joaoblasques/practice-omarchy && cd practice-omarchy

# on the Mac you are leaving (read-only)
./scripts/mac-inventory.sh > ~/mac-inventory.txt     # keep out of git

# on Omarchy
./scripts/practice-omarchy-setup.sh --dry-run        # preview, changes nothing
./scripts/practice-omarchy-setup.sh                  # bash (default); add --shell zsh to keep zsh
python3 scripts/practice-omarchy-cli.py              # 10-question keybinding drill
```

## What is here

| Path | Purpose |
| :--- | :--- |
| [`docs/migration/`](docs/migration/README.md) | Order of operations, Mac-to-Omarchy map, what to bring over (keys, dotfiles, ThinkPad checks). |
| [`docs/guide/exercise-guide.md`](docs/guide/exercise-guide.md) | The four-week practice plan with a "done when" test per week. |
| [`docs/reference/keybindings.md`](docs/reference/keybindings.md) | Verified cheat sheet. The quiz is generated from it. |
| [`docs/reference/configs.md`](docs/reference/configs.md) | Exactly what the installer adds, and what it refuses to touch. |
| [`docs/reference/ai-shell.md`](docs/reference/ai-shell.md) | Warp-style "type a description, press Ctrl+G, get a command" for any terminal. |
| `scripts/practice-omarchy-setup.sh` | Additive installer: backs up first, marked blocks, `--dry-run`, safe to re-run. |
| `scripts/practice-omarchy-cli.py` | Keybinding quiz, 90+ questions, filter by section. |
| `scripts/ai-shell.zsh` | The inline-AI widget. |
| `scripts/ccgo.sh` | Optional: run Claude Code on an OpenCode Go subscription with per-model budgets and a fallback ladder. See [`docs/reference/claude-code-opencode-go.md`](docs/reference/claude-code-opencode-go.md). |
| `scripts/mac-inventory.sh` | Lists your Homebrew tools with a hint for each. |
| `scripts/check-drift.py` | Keeps the installer and `configs.md` identical. Run `./init.sh` for all checks. |
| `docs/blog/omarchy-blog-post.md` | Write-up of the approach. |

## Design choices

- **Additive, never destructive.** Everything the installer edits is backed up first and wrapped in
  `# >>> practice-omarchy:NAME >>>` markers.
- **Omarchy's files stay Omarchy's.** Ghostty, Starship, Hyprland and the base tmux config are generated or
  themed by Omarchy, so they are left alone.
- **One source of truth.** The quiz reads the cheat sheet; a script fails if the installer and docs diverge.
- **Bash first.** Omarchy's helpers are bash. The zsh path is opt-in and ports them for you.

## Contributing and license

See [CONTRIBUTING.md](CONTRIBUTING.md). MIT licensed, see [LICENSE](LICENSE).
Not affiliated with Omarchy or its authors.
