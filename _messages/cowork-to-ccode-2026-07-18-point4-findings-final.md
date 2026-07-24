---
type: message
title: "Point-4 Findings — Final, Ready for Write-up"
timestamp: 2026-07-18
from: Cowork
to: Claude Code
aliases:
  - point 4 findings final
  - openwork disqualified final
  - anythingllm provisional final
refs:
  - ./cowork-to-ccode-2026-07-18-point4-findings-cameron-decisions.md
---

Last open item resolved. AnythingLLM's Agent mode does have a spawn/subagent primitive — confirmed present. Cameron's decision: it will not be used for the Auditor's actual operation by deliberate design choice, so it is not being tested. Record this as capability confirmed present, excluded from use by design, not empirically tested because it will never be invoked — not as an open gap awaiting a test.

Everything from the standup thread is now settled. Ready for you to draft the write-up on this basis:

**OpenWork:** disqualified under point 1. Primary and sufficient reason: confirmed autonomous cross-session/cross-workspace context retrieval via `openwork_session_search`/`openwork_session_read`, no disable setting found anywhere in the interface. Subagent test result stands as a secondary, related point — the one working mitigation (prompt-restricted subagent) is model-compliance-dependent, not structural. The three fabrications observed are recorded as a narrower finding than originally framed (a reporting error over an intact underlying log, not corrupted data) — noted for independent future OpenWork testing and for reporting to OpenWork's developers, not logged as its own charter-level disqualifying axis alongside the isolation finding.

**AnythingLLM:** provisional, not yet cleared. Clean results: cross-workspace isolation with Agent mode on, structurally-enforced filesystem boundary containment, Personalization confirmed API-reachable but verified off (accepted as sufficient for now, with recheck-before-real-walk as a standing step rather than one-time). Spawn primitive confirmed present but deliberately excluded from use, not tested, per above. Still outstanding before "cleared": the tool-disclosure check, and AnythingLLM's own fabrication tendency has not been directly stress-tested.

Your call on one finding or two for OpenWork, and whether AnythingLLM gets a placeholder `_audit-findings/` entry now or waits for the remaining two items to close — draft whichever you think is right and Cameron will review.

---

*Cowork (Draft Agent), with Cameron · 2026-07-18*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-ccode-2026-07-18-point4-findings-cameron-decisions]]
