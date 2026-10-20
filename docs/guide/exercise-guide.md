# Four-week practice plan

For someone who already works in a terminal on macOS and is moving to Omarchy.
Target: **Omarchy v4**. Keys come from
[`docs/reference/keybindings.md`](../reference/keybindings.md); if you blank on
one, `Super + K` lists them all.

**Prerequisites:** Omarchy v4 is installed. The installer
(`bash scripts/practice-omarchy-setup.sh`) has run. Migration steps from
[`docs/migration/README.md`](../migration/README.md) are done. bash is your
login shell.

**WARNING:** No mouse for the week's skills. The mouse is a fallback, not a tool.

**NOTE:** Stay on bash for Weeks 1 to 3. Switch to zsh only when Week 4, Day 4
asks for it. Follow [Procedure 6](../migration/install-zsh.md) for the switch.
The installer is additive and does not touch your existing `~/.zshrc`.

**NOTE:** Plan length is about fifteen minutes per day. Each week has a goal,
daily tasks, and a "done when" check you can run yourself. Copy the progress
checklist at the bottom into a private note. Tick the boxes there.

**NOTE:** When something feels slower than macOS, give it two weeks before
judging. The Omarchy manual says the same.

## Daily warm-up (two minutes)

1. Open a terminal.
2. Type `python3 ~/Work/practice-omarchy/scripts/practice-omarchy-cli.py -n 10` and press `Enter`.
3. Read the missed items at the bottom.

   **Result:** the quiz prints your score and any wrong items.

4. Do each missed item with your fingers once. Not just your eyes.

   **Result:** the same quiz re-run shows fewer misses.

To drill one area, add `--section <name>` (for example `--section tmux`).

---

## Week 1: Move around without a mouse

**Goal:** launch, switch, and close things with `Super` only.

### Day 1 — Launch three apps with Super

1. Press `Super + Return`. A terminal opens.
2. Press `Super + Shift + Return`. A browser opens.
3. Press `Super + Shift + F`. The file manager opens.

   **Result:** three windows appear and tile automatically.

### Day 2 — Move between workspaces

1. Press `Super + 1`. Workspace 1 is active.
2. Press `Super + 2`. Workspace 2 is active.
3. Press `Super + 3`. Workspace 3 is active.
4. Press `Super + 4`. Workspace 4 is active.
5. Press `Super + Shift + 1`. The active window moves to workspace 1.

   **Result:** you can move windows between workspaces with the keyboard.

### Day 3 — Move and swap windows

1. Press `Super + Right`. Focus moves to the right window.
2. Press `Super + Left`. Focus moves to the left window.
3. Press `Super + Shift + Right`. The active window swaps right.
4. Press `Super + Shift + Left`. The active window swaps left.
5. Press `Super + J`. The active split flips.

   **Result:** you can rearrange a split layout with the keyboard.

### Day 4 — Clipboard

1. Select text in any app.
2. Press `Super + C`. The selection copies.
3. Open a terminal. Press `Super + V`. The text pastes.
4. Press `Super + Ctrl + V`. The clipboard history opens.
5. Pick an older entry.

   **Result:** you can copy between apps and inside the terminal with `Super + C / V`.

### Day 5 — Close and float

1. Press `Super + W`. A window closes.
2. Press `Super + T`. The active window toggles to floating.
3. Press `Super + T` again. The window returns to tile.

   **NOTE:** `Super + Q` is not a default Omarchy binding on this version. Use `Super + W`.

   **Result:** you can close windows and toggle float with the keyboard.

### Day 6 — Screenshots and OCR

1. Press `Print Screen`. A full-screen screenshot saves.
2. Press `Super + Ctrl + Print Screen`. A region selector appears.
3. Drag a box. Press `Enter`. The selected text goes to the clipboard.
4. Press `Super + V` in a terminal. The text pastes.

   **Result:** you can grab an image and the text from any screen region.

### Day 7 — Open the Omarchy menu and change theme

1. Press `Super + Space`. The Omarchy menu opens.
2. Type `theme`. The theme picker shows.
3. Pick a different theme. Press `Enter`.

   **Result:** the desktop background, bar, and terminal palette change.

### Day 8 — Toggles

**Goal:** change Omarchy's appearance and runtime state with the keyboard, with no menu clicks.

1. Press `Super + Shift + Space`. The top bar hides.
2. Press `Super + Shift + Space` again. The top bar reappears.

   **Result:** the top bar toggles on and off with one chord.

3. Press `Super + Shift + Backspace`. The window gaps shrink to zero.
4. Press `Super + Shift + Backspace` again. The window gaps return.

   **Result:** you can remove the visual gaps between windows without the menu.

5. Press `Super + Ctrl + N`. The screen tints warmer.
6. Press `Super + Ctrl + N` again. The screen tint returns to neutral.

   **Result:** nightlight toggles on and off with one chord.

7. Press `Super + Ctrl + O`. The toggle menu opens.
8. Press `Escape`. The toggle menu closes.

   **Result:** the toggle menu shows the same toggles and a few more.

9. Press `Super + G` on a tiled window. The window joins a group.
10. Press `Super + G` again. The window leaves the group.

    **Result:** window grouping toggles with one chord.

**Done when — Week 1:** verify each item:

1. A terminal, a browser, and a notes app are open.
2. Each app sits on a different workspace.
3. You return to workspace 1 in under fifteen seconds.
4. Hands stay on the keyboard during steps 1 to 3.
5. Each Day 8 toggle changes state and stays in the new state.

---

## Week 2: Terminal and tmux

**Goal:** live inside tmux. One session per project.

**NOTE:** the tmux prefix is `Ctrl + Space`. Press it before each tmux command.

### Day 1 — Splits and focus

1. Press `Super + Alt + Return`. A floating terminal opens.
2. Press `Prefix + v`. The terminal splits vertically.
3. Press `Prefix + h`. The terminal splits horizontally.
4. Press `Ctrl + Alt + Right`. Focus moves to the right pane.

   **Result:** you can build a two-pane layout with the keyboard.

### Day 2 — Windows

1. Press `Prefix + c`. A new tmux window opens.
2. Press `Alt + 1`. Window 1 is active.
3. Press `Alt + 2`. Window 2 is active.
4. Press `Prefix + r`. Rename the current window.

   **Result:** you can add, switch, and rename tmux windows.

### Day 3 — Sessions

1. Press `Prefix + Shift + C`. A new named session prompts.
2. Type a name and press `Enter`. The new session opens.
3. Press `Prefix + s`. The session picker opens.
4. Press `Prefix + d`. The session detaches.
5. Type `tmux attach -t <name>` and press `Enter`. The session reattaches.

   **Result:** you can create, list, detach, and reattach sessions.

### Day 4 — tdl and tds

1. Type `tdl c` and press `Enter`. The editor + agent + shell layout opens.
2. Use the layout's default keybinds (see `Prefix + ?`).
3. Close the layout.
4. Type `tds` and press `Enter`. The single-pane version opens.

   **Result:** `tdl c` opens the three-pane layout. `tds` opens the single-pane one.

### Day 5 — tdlm in a projects folder

1. `cd` into a folder that holds several project repos.
2. Type `tdlm c` and press `Enter`.
3. Press `Alt + 1` through `Alt + 9`. Each tmux window holds a different project.

   **Result:** one tmux window per project, opened by the layout manager.

### Day 6 — Plugins (sessionx and floax)

1. Press `Prefix + I`. tmux installs its plugins.
2. Press `Prefix + o`. SessionX opens. Pick a session. Press `Enter`.
3. Press `Prefix + p`. Floax opens. Pick a window. Press `Enter`.

   **Result:** both plugins appear in the popup after `Prefix + I`.

### Day 7 — Copy mode

1. Press `Prefix + [`. Copy mode starts.
2. Press `v`. Visual selection starts.
3. Move with the arrow keys. Press `y`. The selection copies.
4. Open another pane. Press `Super + V`. The selection pastes.

   **Result:** you can copy text between tmux panes with the keyboard.

**Done when — Week 2:** verify each item:

1. You detach with `Prefix + d`.
2. You close the terminal app.
3. You open a new terminal and run `tmux attach`.
4. You return to the same pane you left.

---

## Week 3: Shell tools, editor, git

**Goal:** find things and change things fast.

### Day 1 — ff and Ctrl-R

1. Type `ff` and press `Enter`. The file picker opens.
2. Type a partial filename. Pick a result. Press `Enter`.
3. Press `Ctrl + R`. The reverse-search prompt opens.
4. Type a few characters. Press `Enter` on the chosen command.

   **Result:** `ff` opens files. `Ctrl + R` runs older commands.

### Day 2 — Jump and search

1. Type `z <partial>` of a directory you visit often. Press `Enter`.
2. Type `zi` and press `Enter`. Pick a directory.
3. Type `rg <pattern>` and press `Enter`. The matches print.
4. Type `fd <name>` and press `Enter`. The file names print.
5. Type `tldr tar` and press `Enter`. A short tar manual prints.

   **Result:** you can move around and search with the keyboard.

### Day 3 — Neovim (LazyVim) file and search

1. Press `Super + Shift + N`. Neovim opens.
2. Press `Space Space`. The file picker shows.
3. Type a filename. Press `Enter`. The file opens in a buffer.
4. Press `Space S G`. The content search prompt opens.
5. Type a string. Press `Enter`. The matches highlight.

   **Result:** you can open files and search inside them with the leader key.

### Day 4 — Neovim sidebar, tabs, close

1. Press `Space E`. The file sidebar opens.
2. Press `Shift + H`. The tab strip moves left.
3. Press `Shift + L`. The tab strip moves right.
4. Press `Space B D`. The active buffer closes.

   **Result:** you can manage Neovim buffers from the keyboard.

### Day 5 — LazyGit

1. In a git repo, press `Space G G`. LazyGit opens.
2. Edit a file. Save it.
3. In LazyGit, press `s` on the changed file. The change stages.
4. Press `c`. The commit message prompt opens.
5. Type a message. Press `Enter`. The commit lands.

   **Result:** you can stage and commit from LazyGit with the keyboard.

### Day 6 — LazyDocker

1. Start a Docker container (for example `docker run -d -p 8080:80 nginx`).
2. Press `Super + Shift + D`. LazyDocker opens.
3. Pick the running container. Press `s`. The container stops.
4. Press `r`. The container restarts.

   **Result:** you can stop and start containers from LazyDocker.

### Day 7 — One-task redo

1. Pick a real bug in a known repo.
2. Find the cause with `rg <pattern>`.
3. Open the file in Neovim. Fix it.
4. Stage the change in LazyGit. Commit.

   **Result:** you fix a real bug end-to-end without the mouse.

**Done when — Week 3:** verify each item:

1. You fix a small bug in an existing project.
2. The work stays in the terminal the whole time.
3. Hands stay on the keyboard throughout.

---

## Week 4: Agents and making it yours

**Goal:** use agents in the layouts. Then change Omarchy itself.

### Day 1 — One agent in a project

1. `cd` into a project folder.
2. Type `c <task>` and press `Enter`. OpenCode runs as the agent.
3. Use `cx <task>` instead if you want Claude Code.
4. When the agent finishes, type `exit` and press `Enter`.

   **Result:** you can drive one agent from any project folder.

### Day 2 — Two agents side by side

1. Type `icx` (or `tdl c cx`) and press `Enter`.
2. Give each pane a different job in its prompt.

   **Result:** two agents work in parallel.

### Day 3 — Four agents in a grid

1. Type `tsl 4 c` and press `Enter`.
2. Pick the busy agents. Close the idle ones.

   **Result:** you can run a 2x2 agent grid and prune it.

### Day 4 — Inline AI in the shell (zsh only)

**WARNING:** this step needs zsh. Stay on bash for the rest of the plan if you
do not want to switch. To switch, follow
[Procedure 6](../migration/install-zsh.md) first.

1. Open a fresh zsh terminal.
2. Type `source ~/Work/practice-omarchy/scripts/ai-shell.zsh` and press `Enter`.
3. Type `list hidden files` and press `Ctrl + G`.
4. Press `Enter` to accept the suggested command.

   **Result:** the widget inserts a command, often `find . -name '.*' -type f`.

### Day 5 — Add one custom keybinding

1. Open `~/.config/hypr/bindings.lua` in Neovim.
2. Add one line with `bind = SUPER, <key>, <action>`. Save the file.
3. Press `Super + K`. The new binding is listed.

   **Result:** your custom binding appears in the cheat sheet.

### Day 6 — Put your dotfiles under version control

1. On the Mac or the ThinkPad, create a private repo called `dotfiles`.
2. Move your custom config files (for example `~/.config/hypr/bindings.lua`) into it.
3. Symlink them back with GNU Stow, or copy them with a small script.

   **NOTE:** Omarchy owns many of the default config files. Stow your overrides on top, not over them.

   **Result:** your changes survive a re-image.

### Day 7 — Graduation

1. Clone a fresh repo.
2. Type `tdl c` and press `Enter`.
3. Ask the agent to make a small change.
4. Review the diff with `tds`. Approve or comment.
5. Commit with LazyGit. Push.

   **Result:** you finish the change with the keyboard, no mouse.

**Done when — Week 4:** verify each item:

1. You do the graduation task end-to-end.
2. You repeat the whole four-week plan from memory next week.
3. Hands stay on the keyboard throughout.

---

## Progress checklist

Copy this list into a private note and tick each box on the day.

- [ ] Week 1, Day 1 — Launch three apps with Super
- [ ] Week 1, Day 2 — Move between workspaces
- [ ] Week 1, Day 3 — Move and swap windows
- [ ] Week 1, Day 4 — Clipboard
- [ ] Week 1, Day 5 — Close and float
- [ ] Week 1, Day 6 — Screenshots and OCR
- [ ] Week 1, Day 7 — Open the Omarchy menu and change theme
- [ ] Week 1, Day 8 — Toggles
- [ ] Week 2, Day 1 — Splits and focus
- [ ] Week 2, Day 2 — Windows
- [ ] Week 2, Day 3 — Sessions
- [ ] Week 2, Day 4 — tdl and tds
- [ ] Week 2, Day 5 — tdlm in a projects folder
- [ ] Week 2, Day 6 — Plugins (sessionx and floax)
- [ ] Week 2, Day 7 — Copy mode
- [ ] Week 3, Day 1 — ff and Ctrl-R
- [ ] Week 3, Day 2 — Jump and search
- [ ] Week 3, Day 3 — Neovim (LazyVim) file and search
- [ ] Week 3, Day 4 — Neovim sidebar, tabs, close
- [ ] Week 3, Day 5 — LazyGit
- [ ] Week 3, Day 6 — LazyDocker
- [ ] Week 3, Day 7 — One-task redo
- [ ] Week 4, Day 1 — One agent in a project
- [ ] Week 4, Day 2 — Two agents side by side
- [ ] Week 4, Day 3 — Four agents in a grid
- [ ] Week 4, Day 4 — Inline AI in the shell (zsh only)
- [ ] Week 4, Day 5 — Add one custom keybinding
- [ ] Week 4, Day 6 — Put your dotfiles under version control
- [ ] Week 4, Day 7 — Graduation
