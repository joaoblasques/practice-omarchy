# Validate this repo on Omarchy (task file for an AI agent)

You are an AI agent on a real Omarchy machine. The human asked you to check this repo. Be read-only.

## Rules

- Do not edit any file in the repo. Do not run `scripts/practice-omarchy-setup.sh` without `--dry-run`.
- Do not use `sudo`. Do not install packages. Do not print API keys or the contents of `~/.config/opencode-go/key`.
- Run each command. Do not guess the output. If a command fails, record the exact error.
- Write the report to `~/Work/omarchy-validation-report.md` (outside the repo).

## Checks

Record `OK`, `DIFFERENT` (with the real value), or `FAIL` (with the exact error) for each item.

1. **System.** Run `cat /etc/os-release`, `pacman -Q | rg -i omarchy`, and `omarchy --help | head -30`. Record the Omarchy version if you can find it.
2. **Default terminal.** Run `echo "$TERMINAL"` and `command -v foot ghostty alacritty kitty`. The repo says Foot is the default in v4 and Ghostty is optional.
3. **Shell.** Run `echo "$SHELL"`. The repo says bash is the default.
4. **tmux config.** Check that `~/.config/tmux/tmux.conf` exists. Run `rg -n "prefix" ~/.config/tmux/tmux.conf`. The repo says the prefix is `Ctrl + Space`. Check if the file has a `practice-omarchy:tmux` block.
5. **Layout functions.** Run `type tdl tds tdlm tsl c cx cy a` in `bash -ic`. The repo says Omarchy provides all of them in bash.
6. **Installed tools.** Run `command -v atuin tv spf sesh fzf zoxide rg fd bat eza mise lazygit lazydocker nvim`. Run `--version` on each tool that exists. The repo says `atuin`, `tv` (television), `spf` (superfile) and `sesh` are added by the installer, and the others ship with Omarchy.
7. **Keybindings.** Find the Omarchy default key bindings. Start with `rg -l "SUPER" /usr/share/omarchy ~/.config/hypr`. Compare them with the tables in `docs/reference/keybindings.md`. List every row of the Launch, Windows, Clipboard, System panels, and Tmux sections that does not match. Do not press keys.
8. **Scripts.** Run `python3 scripts/practice-omarchy-cli.py --selftest` and `bash scripts/practice-omarchy-setup.sh --dry-run --shell bash`. Record the output.
9. **Claude Code.** Run `ccgo-check`. Record the four lines.
10. **Docs claims.** Read `docs/migration/mac-map.md`. List every row where the Omarchy column is wrong for this machine.

## Report format

For each check: number, title, result (`OK`, `DIFFERENT`, `FAIL`), and one line of evidence. End with a list of the repo files that need a change and the change.

## After the report

Wait. Do not commit. The human decides. If the human says to publish the report, create a new branch named `validation-report`, commit only the report file copied to `docs/migration/reports/thinkpad-report.md`, and push the branch.
