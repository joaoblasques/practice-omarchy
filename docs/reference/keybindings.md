# Keybinding cheat sheet (Omarchy v4)

Source: the official [Omarchy manual, Hotkeys](https://omarchy.org/manual/hotkeys/), read 2026-10-19,
plus [Terminal](https://omarchy.org/manual/terminal/), [Shell tools](https://omarchy.org/manual/shell-tools/)
and [AI](https://omarchy.org/manual/ai/). This is a curated subset for people coming from macOS.

**If you forget everything, remember one binding: `Super + K` lists all of them** (tmux: `Super + Alt + K`).

**Version warning.** Omarchy 3 swapped two of these: there `Super + Space` was the app launcher and
`Super + Alt + Space` the Omarchy menu. Check your version before trusting muscle memory. The legacy
v3 manual is at <https://learn.omacom.io/2/the-omarchy-manual>.

The quiz (`scripts/practice-omarchy-cli.py`) is generated from the tables on this page. Keep each table
as `| Action | Keys |` with the keys in backticks, and one table per `##` section.

## Launch and menus

| Action | Keys |
| :--- | :--- |
| Open the Omarchy menu (apps and everything else) | `Super + Space` |
| Open the apps-only menu | `Super + Alt + Space` |
| Show every keybinding | `Super + K` |
| Open a terminal | `Super + Return` |
| Open a terminal inside tmux | `Super + Alt + Return` |
| Open the browser | `Super + Shift + Return` |
| Open the file manager | `Super + Shift + F` |
| Open the editor (Neovim) | `Super + Shift + N` |
| Open the password manager (1Password) | `Super + Shift + /` |
| Open Obsidian | `Super + Shift + O` |
| Open LazyDocker | `Super + Shift + D` |
| Open the system menu (suspend, restart) | `Super + Escape` |
| Lock the computer | `Super + Ctrl + L` |
| Pick a new theme | `Super + Ctrl + Shift + Space` |

## Windows and workspaces

| Action | Keys |
| :--- | :--- |
| Close the window | `Super + W` |
| Toggle a window between tiling and floating | `Super + T` |
| Toggle window position (horizontal or vertical) | `Super + J` |
| Go full screen | `Super + F` |
| Jump to workspace 1 to 4 | `Super + 1/2/3/4` |
| Move the window to workspace 1 to 4 | `Super + Shift + 1/2/3/4` |
| Jump to the next workspace | `Super + Tab` |
| Move focus to the window in an arrow direction | `Super + Arrow` |
| Swap the window with its neighbour | `Super + Shift + Arrow` |
| Cycle windows on the workspace | `Alt + Tab` |
| Toggle the scratchpad | `Super + S` |
| Toggle window grouping (tabs inside a tile) | `Super + G` |

## Clipboard and capture

| Action | Keys |
| :--- | :--- |
| Copy (works in the terminal too) | `Super + C` |
| Paste (works in the terminal too) | `Super + V` |
| Cut (not in the terminal) | `Super + X` |
| Open clipboard history (text and images) | `Super + Ctrl + V` |
| Take a screenshot | `Print Screen` |
| Record the screen | `Alt + Print Screen` |
| Extract text from a screen region (OCR) | `Super + Ctrl + Print Screen` |
| Open the capture menu (no PrintScr key) | `Super + Ctrl + C` |
| Open the emoji picker | `Super + Ctrl + E` |
| Dismiss the latest notification | `Super + ,` |
| Open notification history | `Super + Shift + Alt + ,` |
| Set a reminder | `Super + Ctrl + R` |

## System panels

| Action | Keys |
| :--- | :--- |
| Audio panel | `Super + Ctrl + A` |
| Bluetooth panel | `Super + Ctrl + B` |
| Wifi and network panel | `Super + Ctrl + W` |
| Activity monitor (btop) | `Super + Ctrl + T` |
| Share files with LocalSend (AirDrop equivalent) | `Super + Ctrl + S` |
| Toggle the top bar | `Super + Shift + Space` |
| Show the battery as a notification | `Super + Ctrl + Alt + B` |

## Tmux

Prefix is `Ctrl + Space` (`Ctrl + B` also works). Config: `~/.config/tmux/tmux.conf`.

| Action | Keys |
| :--- | :--- |
| Split the pane beside | `Prefix + v` |
| Split the pane below | `Prefix + h` |
| Zoom a pane to full screen | `Prefix + z` |
| Kill the pane | `Prefix + x` |
| Move between panes | `Ctrl + Alt + Arrows` |
| Resize panes | `Ctrl + Alt + Shift + Arrows` |
| New window | `Prefix + c` |
| Go to window 1 to 9 | `Alt + 1-9` |
| Rename the window | `Prefix + r` |
| List sessions | `Prefix + s` |
| Detach from the session | `Prefix + d` |
| Next session | `Prefix + N` |
| Enter copy mode | `Prefix + [` |
| Reload the tmux config | `Prefix + q` |
| Show all tmux bindings | `Prefix + ?` |
| Fuzzy session picker (SessionX, added by this repo) | `Prefix + o` |
| Floating popup terminal (Floax, added by this repo) | `Prefix + p` |

## Tmux layouts (commands, run inside tmux)

| Action | Keys |
| :--- | :--- |
| Editor, one agent and a terminal | `tdl c` |
| Editor, two agents and a terminal | `tdl c cx` |
| Four-way square (editor, diff, shell, OpenCode) | `tds` |
| One dev layout per subdirectory | `tdlm c` |
| Four parallel OpenCode agents in a grid | `tsl 4 c` |

## Shell tools

| Action | Keys |
| :--- | :--- |
| Fuzzy find a file with a preview | `ff` |
| Fuzzy search command history | `Ctrl + R` |
| Jump to a frequent directory (zoxide) | `z <name>` |
| Pick a directory interactively (zoxide) | `zi` |
| Search file contents (ripgrep) | `rg <pattern>` |
| Find a file by name | `fd <name>` |
| Show a file with syntax highlighting | `bat <file>` |
| Short examples instead of a man page | `tldr <command>` |
| Natural language to command (this repo, zsh) | `Ctrl + G` |

## AI agents

| Action | Keys |
| :--- | :--- |
| Start OpenCode in the current directory | `c` |
| Start Claude Code in the current directory | `cx` |
| Start Codex in the current directory | `cy` |
| Run the default agent inline | `a` |
| Launch the default agent in its own window | `Super + Shift + Ctrl + A` |

## Neovim (LazyVim)

| Action | Keys |
| :--- | :--- |
| Show the command options | `Space` |
| Open a file by fuzzy search | `Space Space` |
| Search file contents across the project | `Space S G` |
| Toggle the sidebar | `Space E` |
| Open git controls (LazyGit) | `Space G G` |
| Go to the left file tab | `Shift + H` |
| Go to the right file tab | `Shift + L` |
| Close the file tab | `Space B D` |

## Ghostty (only if installed from the Omarchy menu)

| Action | Keys |
| :--- | :--- |
| New split below | `Ctrl + Shift + E` |
| New split beside | `Ctrl + Shift + O` |
| New tab | `Ctrl + Shift + T` |
| Move between splits | `Ctrl + Alt + Arrows` |
