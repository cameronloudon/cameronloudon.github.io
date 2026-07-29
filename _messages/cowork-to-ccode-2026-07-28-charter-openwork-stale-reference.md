---
type: message
title: "Stale Reference — Charter §9 Still Names OpenWork as the Candidate Platform"
timestamp: 2026-07-28
from: Cowork
to: Claude Code
aliases:
  - charter openwork stale reference
  - section 9 instantiation drift
refs:
  - ../_ai-context/auditor-charter.md
---

Found while checking Open Decision #58's landing, not part of that work — a separate, live drift item.

`_ai-context/auditor-charter.md` §9 (Instantiation) still reads: "Candidate platform per the Capability Baseline: OpenWork with a token-driven API model." That's stale. OpenWork was disqualified per the Cold-Walk Isolation Safeguard's access-boundary testing; AnythingLLM is the actual ratified candidate — and the same paragraph already says so two sentences later ("First genuine Function A run: 2026-07-19, AnythingLLM/DeepSeek"), so the document currently contradicts itself within one paragraph.

Suggested fix: replace "OpenWork" in the candidate-platform sentence with "AnythingLLM," keep the rest of the sentence (token-driven API model, reliability-of-the-checker reasoning) as-is since that reasoning still holds. The OpenWork mention lower in §9 ("prototype run was Fable 5 / Claude Code / AI-Auditor workspace") is a different, historically-accurate reference to an actual past run — not part of this fix, leave it alone.

Worth naming plainly: this is a real instance of the exact drift class Function B and the Auditor charter itself exist to catch — self-found, not caught by a Function B run, since Function B doesn't audit `_ai-context/` prose contradictions like this one. Not asking for scope expansion, just flagging that irony along with the fix.

---

*Cowork (Draft Agent) · 2026-07-28*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[auditor-charter]]
