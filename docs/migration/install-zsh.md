# Install zsh and switch your login shell

Run this procedure when the [practice plan](../guide/exercise-guide.md) reaches Week 4, Day 4. The `Ctrl+G` widget is zsh-only. Run on the ThinkPad. Bash stays the default everywhere else; the installer is additive.

**Prerequisites:** the ThinkPad runs Omarchy v4. The repo is at `~/Work/practice-omarchy`. Your account is `jonas`. `ccgo` works.

**WARNING:** `chsh` changes your login shell. After step 5 you must sign in again or run `exec zsh` to take effect. The Mac habit keys (`pbcopy`, `brew`, `/opt/homebrew`) do not exist on Omarchy. The installer does not remove them from your existing `~/.zshrc`.

**NOTE:** This procedure only adds. Your `~/.bashrc` and Omarchy's bash setup stay untouched. To go back to bash, repeat step 4 with `/usr/bin/bash`.

## Procedure

1. Open Foot (`Super + Return`).
2. Type `sudo pacman -S --noconfirm zsh` and press `Enter`.
3. Authenticate with your fingerprint or password.

   **Result:** pacman prints `installing zsh...` and ends with `(1/1) Arming ConditionNeedsUpdate...`.

4. Type `chsh -s /usr/bin/zsh jonas` and press `Enter`.

   **Result:** the terminal prints `Password:` or returns silently. `chsh` asks for the password because it edits `/etc/passwd`.

5. Type your login password and press `Enter`.

   **Result:** `chsh` exits 0 and prints nothing.

6. Press `Super + Ctrl + L`. The screen locks.
7. Sign in. Pick `Hyprland` as the session.

   **Result:** the desktop reloads. The next terminal you open uses zsh.

8. Open Foot (`Super + Return`).
9. Type `echo $0` and press `Enter`.

   **Result:** the terminal prints `zsh`.

10. Type `bash ~/Work/practice-omarchy/scripts/practice-omarchy-setup.sh --shell zsh` and press `Enter`.

    **Result:** the installer prints `ok: appended block 'zsh' to /home/jonas/.zshrc`. If the block already exists, it prints `skip: block 'zsh' already in /home/jonas/.zshrc`.

11. Type `grep -n practice-omarchy ~/.zshrc` and press `Enter`.

    **Result:** the output lists two lines: `# >>> practice-omarchy:zsh >>>` and `# <<< practice-omarchy:zsh <<<`, with their line numbers.

12. Type `printf 'source ~/Work/practice-omarchy/scripts/ai-shell.zsh\n' >> ~/.zshrc` and press `Enter`.

    **Result:** `printf` exits 0 and prints nothing.

13. Type `exec zsh` and press `Enter`.

    **Result:** the same shell is now zsh. The prompt may change. `Ctrl + R` now uses `atuin`.

14. Press `Ctrl + G`. The status line shows `ai-shell ready`. Type `list hidden files` and press `Enter`.

    **Result:** the widget inserts a command, often `find . -name '.*' -type f`.

15. Type `echo $SHELL` and press `Enter`.

    **Result:** the terminal prints `/usr/bin/zsh`.

## If a step fails

| Symptom | Cause | Action |
| :--- | :--- | :--- |
| `pacman` says `package not found` | mirror out of date | Run `sudo pacman -Syu`, then repeat step 2. |
| `chsh: user 'jonas' does not exist` | wrong user name | Run `whoami`, use that name in step 4. |
| Step 10 prints `ERROR: --shell must be bash or zsh` | typo | Re-run step 10 with `--shell zsh` (lowercase). |
| Step 11 shows no `practice-omarchy:zsh` block | the installer's bash branch ran by mistake | Re-run step 10 with `--shell zsh` explicitly. |
| Step 13 still shows bash | the parent shell cached bash | Close the terminal and start a fresh one. |
| `Ctrl + G` does nothing | `ai-shell.zsh` not sourced | Check `~/.zshrc` for `source ~/Work/practice-omarchy/scripts/ai-shell.zsh`. Add it if missing. |

## To go back to bash

1. Type `chsh -s /usr/bin/bash jonas` and press `Enter`.
2. Type your password and press `Enter`.
3. Sign out and sign in.

**Result:** new terminals open in bash. Your `~/.zshrc` stays on disk and stays untouched.