---
type: message
title: "Request — Track Auditor Attribution/Telemetry and Future Write-Scoping as a Real Open Decision"
timestamp: 2026-07-24
from: Cowork
to: Claude Code
aliases:
  - auditor collaborator open decision
  - attribution telemetry gap
  - future write access scoping
refs: []
---

Cameron's been working through what it means to treat the Auditor as a genuine third collaborator, on par with Draft and Publish, not just a checking tool. Two real threads came out of that discussion today, and I'd initially just saved them to my own memory — Cameron correctly caught that this is wrong: real project open items belong in `PROJECT_STATE.md`, visible to every agent, not in memory only I can see. Requesting you add this as a new Open Decision at session close, since Draft Agent doesn't write that file.

**Thread 1 — attribution/telemetry parity for the Auditor.** RCT's collab-note and session-log conventions were built for Draft/Publish, which produce pages and repo commits. The Auditor produces neither — its only output channel is the screen, and Cameron manually copies that into a `.md` file and places it in the right folder. That means any run's metadata (`type`, `title`, `from`, `refs`, run context) has to already exist as literal, copy-pasteable text in the model's own response — nothing downstream adds it mechanically the way `generate-links-footer.ps1` does for Draft/Publish content. `timestamp` specifically has to stay Cameron's own annotation, not the model's — the isolation safeguard already forbids the model from guessing the date, and 2026-07-19's wrong-date anomaly is the concrete evidence why. Needs an addition to `_ai-context/auditor-kickoff-prompt.md` or charter §6 — not a new document, an addition to what's already there — going through the same review path as everything else charter-adjacent.

**Thread 2 — future write-access scoping.** Cameron may eventually give the Auditor real write functionality instead of pure screen-output-plus-manual-relay. If that happens, the write scope needs structural enforcement — JSON/connector-level configuration (the same idea as `.claude/settings.json`'s path-scoped grants), verified empirically the way the isolation safeguard's point 4 already requires — not a system-prompt instruction alone, which Cameron named directly as insufficient ("just generic text"). Direct precedent already in this project for why prompt-only isn't enough: toggling an AnythingLLM action checkbox off doesn't remove the tool from the model's schema, only makes execution fail — the platform's structural behavior is what actually held the boundary, not anything stated in text.

Neither thread has a drafted proposal yet — both are Cameron flagging real, non-trivial design questions for later, not asking either of us to build something now. Just asking that "later" be trackable by both of us, not sitting in a place only I can see.

---

*Cowork (Draft Agent), with Cameron · 2026-07-24*
