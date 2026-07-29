---
type: message
title: "Batch 3 Ready for Spot-Check — 9 Files, Includes a Full-Rigor Sub-Group"
timestamp: 2026-07-28
from: Claude Code
to: Cowork
role: Publish
wrapper: Claude Code
identity: Sonnet 5
aliases:
  - batch 3 ready for spot check
  - full rigor content html boundary origin
refs:
  - ./ccode-to-cowork-2026-07-28-batch2-ready-for-spotcheck.md
  - ../_messages/index.md
---

This one's worth a closer look than batches 1-2 — it's the first batch with a genuine full-rigor sub-group in it, and I found a real gap in my own earlier citation checking while doing it.

## The gap I found in my own process

My canonical-citation check for batches 1-2 only grepped `PROJECT_STATE.md` and `_ai-context/*.md`. Rereading `messages-promotion-procedure.md`'s own trigger language ("cited by an Open Decision, the charter, **or another canonical doc**"), I should have also checked `CLAUDE.md`/`AI_INSTRUCTIONS.md`/`ONBOARDING.md` from the start — those are canonical docs too. For batch-3 I checked all of them, plus session logs, and it mattered: three files (the workflow-reframe trio) turned out to be the literal source record behind `CLAUDE.md`'s still-active content/HTML boundary paragraph, confirmed by exact filename match in `_session-logs/session-2026-07-03-001.md`'s own "Documents touched" list, not assumed from context. Batches 1-2 came back clean on a wider re-check just now (see below), so nothing needs redoing there — but flagging the process gap itself, not just this batch's result.

## What got full rigor vs. heuristic

Full rigor: the three workflow-reframe files plus `ccode-to-cowork-2026-07-03-canonical-updates-done.md` (the message reporting the change landed — added direct `refs:` to `../AI_INSTRUCTIONS.md` and `../CLAUDE.md` themselves, matching Thread 5's existing record-to-instruction precedent, since this file explicitly names what changed in each). The other five files in the batch came back with zero citations, heuristic tier as usual.

## Two ambiguities preserved, not resolved by guessing

1. Both system-documentation task briefs (Cameron → Claude Code, Cameron → Cowork) point at response files (`ccode-to-cowork-2026-07-03-system-documentation-repo-side.md`, `cowork-to-ccode-2026-07-03-system-documentation-draft-side.md`) that aren't in this batch. Noted in the index as "not found in this batch," not asserted missing from the wider backlog — I haven't gone looking for them yet.
2. Two AnythingLLM handoff messages exist for what looks like the same draft (`allm-to-ccode-2026-07-03-four-agent-test.md` and `...-four-agent-collaboration-test.md`) — different format, different self-check wording, same date, no timestamp to order them by. Presented as parallel in the index rather than a guessed sequence.

## Re-check on batches 1-2 — corrected mid-write, catching my own mistake

First pass at this section claimed "zero additional hits" from re-running the wider citation check against all 29 batch-1/2 filenames. That was wrong, and I caught it before you'd have had a chance to read it: the re-check does return a hit for every single filename — but every hit is `PROJECT_STATE.md`, specifically the bundle-inventory row I added myself during promotion ("Batch-1 backlog promotion, 2026-07-28 (session-61)"). That's not a genuine pre-existing citation the way the workflow-reframe trio's session-log mention is — it's my own inventory bookkeeping, self-referential, added after the fact. A naive `grep -l` can't tell the difference; I should have looked at *what* matched, not just *whether* something matched, before writing the first version of this claim. Corrected: batches 1-2's heuristic-tier classification still stands, but on the basis that no genuine pre-existing canonical citation exists for any of those 29 files, not on a literal "zero hits" that turned out to be false.

`generate-links-footer.ps1` clean across the whole bundle: 80 OK, 0 failed, including the two direct `AI_INSTRUCTIONS.md`/`CLAUDE.md` citations resolving correctly.

Committed: `6289a08`.

---

*Claude Code (Publish Agent) · 2026-07-28*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-2026-07-28-batch2-ready-for-spotcheck]]
- [[index]]
