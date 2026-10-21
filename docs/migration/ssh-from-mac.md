# Let the Mac reach the ThinkPad (Tailscale and SSH)

Run this procedure on the ThinkPad. It gives the Mac a stable name and an SSH login to the ThinkPad.
After it, `scripts/migrate-cc-from-mac.sh --host jonas@<name>` works from the Mac.

**Prerequisites:** the ThinkPad runs Omarchy v4. The ThinkPad has internet access. You have a Tailscale account.
The Mac already runs Tailscale on the same account (tailnet).

**WARNING:** Step 9 opens port 22. Omarchy rate-limits the port against brute force. Do not enable password login for SSH.

**NOTE:** Sources: the Omarchy manual [Networking](https://omarchy.org/manual/networking/) and
[Security](https://omarchy.org/manual/security/) pages. SSH is off by default.
Omarchy turns it on with `Setup > Security > SSHD`. Omarchy installs Tailscale with `Install > Service > Tailscale`.

## Part A. Install Tailscale

1. Press `Super + Space`. The Omarchy menu opens.
2. Select `Install`.
3. Select `Service`.
4. Select `Tailscale`.
5. Authenticate with your fingerprint or password.

   **Result:** the installer finishes. A Tailscale panel appears in the top bar.

6. Click the Tailscale panel in the top bar.
7. Select the connect action. Sign in to your Tailscale account in the browser.

   **Result:** the panel shows the ThinkPad as connected.

8. Open Foot (`Super + Return`). Type `tailscale status` and press `Enter`.

   **Result:** the list shows the ThinkPad and `jonass-macbook-pro`. Write down the ThinkPad name in the first lines.

## Part B. Turn on SSH

9. Press `Super + Space`. Select `Setup`, then `Security`, then `SSHD`.

   **Result:** Omarchy starts the SSH daemon and opens port 22. Tailscale SSH needs no key, so Part C is optional. Do Part C only if SSH asks for a key.

10. In Foot, type `systemctl is-active sshd` and press `Enter`.

    **Result:** the terminal prints `active`. If it prints `inactive` or `failed`, stop. Show the owner the output.

## Part C. Authorize the Mac key

11. On the Mac, type `cat ~/.ssh/id_ed25519.pub` and press `Enter`. Copy the full line.
12. On the ThinkPad, type `mkdir -p ~/.ssh && chmod 700 ~/.ssh` and press `Enter`.
13. Type `nano ~/.ssh/authorized_keys` and press `Enter`.
14. Paste the Mac key on a new line. Press `Ctrl + O`, `Enter`, then `Ctrl + X`.
15. Type `chmod 600 ~/.ssh/authorized_keys` and press `Enter`.

    **Result:** `grep -c ssh-ed25519 ~/.ssh/authorized_keys` prints a number of 1 or more.

**NOTE:** If step 9 already authorized a key, check it with step 15. Add the Mac key only if the Mac key is missing.

## Part D. Report to the owner

16. Type `tailscale status | head -5` and press `Enter`.
17. Type `whoami` and press `Enter`.
18. Tell the owner these two values: the ThinkPad name from step 16 and the user name from step 17.

    **Result:** the owner can type `ssh jonas@<name>` on the Mac and get a shell.

## Part E. Record the result

19. Open `feature_list.json`. Find item F19.
20. Add to the F19 `evidence`: the output of step 10 and the line `tailscale ok` (do not add the key or the IP).
21. Run `git pull --rebase --autostash`.
22. Run `git commit -m "F19: record ThinkPad Tailscale and SSH setup" -- feature_list.json`.
23. Run `git push`.

## If a step fails

- `tailscale status` shows `Logged out`: repeat step 7.
- The Mac cannot reach the ThinkPad by name: use the Tailscale IP from `tailscale status`. Tailscale IPs start with `100.`.
- `sshd` is `inactive`: repeat step 9 and read the error text on screen.
