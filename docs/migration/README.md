# Migrating from macOS to Omarchy

Order of operations. Do them in this order; each step is small.

1. **Inventory your Mac** (read-only, stays on your machine):
   `./scripts/mac-inventory.sh > ~/mac-inventory.txt`
   Keep that file out of git. It lists your installed tools with a hint for each.
2. **Back up what only exists on the Mac** (see [bring-your-stuff.md](bring-your-stuff.md)). Do this before you wipe or re-image anything.
3. **Install Omarchy.** Follow the official [Getting started](https://omarchy.org/manual/getting-started/).
   Note: the installer wipes the target drive and uses full-disk encryption, so back up first.
   I read this for the legacy v3 manual only; recheck the v4 page.
4. **Learn the map** ([mac-map.md](mac-map.md)): where each Mac tool or habit lands.
5. **Preview the installer**, then run it:
   ```bash
   ./scripts/practice-omarchy-setup.sh --dry-run            # nothing changes
   ./scripts/practice-omarchy-setup.sh                      # bash, Omarchy's default shell
   ./scripts/practice-omarchy-setup.sh --shell zsh          # only if you want to keep zsh
   ```
   What it changes and what it leaves alone: [configs.md](../reference/configs.md).
6. **Start the [four-week plan](../guide/exercise-guide.md).**

## Decide this first: bash or zsh?

Omarchy's helpers (`tdl`, `tds`, `ff`, `c`, ...) are written for **bash**. If you stay on bash you get
them for free, and Omarchy updates keep them current. If you move your Mac zsh setup over, the
installer's zsh block re-creates them, and you maintain that copy yourself.
Recommendation: start on bash for the first two weeks, since the practice plan assumes Omarchy's
defaults, and switch to zsh later only if something specific is missing.

## Which Omarchy version?

This repo targets **Omarchy v4**. Run `omarchy` to see the command centre, and compare
[Hotkeys](https://omarchy.org/manual/hotkeys/) with what `Super + K` shows. In Omarchy 3,
`Super + Space` was the app launcher and `Super + Alt + Space` the Omarchy menu; v4 swapped them.
