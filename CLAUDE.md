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

## State (2026-10-19)

- The repo is private: `github.com/joaoblasques/practice-omarchy`. Default branch is `main`.
- On the ThinkPad: `ccgo-setup.sh` ran, `ccgo-check` shows `ok` for four models, `ccgo` works.
- Go Console: Extra Usage is off, balance is $0, per-model budgets are unconfirmed (see
  `docs/reference/claude-code-opencode-go.md`).
- `feature_list.json` is the task list. F14 passed. **F15 is in progress.**

## Next tasks, in order

1. **F15, validation.** Do `docs/migration/validate-on-omarchy.md` (read-only). Write the report to
   `~/Work/omarchy-validation-report.md`. Then fix every DIFFERENT and FAIL item in the repo files
   (`docs/reference/keybindings.md`, `docs/migration/mac-map.md`, `docs/reference/configs.md`, the installer and so on).
   Keep `docs/reference/keybindings.md` in the `| Action | \`keys\` |` row format. Run `./init.sh` if `shellcheck`
   and `zsh` exist. If they do not exist, tell the owner. Do not install them without asking.
2. **Procedure 3, installer.** Follow `docs/migration/thinkpad-setup.md`. Run `--dry-run` first. Show the owner the
   output. Run the real installer only after the owner says yes. The installer uses `sudo`.
3. **Procedure 4, keys and files.** See `docs/migration/bring-your-stuff.md`. Write it as numbered ASD-STE100 steps.
4. **Procedure 5, practice plan.** See `docs/guide/exercise-guide.md`.

## Differences from the Mac session

- On Omarchy you can verify facts on the real system. Prefer a command over a guess. Record the exact output.
- The installer rule in `AGENTS.md` ("never run the installer against the real `$HOME`") applies on the Mac.
  On the ThinkPad, run the real installer only after the owner approves a dry run.
- `HANDOFF.md` is gitignored and not on this machine. This file and `feature_list.json` hold the state.
- Update `feature_list.json` evidence and this "State" section when a task finishes.
