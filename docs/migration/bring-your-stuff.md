# Bring your stuff over

These steps move secrets, dotfiles, apps, and hardware settings from your Mac to Omarchy. Do them on the ThinkPad.

**Prerequisites:** the ThinkPad runs Omarchy v4. The Mac and ThinkPad share a network. 1Password, Ghostty, and Foot are installed.

**WARNING:** Never commit secrets to a public repo. Use a private dotfiles repo or `scp`.

**NOTE:** Omarchy v4 ships bash by default. zsh is opt-in. Steps below assume bash.

**NOTE:** See the Omarchy manual for hardware items ([Hardware authentication](https://omarchy.org/manual/hardware-authentication/), [Keyboard, mouse, trackpad](https://omarchy.org/manual/keyboard-mouse-trackpad/), [System sleep](https://omarchy.org/manual/system-sleep/)).

## Part A: Secrets and identity

1. Open Foot (`Super + Return`).
2. Type `ssh-keygen -t ed25519` and press `Enter`.
3. Press `Enter` to accept the default path.
4. Press `Enter` twice for an empty passphrase.

   **Result:** the terminal prints the key fingerprint.

5. Type `cat ~/.ssh/id_ed25519.pub | wl-copy` and press `Enter`.
6. Open GitHub at **Settings > SSH and GPG keys > New SSH key**.
7. Paste the public key. Save.

8. On the Mac, type `gpg --export-secret-keys --armor you@example.com > gpg.asc` and press `Enter`.
9. Copy `gpg.asc` to the ThinkPad with `scp`.
10. On the ThinkPad, type `gpg --import gpg.asc` and press `Enter`.
11. Type `rm gpg.asc` and press `Enter`.

    **Result:** `gpg --list-secret-keys` shows the imported key.

12. On the Mac, note `git config --global user.name` and `user.email`.
13. On the ThinkPad, type `git config --global user.name "Your Name"` and press `Enter`.
14. Type `git config --global user.email "you@example.com"` and press `Enter`.

15. Press `Super + Shift + /`. The 1Password app opens.
16. Sign in to 1Password.
17. Enable biometric unlock.

    **Result:** 1Password fills credentials on the next login.

18. Open 1Password. Find each API key.

    **WARNING:** Do not copy raw `.env` files from the Mac. Recreate them on the ThinkPad.

19. Recreate each `.env` file on the ThinkPad. Add the matching key.
20. Type `chmod 600 ~/.env` for each file.

## Part B: Dotfiles

21. On the Mac, type `gh repo create dotfiles --private --source=.` and press `Enter`.

    **NOTE:** Skip files Omarchy owns. See [configs.md](../reference/configs.md).

22. On the ThinkPad, type `gh repo clone user/dotfiles ~/.dotfiles` and press `Enter`.
23. Stow each package with `stow <package>`.

24. Open `~/.zshrc` in `nvim`.
25. Delete lines starting with `brew`.
26. Replace `pbcopy` and `pbpaste` with `wl-copy` and `wl-paste`.
27. Replace `open` with `xdg-open`.
28. Replace `/opt/homebrew` paths with `/usr`.

## Part C: Data and apps

29. Open Firefox or Chrome. Sign in. Wait for sync.

30. Copy the Obsidian vault folder from the Mac to `~/Documents` with `scp`.
31. Press `Super + Shift + O`. Obsidian opens.
32. Point Obsidian at the vault folder.

33. On the Mac, type `git status` in each project. Commit any unpushed work.
34. On the ThinkPad, type `gh repo clone user/repo` for each project.

35. Press `Super + Space`. The Omarchy menu opens.
36. Click **Install > Style > Font**.
37. Pick the font. Click **Install**.

## Part D: Hardware

38. Press `Super + Space`.
39. Click **Setup > Security > Fingerprint**.
40. Follow the prompts. Scan the same finger twice.

    **Result:** `sudo` prompts for a fingerprint instead of a password.

41. Open `~/.config/hypr/input.conf` in `nvim`.
42. Set `natural_scroll = yes` for the touchpad.
43. Adjust `sensitivity` to taste. Save the file.

44. Press `Super + Space`.
45. Click **Setup > Power**.
46. Pick the lid-close action. Set the idle timeout.

47. Press `Super + Space`.
48. Click **Setup > Monitors**.
49. Set the scale. Pick the orientation.

50. Plug in the external keyboard.
51. Press `Super + Space`.
52. Click **Setup > Keyboard**.
53. Pick the layout.