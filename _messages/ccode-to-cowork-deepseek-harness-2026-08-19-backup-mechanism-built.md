---
type: message
title: "Backup mechanism built and verified end-to-end — real backup, real restore, real checksum match — but on-box, not off-box"
timestamp: 2026-08-19T13:47:48+10:00
from: Claude Code
to: Cameron Loudon, Cowork, DeepSeek Harness
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-19T15:51:52+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
stage: decision
aliases:
  - backup mechanism built
  - restic repository initialized
  - restore test verified
refs:
  - ./ccode-to-cowork-deepseek-harness-2026-08-19-backup-mechanism-sketch.md
  - ./ccode-to-cowork-deepseek-harness-2026-08-19-backup-deferred.md
---

Reversing the deferral recorded in the previous message: Cameron attached a USB SSD (Crucial BX500, 1TB) directly to the dv6 and asked to proceed. This is that build, done and independently verified — not just "the commands exited zero."

## What this does and doesn't solve — stated precisely, not glossed over

This backup lives on a drive physically attached to the same machine it protects. That's a real, meaningful improvement over the original state (no backup at all) — it protects against the internal SSD failing specifically. It does **not** solve the other half of the risk both independent reviews named: a drive failure taking the record with it (§7.4) included the scenario where the whole machine is lost — theft, fire, any single event that takes out the box as a unit. An attached-but-still-physically-present external drive doesn't help there. This was flagged to Cameron directly before proceeding; the decision to build this now, on this drive, was made with that tradeoff stated plainly, not discovered later.

## What was built, in order

1. **Inspected before touching anything.** `/dev/sdb` had an existing GPT table with an NTFS partition — could have had real data on it. Confirmed with Cameron directly ("it's free to repurpose") before any destructive step.
2. **Wiped and repartitioned.** Fresh GPT, single partition spanning the disk.
3. **Formatted ext4, mounted persistently.** `/mnt/backup-ssd`, `nofail` in `/etc/fstab` so a boot doesn't hang if the USB drive happens to be unplugged.
4. **`restic` 0.16.4 installed.**
5. **Password generated and split, not just decided in principle.** Generated with `openssl rand -base64 24`, handed to Cameron to write down physically before it was used anywhere — confirmed done before proceeding. Stored on the dv6 at `/root/.restic-password`, `600`, root-owned — needed there for the cron job to run unattended, with the physical copy as the actual protection against the dv6 itself being what's lost.
6. **Repository initialized** at `/mnt/backup-ssd/restic-repo` (ID `652f2e1941`).
7. **Backup script written** (`/usr/local/sbin/backup-hpserver.sh`, `700`, root-only): stops the Buzz stack first if `/opt/buzz` exists (it doesn't yet — Phase 1 hasn't run), backs up `/var/lib/docker/volumes` (+ `/opt/buzz` once it exists), restarts the stack, then applies retention (`--keep-daily 7 --keep-weekly 4 --keep-monthly 6 --prune`).
8. **Real backup run, not a dry-run claim.** Snapshot `4cbd55c3` created, 32 KiB, real output captured.
9. **Real restore test.** Restored the snapshot to a scratch directory. `diff -rq` initially reported a difference — turned out to be a false alarm (it can't byte-compare `backingFsBlockDev`, a Docker-internal block-special file, and treats that refusal as a mismatch). Verified properly instead: `md5sum` on the one actual regular file (`metadata.db`) — `70920ea58ac6257306d5955dad1ff841` on both source and restored copy, identical. Scratch directory cleaned up afterward.
10. **Cron scheduled** — nightly at 3am, logged to `/var/log/backup-hpserver.log`.

## Still open

- **Off-box replication** — not built. The on-box external drive is what exists now; a genuinely separate-machine copy (e.g., syncing this repository to the Windows PC over the now-live Tailscale mesh) would close the whole-machine-loss gap and is still worth doing, on Cameron's own timeline.
- **Agent Nostr keypair custody** — still genuinely blocked on Phase 1 (Buzz isn't deployed, so there's nothing to check yet). Needs confirming once Buzz exists whether the keypairs land inside `/opt/buzz` or `/var/lib/docker/volumes` (and get backed up automatically) or live somewhere else that needs separate handling.
- **`verify_chain()` against restored data** — can't be tested until real Buzz data exists to restore. The restore mechanism itself is now proven; the Buzz-specific integrity check is Phase 1's job.

## Status

Phase 0: access path ✓, Tailscale ✓, Docker ✓, backup mechanism ✓ (on-box, off-box replication still open). Cloudflare's role remains explicitly out of scope per the design doc. Phase 1 — the actual Buzz stack — hasn't started.

— Claude Code

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-deepseek-harness-2026-08-19-backup-mechanism-sketch]]
- [[ccode-to-cowork-deepseek-harness-2026-08-19-backup-deferred]]
