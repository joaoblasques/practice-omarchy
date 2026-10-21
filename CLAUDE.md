@AGENTS.md

# Claude Code notes (read this first)

You may run on the owner's ThinkPad under Omarchy v4, started with `ccgo` (Claude Code on an OpenCode Go
subscription). A session on the Mac may also work on this repo. Two writers exist, so follow the rules below.

## Owner rules (apply to every reply)

- **Write instructions and procedures in ASD-STE100 style.** One action in each step. Imperative verbs. Active voice.
  Procedural sentences of 20 words or fewer. Same word for same thing. Use WARNING, CAUTION and NOTE blocks.
  Add a "Result:" line after steps that need a check. Do not use idioms.
- **Lead with your recommendation** when you offer options. Say which option you pick and why.
- **Do not use the OpenCode CLI or harness.** Do not suggest `opencode`, `c`, or OpenCode free models.
  Claude Code with the OpenCode Go API (`ccgo`) is the only AI path. Do not use `cx` with Go.
- **Never print, log, or commit an API key.** Never read `~/.config/opencode-go/key` aloud.
- **Ask before irreversible or outward-facing actions** (push to `main`, delete files, `sudo`, install packages).
- **Priority for AI access:** never hit limits and never lose access. Quality is second.
- **Short, direct answers.** Say what you checked and what you did not check.

## Two-writer rule

- Run `git pull --rebase --autostash` before you start and before each commit.
- Commit small. Push at once. Use `git commit -m "..." -- <your paths>`. Never run `git add -A`.
- Do not edit the same file as the other writer at the same moment. `feature_list.json` is the shared state:
  change only the item you work on.

## State (2026-10-20)

- The repo is public (since 2026-10-21): `github.com/joaoblasques/practice-omarchy`. Default branch is `main`.
- On the ThinkPad: `ccgo-setup.sh` ran, `ccgo-check` shows `ok` for four models, `ccgo` works.
- Go Console: Extra Usage is off, balance is $0, per-model budgets are unconfirmed (see
  `docs/reference/claude-code-opencode-go.md`).
- `feature_list.json` is the task list. Passing: F01-F09, F11, F13-F17. Blocked: F10 (real ThinkPad
  time). Not started: F12 (first public commit).
- F15: report at `~/Work/omarchy-validation-report.md` (no FAIL; 3 DIFFERENT fixed in `docs/reference/keybindings.md`,
  `docs/migration/mac-map.md`, `docs/guide/exercise-guide.md`). Real installer run completed on the ThinkPad:
  atuin 18.23.0, television 0.15.9, superfile v1.6.0, sesh-bin 2.33.0 installed via `omarchy pkg add` + `yay`;
  `practice-omarchy:tmux` block appended to `~/.config/tmux/tmux.conf`; `practice-omarchy:bash` block appended to
  `~/.bashrc`; `~/.tmux/plugins/tpm` cloned; tmux plugins `tpm`, `omerxx/tmux-sessionx`, `omerxx/tmux-floax` installed
  at `~/.config/tmux/plugins/` (TMUX_PLUGIN_MANAGER_PATH). `shellcheck` and `zsh` are NOT installed on this ThinkPad;
  `init.sh` did not run. F15 was Procedure 4 in the original task list (Procedure 4 = "validate then install");
  Procedure 4/keys-and-files = `docs/migration/bring-your-stuff.md` was also completed in commit `134fee6`.
- F16 closed today (`docs/migration/install-zsh.md`): mixed run on the ThinkPad — pacman zsh 5.9.2-1,
  `sudo chsh` jonas to /usr/bin/zsh, installer --shell zsh appended the practice-omarchy:zsh block and
  the ai-shell.zsh source line, ~/.bashrc md5+mtime unchanged, widget fired on Ctrl+G with the buffer
  becoming `ls -a`. Two repo fixes shipped live (3b10af9 ccgo detection in ai-shell.zsh; 5ab4c02
  `export SHELL` from getent passwd in installer zsh block, check-drift.py still passes). Two
  user-config fixes shipped outside the repo (~/.config/ghostty/config + foot/foot.ini + Hyprland
  env directive) to make new terminals always start zsh regardless of when Hyprland launched.
- F17 added today (`docs/guide/exercise-guide.md`): four-week plan rewritten as numbered ASD-STE100 procedure
  steps. 29 days (Day 8 Toggles added via F18 batch 1), 138 numbered steps, 0 sentences over 20 words.

## Next tasks, in order

1. **F12 publish.** First commit on `main` and remote publish, after F10 results land (outward-facing: ask
   before push). F16 evidence now in; ready to ship.
2. **F19 end-to-end run.** Owner follows the F19 procedure from the Mac to migrate `.claude/commands`
   and `.claude/skills` to the ThinkPad. The script lives at `scripts/migrate-cc-from-mac.sh`; the doc at
   `docs/reference/claude-code-migrate.md`; the Mac-side checklist at `docs/from-mac.md`.
3. **F10 stale state.** Label is still `blocked`, but F15 + F16 effectively covered its verification line.
   Owner decision on whether to flip to `passing` or run a final smoke test first.

## Handoff (added 2026-10-20)

Owner is leaving the ThinkPad session and continuing on the Mac. When they next open this repo:

- On the **Mac**: read `docs/from-mac.md` (the AGENTS.md `macOS session mode` clause points the agent there
  on demand). Run `scripts/migrate-cc-from-mac.sh --host <thinkpad-host>` from a Mac terminal. End-to-end
  F19 outcome folds back into F19 evidence.
- On the **ThinkPad**: state lives in `feature_list.json` (20 features; F12 not_started, F18 in_progress,
  everything else passing) and this file. Origin `main` is at `7912dcc`. The push-from-Mac flow lands
  files in the ThinkPad user's `~/.claude/`. If the operator returns to a fresh Claude Code session on
  either side, those commands and skills are available locally.
- **Outward-facing actions** (push to a public remote, delete files, `sudo`, install packages) still
  require explicit owner approval.

## Differences from the Mac session

- On Omarchy you can verify facts on the real system. Prefer a command over a guess. Record the exact output.
- The installer rule in `AGENTS.md` ("never run the installer against the real `$HOME`") applies on the Mac.
  On the ThinkPad, run the real installer only after the owner approves a dry run.
- `HANDOFF.md` is gitignored and not on this machine. This file and `feature_list.json` hold the state.
- Update `feature_list.json` evidence and this "State" section when a task finishes.
