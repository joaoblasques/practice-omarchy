# ThinkPad setup procedures

Written in ASD-STE100 style: one action in each step, short sentences, same word for same thing.
Do the steps in order. Do not skip a "Result" check.

**NOTE:** Omarchy version 4 is the target. All steps are untested on the ThinkPad until you do them.
If a step fails, send me the step number and the exact text on the screen.

**NOTE:** This procedure does not use the OpenCode program. It uses Claude Code with the OpenCode Go API.

---

## Procedure 1: Run Claude Code on Go (`ccgo`)

Time: about 20 minutes. This procedure does not need AI help.

**Prerequisites:** The ThinkPad runs Omarchy. The ThinkPad has internet. You have a payment card.

**WARNING:** Do not share the API key. Do not put the key in a Git folder.

### Part A: Get the API key

1. Open the browser. Press `Super + Shift + Return`.
2. Go to `https://opencode.ai`. Find the link to the Console. Sign in.
3. Subscribe to **Go**. The price is $10 each month. Add your billing details.
4. Copy the API key. Keep the browser open.

### Part B: Get the repo

5. Open a terminal. Press `Super + Return`.
6. Type `gh --version` and press `Enter`.
7. If the terminal shows `command not found`, type `omarchy pkg add github-cli` and press `Enter`.
8. Type `gh auth login` and press `Enter`.
9. Answer the questions in this order:
   1. Select **GitHub.com**.
   2. Select **HTTPS**.
   3. Select **Yes** to authenticate Git.
   4. Select **Login with a web browser**.
10. Copy the one-time code that the terminal shows. Press `Enter`.
11. In the browser, paste the code. Approve the login.
12. Type `gh auth status` and press `Enter`.

    **Result:** The terminal shows `Logged in to github.com`.
13. Type `cd ~/Work` and press `Enter`.
14. Type `gh repo clone joaoblasques/practice-omarchy` and press `Enter`.
15. Type `cd practice-omarchy` and press `Enter`.
16. Type `bash -n scripts/ccgo.sh && echo OK` and press `Enter`.

    **Result:** The terminal shows `OK`.

### Part C: Run the setup script

The script finds old `ANTHROPIC` settings, saves the key, loads `ccgo`, and tests the key.
The script asks before it changes a file. It saves a backup of each shell file that it edits.

17. Type `cd ~/Work/practice-omarchy && git pull` and press `Enter`.

    **Result:** The terminal shows `Already up to date` or a list of changed files.
18. Type `bash scripts/ccgo-setup.sh` and press `Enter`.
19. If the script asks `Comment out these lines?`, type `y` and press `Enter`.
20. When the script asks for the key, press `Super + V`. The screen shows nothing. This is normal. Press `Enter`.

    **Result:** The terminal shows four lines that start with `ok`. It then shows `Result: all four models work.`
21. Open a new terminal. Press `Super + Return`.

### Part D: Start Claude Code

22. Type `mkdir -p ~/Work/test && cd ~/Work/test && ccgo` and press `Enter`.
23. If Claude Code asks to use the API key, select **Yes**.
24. If Claude Code asks for a login, do not log in. Close it. Send me the screen text.
25. In Claude Code, type `/status` and press `Enter`.

    **Result:** The screen shows the base URL `opencode.ai`.
26. Type `Say OK` and press `Enter`.

    **Result:** The model replies. You have AI on the ThinkPad.

**NOTE:** The screen can show "API Usage Billing". This is normal for `ccgo`. The cost is your Go subscription.

**NOTE:** The screen can show a 403 error for remote managed settings. Claude Code continues without them. This is normal.

**WARNING:** Do not use `cx` with Go. The `cx` command starts in auto-approve mode and uses your Anthropic login.

### If a step fails

| Symptom | Cause | Action |
| :--- | :--- | :--- |
| Script shows `STOP` and names `settings.json` | Old settings override the key | Open the file. Delete the `ANTHROPIC` lines. Do step 18 again. |
| Script shows `HTTP 401` | The key is wrong | Copy the key again from the Console. Do step 18 again. Answer `y` to replace the key. |
| Script shows `HTTP 404` | Model name changed | Read `https://opencode.ai/docs/go/`. Send me the model names. |
| Script shows `LIMIT` | The model budget is used | Run `ccgo --model minimax-m3`. |
| `ccgo` shows `MissingSessionID` | Claude Code is old | Run `mise upgrade claude`. Start `ccgo` again. |
| `ccgo: command not found` | The terminal is old | Open a new terminal. Press `Super + Return`. |
| `claude: command not found` | Omarchy did not install it | Run `omarchy update`. Do step 22 again. |
| `git pull` shows an error | Git is not ready | Send me the full screen text. |

If the failure remains, send me the step number and the exact error text.

---

## Appendix: Manual steps (use only if the script fails)

These steps do the same work as Part C. Use the label M1, M2, and so on.

**CAUTION:** Remove only the lines that contain `ANTHROPIC`. Do not delete files.

- M1. Type `env | rg '^ANTHROPIC'` and press `Enter`.
- M2. If the terminal shows lines, type `nvim ~/.bashrc` and press `Enter`. Delete each line that contains `ANTHROPIC`. Type `:wq` and press `Enter`.
- M3. Type `rg ANTHROPIC ~/.claude/settings.json` and press `Enter`.
- M4. If the terminal shows lines, type `nvim ~/.claude/settings.json` and press `Enter`. Delete the `ANTHROPIC` lines from the `env` block. Type `:wq` and press `Enter`.
- M5. Type `mkdir -p ~/.config/opencode-go && chmod 700 ~/.config/opencode-go` and press `Enter`.
- M6. Type this command. Press `Enter`. Do not type the key yet.

  ```bash
  read -rs -p "Go key: " k && printf '%s' "$k" > ~/.config/opencode-go/key && chmod 600 ~/.config/opencode-go/key; unset k
  ```
- M7. Paste the key. Press `Super + V`. The screen shows nothing. This is normal. Press `Enter`.
- M8. Type `echo $SHELL` and press `Enter`.
- M9. If the terminal shows `bash`, type this command. Press `Enter`. If the terminal shows `zsh`, use `~/.zshrc`.

  ```bash
  echo 'source ~/Work/practice-omarchy/scripts/ccgo.sh' >> ~/.bashrc
  ```
- M10. Open a new terminal. Type `ccgo-check` and press `Enter`.

  **Result:** The terminal shows four lines that start with `ok`.

Then do Part D.

---

## Planned procedures

- Procedure 2: Run the installer. First use `--dry-run`.
- Procedure 3: Bring your keys and files. See [bring-your-stuff.md](bring-your-stuff.md).
- Procedure 4: Start the [four-week practice plan](../guide/exercise-guide.md).
