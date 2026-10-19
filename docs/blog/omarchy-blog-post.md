# Practice Omarchy: Mastering DHH's Omakase Linux & Modern Terminal Architecture for macOS Converts

> *Transitioning from macOS overlapping windows to Omarchy's keyboard-driven Hyprland tiling environment and modern terminal toolchain.*

---

## 1. Introduction: Motivation Is Downstream from Beauty & Speed

For over a decade, macOS has been the default operating system for modern software developers. However, as web development workflows have shifted heavily toward CLI-first tooling, terminal multiplexing, and AI coding agents, traditional desktop GUIs with floating windows often feel sluggish and fragmented.

Enter **Omarchy Linux**—an opinionated Arch Linux distribution created by David Heinemeier Hansson (DHH) built around the **Hyprland** Wayland tiling window manager. Omarchy is designed around a core philosophy: **developer motivation and productivity are downstream from workflow aesthetics and keyboard-driven execution.**

To bridge the gap for former Mac users, I built **Practice Omarchy**—a unified training suite and hands-on repository combining Omarchy's OS navigation with the Ultimate Modern Terminal Setup.

---

## 2. The Mental Shift: macOS Floating vs. Hyprland Tiling

Switching from macOS to Omarchy requires shifting from a mouse/trackpad-centric mental model to a keyboard-first tiling architecture:

* **No More Overlapping Windows**: Every open application in Hyprland automatically tiles side-by-side. You never drag window borders or hunt for covered app windows.
* **The Universal `Super` Key**: Omarchy maps all system controls to the `Super` (Windows) key instead of macOS `Command (⌘)`. Pressing `Super + Return` launches your terminal, `Super + Alt + Return` opens it inside Tmux, and `Super + Space` brings up the Omarchy Menu (this is the v4 mapping; Omarchy 3 swapped `Super + Space` and `Super + Alt + Space`).
* **One Clipboard Everywhere**: `Super + C` and `Super + V` copy and paste in every app, terminal included, so there is no separate `Ctrl + Shift + C/V` reflex to learn. `Super + Ctrl + V` opens a clipboard history that holds images as well as text.

---

## 3. The Modern Terminal Architecture: Built for Omarchy

Omarchy comes pre-installed with over half of the modern CLI stack out of the box (`eza`, `zoxide`, `fzf`, `ripgrep`, `fd`, `bat`, `mise`, and LazyVim).

By extending this with **Ghostty**, **Atuin**, **Tmux + SessionX + Floax**, **sesh**, and AI agents such as Claude Code and OpenCode, the terminal becomes a complete local IDE:

| Layer | Primary Tool | Purpose |
| :--- | :--- | :--- |
| **Terminal Emulator** | **Ghostty** | Mitchell Hashimoto's GPU-accelerated Zig terminal. Optional in Omarchy (Foot is the default); install it from the Omarchy menu and Omarchy themes it. |
| **Directory Navigation** | **`zoxide` + `eza`** | Smart frecency path jumping (`z`) and tree file listings with Nerd Font icons. |
| **Search & History** | **`fzf` + Atuin** | SQLite-backed fuzzy command history (`Ctrl+R`) and file previewing (`ff`). |
| **Workspace Multiplexing** | **Tmux + Floax** | Session isolation with persistent floating popup windows (`Ctrl+Space -> p`). |
| **Programmable Layouts** | **`tdl` / `tds` / `tsl`** | Automated screen splitting into editor, AI agent, and terminal shell panes. |
| **Developer Runtimes** | **`mise`** | Automatic per-project environment loading (`Node`, `Ruby`, `Go`, `Python`). |
| **Editor & AI Agent** | **LazyVim + Claude Code / OpenCode** | Modal editing next to LLM coding agents in the same tmux layout. |

---

## 4. Omarchy Layout Functions: Programmable Workspaces

One of Omarchy's most powerful features is its shell-based layout functions (they ship in Omarchy's bash setup). Instead of manually splitting Tmux panes, simple shell commands deploy pre-arranged workspaces:

* **`tdl c` (or `ic`)**: Spawns a 3-way split featuring Neovim on the left, OpenCode AI agent on the top-right, and a shell pane on the bottom-right.
* **`icx`**: Opens OpenCode and Claude AI side-by-side on the right.
* **`tds`**: Deploys a 4-way square grid with Neovim (top-left), Git diff watcher (top-right), Terminal shell (bottom-left), and OpenCode (bottom-right).
* **`tdlm`**: Scans all subdirectories in your project path and creates an automated workspace window for each.

---

## 5. Learning by Doing: The Practice Omarchy Suite

To make the transition from macOS as hands-on as possible, the **Practice Omarchy** repository includes:

1. **`practice-omarchy-setup.sh`**: An additive installer. It adds only what Omarchy does not ship, backs up every file it touches, and has a `--dry-run` mode.
2. **`practice-omarchy-cli.py`**: A terminal quiz generated from the keybinding cheat sheet, so the docs and the drill cannot disagree.
3. **`docs/guide/exercise-guide.md`**: A four-week practice plan with a "done when" test for each week, next to a Mac-to-Omarchy migration map.

By practicing OS spaces and terminal tools together, former Mac users build the muscle memory required for daily fluency in DHH's Omakase Linux environment.

---

*Published as part of the Practice Omarchy Learning Suite.*
