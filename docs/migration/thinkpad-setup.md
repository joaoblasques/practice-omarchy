# ThinkPad setup procedures

Written in ASD-STE100 style: one action in each step, short sentences, same word for same thing.
Do the procedures in order. Do not skip a "Result" check.

**NOTE:** Omarchy version 4 is the target. All steps are untested on the ThinkPad until you do them.
Tell me which step fails and what the screen shows.

---

## Procedure 1: Get AI on the ThinkPad

Time: about 10 minutes.

**Prerequisites:** The ThinkPad runs Omarchy. The ThinkPad has internet. You have a payment card.

**WARNING:** Do not share the API key. Do not put the key in a Git folder.

1. Open the browser. Press `Super + Shift + Return`.
2. Go to `https://opencode.ai`. Find the link to the Console. Sign in.
3. Subscribe to **Go**. The price is $10 each month. Add your billing details.
4. Copy the API key.
5. Open a terminal. Press `Super + Return`.
6. Go to the work folder. Type `cd ~/Work` and press `Enter`.
7. Start OpenCode. Type `opencode` and press `Enter`.

   **NOTE:** Do not use `c` for this step. The `c` command starts OpenCode in auto-approve mode.

   **NOTE:** On the first run, OpenCode downloads files. Wait until the screen is ready.
8. In OpenCode, type `/connect` and press `Enter`.
9. Select **OpenCode Go**.
10. Paste the API key. Press `Super + V`. Press `Enter`.
11. Type `/models` and press `Enter`.
12. Select `qwen3.8-flash`.

    **NOTE:** This model has the largest request budget of the strong models. The budget is about 27,000 requests each month.
13. Type `Say OK` and press `Enter`.

**Result:** The model replies. You have AI on the ThinkPad.

### If a step fails

| Symptom | Cause | Action |
| :--- | :--- | :--- |
| `opencode: command not found` | Omarchy did not install it yet | Run `omarchy update`. Do step 7 again. |
| Paste does not work | Wrong paste key | Press `Ctrl + Shift + V`. |
| Error 401 | The key is wrong | Copy the key again from the Console. Do steps 8 to 10 again. |
| Model is not in the list | The Go list changed | Select a model with `Flash` in the name. |

---

## Procedure 2: Run Claude Code on Go (`ccgo`)

Time: about 15 minutes. Do Procedure 1 first. Then you can ask OpenCode for help.

**Prerequisites:** Procedure 1 gives the result. You have the Go API key.

### Part A: Get the repo

1. Open a terminal. Press `Super + Return`.
2. Check the GitHub tool. Type `gh --version` and press `Enter`.
3. If the terminal shows `command not found`, type `omarchy pkg add github-cli` and press `Enter`.
4. Log in to GitHub. Type `gh auth login` and press `Enter`.
5. Answer the questions in this order:
   1. Select **GitHub.com**.
   2. Select **HTTPS**.
   3. Select **Yes** to authenticate Git.
   4. Select **Login with a web browser**.
6. Copy the one-time code that the terminal shows. Press `Enter`.
7. In the browser, paste the code. Approve the login.
8. Check the login. Type `gh auth status` and press `Enter`.

   **Result:** The terminal shows `Logged in to github.com`.
9. Go to the work folder. Type `cd ~/Work` and press `Enter`.
10. Get the repo. Type `gh repo clone joaoblasques/practice-omarchy` and press `Enter`.
11. Type `cd practice-omarchy` and press `Enter`.
12. Check the script. Type `bash -n scripts/ccgo.sh && echo OK` and press `Enter`.

    **Result:** The terminal shows `OK`.

### Part B: Remove old settings

**CAUTION:** Remove only the lines that contain `ANTHROPIC`. Do not delete files.

13. Check the shell variables. Type `env | rg '^ANTHROPIC'` and press `Enter`.
14. If the terminal shows lines, open `~/.bashrc`. Type `nvim ~/.bashrc` and press `Enter`.
15. Delete each line that contains `ANTHROPIC`. Save the file. Type `:wq` and press `Enter`.
16. Check the Claude Code settings. Type `rg ANTHROPIC ~/.claude/settings.json` and press `Enter`.
17. If the terminal shows lines, open the file. Type `nvim ~/.claude/settings.json` and press `Enter`.
18. Delete the `ANTHROPIC` lines from the `env` block. Save the file. Type `:wq` and press `Enter`.
19. Close the terminal. Open a new terminal. Press `Super + Return`.
20. Do step 13 again.

    **Result:** The terminal shows no lines.

### Part C: Save the key

21. Type `mkdir -p ~/.config/opencode-go && chmod 700 ~/.config/opencode-go` and press `Enter`.
22. Type this command. Press `Enter`. Do not type the key yet.

    ```bash
    read -rs -p "Go key: " k && printf '%s' "$k" > ~/.config/opencode-go/key && chmod 600 ~/.config/opencode-go/key; unset k
    ```
23. Paste the key. Press `Super + V`. The screen shows nothing. This is normal. Press `Enter`.
24. Check the file. Type `test -s ~/.config/opencode-go/key && echo saved` and press `Enter`.

    **Result:** The terminal shows `saved`.

### Part D: Load the script

25. Check your shell. Type `echo $SHELL` and press `Enter`.
26. If the terminal shows `bash`, type this command. Press `Enter`.

    ```bash
    echo 'source ~/Work/practice-omarchy/scripts/ccgo.sh' >> ~/.bashrc
    ```
27. If the terminal shows `zsh`, use `~/.zshrc` in place of `~/.bashrc` in step 26.
28. Close the terminal. Open a new terminal. Press `Super + Return`.
29. Type `type ccgo ccgo-check` and press `Enter`.

    **Result:** The terminal shows two functions.

### Part E: Test and start

30. Type `ccgo-check` and press `Enter`.

    **Result:** The terminal shows four lines. Each line starts with `ok`.
31. Go to a test folder. Type `mkdir -p ~/Work/test && cd ~/Work/test` and press `Enter`.
32. Type `ccgo` and press `Enter`.
33. If Claude Code asks to use the API key, select **Yes**.
34. In Claude Code, type `/status` and press `Enter`.

    **Result:** The screen shows the base URL `opencode.ai`.
35. Type `Say OK` and press `Enter`.

    **Result:** The model replies.

**NOTE:** The screen can show "API Usage Billing". This is normal for `ccgo`. The cost is your Go subscription.

**NOTE:** The screen can show a 403 error for remote managed settings. Claude Code continues without them. This is normal.

**WARNING:** Do not use `cx` with Go. The `cx` command starts in auto-approve mode and uses your Anthropic login.

### If a step fails

| Symptom | Cause | Action |
| :--- | :--- | :--- |
| `ccgo-check` shows `HTTP 401` | The key is wrong | Copy the key again from the Console. Do Part C again. |
| `ccgo-check` shows `HTTP 404` | Model name changed | Read `https://opencode.ai/docs/go/`. Set `CCGO_SONNET` to a name on that page. |
| `ccgo-check` shows `LIMIT` | The model budget is used | Run `ccgo --model minimax-m3`. |
| `ccgo` shows `MissingSessionID` | Claude Code is old | Run `mise upgrade claude`. Start `ccgo` again. |
| `ccgo: no key` | The key file is missing | Do Part C again. |
| `type` shows `not found` | The script did not load | Do Part D again. Check the path in `~/.bashrc`. |

If the failure remains, run `opencode` (Procedure 1). Ask it to help. Give it the exact error text.

---

## Planned procedures

- Procedure 3: Run the installer. First use `--dry-run`.
- Procedure 4: Bring your keys and files. See [bring-your-stuff.md](bring-your-stuff.md).
- Procedure 5: Start the [four-week practice plan](../guide/exercise-guide.md).
