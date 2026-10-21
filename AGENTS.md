# AGENTS.md

Context for AI agents working in this repo. Read this before editing.

## What this repo is
Practice Omarchy: a public migration + practice kit for moving from macOS to Omarchy
(Arch + Hyprland), plus the extra terminal tools many Mac developers run (Ghostty, Atuin,
tmux plugins, AI agents). Target: **Omarchy v4**; facts come from https://omarchy.org/manual/.

## Layout
```
README.md  CONTRIBUTING.md  LICENSE   public face
AGENTS.md                         this file
init.sh                           baseline checks (read-only, safe to run)
feature_list.json                 work items: behavior + verification + state
HANDOFF.md                        session state (gitignored); read first, update last
docs/
  migration/                      README (order), mac-map.md, bring-your-stuff.md
  guide/exercise-guide.md         four-week practice plan
  reference/keybindings.md        verified cheat sheet; the quiz is generated from it
  reference/configs.md            what the installer adds; blocks mirror the installer
  reference/ai-shell.md           inline-AI notes and alternatives
  reference/claude-code-opencode-go.md  Claude Code on OpenCode Go: budgets, fallback ladder
  blog/omarchy-blog-post.md       publishable blog post
  hardware/                       local-only vendor PDF (gitignored, never edit)
scripts/
  practice-omarchy-setup.sh       additive installer (--dry-run, backups, marked blocks)
  practice-omarchy-cli.py         quiz; questions parsed from keybindings.md
  ai-shell.zsh                    Ctrl+G natural language -> command widget
  ccgo.sh                         sourced; ccgo / ccgo-check run Claude Code on OpenCode Go
  mac-inventory.sh                read-only brew inventory with Omarchy hints
  check-drift.py                  fails if installer heredocs and configs.md blocks differ
```

## Session workflow
Start: `pwd`, read `HANDOFF.md` if present, read `feature_list.json`, `git log --oneline -5`, run `./init.sh`.
If `./init.sh` fails, fix that before any new work.

Rules:
- One feature `in_progress` at a time; finish or mark `blocked` before the next.
- A feature is `passing` only after its `verification` command exits 0 and the result
  is pasted into `evidence`. "Code written" is not done.
- Don't weaken a check or edit `verification` to make something pass.
- Stay inside the chosen feature; note unrelated problems in `HANDOFF.md`.
- Cite a source (manual page, package page) for any new fact about Omarchy or Arch.

End: `./init.sh` green, `feature_list.json` and `HANDOFF.md` updated, nothing half-done
unrecorded. Commit only when asked.

## Commands
- Baseline, no side effects: `./init.sh` (syntax checks, shellcheck, installer dry-run, drift check, quiz selftest)
- Quiz: `python3 scripts/practice-omarchy-cli.py` (needs a TTY); `--count`, `--selftest`, `--section tmux`
- Installer preview: `bash scripts/practice-omarchy-setup.sh --dry-run [--shell zsh]`
- Avoid `py_compile` (writes `__pycache__`); use `compile(open(f).read(), f, 'exec')`.

## Safety rules
- **Never run the installer against the real `$HOME`** without `--dry-run`. Exception: on a real Omarchy
  machine, after the owner approves a dry run (see `CLAUDE.md`). A write test is
  allowed only with a throwaway home: `HOME=$(mktemp -d) bash scripts/practice-omarchy-setup.sh --skip-packages --skip-tpm`.
- The installer must stay additive: no overwriting files, no `unbind-key -a`, no writing
  Omarchy-generated configs (Ghostty, Starship, Hyprland). Back up before any edit.
- Don't edit the user's dotfiles or source their rc files from here.
- `docs/hardware/*.pdf` is a vendor manual. Don't modify or publish it.
- Never commit secrets or `mac-inventory*.txt`.

## Conventions
- **Two places, kept identical:** the `add_block ... <<'EOF'` heredocs in the installer and the fenced
  blocks under `<!-- block:NAME -->` in `docs/reference/configs.md`. `scripts/check-drift.py` enforces it.
- **Quiz source:** `docs/reference/keybindings.md`. Rows must be `| Action | \`keys\` |`, one table per `##`.
- Shell scripts: bash, `set -euo pipefail`, shellcheck-clean at `-S warning`.
- Python: stdlib only, 3.12+. No new dependencies.
- Docs in English. Facts over voice: if the blog post disagrees with the manual, fix the post.
- Commit only when asked. Use `git -C <repo>` if working outside this directory.

## Known limits (see `feature_list.json` for status)
- Nothing here has run on a real Omarchy machine yet. Omarchy-side behaviour (tmux plugin
  dependencies, `omarchy pkg add` AUR handling, Ctrl+G widget) is unverified.
- The agent aliases `c`, `cx`, `cy` exist in Omarchy's bash; the zsh block approximates them
  without Omarchy's auto-approve flags.

## macOS session mode (added 2026-10-20)

When the operator opens this repo on macOS and identifies themselves as on Mac, read
`docs/from-mac.md` and walk them through the macOS-side checklist. Do not read it on a
ThinkPad session. The full procedure lives at `docs/reference/claude-code-migrate.md`; the
handoff file is the Mac-side subset the user can read at a glance.

## ThinkPad handoff trigger

When the owner says "I'm in the thinkpad", give these instructions. Do not add more.

On the ThinkPad:
1. Run `git pull --rebase --autostash` in the repo.
2. Open `docs/migration/ssh-from-mac.md` and follow it, or tell the ThinkPad Claude session to follow it.

What the procedure does:
- Part A: installs Tailscale from `Install > Service > Tailscale` and connects it.
- Part B: turns on SSH from `Setup > Security > SSHD`, then checks that `sshd` is active.
- Part C: adds the Mac public key to `~/.ssh/authorized_keys`.
- Parts D and E: report the ThinkPad name and user to the owner, and record the result in F19 evidence.

## Open work split by machine (2026-10-20)

State: SSH Mac -> ThinkPad works over Tailscale SSH (host `jonas@omarchy`, no key needed). F19 (copy
`~/.claude/commands` and `~/.claude/skills`) is not done. The ThinkPad already holds the skills
`diagnose-crash` and `omarchy`, and 0 commands. `scp` adds and overwrites; it never deletes.

### Mac session (do first)
1. Change `scripts/migrate-cc-from-mac.sh` to verify by name: every source command and skill name must exist on
   the ThinkPad. Do not compare totals. The ThinkPad's own skills make totals differ.
2. List names that exist on both machines. Show the owner any overlap before the copy. `scp` overwrites them.
3. Run `bash scripts/migrate-cc-from-mac.sh --host jonas@omarchy`.
4. Scan the copied skills for `/Users/jonasblasques` and macOS-only tools. List the skills that need a fix.
5. (Done 2026-10-21) The ThinkPad repo path is `~/Work/practice-omarchy`. `~/Dev` does not exist there.
   An earlier version of this step said the opposite. That was wrong.
6. Note in `docs/migration/ssh-from-mac.md` that Tailscale SSH needs no key, so Part C is optional.
7. Record the result in F19 `evidence` in `feature_list.json`. Commit and push.

### ThinkPad session (after the Mac copy)
1. Run `git pull --rebase --autostash`.
2. Open Claude Code. Run `/anythingood` and `/monthly-checkin`. Run `/clarity-review`, `/clarity-interview` and `/clarity-rewrite`.
3. Report any command or skill that fails or uses a Mac path. The Mac session fixes it.
4. Ask the owner about F12 (first public commit). Push only after the owner says yes.
5. Continue F18 (in progress). Change only that item in `feature_list.json`.
