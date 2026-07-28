---
type: index
title: "Messages"
okf_version: "0.1"
---

Chain-of-custody record of AI/human message exchanges on this project, promoted from `AI-Working/Messages/` into git for diffable, tamper-evident history. Not rendered on the live site — excluded via `_config.yml`.

Authored originals continue to live in `AI-Working/Messages/`; files here are the audit copy of record.

## How to read this

Each entry below is `[Title](./file.md)` — `type` — a one-line pointer to what it replies to or continues, drawn directly from that file's own `refs:` frontmatter (not re-derived here, so this index can go stale-checkable: if an entry's arrow doesn't match the file's `refs:`, the index is wrong, not the file). Grouped by thread and rough chronological order within each. `superseded_by:` relationships are called out explicitly where they exist.

---

## Thread 0 — AI Independence Verification & Two-Agent System Audit (2026-06-26 to 2026-06-29)

The earliest material in the whole backlog — predates `_messages/` as a convention by weeks. First slice promoted from the wider 343-file `AI-Working/Messages/` backlog per Cameron's 2026-07-24 request (see "Gaps" below); a 10-file validation batch under full manual `refs:`/`aliases:` rigor, chosen deliberately to include a type-ambiguity case (operational prompt-paste templates were excluded from this batch and the standing rule going forward — they aren't correspondence) alongside genuine summaries and message pairs.

**AI Independence Verification — DeepSeek's runbook review (2026-06-26 to 06-27):**
- [Cowork Response — AI Independence Verification Document](./ai-independence-cowork-response.md) — `message` (Cowork → DeepSeek) → refs the Claude Code response and the synthesis below
- [Claude Code Response — AI Independence Verification Document](./ai-independence-claude-code-response.md) — `message` (Claude Code → DeepSeek) → refs the Cowork response and the synthesis below; explicitly reviews Cowork's response in Part 2
- [AI Independence Verification — Synthesis Document](./ai-independence-synthesis.md) — `summary` (Cowork → DeepSeek) → refs both responses above, its own stated source documents
- [AI Independence Verification — Session Report](./ai-independence-session-report-2026-06-27.md) — `summary` (Cowork → Claude Code and DeepSeek) → refs the synthesis above; covers the practical execution phase (OpenCode/AnythingLLM configuration, the anti-hallucination guard finding)

**Shared Prompts Folder proposal — becomes the Messages/ convention (2026-06-29):**
- [Shared Prompts Folder — Proposal for Discussion](./cowork-to-ccode-2026-06-29-shared-prompts-folder.md) — `message` (Cowork → Claude Code) — originating proposal, nothing prior to refs; the naming convention proposed here (`[from]-to-[to]-[date]-[topic].md`) is the one this whole bundle now uses
- [Re: Shared Prompts Folder Proposal](./ccode-to-cowork-2026-06-29-shared-prompts-folder.md) — `message` (Claude Code → Cowork) → responds to the proposal above; confirms the Messages/ subfolder decision and settings.json permission syntax

**Two-agent system audit and AnythingLLM pre-test fixes (2026-06-29):**
- [Claude Code — Catch-up Prompt](./claude-code-catchup-2026-06-29.md) — `message` (Cowork → Claude Code) → refs the pre-test-fixes-complete message below; tracks the AnythingLLM system-prompt test-blockers as they're found
- [Claude Code — Pre-Test Fixes Complete](./claude-code-pretest-complete-2026-06-29.md) — `message` (Cowork → Claude Code) → refs the catch-up prompt above; closes every tracked test-blocker
- [Cowork Session Handoff](./cowork-session-handoff-2026-06-29.md) — `message` (Cowork → Cowork, cross-session) → refs the verification findings below; the agreed two-agent system (actors, data stores, permissions table) as re-architected this session
- [Cowork — Independent Verification Findings](./cowork-verification-findings-2026-06-29.md) — `summary` (Cowork → Claude Code) → refs the session handoff above; 15 findings auditing the re-architected system's actual documentation

---

## Thread 1 — Origin, Architecture, OpenCode Readiness, and AnythingLLM's First Draft (2026-07-02)

Where the living-knowledgebase idea first came up, five days before "Messages" existed as a convention (see Open Decision #35) — the same day also carried the lean-system-prompt architecture proposal, the Messages/ folder's own implementation consensus, the first OpenCode-as-Publish-Agent readiness review, and AnythingLLM's first real content-drafting attempt (which failed twice, generating the deviation/diagnosis sub-thread below). Promoted 2026-07-28 (session-61, two batches) as the first resumed backlog-promotion effort under the tiered-rigor approach settled 2026-07-24 (heuristic, `Re:`-line-assisted, per-batch — see `_ai-context/prescan-backlog.ps1`); none of this thread's files are cited by any Open Decision, the charter, or another canonical doc's `refs:`, so full manual rigor wasn't triggered.

**Origin — the thinking session:**
- [Claude Code & Cameron — Messages/ Catch-up and AI-Facing Publishing, A Thinking Session](./ccode-to-cowork-2026-07-02-conversation-transcript.md) — `transcript`
- [Summary — Messages/ Catch-up and AI-Facing Publishing Thinking Session](./ccode-to-cowork-2026-07-02-conversation-summary.md) — `summary` → points back to the transcript above; no response required, archival

**Architecture proposal — lean system prompt + config file:**
- [Architecture Proposal — Lean System Prompt + Config File](./cowork-to-ccode-2026-07-02-architecture-proposal.md) — `message` (Cowork → Claude Code) — originating, no prior refs
- [Architecture Feedback — Approve Direction, Two Concerns Before Testing](./ccode-to-cowork-2026-07-02-architecture-feedback.md) — `message` (Claude Code → Cowork) → refs the proposal above

**Messages/ folder implementation — consensus and Test 1:**
- [Messages Folder — Implementation Plan for Consensus](./cowork-to-ccode-2026-07-02-messages-folder-consensus.md) — `message` (Cowork → Claude Code) → refs `ccode-to-cowork-2026-06-29-shared-prompts-folder.md` (Thread 0)
- [Response Format Correction](./cowork-to-ccode-2026-07-02-response-as-file.md) — `message` (Cowork → Claude Code) → refs the implementation plan above; asks for the response below to be written as a file, not pasted
- [Response to Messages/ Implementation Plan](./ccode-to-cowork-2026-07-02-messages-folder-consensus-response.md) — `message` (Claude Code → Cowork) → refs the implementation plan and the format-correction message above
- [Consensus Reached — Proceed with settings.json and Test 1](./cowork-to-ccode-2026-07-02-consensus-next-steps.md) — `message` (Cowork → Claude Code) → refs the response above; carries Cameron's Q1/Q2 answers and Test 1 instructions
- [Test 1 Result — Permission Verification](./ccode-to-cowork-2026-07-02-test1-result.md) — `message` (Claude Code → Cowork) → refs the consensus message and the two files it names as read-tested; Read/Write/Edit on Messages/ all confirmed PASS

**OpenCode configuration and readiness review:**
- [Create opencode.json from Corrected Template](./cowork-to-ccode-2026-07-02-create-opencode-json.md) — `message` (Cowork → Claude Code) — originating, no prior refs
- [opencode.json Created — With Two Open Items Flagged](./ccode-to-cowork-2026-07-02-opencode-json-created.md) — `message` (Claude Code → Cowork) → refs the request above; flags the `big-pickle` model and a `Copy-Item` command-syntax concern
- [Correction — Copy-Item Is Not a Blocker](./ccode-to-cowork-2026-07-02-copy-item-correction.md) — `message` (Claude Code → Cowork) → refs the flag above; Cameron confirms OpenCode's shell is PowerShell, not POSIX
- [Correction — big-pickle Confirmed Real, Readiness Review Closed](./ccode-to-cowork-2026-07-02-big-pickle-confirmed.md) — `message` (Claude Code → Cowork) → refs the correction above; both open items resolved
- [OpenCode Readiness — Seeking Consensus Before Full Test](./cowork-to-ccode-2026-07-02-opencode-readiness.md) — `message` (Cowork → Claude Code) — originating ask, asks Claude Code to read two `Prompts/` files outside its access scope
- [OpenCode Files for Review — Content Included](./cowork-to-ccode-2026-07-02-opencode-files-for-review.md) — `message` (Cowork → Claude Code) → refs the ask above; resolves the permission-boundary conflict by surfacing the file content directly
- [OpenCode Readiness — Independent Assessment](./ccode-to-cowork-2026-07-02-opencode-readiness-response.md) — `message` (Claude Code → Cowork) → refs both messages above; a certain-failure Messages/ permission gap and a likely `Copy-Item` shell mismatch, both flagged before any live test

**OpenCode Messages/ round-trip verification:**
- [OpenCode Verification Test](./cowork-to-opencode-2026-07-02-verification.md) — `message` (Cowork → OpenCode) — originating, no prior refs
- [OpenCode Verification Response](./opencode-to-cowork-2026-07-02-verification-response.md) — `message` (OpenCode → Cowork) → refs the test above
- [OpenCode Verification — Passed](./cowork-to-ccode-2026-07-02-opencode-verified.md) — `message` (Cowork → Claude Code) → refs the response above; all four agents (Cowork, Claude Code, AnythingLLM, OpenCode) now verified for the Messages/ round-trip
- [Verification Response Reviewed — Substance Correct, One Pattern to Watch](./ccode-to-cowork-2026-07-02-opencode-verified-note.md) — `message` (Claude Code → Cowork) → refs the two messages above; substance confirmed, flags a dropped-leading-character pattern worth watching in OpenCode's literal command output

**Architecture feedback, cross-checked (separate sub-thread, same day):**
- [Cross-Check on OpenCode's Architecture Feedback](./ccode-to-cowork-2026-07-02-opencode-feedback-review.md) — `message` (Claude Code → Cowork) → refs the architecture proposal above; independently verifies OpenCode's four feedback points against the actual files rather than agreeing at face value

**AnythingLLM system-prompt verification (v4):**
- [System Prompt Verification](./cowork-to-allm-2026-07-02-verify-system-prompt.md) — `message` (Cowork → AnythingLLM) — originating, no prior refs
- [System Prompt Summary](./allm-to-cowork-2026-07-02-system-prompt-summary.md) — `message` (AnythingLLM → Cowork) → refs the verification request above

**AnythingLLM content draft — brief, deviation, and diagnosis (batch-2, promoted 2026-07-28, session-61):**
- [Draft Brief — End-to-End Verification Test Summary](./cowork-to-allm-2026-07-02-draft-brief.md) — `message` (Cowork → AnythingLLM) — originating, no prior refs; the ideas-post brief that triggered the deviation sub-thread below
- [Path Correction — Structure Template Included](./cowork-to-allm-2026-07-02-path-correction.md) — `message` (Cowork → AnythingLLM) → refs the brief above; fixes an absolute-path error and embeds the full structure template inline
- [\[Publish Agent\] Prompt — ai-verification-test](./allm-to-opencode-2026-07-02-handoff.md) — `message` (AnythingLLM → OpenCode) → refs the brief and path-correction above; AnythingLLM's own handoff for the first draft attempt, self-check checklist marked fully passed — later shown to be false on every structural point, the concrete evidence behind the "checklist rubber-stamping" finding in the analysis pair below
- [Self-Diagnostic — Compare Your Draft Against the Spec](./cowork-to-allm-2026-07-02-self-diagnostic.md) — `message` (Cowork → AnythingLLM) → refs the brief and the handoff above; an open-ended self-diagnosis request, superseded before AnythingLLM ever wrote a response — no `allm-to-cowork-2026-07-02-self-diagnostic.md` exists in the backlog, confirmed directly rather than assumed missing; the more pointed structure-deviations message below appears to have replaced it
- [Structure Deviations — Explain](./cowork-to-allm-2026-07-02-structure-deviations.md) — `message` (Cowork → AnythingLLM) → refs the brief, path-correction, and handoff above; eleven pointed questions replacing the open-ended self-diagnostic approach
- [Structure Deviations Explanation](./allm-to-cowork-2026-07-02-deviation-explanation.md) — `message` (AnythingLLM → Cowork) → refs the eleven questions above; full point-by-point accounting, no rationalization offered

**AnythingLLM failure analysis (batch-2, promoted 2026-07-28, session-61):**
- [AnythingLLM Analysis — Two Questions](./cowork-to-ccode-2026-07-02-anythingllm-analysis.md) — `message` (Cowork → Claude Code) → refs the brief, path-correction, structure-deviations, and deviation-explanation above; asks whether the failure is a capability ceiling or a system-prompt design problem
- [AnythingLLM Analysis — Response](./ccode-to-cowork-2026-07-02-anythingllm-analysis.md) — `message` (Claude Code → Cowork) → refs the question above; names the "thinking partner" phrase-leak hypothesis for topic drift, treats checklist rubber-stamping as a separate capability-ceiling symptom, and recommends the config-file split while cautioning against expecting it to fully fix either symptom

---

## Thread 2 — The Four-Agent Test's Primary Evidence (2026-07-03)

- [Transcript of Conversation with Gemma 4 — January 2025](./OpenWEBUIandGemma4isWHACKED.md) — `summary` — raw evidence of AnythingLLM/Gemma's actual failure mode (fabricated paths, unauthorized writes); recovered after being nearly lost, see Open Decision #34. Referenced by the Thread 3 transcript and by Open Decision #36's correction to the four-agent-test diagnosis.

---

## Thread 3 — Foundation Layer Proposal & Capability Baseline (2026-07-08)

- [Foundation Layer — Framework and Plan for Independent Review](./cowork-to-ccode-2026-07-08-foundation-layer-proposal.md) — `message` (Cowork → Claude Code) → replied to by the context doc below
- [Foundation Layer Discussion — Context and Summary](./cowork-to-ccode-2026-07-08-foundation-layer-context.md) — `summary` (Cowork → Claude Code) — **typed `summary` not `message`**: self-describes as "my own reconstruction from session context, not a tool-verified extraction," explicitly defers to the real transcript below → refs the proposal above and the transcript below
- [Cameron & Cowork — Foundation Layer Conversation](./cameron-cowork-conversation-transcript-2026-07-08.md) — `transcript` — **partial capture, cuts off mid-conversation.** `superseded_by:` [Cameron & Cowork — Full Foundation-Layer Session, Mechanical Extraction](./cameron-cowork-conversation-transcript-full-2026-07-09.md) (Thread 4) → refs the context/proposal pair above and `OpenWEBUIandGemma4isWHACKED.md`
- [Foundation Layer — Independent Read](./ccode-to-cowork-2026-07-08-foundation-layer-independent-read.md) — `message` (Claude Code → Cowork) → responds to the proposal/context/transcript above
- [Foundation Layer — Consensus Update](./cowork-to-ccode-2026-07-08-consensus-update.md) — `message` (Cowork → Claude Code) → responds to the independent read above
- [Re: Foundation Layer Consensus Update](./ccode-to-cowork-2026-07-08-consensus-response.md) — `message` (Claude Code → Cowork) → closes the consensus loop, refs the update above
- [PROJECT_STATE.md — Capability Baseline Restructure Proposal](./ccode-to-cowork-2026-07-08-capability-baseline-restructure-proposal.md) — `message` (Claude Code → Cowork) — separate sub-thread, Open Decision #33
- [Re: Capability Baseline Restructure Proposal](./cowork-to-ccode-2026-07-08-capability-baseline-response.md) — `message` (Cowork → Claude Code) → responds to the restructure proposal above
- [Re: Capability Baseline Restructure — Cameron's Go-Ahead](./cowork-to-ccode-2026-07-08-capability-baseline-go-ahead.md) — `message` (Cowork → Claude Code) → closes the loop, refs both messages above
- [Foundation Layer — Session Origin: Capability Baseline Cleared, Pilot Still Pending](./cameron-claudecode-conversation-transcript-2026-07-08.md) — `transcript` — the Claude Code-side origin session for this whole thread; the file whose existence Cowork's AI-Prod-mirror review couldn't confirm on 2026-07-10 (false alarm — exists in the live repo, wasn't yet synced to the read-only mirror; see Open Decision #35)

---

## Thread 4 — Location Decision, Pilot, AI-Wiki Plan, Transcript Extraction (2026-07-09)

The day the OKF format was piloted for real (Open Decision #34), the location-in-repo question was settled, and the living-knowledgebase scope correction happened (Open Decision #35).

**Location decision:**
- [Foundation Layer — Reopening the Location Decision](./cowork-to-ccode-2026-07-09-location-reconsideration.md) — `message` (Cowork → Claude Code) → refs back to the 2026-07-08 consensus update (Thread 3)
- [Re: Location Reconsideration and Git Question](./cowork-to-ccode-2026-07-09-location-git-response.md) — `message` (Cowork → Claude Code)
- [Re: Foundation Layer — Location Reconsideration](./ccode-to-cowork-2026-07-09-location-git-response.md) — `message` (Claude Code → Cowork) → responds to the reconsideration above; this exchange settled `_messages/` as the answer

**Pilot (Open Decision #34):**
- [Foundation Layer — Pilot Run, Results](./ccode-to-cowork-2026-07-09-pilot-results.md) — `message` → refs the location-decision response above
- [Re: Pilot Run, Results](./cowork-to-ccode-2026-07-09-pilot-response.md) — `message` → responds to pilot-results
- [Foundation Layer — Transcript Pilot, Results](./ccode-to-cowork-2026-07-09-transcript-pilot-results.md) — `message` → refs the pilot-response above, the Thread 3 transcript, and `OpenWEBUIandGemma4isWHACKED.md`
- [Re: Transcript Pilot, Results](./cowork-to-ccode-2026-07-09-transcript-pilot-response.md) — `message` → responds to transcript-pilot-results
- [Foundation Layer — Pilot Question Closed, Auditor Deferred](./ccode-to-cowork-2026-07-09-pilot-close.md) — `message` → closes the loop, refs transcript-pilot-response

**`_config.yml` exclude recheck (small side-thread):**
- [Re: Urgent — _config.yml exclude Recheck](./ccode-to-cowork-2026-07-09-config-exclude-recheck.md) — `message`
- [Re: Urgent — _config.yml Exclude Recheck, Resolved](./cowork-to-ccode-2026-07-09-config-exclude-resolution.md) — `message` → responds to the recheck above

**LLM Wiki / AI-wiki plan (Open Decision #35's design conversation):**
- [Foundation Layer — AI Wiki vs. Human Query Layer, A Thinking Session](./cameron-claudecode-conversation-transcript-2026-07-09.md) — `transcript` — the full design conversation where the living-knowledgebase scope correction happened → refs the llm-wiki-question message below (its provenance note was stale on this point until 2026-07-10, fixed same day)
- [LLM Wiki — Cameron Found a Real, Concrete Implementation](./cowork-to-ccode-2026-07-09-llm-wiki-question.md) — `message` (Cowork → Claude Code) — originating question, nothing prior to refs
- [AI Wiki / Human Query Layer — A Plan for Your Independent Review](./ccode-to-cowork-2026-07-09-ai-wiki-plan-proposal.md) — `message` → refs the llm-wiki-question above and the design-conversation transcript
- [Re: AI Wiki / Human Query Layer — Independent Review](./cowork-to-ccode-2026-07-09-ai-wiki-plan-response.md) — `message` → responds to the plan proposal above; confirmed Cowork's real cross-file search capability

**Transcript-extraction proof (de-risks the historical backfill question, Open Decision #35):**
- [How to Capture a Conversation as a Genuine Transcript](./ccode-to-cowork-2026-07-09-transcript-capture-howto.md) — `message` → refs the design-conversation transcript and `OpenWEBUIandGemma4isWHACKED.md`
- [Re: How to Capture a Conversation as a Genuine Transcript](./cowork-to-ccode-2026-07-09-transcript-capture-response.md) — `message` → responds to the how-to above
- [Re: How the Transcript Got Made, and Sequencing](./ccode-to-cowork-2026-07-09-transcript-method-and-sequencing.md) — `message` → refs the ai-wiki-plan-response above
- [Re: How the Transcript Got Made, and Sequencing](./cowork-to-ccode-2026-07-09-transcript-method-response.md) — `message` → responds to the method/sequencing message above
- [Closed-Session Parsing — Tested, Works, Script Attached](./ccode-to-cowork-2026-07-09-transcript-extraction-result.md) — `message` → refs the method/sequencing message; Claude Code's side of the proof (`_ai-context/extract-session-transcript.ps1`)
- [Re: Closed-Session Parsing — Tested on Cowork's Side Too](./cowork-to-ccode-2026-07-09-my-extraction-result.md) — `message` → responds to the extraction-result above; Cowork's side of the proof

**Full transcripts of the day's live sessions:**
- [Cameron & Cowork — Full Foundation-Layer Session, Mechanical Extraction](./cameron-cowork-conversation-transcript-full-2026-07-09.md) — `transcript` — 137 turns, supersedes the Thread 3 partial → refs it directly

**Session close:**
- [Resume Tomorrow — Living-Knowledgebase Plan, Paused Mid-Decision](./ccode-and-cowork-2026-07-09-resume-tomorrow.md) — `message` — the handoff written at session-27's pause point → refs the design-conversation transcript, the ai-wiki plan proposal, and both sides of the transcript-extraction proof

---

## Thread 5 — Record-to-Instruction Traceability Demo (2026-07-10)

- [Record-to-Instruction Traceability — Demo](./ccode-to-cowork-2026-07-10-refs-to-instruction-demo.md) — `message` → refs the full 2026-07-09 transcript above (Thread 4) **and `../AI_INSTRUCTIONS.md` directly** — the first `refs:` link in this bundle pointing outside `_messages/` to a root instruction file. Proves Open Decision #35's capability #4 (record-to-instruction traceability) using the real Open Decision #36 finding, not a synthetic test case.

---

## Thread 6 — Cold-Walk Safeguard Point-4 Execution: OpenWork Standup and Findings (2026-07-18 to 2026-07-19)

Execution of `_ai-context/cold-walk-isolation-safeguard.md` point 4 against OpenWork and, in parallel, AnythingLLM — the OpenWork candidate named in Auditor Charter §9, and AnythingLLM as the alternative that emerged once OpenWork's results turned out disqualifying. Ends in OpenWork's disqualification and AnythingLLM cleared with conditions. See `_audit-findings/2026-07-18-openwork-point4-disqualification.md` and `_audit-findings/2026-07-19-anythingllm-point4-cleared-with-conditions.md` for the promoted findings.

**Standing it up — sequence, ownership, protocol:**
- [Standing Up OpenWork for the Cold-Walk Safeguard's Point-4 Check — Proposal](./cowork-to-ccode-2026-07-18-openwork-standup-proposal.md) — `message` (Cowork → Claude Code) — originating question, nothing prior to refs
- [Standing Up OpenWork for the Cold-Walk Safeguard's Point-4 Check — Independent Read](./ccode-to-cowork-2026-07-18-openwork-standup-response.md) — `message` (Claude Code → Cowork) → responds to the proposal above; settles ownership (Cameron runs steps 1–2 directly) and proposes the canary-based step-2 protocol
- [Step-2 Protocol for Point-4 — Independent Review](./cowork-to-ccode-2026-07-18-openwork-standup-step2-protocol-review.md) — `message` (Cowork → Claude Code) → responds to the protocol above
- [Step-2 Protocol — Cameron's Decision](./cowork-to-ccode-2026-07-18-openwork-standup-step2-decision.md) — `message` (Cowork → Claude Code) → closes the protocol sub-thread, refs both messages above

**Running it — empirical results and disposition:**
- [Point-4 Empirical Findings — OpenWork and AnythingLLM](./cowork-to-ccode-2026-07-18-point4-findings-openwork-anythingllm.md) — `message` (Cowork → Claude Code) — the raw empirical results (Verdance-7 canary leak, three OpenWork fabrications, AnythingLLM's parallel results) → refs all four standup-thread messages above
- [Point-4 Empirical Findings — Independent Read](./ccode-to-cowork-2026-07-18-point4-findings-response.md) — `message` (Claude Code → Cowork) → responds to the findings above; argues the cross-workspace leak, not the subagent test, is the headline disqualifying reason
- [Point-4 Findings — Cameron's Resolution of Open Items](./cowork-to-ccode-2026-07-18-point4-findings-cameron-decisions.md) — `message` (Cowork → Claude Code) → responds to the independent read above; narrows the fabrication finding after checking the underlying session log directly, confirms Personalization is API-reachable
- [Point-4 Findings — Final, Ready for Write-up](./cowork-to-ccode-2026-07-18-point4-findings-final.md) — `message` (Cowork → Claude Code) → closes the initial round, refs the resolution above; hands off the write-up decision (one finding or two for OpenWork; AnythingLLM placeholder or wait) and confirms AnythingLLM's spawn primitive is present but excluded by design

**Closing AnythingLLM's remaining gaps — tool disclosure, fabrication stress-test (2026-07-19):**
- [AnythingLLM's Remaining Point-4 Checks — Protocol Proposal](./ccode-to-cowork-2026-07-19-anythingllm-remaining-checks-protocol.md) — `message` (Claude Code → Cowork) — proposes method for the two items left open in the final message above → refs it directly
- [Re: AnythingLLM's Remaining Point-4 Checks — Independent Review](./cowork-to-ccode-2026-07-19-anythingllm-remaining-checks-response.md) — `message` (Cowork → Claude Code) → responds to the protocol above, adds a pointed sub-question to check 1 and a ground-truth-anchored claim for check 2's citation probe
- [AnythingLLM's Remaining Point-4 Checks — Results and Final Architecture Decision](./cowork-to-ccode-2026-07-19-anythingllm-checks-complete.md) — `message` (Cowork → Claude Code) → responds to the review above; both checks closed (one clean, one inconclusive), Document Summarizer cross-workspace test superseded by Cameron's single-dedicated-workspace architecture decision; hands off the final write-up call → see `_audit-findings/2026-07-19-anythingllm-point4-cleared-with-conditions.md` for the promoted finding

---

## Gaps this index doesn't close (yet)

- **Record-to-instruction traceability, the other direction** — Thread 5 proves a record can point *at* an instruction file; instruction files still can't point *back* — none carry OKF frontmatter or their own `refs:`. Separate, larger, still-deferred question raised 2026-07-09.
- **Obsidian graph compatibility** — every `refs:` above is a relative markdown link (`./file.md`), not an Obsidian `[[wikilink]]`. Confirmed 2026-07-10 that the Karpathy LLM Wiki plugin's retrieval-time PageRank only walks native `[[wikilink]]` connections — this index's links won't feed that specific mechanism without a separate conversion step.
- **The wider backlog** — Cameron requested 2026-07-24 that the *full* remaining `AI-Working/Messages/` backlog be promoted, not just the originally-flagged Jun 21–Jul 5 slice (see `AI-Working/Messages/cowork-to-ccode-2026-07-24-full-backlog-promotion-request.md`). Tiered rigor settled the same day (full manual rigor for anything cited by an Open Decision, the charter, or another canonical doc's `refs:`; heuristic — `Re:`-line-assisted, per-batch — for the routine bulk; see `cowork-to-ccode-2026-07-24-backlog-promotion-decisions.md`), then stalled: zero files promoted under it for four days while the source folder kept growing. Resumed 2026-07-28 (session-61) — Thread 1's architecture/OpenCode-readiness and AnythingLLM sub-threads above (batch-1: 19 files; batch-2: 10 files, the AnythingLLM system-prompt verification and first-draft deviation/analysis sub-thread) are the first two batches under the actual tiered approach, distinct from Thread 0's earlier full-rigor validation batch, using `_ai-context/prescan-backlog.ps1` to cut the per-file search cost. Verified count after batch-2: 398 unpromoted files remain (operational prompt-paste templates excluded by standing rule) — still higher than 2026-07-24's 343 despite two batches landing, since ordinary work keeps adding new files faster than promotion currently removes them. All pre-`_messages/` history on outside platforms (DeepSeek, ChatGPT, old AnythingLLM/Gemma sessions) remains separately out of scope — covered by `_ai-context/outside-conversation-capture-convention.md`, not this procedure. See Open Decision #35.
