# Bring your stuff over

A checklist of what lives only on your Mac. Never commit any of it to this repo or any public one.

## Secrets and identity

- [ ] **SSH keys.** Simplest and safest: generate a new key on the new machine
      (`ssh-keygen -t ed25519`), add it to GitHub/servers, and retire the old key when ready.
      If you must copy the old one, move it over an encrypted channel and run `chmod 700 ~/.ssh && chmod 600 ~/.ssh/id_*`.
- [ ] **GPG / signing keys.** Export from the Mac (`gpg --export-secret-keys`), import on Omarchy, delete the export file.
- [ ] **Git identity.** `git config --global user.name` / `user.email` (copy from `~/.gitconfig`; check for macOS-only entries such as `osxkeychain`).
- [ ] **Password manager.** 1Password ships with Omarchy (`Super + Shift + /`). Sign in there before opening other apps.
- [ ] **API keys and `.env` files.** Recreate from the password manager rather than copying files around.

## Dotfiles

- [ ] Put your shell, git and editor config in a private dotfiles repo (the manual suggests GNU Stow).
- [ ] Skip files Omarchy owns (Hyprland, Ghostty, tmux base config). See [configs.md](../reference/configs.md).
- [ ] Review macOS-only lines in `~/.zshrc`: `brew`, `pbcopy`/`pbpaste` (use `wl-copy`/`wl-paste`), `open` (use `xdg-open`), `/opt/homebrew` paths.

## Data and apps

- [ ] Browser: sign in to sync bookmarks and extensions. Log in before using web-app shortcuts.
- [ ] Obsidian vault: copy the folder; Obsidian ships with Omarchy (`Super + Shift + O`).
- [ ] Projects: clone from git instead of copying; copy only unpushed work.
- [ ] Fonts you rely on beyond JetBrainsMono Nerd Font (Omarchy menu > Install > Style > Font).

## Hardware: ThinkPad

I have not read the v4 hardware pages. Check these on the machine and in the manual
([Hardware authentication](https://omarchy.org/manual/hardware-authentication/),
[Keyboard, mouse, trackpad](https://omarchy.org/manual/keyboard-mouse-trackpad/),
[System sleep](https://omarchy.org/manual/system-sleep/)):

- [ ] Fingerprint reader (Omarchy menu > Setup > Security).
- [ ] TrackPoint and trackpad speed, natural scrolling (`~/.config/hypr/input.lua`).
- [ ] Suspend and hibernate behaviour.
- [ ] Display scaling: Omarchy assumes a high-resolution screen (Setup > Monitors).
- [ ] External or split keyboard layout, if you use one.
