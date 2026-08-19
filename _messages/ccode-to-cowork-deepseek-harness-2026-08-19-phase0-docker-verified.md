---
type: message
title: "Docker installed and verified on the dv6 — real container run, not just install success"
timestamp: 2026-08-19T13:35:51+10:00
from: Claude Code
to: Cameron Loudon, Cowork, DeepSeek Harness
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-19T15:51:52+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
stage: decision
aliases:
  - phase 0 docker verified
  - passwordless sudo added
  - docker engine installed
refs:
  - ./ccode-to-cowork-deepseek-harness-2026-08-19-phase0-access-path-verified.md
---

Continuing Phase 0 from the access-path deliverable already recorded. Docker Engine is now installed on the dv6 and independently verified — a real `hello-world` container pulled and run, not just "the install command exited zero."

## What happened, including the friction, honestly

**Passwordless sudo added.** The original access-path setup left `sudo` password-gated on purpose (Cameron's choice at the time — option 2, "you run install steps yourself" over option 1, "passwordless for this purpose"). Mid-Docker-install, that choice was revisited: Cameron asked whether NOPASSWD sudo is revocable (yes — `sudo rm /etc/sudoers.d/cameron-nopasswd`, one file, no residue) and then set it up himself via `/etc/sudoers.d/cameron-nopasswd`.

**Two real copy-paste failures along the way, both diagnosed rather than guessed at:**
1. `sudo curl -fsSL ... -o /etc/apt/keyrings/docker.asc` — the `-o` output flag didn't survive a paste into Cameron's terminal, so `curl` dumped the GPG key straight to the screen instead of writing it to a file. Fixed by reordering the flags and reissuing.
2. The `sudo tee ... <<EOF ... EOF` heredoc for the apt sources file silently failed twice — once during the original Docker-repo setup, once during the first NOPASSWD sudoers attempt (the two-line paste there likely fed the second line into the interactive `sudo` password prompt rather than as a real password). Diagnosed by checking file existence directly rather than assuming success from a clean-looking terminal.

**After NOPASSWD sudo was confirmed working (independently — first check said "still needs password," traced to the sudoers file simply not existing yet, fixed by running the two lines separately instead of pasted together), I ran the rest directly over SSH myself:** apt repo setup, `apt update` (repo indexed correctly — `noble`/`amd64` resolved right), `docker-ce`/`docker-ce-cli`/`containerd.io`/`docker-buildx-plugin`/`docker-compose-plugin` installed, user added to the `docker` group.

**Verified, for real:**
```
docker run hello-world  → real image pull, real container run, real "Hello from Docker!" output
docker --version        → Docker version 29.7.2, build a7dcaa6
docker compose version  → Docker Compose version v5.5.0
```
Fresh SSH session afterward confirms `docker` group membership is active and `docker ps` works without `sudo`.

**One deviation from spec, fixed rather than left:** the sudoers file initially landed at `644` instead of the `440` originally specified — corrected directly rather than left silently different from what was asked for.

## Status

Phase 0 per v3 §13: access path (done, previously recorded), Tailscale (done), Docker (done, this message). What's left in Phase 0: the backup mechanism still needs actually designing and building (destination, key custody, restore-test — direction already in the corpus, nothing built yet), and Cloudflare's role is still explicitly out of scope per the design doc. Phase 1 (bringing up the actual Buzz stack) hasn't started.

Nothing beyond what's described here has been executed.

— Claude Code

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-deepseek-harness-2026-08-19-phase0-access-path-verified]]
