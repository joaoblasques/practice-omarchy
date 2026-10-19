# ThinkPad setup procedures

Written in ASD-STE100 style: one action in each step, short sentences, same word for same thing.
Do the parts in order. Do not skip a "Result" check.

**NOTE:** Omarchy version 4 is the target. All steps are untested on the ThinkPad until you do them.
If a step fails, send me the step number and the exact text on the screen.

**NOTE:** This procedure does not use the OpenCode program. It uses Claude Code with the OpenCode Go API.

---

## Procedure 1: Run Claude Code on Go (`ccgo`)

Time: about 25 minutes. This procedure does not need AI help.

**Prerequisites:** The ThinkPad runs Omarchy. The ThinkPad has internet. You have a payment card.

**WARNING:** Do not share the API key. Do not put the key in a Git folder.

### Part A: Get the API key

1. Open the browser. Press `Super + Shift + Return`.
2. Go to `https://opencode.ai`. Find the link to the Console. Sign in.
3. Subscribe to **Go**. The price is $10 each month. Add your billing details.
4. Copy the API key. Keep the browser open.

### Part B: Get the repo

5. Open a terminal. Press `Super + Return`.
6. Check the GitHub tool. Type `gh --version` and press `Enter`.
7. If the terminal shows `command not found`, type `omarchy pkg add github-cli` and press `Enter`.
8. Log in to GitHub. Type `gh auth login` and press `Enter`.
9. Answer the questions in this order:
   1. Select **GitHub.com**.
   2. Select **HTTPS**.
   3. Select **Yes** to authenticate Git.
   4. Select **Login with a web browser**.
10. Copy the one-time code that the terminal shows. Press `Enter`.
11. In the browser, paste the code. Approve the login.
12. Check the login. Type `gh auth status` and press `Enter`.

    **Result:** The terminal shows `Logged in to github.com`.
13. Go to the work folder. Type `cd ~/Work` and press `Enter`.
14. Get the repo. Type `gh repo clone joaoblasques/practice-omarchy` and press `Enter`.
15. Type `cd practice-omarchy` and press `Enter`.
16. Check the script. Type `bash -n scripts/ccgo.sh && echo OK` and press `Enter`.

    **Result:** The terminal shows `OK`.

### Part C: Remove old settings

**CAUTION:** Remove only the lines that contain `ANTHROPIC`. Do not delete files.

17. Check the shell variables. Type `env | rg '^ANTHROPIC'` and press `Enter`.
18. If the terminal shows lines, open `~/.bashrc`. Type `nvim ~/.bashrc` and press `Enter`.
19. Delete each line that contains `ANTHROPIC`. Save the file. Type `:wq` and press `Enter`.
20. Check the Claude Code settings. Type `rg ANTHROPIC ~/.claude/settings.json` and press `Enter`.
21. If the terminal shows lines, open the file. Type `nvim ~/.claude/settings.json` and press `Enter`.
22. Delete the `ANTHROPIC` lines from the `env` block. Save the file. Type `:wq` and press `Enter`.
23. Close the terminal. Open a new terminal. Press `Super + Return`.
24. Do step 17 again.

    **Result:** The terminal shows no lines.

### Part D: Save the key

25. Type `mkdir -p ~/.config/opencode-go && chmod 700 ~/.config/opencode-go` and press `Enter`.
26. Type this command. Press `Enter`. Do not type the key yet.

    ```bash
    read -rs -p "Go key: " k && printf '%s' "$k" > ~/.config/opencode-go/key && chmod 600 ~/.config/opencode-go/key; unset k
    ```
27. Paste the key. Press `Super + V`. The screen shows nothing. This is normal. Press `Enter`.
28. Check the file. Type `test -s ~/.config/opencode-go/key && echo saved` and press `Enter`.

    **Result:** The terminal shows `saved`.

### Part E: Load the script

29. Check your shell. Type `echo $SHELL` and press `Enter`.
30. If the terminal shows `bash`, type this command. Press `Enter`.

    ```bash
    echo 'source ~/Work/practice-omarchy/scripts/ccgo.sh' >> ~/.bashrc
    ```
31. If the terminal shows `zsh`, use `~/.zshrc` in place of `~/.bashrc` in step 30.
32. Close the terminal. Open a new terminal. Press `Super + Return`.
33. Type `type ccgo ccgo-check` and press `Enter`.

    **Result:** The terminal shows two functions.

### Part F: Test and start

34. Check Claude Code. Type `claude --version` and press `Enter`.

    **NOTE:** On the first run, Omarchy downloads Claude Code. Wait until the version shows.
35. Type `ccgo-check` and press `Enter`.

    **Result:** The terminal shows four lines. Each line starts with `ok`.
36. Go to a test folder. Type `mkdir -p ~/Work/test && cd ~/Work/test` and press `Enter`.
37. Type `ccgo` and press `Enter`.
38. If Claude Code asks to use the API key, select **Yes**.
39. If Claude Code asks for a login, do not log in. Close it. Do Parts C to E again.
40. In Claude Code, type `/status` and press `Enter`.

    **Result:** The screen shows the base URL `opencode.ai`.
41. Type `Say OK` and press `Enter`.

    **Result:** The model replies. You have AI on the ThinkPad.

**NOTE:** The screen can show "API Usage Billing". This is normal for `ccgo`. The cost is your Go subscription.

**NOTE:** The screen can show a 403 error for remote managed settings. Claude Code continues without them. This is normal.

**WARNING:** Do not use `cx` with Go. The `cx` command starts in auto-approve mode and uses your Anthropic login.

### If a step fails

| Symptom | Cause | Action |
| :--- | :--- | :--- |
| `ccgo-check` shows `HTTP 401` | The key is wrong | Copy the key again from the Console. Do Part D again. |
| `ccgo-check` shows `HTTP 404` | Model name changed | Read `https://opencode.ai/docs/go/`. Set `CCGO_SONNET` to a name on that page. |
| `ccgo-check` shows `LIMIT` | The model budget is used | Run `ccgo --model minimax-m3`. |
| `ccgo` shows `MissingSessionID` | Claude Code is old | Run `mise upgrade claude`. Start `ccgo` again. |
| `ccgo: no key` | The key file is missing | Do Part D again. |
| `type` shows `not found` | The script did not load | Do Part E again. Check the path in `~/.bashrc`. |
| `claude: command not found` | Omarchy did not install it | Run `omarchy update`. Do step 34 again. |

If the failure remains, send me the step number and the exact error text.

---

## Planned procedures

- Procedure 2: Run the installer. First use `--dry-run`.
- Procedure 3: Bring your keys and files. See [bring-your-stuff.md](bring-your-stuff.md).
- Procedure 4: Start the [four-week practice plan](../guide/exercise-guide.md).
