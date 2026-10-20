# Migrate Claude Code slash commands and skills from Mac to ThinkPad

For someone running Claude Code on a Mac. Run the steps from the Mac; the destination is a ThinkPad running Omarchy v4.

**Prerequisites:** SSH from the Mac reaches the ThinkPad on its hostname or IP. Mac account name `jonas` matches the ThinkPad account name.

**WARNING:** Skills and commands can read local paths, run local tools, and assume local environment (paths, binaries, GitHub tokens). Migrating the `.md` files alone may not bring a fully working skill. Audit each before you trust it.

**NOTE:** Only `~/.claude/commands/` and `~/.claude/skills/` are portable. Do **not** copy `sessions/`, `projects/`, `cache/`, `history.jsonl`, `file-history/`, `paste-cache/`, `shell-snapshots/`, `.credentials.json`, or `settings.json`. Those hold per-machine session data and per-account credentials. Copying them breaks the Claude Code session on at least one side.

## Part A: Inventory what's on the Mac

1. Open a terminal on the Mac.
2. Type `ls -la ~/.claude/commands/` and press `Enter`.

   **Result:** a list of `<name>.md` files, one per slash command.

3. Type `ls -la ~/.claude/skills/` and press `Enter`.

   **Result:** a list of skill directories. Each contains a `SKILL.md`.

4. Note the count in each.

   **Result:** you have a number for each. Use it to verify after the copy.

## Part B: Pick a transport

Use the transport that matches the machine link.

| Transport | Use when |
| :--- | :--- |
| `scripts/migrate-cc-from-mac.sh --host <thinkpad>` | Both machines on the same network. SSH on the ThinkPad is on. One-shot copy with auto-verify. |
| `scp` directly | Same shape, but you write the verification and warning list yourself. |
| `rsync` | Same as scp, but resumable. |
| `git push` then `git clone` | You keep your commands or skills in a private git repo. |
| Manual copy-paste | A handful of small files. |

## Part C: Copy with the bundled script

The script automates Part C, refuses to copy non-portable state, and verifies the counts.

**Prerequisites:** jonas's SSH public key lives in `jonas@<thinkpad-host>:.ssh/authorized_keys`.

1. Open a terminal on the Mac.
2. Type `cd ~/Work/practice-omarchy` and press `Enter`.

   **Result:** the working directory is the local clone of this repo.

3. Type `bash scripts/migrate-cc-from-mac.sh --host <thinkpad-host>` and press `Enter`.

   **Result:** the script copies `~/.claude/commands/` and `~/.claude/skills/`, then prints `ok: counts match. Open Claude Code on <host> and try /<command> for each one.`

4. If SSH asks for the password, type it and press `Enter`.

   **Result:** the script completes after auth.

## Part D: If your commands or skills live in a private git repo

Run push from the Mac. Clone from the ThinkPad later.

On the Mac:

1. `cd` into your commands or skills private repo.
2. Type `git add -A` and press `Enter`.
3. Type `git commit -m "sync before Mac to ThinkPad migration"` and press `Enter`.

   **Result:** the local repo has the latest files committed.

4. Type `git push` and press `Enter`.

   **Result:** the remote has the same files.

On the ThinkPad, after Part C completes:

5. Type `cd ~/.claude/` and press `Enter`.
6. Type `git clone <repo-url> commands` and press `Enter`.

   **Result:** `~/.claude/commands/` is a fresh clone from the remote.

7. Repeat for the skills repo if separate.

## Part E: Verify on the ThinkPad

Run these on the ThinkPad.

1. Type `ls ~/.claude/commands | wc -l` and press `Enter`.
2. Type `ls ~/.claude/skills | wc -l` and press `Enter`.

   **Result:** both numbers match the Mac counts from Part A step 4.

3. Open a new Claude Code session on the ThinkPad.

   **Result:** the prompt is ready.

4. Type each slash command name with a leading `/` (for example `/review-pr`) and press `Enter`.

   **Result:** the command's prompt loads.

5. Ask Claude Code about a topic covered by one of the skills you copied.

   **Result:** the skill's instructions surface when the description matches.

## Part F: Resolve missing dependencies

Some commands or skills assume tools the ThinkPad does not have yet.

1. Open the file or `SKILL.md` for each migrated item.
2. Search the file for tool names and paths.

   **Result:** a list of expected binaries like `gh`, `docker`, `mage`, `jq`, etc.

3. For each, run `which <tool>` on the ThinkPad.

   **Result:** either a path (tool is present) or nothing (tool is missing).

4. Install each missing tool with the Omarchy menu or `pacman`.

   **Result:** the tools are reachable.

5. Edit any hard-coded Mac paths in the `.md` files to match the ThinkPad.

**Done when — Procedure:** verify each item:

1. Every `/command` from the Mac opens Claude Code's prompt on the ThinkPad.
2. Every skill triggers when its topic comes up.
3. No command silently fails on a missing tool.
