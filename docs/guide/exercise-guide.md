# Four-week practice plan

For someone who already works in a terminal on macOS and is moving to Omarchy.
Target: **Omarchy v4**. Keys come from [`docs/reference/keybindings.md`](../reference/keybindings.md);
if you blank on one, `Super + K` lists them all.

**How it works.** About 15 minutes a day. Each week has a goal, daily tasks and a "done when" test you can
check without anyone grading you. Copy this file somewhere private and tick the boxes there.

**The one rule that makes it stick: no mouse for the week's skills.** Touch the trackpad and you
have not practiced that skill. The mouse is your fallback, not your tool.

**Daily warm-up (2 minutes).** `python3 scripts/practice-omarchy-cli.py -n 10`
(add `--section tmux` to drill one area). Missed items are listed at the end; do those with your
fingers once, not just your eyes.

Before week 1, finish the [migration steps](../migration/README.md) so your tools and files are on the machine.

---

## Week 1: Move around without a mouse

Goal: launch, switch and close things using only `Super`.

- [ ] Day 1: Open a terminal (`Super + Return`), a browser (`Super + Shift + Return`) and the file manager (`Super + Shift + F`). Watch them tile.
- [ ] Day 2: Jump between workspaces `Super + 1/2/3/4`; send a window to another with `Super + Shift + 1/2/3/4`.
- [ ] Day 3: Move focus with `Super + Arrow`, swap windows with `Super + Shift + Arrow`, flip a split with `Super + J`.
- [ ] Day 4: Copy and paste with `Super + C` / `Super + V`, including inside the terminal. Open clipboard history with `Super + Ctrl + V`.
- [ ] Day 5: Close a window with `Super + W`. Toggle one floating with `Super + T`. (Mac habit: `Super + Q` is not a default Omarchy binding on this version.)
- [ ] Day 6: Take a screenshot (`Print Screen`), then extract text from a screen region (`Super + Ctrl + Print Screen`) and paste it.
- [ ] Day 7: Open the Omarchy menu (`Super + Space`) and change the theme without the mouse.

**Done when:** you can open a terminal, a browser and Obsidian on three different workspaces and
return to the first one in under 15 seconds, hands on the keyboard.

## Week 2: Terminal and tmux

Goal: live inside tmux; one session per project.

- [ ] Day 1: Open `Super + Alt + Return`. Split with `Prefix + v` and `Prefix + h`; move with `Ctrl + Alt + Arrows`. (Prefix is `Ctrl + Space`.)
- [ ] Day 2: Windows: `Prefix + c`, `Alt + 1-9`, rename with `Prefix + r`.
- [ ] Day 3: Sessions: create `Prefix + C`, list `Prefix + s`, detach `Prefix + d`, then reattach with `tmux attach`.
- [ ] Day 4: Run `tdl c` (editor + agent + shell). Close it, run `tds`.
- [ ] Day 5: In a folder of projects, run `tdlm c` and hop between windows with `Alt + 1-9`.
- [ ] Day 6: After installing the plugins (`Prefix + I`), open SessionX (`Prefix + o`) and Floax (`Prefix + p`).
- [ ] Day 7: Copy mode: `Prefix + [`, `v` to select, `y` to copy, paste with `Super + V`.

**Done when:** you detach, close the terminal, open a new one and return to exactly where you were.

## Week 3: Shell tools, editor, git

Goal: find things and change things fast.

- [ ] Day 1: `ff` to fuzzy-find a file with preview. `Ctrl + R` to find an old command.
- [ ] Day 2: `z <partial>` and `zi` to jump around; `rg <pattern>` to search; `fd <name>` to find files; `tldr tar`.
- [ ] Day 3: Open Neovim (`Super + Shift + N`). `Space Space` to open a file, `Space S G` to search contents.
- [ ] Day 4: In Neovim: `Space E` sidebar, `Shift + H/L` between tabs, `Space B D` to close one.
- [ ] Day 5: Make a change, stage and commit it in LazyGit (`Space G G`).
- [ ] Day 6: `Super + Shift + D` (LazyDocker) with a container running; stop and start it.
- [ ] Day 7: Redo days 1 to 6 as one task: find a bug with `rg`, fix it in Neovim, commit with LazyGit.

**Done when:** you fix a small bug in an existing project without leaving the terminal and without the mouse.

## Week 4: Agents and making it yours

Goal: use AI agents in the layouts, then change Omarchy itself.

- [ ] Day 1: Start your agent with `c` (OpenCode) or `cx` (Claude Code) in a project.
- [ ] Day 2: `icx` / `tdl c cx`: two agents side by side. Give them different jobs.
- [ ] Day 3: `tsl 4 c`: four agents in a grid. Notice who is idle; close the rest.
- [ ] Day 4: If you use zsh: source `scripts/ai-shell.zsh`, type a request, press `Ctrl + G`. See [ai-shell.md](../reference/ai-shell.md).
- [ ] Day 5: Add one keybinding in `~/.config/hypr/bindings.lua` using `Super + K` to check it is free.
- [ ] Day 6: Put your dotfiles under version control (the manual suggests GNU Stow).
- [ ] Day 7: Graduation: clone a repo, `tdl c`, have the agent make a change, review the diff with `tds`, commit with LazyGit, push. No mouse.

**Done when:** you can do the graduation task, then repeat the whole thing from memory next week.

---

## Rules for yourself

- Missed a key twice in the quiz? Write it on a sticky note on the monitor for a week.
- Fix friction by editing config files, not by going back to the mouse. Omarchy exposes edits under
  the menu: Setup.
- When something feels slower than macOS, give it two weeks before judging. The Omarchy manual says the same.
