# from-mac.md — macOS-side handoff for practice-omarchy

You opened this repo on macOS and the Claude Code session you are talking to runs on this Mac. The destination machine (a ThinkPad running Omarchy v4) is a separate environment.

**Prerequisites:** SSH from the Mac reaches the ThinkPad. jonas's SSH public key lives in the ThinkPad's `~/.ssh/authorized_keys`.

**WARNING:** Skills and commands can read local paths and assume local tools. Migrating the `.md` files alone may not bring a fully working skill. Audit each before you trust it.

**NOTE:** Only `~/.claude/commands/` and `~/.claude/skills/` are portable. Do not copy `sessions/`, `projects/`, `cache/`, `history.jsonl`, `file-history/`, `paste-cache/`, `shell-snapshots/`, `.credentials.json`, or `settings.json`. Those hold per-machine session data and per-account credentials.

## Mac-side checklist (do these in order)

1. Open a Mac terminal.
2. Type `cd ~/Work/practice-omarchy` and press `Enter`.

   **Result:** the working directory is your local clone of this repo.

3. Type `ls -la ~/.claude/commands/` and press `Enter`. Note the count.

   **Result:** a list of slash commands.

4. Type `ls -la ~/.claude/skills/` and press `Enter`. Note the count.

   **Result:** a list of skill directories.

5. Type `bash scripts/migrate-cc-from-mac.sh --host <thinkpad-host>` and press `Enter`. Replace `<thinkpad-host>` with the ThinkPad's hostname or `jonas@<ip>`.

   **Result:** the script copies the two directories. It ends with `ok: every source name exists on <host>.` or `FAIL: ...`.

6. If SSH prompts, type the password and press `Enter`.

7. (Fallback — only if your commands or skills live in a private git repo.) On the Mac: push the repo. On the ThinkPad: clone it into `~/.claude/commands` or `~/.claude/skills`. See `docs/reference/claude-code-migrate.md` Part D.

8. Switch to the ThinkPad Claude Code session. Paste the counts from steps 3 and 4.

   **Result:** the ThinkPad agent runs the rest of the procedure.

**Done when:** the migration script printed `ok: every source name exists on <host>. Open Claude Code there and try /<command> for each one.`.

## For the assistant on this Mac

When the operator opens this repo on macOS and identifies themselves as on Mac, walk them through the checklist above. The full procedure lives at `docs/reference/claude-code-migrate.md`. This file is the Mac-side subset the user can read at a glance.

## Where to look

- Full procedure: `docs/reference/claude-code-migrate.md`
- Migration script: `scripts/migrate-cc-from-mac.sh`
- This handoff file: `docs/from-mac.md`
