---
type: reference
title: "Instruction Provenance — Rules Traced Back to the Records That Justified Them"
aliases:
  - provenance sidecar
  - instruction provenance
  - record-to-instruction traceability, reverse direction
refs:
  - ../AI_INSTRUCTIONS.md
  - ../PROJECT_STATE.md
---

**Last updated:** 2026-07-11 (session-33)
**Status:** First version — two worked examples, not an exhaustive clause-by-clause audit of every instruction file. Mapping the rest is future, incremental work, applied on next-touch, same discipline as the rest of `_ai-context/` (`PROJECT_STATE.md` Open Decision #49).
**Purpose:** The `refs:`-to-instruction demo (`_messages/ccode-to-cowork-2026-07-10-refs-to-instruction-demo.md`) proved a record can point *at* an instruction clause. This file is the other direction: an instruction clause pointing *back* at the record that justified it, so an Auditor — or anyone — can check "is this rule still justified, and by what evidence?" by following a link instead of taking the rule on faith or hunting through session history.

---

## Entry 1 — `AI_INSTRUCTIONS.md` §6, the Phase 2 merge-time state correction rule

**The clause:** "When Cameron confirms a merge... correct `PROJECT_STATE.md`'s Active Branch section immediately, as the first action of a newly-opened branch... do not wait for the next session's start-of-session verification to catch the staleness."

**Justifying record:** Open Decisions #19 and #21 (`PROJECT_STATE.md`) — the branch-staleness bug that recurred three times before the fix moved from "reactive, catches it if a session happens to start" to "anchored to the merge event itself." Full recurrence history: sessions 8–10.

**A distinction worth stating plainly, not leaving implicit:** this clause already carries its own informal citation in its own prose — "relying on it alone is what let the same staleness bug recur (see `PROJECT_STATE.md` Open Decisions #19 and #21)." This entry doesn't originate that traceability; it formalizes something partially already there — turning a prose aside into a structured, `refs:`-checkable pointer an Auditor's Function B can verify mechanically rather than parse from sentence structure. Caught by Cowork's review before this file existed, not something I noticed independently.

## Entry 2 — `AI_INSTRUCTIONS.md` §5, the attribution-is-non-negotiable clause

**The clause:** "**Attribution is non-negotiable.** Do not publish content without a collaboration note. Do not end a session without writing a session log if content was published or the repo was changed."

**Justifying record:** Open Decision #36 — the published `_ideas/four-agent-collaboration-test/` page's diagnosis was found wrong during the 2026-07-10 curated-slice review, using Cowork's full 137-turn transcript as the raw evidence. A published claim that turned out inaccurate is exactly the failure mode this clause exists to prevent — a reader relying on the page's stated diagnosis had no way to know it didn't match what the transcript actually showed, until someone happened to reread the right raw record.

**Unlike Entry 1, a clean zero-to-one case:** §5 carried no inline citation of any kind before this file — the traceability here didn't exist in any form until now, not even informally in prose. Worth keeping this contrast visible rather than letting both entries read as the same kind of gap closed the same way.

---

## What this file doesn't do

Doesn't map every clause in `AI_INSTRUCTIONS.md`, `CLAUDE.md`, or any `_ai-context/` file — two real, independently-verified worked examples, not a completeness claim. Doesn't argue either clause is *correct*, only that each is traceable to something checkable. Building out the rest is deliberately deferred, same as the rest of `_ai-context/`'s OKF rollout: applied when a clause is next genuinely being worked on, not audited wholesale ahead of need.

## Links
<!-- generated from refs: - do not hand-edit -->
- [[AI_INSTRUCTIONS]]
- [[PROJECT_STATE]]
