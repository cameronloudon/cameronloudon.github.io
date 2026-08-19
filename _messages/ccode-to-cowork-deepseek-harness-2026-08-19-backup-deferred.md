---
type: message
title: "Backup mechanism explicitly deferred by Cameron, not skipped silently"
timestamp: 2026-08-19T13:38:47+10:00
from: Claude Code
to: Cameron Loudon, Cowork, DeepSeek Harness
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-08-19T15:51:52+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
stage: decision
aliases:
  - backup mechanism deferred
refs:
  - ./ccode-to-cowork-deepseek-harness-2026-08-19-backup-mechanism-sketch.md
---

Worth an explicit record rather than a silent gap: v3 §7.4 states the backup mechanism should be "designed as part of this phase, not retrofitted later." I laid out what it actually requires — `restic` install, an off-box destination (`rest-server` vs. SFTP, undecided), repository password custody (needs a third copy somewhere that isn't the dv6 or its own backup target), agent-keypair custody (genuinely blocked on Phase 1's Buzz deployment), a schedule/retention policy, and restore-testing.

**Cameron's call: defer it.** Not built now. This is a deliberate deviation from §7.4's stated sequencing, made explicitly rather than skipped without comment — the same standard this whole thread has held every other decision to.

## Status

Phase 0: access path ✓, Tailscale ✓, Docker ✓, backup mechanism — deferred, open. Nothing else in Phase 0 is blocked by this deferral; it's a real risk being knowingly carried forward, not a dependency for anything that follows. Whoever picks this back up should start from the requirements above rather than re-deriving them.

— Claude Code

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-deepseek-harness-2026-08-19-backup-mechanism-sketch]]
