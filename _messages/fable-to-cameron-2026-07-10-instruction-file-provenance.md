---
type: message
title: "Instruction-File Provenance — The Other Direction of Traceability, and Why It Should Wait"
timestamp: 2026-07-10
from: Claude Code (Fable 5, AI-Auditor workspace — not the Publish Agent)
to: Cameron
refs:
  - ./fable-to-cameron-2026-07-10-ai-prod-examination-and-proposals.md
  - ./fable-to-cameron-2026-07-10-discoverability-and-link-representation.md
  - ./ccode-to-cowork-2026-07-10-refs-to-instruction-demo.md
  - ./index.md
  - ../AI_INSTRUCTIONS.md
---

**A note on `refs:` above:** the first two entries are folder-relative (this file's companions in `AI-Auditor\`); the rest are repo-relative to `cameronloudon.github.io`, per the Open Decision #34 rule that citations point at git-tracked paths. Same custody caveat as the companions: `AI-Auditor\` is not git-tracked; stated rather than left implicit.

---

## 1. What this covers

Third and final file from the 2026-07-10 examination session. The companions cover Observations 1–2 (mirror sync, action evidence) and the discoverability/link-representation convention. This one covers the remaining open item: **the second half of record-to-instruction traceability.**

Session-28's demo (`ccode-to-cowork-2026-07-10-refs-to-instruction-demo.md`, linked above) proved the first half: a `_messages/` record can `refs:` directly to a root instruction file, git-tracked and resolvable, with zero new mechanism. The gap `_messages/index.md` itself names is the other direction: instruction files carry no OKF frontmatter and no `refs:` of their own — they cannot point back at the records that shaped them.

## 2. Why the direction matters

Every rule in `AI_INSTRUCTIONS.md`, `CLAUDE.md`, and `_ai-context/` came from somewhere — a session, a failure, a consensus exchange. Some of that provenance survives as prose asides ("this exact gap has recurred multiple times on this project"), but prose is unfollowable: an Auditor asking *"is this rule still justified, and by what evidence?"* has to take the aside on faith or go hunting. The claims-vs-actions ledger the Auditor needs has two sides — records checked against spec, and spec traceable to the record that justified it. Today only the first side has a mechanism.

## 3. The solution space

**Option 1 — Full OKF frontmatter on the instruction files themselves.** `type`, `timestamp`, `refs:` on `AI_INSTRUCTIONS.md`, `CLAUDE.md`, and the `_ai-context/` files. Clean in theory; wrong in practice for the root files. `CLAUDE.md` is Claude Code's auto-loaded operational file — frontmatter and `refs:` blocks would cost context tokens every single session and put audit metadata in front of the very agents the file exists to instruct. File-level `refs:` are also too coarse to be useful: the meaningful provenance is per *clause*, not per file. Over-engineering.

**Option 2 — Clause-level provenance inline.** Each major rule gains a citation line pointing at its justifying record (e.g., the §6 merge-correction rule citing Open Decisions #19/#21 and sessions 8–10). Genuinely valuable to a reader — but it is hand-maintained prose in multiple files, which reintroduces exactly the drift liability the link-representation convention (companion file) was designed to eliminate. Every instruction edit becomes a citation-maintenance obligation across the `AI_INSTRUCTIONS.md`↔`CLAUDE.md` pair — compounding the manual-sync risk DeepSeek already ranked as the project's highest (Open Decision #28), not relieving it.

**Option 3 — A provenance sidecar.** One small OKF-stamped file (e.g., `_ai-context/instruction-provenance.md`) mapping instruction clauses to the records behind them: "`AI_INSTRUCTIONS.md` §6, merge-time state correction ← Open Decisions #19/#21, `_session-logs/session-2026-07-05-001.md`, recurrence history." The instruction files stay clean and cheap to load; the traceability lives in a file that is itself a first-class node in the knowledgebase — it carries `refs:`, gains generated `[[wikilinks]]` under the link convention, and appears in the Obsidian graph as the hub connecting rules to their evidence. It is also precisely the artifact the future Auditor consumes on the spec side of its ledger.

## 4. Recommendation: Option 3 — and not yet

Option 3 is the right shape, but building it now would be building the Auditor sideways. Cameron's standing decision (Open Decision #34, reaffirmed through session-27) is that the Auditor track waits for real design thought rather than accreting through convenient side-projects — the same discipline that kept `type: audit-finding` unused rather than tested synthetically. The provenance sidecar has no other customer: nothing in the backfill, the link convention, or day-to-day publishing depends on it. Its natural birth is as one of the Auditor's first deliverables, built against the Auditor's actual requirements once those are scoped — at which point its first entries can be real cases (Open Decision #36 is sitting there waiting to be its worked example), matching the "genuine material, not synthetic tests" rule the project has applied to every mechanism that worked.

What *is* worth doing now costs one sentence: when the Auditor role is eventually scoped, the sidecar should be in its initial deliverables list. This file is the record of that intent.

## 5. Proposed actions

1. **Log the design answer, defer the build.** The "other direction" gap in `_messages/index.md` gets its answer recorded — provenance sidecar, Option 3 — either by a pointer to this file or a line in the relevant Open Decision, without opening a build task. Owner: Publish Agent, next convenient session.
2. **Do not add OKF frontmatter to `CLAUDE.md`/`AI_INSTRUCTIONS.md`** (Option 1) and **do not begin inline clause citations** (Option 2) in the meantime — both would create maintenance surface ahead of the mechanism that justifies it. Owner: standing guidance, no action.
3. **When Cameron scopes the Auditor role**, include the provenance sidecar in its first deliverables, seeded with real cases — Open Decision #36 (the four-agent-test misdiagnosis) as the worked example of a published claim traced against both its evidence and the instruction clause it violated. Owner: Cameron gates; the Auditor track builds.

## 6. Limits

- The token-cost argument against Option 1 applies with certainty to `CLAUDE.md` (auto-loaded) and only weakly to `_ai-context/` files (read on demand); a future decision could reasonably treat those two classes differently.
- Whether clause-level granularity is right — versus section-level or rule-level — is deliberately left to the Auditor design work; this file argues the *shape* (sidecar, not inline, not file-level frontmatter), not the resolution.
- Fable 5 access is time-limited; as with both companions, this is written to be executable by any capable AI without this session's context.

## 7. Session close-out

This completes the 2026-07-10 examination session's working list: Observation 1 closed (fix identified, independently converged, execution pending in session-29); Observation 2's solution space on file with an urgent evidence-rescue flag; discoverability and link representation resolved into one pre-backfill convention; and bidirectional traceability shaped and deliberately deferred to the Auditor track. Three OKF-stamped records in `AI-Auditor\` are the session's durable output. Their own promotion into a git-tracked home — and whether `AI-Auditor\` becomes a tracked workspace — is Cameron's call, noted in all three files' custody caveats.

---

<div class="collab-note">
<div class="collab-note-header">AI Collaboration Note</div>
<div class="collab-note-body">
This document was written by Claude (Anthropic), model claude-fable-5, running in Claude Code in the AI-Auditor workspace — a separate session from the project's Publish Agent. The solution space, the sidecar recommendation, and the deliberate deferral to the Auditor track are the AI's analysis; Cameron directed the session, set the standing rule this recommendation defers to (the Auditor waits for real design thought), and requested this record. No files in AI-Prod or the repo were created, modified, or deleted. Nothing here has been actioned — every proposal awaits Cameron's decision through the project's normal propose→review→consensus process.
</div>
</div>

*Written under the Radical Collaboration Transparency framework.*
*Model: claude-fable-5 · Platform: Claude Code · Workspace: AI-Auditor · Date: 2026-07-10*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[fable-to-cameron-2026-07-10-ai-prod-examination-and-proposals]]
- [[fable-to-cameron-2026-07-10-discoverability-and-link-representation]]
- [[ccode-to-cowork-2026-07-10-refs-to-instruction-demo]]
- [[index]]
- [[AI_INSTRUCTIONS]]
