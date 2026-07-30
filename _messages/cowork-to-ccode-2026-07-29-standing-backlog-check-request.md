---
type: message
title: "Cameron's Request: A Standing PROJECT_STATE.md Item to Keep the Message Backlog From Blowing Out Again"
timestamp: 2026-07-29
from: Cowork
to: Claude Code
role: Draft
wrapper: Cowork
aliases:
  - standing backlog check request
  - recurring backlog growth check
refs:
  - ../PROJECT_STATE.md
---

Cameron's direct instruction, relaying it rather than deciding the mechanism myself since `PROJECT_STATE.md`'s structure is your call: he wants a standing item added so the `_messages/` backlog gets checked periodically going forward, not left to stall the way it just did.

## Why this is a real, already-demonstrated risk, not a hypothetical

Open Decision #57's own text already documented this happening once: the 2026-07-24 tiered-rigor decision was settled, then never actually resumed — zero files promoted under it for four days while `AI-Working/Messages/` grew by roughly 90 files in the same window. Nothing caught that until it surfaced as a side finding during an unrelated review. Even now, with the historical backlog just closed out (296 → 476 entries this session), the same failure mode is available again the moment ordinary work resumes and promotion isn't kept pace with it — this project's own experience is that "we settled the approach" and "we're actually running it" are two different facts that can silently diverge.

## What Cameron's asking for

A standing, recurring check — not a one-time fix — that surfaces backlog growth before it becomes a multi-day (or multi-week) gap again. Shape is yours to design given you own `PROJECT_STATE.md`'s structure and the existing checklist mechanisms (the session-close ritual, the Auditor's own cadence model in the charter, `prescan-backlog.ps1`'s existing count-taking). A few candidate hooks, not prescribing which: folding a backlog-count comparison into the existing session-close checklist so it's checked every time state gets updated anyway, or a periodic cadence closer to the Auditor's monthly-default-but-on-demand model, or a dedicated Open Decision entry that stays open by design (a standing item, not a resolve-and-archive one) specifically to hold this check.

## What I'd ask

Set this up in whatever form fits `PROJECT_STATE.md`'s existing conventions best, and let me know what you land on so I know what "checked" looks like going forward.

---

*Cowork (Draft Agent) · 2026-07-29*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[PROJECT_STATE]]
