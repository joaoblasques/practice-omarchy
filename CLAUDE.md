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

- The repo is private: `github.com/joaoblasques/practice-omarchy`. Default branch is `main`.
- On the ThinkPad: `ccgo-setup.sh` ran, `ccgo-check` shows `ok` for four models, `ccgo` works.
- Go Console: Extra Usage is off, balance is $0, per-model budgets are unconfirmed (see
  `docs/reference/claude-code-opencode-go.md`).
- `feature_list.json` is the task list. Passing: F01-F09, F11, F13-F15. Blocked: F10 (real ThinkPad
  time). Not started: F12 (first public commit), F16 (install-zsh procedure doc only, not yet
  followed on the ThinkPad).
- F15: report at `~/Work/omarchy-validation-report.md` (no FAIL; 3 DIFFERENT fixed in `docs/reference/keybindings.md`,
  `docs/migration/mac-map.md`, `docs/guide/exercise-guide.md`). Real installer run completed on the ThinkPad:
  atuin 18.23.0, television 0.15.9, superfile v1.6.0, sesh-bin 2.33.0 installed via `omarchy pkg add` + `yay`;
  `practice-omarchy:tmux` block appended to `~/.config/tmux/tmux.conf`; `practice-omarchy:bash` block appended to
  `~/.bashrc`; `~/.tmux/plugins/tpm` cloned; tmux plugins `tpm`, `omerxx/tmux-sessionx`, `omerxx/tmux-floax` installed
  at `~/.config/tmux/plugins/` (TMUX_PLUGIN_MANAGER_PATH). `shellcheck` and `zsh` are NOT installed on this ThinkPad;
  `init.sh` did not run. F15 was Procedure 4 in the original task list (Procedure 4 = "validate then install");
  Procedure 4/keys-and-files = `docs/migration/bring-your-stuff.md` was also completed in commit `134fee6`.
- F16 added today (`docs/migration/install-zsh.md`): the zsh install + chsh + `practice-omarchy-setup --shell zsh`
  procedure for Week 4 / Ctrl+G widget. Document only — not yet followed on the ThinkPad.

## Next tasks, in order

1. **Procedure 5, practice plan.** Rewrite `docs/guide/exercise-guide.md` as numbered ASD-STE100 steps.
   Pulls from the F07 four-week plan; turns drills into runnable task steps.
2. **Procedure 6, install zsh (F16).** Owner follows `docs/migration/install-zsh.md` on the ThinkPad, then
   captures evidence and marks F16 passing.
3. **F12 publish.** First commit on `main` and remote publish, after F10 / F16 results land (outward-facing:
   ask before push).

## Differences from the Mac session

- On Omarchy you can verify facts on the real system. Prefer a command over a guess. Record the exact output.
- The installer rule in `AGENTS.md` ("never run the installer against the real `$HOME`") applies on the Mac.
  On the ThinkPad, run the real installer only after the owner approves a dry run.
- `HANDOFF.md` is gitignored and not on this machine. This file and `feature_list.json` hold the state.
- Update `feature_list.json` evidence and this "State" section when a task finishes.
