---
type: audit-finding
title: "OpenWork Disqualified Under Point 1 — Cold-Walk Isolation Safeguard, Point-4 Empirical Check"
timestamp: 2026-07-18
severity: blocks-independence
failure-kind:
provenance: "Produced outside the Auditor's own §5/§6 workflow (Auditor Charter) — no Auditor instance exists yet, this is the safeguard's own point-4 verification step, run against the candidate named in Auditor Charter §9. Authored directly by Cameron Loudon, who ran the empirical tests himself per the independence rationale settled in the standup thread (an audited party should not calibrate its own audit gate), with independent review from Cowork (Draft Agent) and Claude Code (Publish Agent) before and after the test run. Not promoted from a running Auditor workspace instance, and not written by either incumbent agent's own hand — Claude Code (Publish Agent) drafted this file mechanically from the settled thread, per Cameron's explicit sign-off request in the closing message of that thread."
aliases:
  - openwork disqualified
  - point 4 finding
  - cold walk isolation safeguard point 4
  - openwork session search leak
  - verdance-7 canary test
refs:
  - ../_ai-context/cold-walk-isolation-safeguard.md
  - ../_ai-context/auditor-charter.md
  - ../_messages/cowork-to-ccode-2026-07-18-point4-findings-openwork-anythingllm.md
  - ../_messages/ccode-to-cowork-2026-07-18-point4-findings-response.md
  - ../_messages/cowork-to-ccode-2026-07-18-point4-findings-cameron-decisions.md
  - ../_messages/cowork-to-ccode-2026-07-18-point4-findings-final.md
  - ../_messages/cowork-to-ccode-2026-07-18-openwork-standup-proposal.md
  - ../_messages/ccode-to-cowork-2026-07-18-openwork-standup-response.md
  - ../_messages/cowork-to-ccode-2026-07-18-openwork-standup-step2-protocol-review.md
  - ../_messages/cowork-to-ccode-2026-07-18-openwork-standup-step2-decision.md
---

## What was checked

Point 4 of `_ai-context/cold-walk-isolation-safeguard.md`, run empirically against OpenWork — the candidate named concretely in that document and in Auditor Charter §9 — per the step-2 protocol agreed in advance between Cameron, Cowork, and Claude Code:

1. Does spawning a subagent from OpenWork inherit parent context by default? Is there a genuinely isolated/stateless spawn mode?
2. Does OpenWork auto-retrieve or inject context at all (RAG-style), and what actually triggers it?

Cameron ran the tests directly, 2026-07-18, not either incumbent agent — settled in advance as a requirement of Function A's independence design (Auditor Charter Provenance line; see `ccode-to-cowork-2026-07-18-openwork-standup-response.md`).

## What was found

**Sub-question 2 — confirmed positive, twice, no disable path found.** A fabricated, project-unrelated marker ("Verdance-7," a fictional planet) was seeded in one session, with the explicit Memory Bank save prompt declined. A genuinely separate, later session — then repeated in a brand-new workspace — surfaced the marker anyway via autonomous, unprompted calls to `openwork_session_search`/`openwork_session_read`. Checked directly against the interface (general/preferences/permissions/advanced panels), not inferred from the model's own claims: no setting exists to disable this. A cross-platform control (the same DeepSeek API token via AnythingLLM instead of OpenWork) showed zero knowledge of the marker, isolating the leak to OpenWork's own client-side session-search feature rather than the underlying account or model.

**Sub-question 1 — mixed, and independently insufficient on its own terms.** OpenWork's `task()` subagent mechanism did not inherit the marker directly when it wasn't repeated in the subagent's prompt. But the subagent's own tool-disclosure listed the full `openwork_session_*` surface by default — the same cross-session search capability responsible for the sub-question-2 leak. The one clean trial (marker not found) required an explicit prompt-level instruction telling the subagent not to use session tools; nothing in the platform itself removes that capability from the subagent's surface. The mitigation is model-compliance-dependent, not structural.

**Related observation, disposition narrowed after direct verification.** OpenWork's verbal self-report of where the Verdance-7 fact came from ("a session on 2026-07-17... 'What model are you?' conversation") was factually wrong on its face — today was 2026-07-18, and the actual source was the test session itself. Cameron checked the underlying OpenWork session log directly, not just the model's verbal claim, and confirmed the log itself was intact and accurate; the error was the model's own summarization of a good record, not a corrupted or fabricated one. A second instance of the same wrong provenance claim occurred verbatim in a separate workspace, and a citation offered in support of a related claim (that no disable setting exists) pointed to a real URL whose actual content (checked directly) does not support what it was cited for. This is recorded here as a related reliability observation, not folded into this finding's severity — see Disposition below.

## Instruction clause

`_ai-context/cold-walk-isolation-safeguard.md`, point 1: "The cold-walk instance must be a genuinely fresh conversation, not a subagent inherited from a workspace whose own system prompt or memory index already names this project. If a candidate tool's architecture makes a truly blank spawn structurally impossible, that tool is disqualified from running mission 1 — not accommodated or worked around."

The operative failure here is broader than the subagent case that clause names directly: the sub-question-2 leak occurred between two independent, freshly-opened sessions with no spawn relationship between them at all — the most "fresh conversation" a candidate can offer. Point 4's own text anticipates exactly this as the harder case: auto-retrieval "is the one vector step 2's disclosure structurally cannot catch... it can't distinguish 'I inferred this' from 'this got pulled in behind me.'" A platform with no way to disable that retrieval path, evidenced twice, meets point 1's "structurally impossible" bar directly — it is not a configuration gap that a careful operator could work around.

## Severity

`blocks-independence`. This disqualifies OpenWork as a Function A / Auditor candidate as currently configured. Mission 1 (the cold walk) cannot run through a tool with no verified-isolated session or spawn mode — running it anyway would produce a result that looks like independent evidence but might not be.

## Failure-kind

Reserved, left blank per Auditor Charter §4 pending the still-developing failure-taxonomy decision.

## Disposition and recommendation

**OpenWork is disqualified for Function A / Auditor use, as currently configured.** No mitigation tested clears point 1's bar: the one working restriction (prompt-instructed subagent) depends on model compliance rather than a structural guarantee, and it does nothing to address the independently-sufficient sub-question-2 leak between ordinary fresh sessions. Recommend: do not proceed to the point-3 decoy build, or any further Auditor-role testing against OpenWork, on this basis. If a future, structurally different OpenWork configuration or version becomes available, it would need its own fresh point-4 run — this finding does not transfer forward automatically.

**The related provenance/citation inaccuracies are not counted toward this severity.** Cameron's direct check of the underlying session log confirmed the record itself was intact; the failure was the model's own summarization of good data, not corrupted or absent evidence. This is narrower than "fabricates freely" and does not, on its own, meet the bar for a second independent `blocks-independence` finding alongside the isolation result above. It is retained here as a standing note: (a) for any future, independently-run evaluation of OpenWork for a different role (e.g., Draft Agent, per an informal reallocation idea in circulation as of this writing — not a ratified proposal) — that evaluation starts fresh and does not inherit this finding, but should test citation accuracy directly rather than assume it; (b) as a candidate bug report to OpenWork's developers, not yet filed as of this record.

**AnythingLLM, tested in parallel as an alternative candidate, is not addressed by this finding.** Results to date (structurally-enforced filesystem containment, clean cross-workspace isolation with Agent mode on, Personalization confirmed off and its API-reachability checked directly) are more promising than OpenWork's, but two items remain open — a tool-disclosure check, and a direct stress-test of AnythingLLM's own fabrication tendency — before it could be called cleared. No separate audit-finding has been written for AnythingLLM at this time: it has no disposition yet to record, and point 4's own two sub-questions aren't both closed (its spawn/subagent primitive is confirmed present but is being deliberately excluded from use by Cameron's own architecture preference, not empirically tested — recorded as "excluded by design," not an open gap). A finding will follow once testing concludes either way, rather than a placeholder entry that would need editing in place once it does — audit-findings are meant to record a disposition, and no immutable-record convention exists yet for amending one once it lands.

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cold-walk-isolation-safeguard]]
- [[auditor-charter]]
- [[cowork-to-ccode-2026-07-18-point4-findings-openwork-anythingllm]]
- [[ccode-to-cowork-2026-07-18-point4-findings-response]]
- [[cowork-to-ccode-2026-07-18-point4-findings-cameron-decisions]]
- [[cowork-to-ccode-2026-07-18-point4-findings-final]]
- [[cowork-to-ccode-2026-07-18-openwork-standup-proposal]]
- [[ccode-to-cowork-2026-07-18-openwork-standup-response]]
- [[cowork-to-ccode-2026-07-18-openwork-standup-step2-protocol-review]]
- [[cowork-to-ccode-2026-07-18-openwork-standup-step2-decision]]
