# Contributing

Thanks for helping. The most valuable contributions are **corrections**: a keybinding that changed, a
package that moved, a step that failed on your Omarchy version.

## Ground rules

- **Cite your source.** Facts about Omarchy should link to the [official manual](https://omarchy.org/manual/)
  or say how you verified them. Say which Omarchy version you tested.
- **Never run the installer on a machine you care about without `--dry-run` first.**
- **No secrets, no personal files.** Do not commit keys, `.env` files, or your Mac inventory.
- Keep scripts dependency-free: bash for shell, Python 3 standard library only.

## Before opening a pull request

```bash
./init.sh          # bash -n, zsh -n, shellcheck, installer/docs drift check, quiz selftest
```

It must pass. Specific things to keep in sync:

- `scripts/practice-omarchy-setup.sh` heredocs and the fenced blocks in `docs/reference/configs.md`
  (`scripts/check-drift.py` enforces this).
- `docs/reference/keybindings.md` tables use `| Action | `keys` |` rows, one table per `##` section,
  because the quiz parses them (`python3 scripts/practice-omarchy-cli.py --selftest`).

## Reporting a problem

Include: Omarchy version (`omarchy` output), what you ran, what you expected, what happened.
