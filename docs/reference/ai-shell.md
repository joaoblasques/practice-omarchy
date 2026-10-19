# Inline AI in the shell (the Warp "AI command search" experience)

Ghostty has no AI features; neither does any plain terminal. Warp's feature is really a
shell-input feature: describe what you want, get a command in the prompt. You can get
the same thing in any terminal with a zsh line-editor (ZLE) widget.

`scripts/ai-shell.zsh` does exactly that. Type a description, press **Ctrl+G**, and the
line becomes a command. Nothing executes until you press Enter, so a human always sends.

```zsh
# ~/.zshrc
source ~/path/to/practice-omarchy/scripts/ai-shell.zsh
```

```text
$ find files larger than 100mb here      <Ctrl+G>
$ find . -type f -size +100M -exec ls -lh {} +
```

## Why this instead of the GitHub Copilot CLI

The `gh copilot suggest` extension this repo used before was retired on 2025-10-25.
GitHub's replacement is a standalone agent (`copilot`), not a command suggester, and it
requires a paid Copilot plan.
([changelog](https://github.blog/changelog/2025-09-25-upcoming-deprecation-of-gh-copilot-cli-extension/),
[docs](https://docs.github.com/en/copilot/how-tos/use-copilot-for-common-tasks/use-copilot-in-the-cli))
The widget reuses an agent CLI you already have, so there is nothing new to install or pay for.

## Backend

`AI_SHELL_CMD` is any command that reads a prompt on stdin and prints an answer on stdout.

| Backend | Setting | Notes |
| :--- | :--- | :--- |
| Claude Code (default) | _(unset)_ | Haiku, no tools, ~3-4s. Uses your subscription login. |
| OpenCode | `export AI_SHELL_CMD='opencode run'` | Ships with Omarchy as `opencode` / `c`. Not timed here. |
| aichat | `export AI_SHELL_CMD='aichat'` | Many providers, local models via Ollama. Not timed here. |

Measured on macOS with Claude Code: `claude -p` took ~9.6s with user hooks and plugins
loaded, ~3.1s with `--setting-sources project`. Do not use `--bare`: it ignores
subscription login and needs an API key.

## Other options (not adopted)

Dedicated zsh plugins exist: [zsh-ai-prompt](https://github.com/hex/zsh-ai-prompt),
[Zsh-Opencode-Tab](https://github.com/alberti42/Zsh-Opencode-Tab),
[zsh-ask-opencode](https://github.com/andreacasarin/zsh-ask-opencode),
[zsh-ai](https://github.com/thiswillbeyourgithub/zsh-ai),
[nlsh](https://github.com/PsychArch/nlsh), [shell_gpt](https://github.com/TheR1D/shell_gpt).
I read their READMEs only; none were installed or run. Adopt one if you want features
the 30-line widget lacks (ranked suggestions via fzf, explain, fix-last-command).

## Limits

- The request blocks the prompt while it runs.
- No "explain" or "fix last command" yet (Warp has both).
- The ZLE widget was written on macOS and only the suggest function was tested
  non-interactively. Confirm Ctrl+G on your ThinkPad.
