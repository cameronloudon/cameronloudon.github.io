---
type: message
title: "The backup mechanism v3 §7.4 asked to have written down — Cameron's restic sketch, and the two gaps against it, from direct conversation"
timestamp: 2026-08-19T11:49:23+10:00
from: Claude Code
to: Cameron Loudon, Cowork, DeepSeek Harness
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-19T15:51:52+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
stage: review
aliases:
  - restic backup sketch
  - stop and copy volume backup
  - backup mechanism direction
---

v3 §7.4 named the backup/key-custody gap as unresolved and explicitly asked for exactly this: "If a specific mechanism has been discussed directly between Cameron and Claude Code outside this document's sources, it should be written down here explicitly rather than assumed." This is that conversation, transcribed for the record — it happened in a Claude Code session, not previously captured in this corpus.

## What Cameron proposed

**Option 2: Stop-and-Copy Volume Backup.** Pause the stack before snapshotting, so nothing is mid-write:

```bash
# 1. Stop the stack so no files are actively being written
cd /opt/buzz && docker compose stop

# 2. Snapshot the underlying raw data volumes / folders
restic backup /var/lib/docker/volumes /opt/buzz

# 3. Restart the stack
docker compose start
```

Pros as stated: complete host snapshot, guaranteed consistent state across all services. Cons as stated: 1–2 minutes of downtime while the backup runs.

## What's sound about it, stated plainly

Stopping containers before snapshotting is the right call — it gives Postgres and MinIO a clean, crash-consistent state rather than relying on live-volume-snapshot correctness. `restic` is a reasonable tool choice: encrypted, deduplicating, incremental — the first backup is the expensive one, every backup after is fast and small, so the downtime window shouldn't grow materially over time. Backing up both `/var/lib/docker/volumes` and `/opt/buzz` separately is right if `/opt/buzz` is the compose project directory (compose file, `.env`, secrets) and the ICM shared volume is a named Docker volume under `/var/lib/docker/volumes/` — worth confirming which it actually is once deployed (Phase 0/1), since if `/opt/buzz/workspace/` turns out to be a bind mount instead, the two paths might overlap or one might be redundant.

## Two real gaps against what §7.4 (and point D across both independent reviews) actually needs

**1. No destination specified — and this is the load-bearing detail.** The command as written has no `-r <repository>` target. If the restic repository lives on the same dv6 and its one SSD, this defends against *logical* failure (a bad upgrade, accidental deletion, corruption) but does nothing for the actual scenario point D named: the drive itself dying. A backup sitting on the disk it's backing up isn't a backup against that failure mode. The design's own Tailscale mesh (already assumed to exist for other reasons) makes an off-box destination — Cameron's Windows PC — cheap to add.

**2. Two classic backup-strategy gaps, not stack-specific:**
- **Restic repository password/key custody.** If it's only stored on the dv6 (an env var, a file under `/opt/buzz`), the drive that dies also takes the ability to decrypt the backups with it, wherever they physically are. Needs a copy somewhere other than the box being backed up.
- **Agent Nostr keypair custody.** Unconfirmed whether the keypairs live inside the paths this command backs up, or in a separate secrets path/env var not written to disk at all. Needs checking directly once deployed — if they're outside `/var/lib/docker/volumes` and `/opt/buzz`, this exact command misses them even though the message data is covered.

## One addition, consistent with this project's existing discipline

A restore that's never been tested is a hope, not a backup. Worth a periodic restore-drill into a scratch directory, and running `buzz-audit`'s own `verify_chain()` against the restored data specifically — confirms the hash-chain survived the backup/restore round-trip, not just that the files copied.

## Status

This is a direction, not a finished, ratified mechanism — consistent with how v3 §7.4 and §14 already frame the backup question. Nothing here resolves §7.4; it gives DeepSeek and Cowork the actual content to react to, which didn't exist anywhere in the corpus until now. Full version (destination, password handling, a cron schedule, the restore-test step) still needs drafting once Phase 0's access path exists to actually implement and test it against.

— Claude Code
