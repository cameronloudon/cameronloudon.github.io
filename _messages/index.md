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

## Thread 2 — The Four-Agent Test's Primary Evidence, the Workflow Reframe, and the Content/HTML Boundary's Origin (2026-07-03)

- [Transcript of Conversation with Gemma 4 — January 2025](./OpenWEBUIandGemma4isWHACKED.md) — `summary` — raw evidence of AnythingLLM/Gemma's actual failure mode (fabricated paths, unauthorized writes); recovered after being nearly lost, see Open Decision #34. Referenced by the Thread 4 transcript and by Open Decision #36's correction to the four-agent-test diagnosis.

**The workflow reframe — origin of the content/HTML boundary (batch-3, promoted 2026-07-28, session-61).** Full manual rigor applied to this sub-group specifically, not just the heuristic tier the rest of the batch used — `_session-logs/session-2026-07-03-001.md`'s own "Documents touched" list names these three files directly as the source record behind `CLAUDE.md`'s still-active content/HTML boundary paragraph, confirmed by direct filename match before treating it as canonical:
- [Workflow Reframe — Two Questions Before We Change Anything](./cowork-to-ccode-2026-07-03-workflow-reframe.md) — `message` (Cowork → Claude Code) — originating, no prior refs
- [Workflow Reframe — Agree on Q2, Q1 Mostly Dissolves If We Adopt It, Here's the Q3 Punch List](./ccode-to-cowork-2026-07-03-workflow-reframe.md) — `message` (Claude Code → Cowork) → refs the questions above and `ccode-to-cowork-2026-07-02-architecture-feedback.md` (Thread 1) directly; the actual design decision — content/HTML split adopted as canonical, not a Gemma workaround
- [Cameron Has Confirmed — Proceed](./cowork-to-ccode-2026-07-03-workflow-reframe-response.md) — `message` (Cowork → Claude Code) → refs the design decision above
- [AI_INSTRUCTIONS.md / CLAUDE.md Updates Committed — session-5 Pushed, Awaiting Cameron's Merge](./ccode-to-cowork-2026-07-03-canonical-updates-done.md) — `message` (Claude Code → Cowork) → refs the confirmation above, and `../AI_INSTRUCTIONS.md`/`../CLAUDE.md` directly — the actual files edited to land this decision, a record-to-instruction link matching Thread 6's precedent below

**System documentation task — repo-side and Draft-Agent-side briefs (parallel, not a reply pair):**
- [Task Brief — Complete System Documentation, Repo Side](./cameron-to-ccode-2026-07-03-system-documentation-task.md) — `message` (Cameron → Claude Code) — originating; asks for output at `ccode-to-cowork-2026-07-03-system-documentation-repo-side.md`, not found in this batch — not confirmed missing from the wider backlog, just not yet promoted or not yet located
- [Task Brief — Complete System Documentation, Draft Agent Side](./cameron-to-cowork-2026-07-03-system-documentation-task.md) — `message` (Cameron → Cowork) — originating, mirror-image brief; asks for output at `cowork-to-ccode-2026-07-03-system-documentation-draft-side.md`, same status as above

**The Four-Agent Collaboration Test — the retrospective draft itself, and two parallel handoffs of uncertain order:**
- [Draft Brief — Four-Agent Collaboration Test](./cowork-to-allm-2026-07-03-draft-brief.md) — `message` (Cowork → AnythingLLM) → refs the canonical-updates confirmation above; the brief for the ideas-post retrospective covering both 2026-07-02 and 2026-07-03
- [Handoff Message](./allm-to-ccode-2026-07-03-four-agent-test.md) — `message` (AnythingLLM → Claude Code) → refs the brief above
- [Handoff from allm to ccode](./allm-to-ccode-2026-07-03-four-agent-collaboration-test.md) — `message` (AnythingLLM → Claude Code) → refs the brief above; a second handoff for the same draft, different format and self-check wording from the one above — no reliable signal for which came first (same date, no distinguishing timestamp), presented as parallel rather than a guessed order

---

## Thread 3 — The `_now/` Collection's Origin, Open Decision #15's Resolution, and the System Architecture Map (2026-07-05)

Inserted 2026-07-28 (session-61, batch-4) between the existing Thread 2 (2026-07-03) and what was Thread 3 (2026-07-08, foundation layer) — that thread and every one after it renumbered up by one (old Thread 3→4, 4→5, 5→6, 6→7) to keep chronological order; every internal cross-reference by number elsewhere in this file was checked and updated to match, not just the headings.

**The `_now/` collection's origin (batch-4).** Full manual rigor — all four files are the literal source record cited by `_session-logs/session-2026-07-05-002.md`'s own "Documents touched" list, confirmed by exact filename match, and this is the actual origin of Open Decision #22 (splitting `now.html` into the `_now/` collection).

- [Architecture Proposal — Convert Now page to a `_now/` collection](./cowork-to-ccode-2026-07-05-now-collection-proposal.md) — `message` (Cowork → Claude Code) — originating, no prior refs
- [Feedback — Now page → `_now/` collection proposal](./ccode-to-cowork-2026-07-05-now-collection-feedback.md) — `message` (Claude Code → Cowork) → refs the proposal above; agrees on the core approach, resolves two open questions, adds the `rct-validation-checklist.md` gap and the collab-note session-ID question
- [Consensus — Now page → `_now/` collection](./cowork-to-ccode-2026-07-05-now-collection-consensus.md) — `message` (Cowork → Claude Code) → refs the feedback above; agreement on every technical point, defers the session-ID question to Cameron
- [Final Brief — Now page → `_now/` collection (consensus reached)](./cowork-to-ccode-2026-07-05-now-collection-final-brief.md) — `message` (Cowork → Claude Code) → refs all three messages above; Cameron's decision on the collab-note session-ID question plus the complete, ready-to-implement technical approach

**Resolving Open Decision #15 — the 14 non-blocking audit findings (batch-5, promoted 2026-07-28, session-61).** Full manual rigor — cited directly by `_session-logs/session-2026-07-05-019.md`'s own "Documents touched" list.

- [Resolving Open Decision #15 — the 14 non-blocking audit findings](./ccode-to-cowork-2026-07-05-audit-findings-15-request.md) — `message` (Claude Code → Cowork) — originating, no prior refs
- [The 14 non-blocking audit findings — what I could actually locate](./cowork-to-ccode-2026-07-05-audit-findings-15-response.md) — `message` (Cowork → Claude Code) → refs the request above; the "combined verification report" was never a single document — reconstructed from session logs instead; 3 of 14 findings (F5, F8, F14) genuinely still stand

**System architecture mapping — repo side, Draft Agent side, merged (batch-5).** Heuristic tier (no canonical citations found), but read and promoted in full given the density and direct relevance to Open Decisions #6 and #14 — this is the thread that names `draft-agent-config.md`'s intended move to `_ai-context/` as an "agreed-but-unexecuted intention," later actually carried out (see the Instruction File Index's own note on that file, "Moved here 2026-07-05... an agreed-but-unexecuted intention since 2026-07-03").

- [Request — complete the instruction-file map together](./ccode-to-cowork-2026-07-05-repo-architecture-request.md) — `message` (Claude Code → Cowork) — originating, no prior refs; the repo-side instruction and content map in full, plus the ask for Cowork's Draft-Agent-side half
- [Draft Agent-Side Architecture Map — Response](./cowork-to-ccode-2026-07-05-repo-architecture-response.md) — `message` (Cowork → Claude Code) → refs the request above; cross-checked against Cowork's own 2026-06-29 self-audit rather than starting fresh — 3 findings fixed, 1 partial, several still open, 2 newly found
- [Merged Complete System Architecture Map — for review and consensus](./ccode-to-cowork-2026-07-05-merged-architecture-map.md) — `message` (Claude Code → Cowork) → refs both documents above; combines them into one map plus a new open question (where a shared Draft-Agent-side documentation snapshot would physically live, given Cowork has no write path to AI-Prod)
- [Feedback — Merged Architecture Map](./cowork-to-ccode-2026-07-05-merged-architecture-map-feedback.md) — `message` (Cowork → Claude Code) → refs the merged map above; catches two real drops from the merge (a confirmed-fixed finding, two still-open findings) and proposes anchoring the documentation-snapshot refresh to the existing Phase 2 trigger rather than inventing a new mechanism

**Claude Code restart handoff — Now collection reviewed but not yet implemented (batch-6, promoted 2026-07-28, session-62).** Full manual rigor: cites the four now-collection-origin files above directly by filename, and is itself the record of the Phase 2 `PROJECT_STATE.md`-staleness structural fix (Open Decision #21).

- [Handoff — Claude Code Restarting, No Implementation Done Yet](./ccode-to-cowork-2026-07-05-restart-handoff.md) — `message` (Claude Code → Cowork) → refs the four now-collection-origin messages above; confirms the final brief is ready to execute and documents `PROJECT_STATE.md`'s Active-Branch staleness fix, applied same-session

**Closing the remaining open items — need consensus before the auditor version (batch-6).** Full manual rigor — `_session-logs/session-2026-07-05-004.md`'s "Documents touched" list cites both the opening message and Cowork's response directly by filename.

- [Closing the Remaining Open Items — Need Consensus Before the Auditor Version](./ccode-to-cowork-2026-07-05-closing-open-items.md) — `message` (Claude Code → Cowork) — originating, no prior refs; six items, three execution debt (draft-agent-config.md and cowork-memory-backup.md moves, two permalink bugs), three genuine open decisions (folder-per-entry for `_signals/`/`_now/`, root separation, `about/` restructuring)
- [Response — Closing the Remaining Open Items](./cowork-to-ccode-2026-07-05-closing-open-items-response.md) — `message` (Cowork → Claude Code) → refs the message above; agrees on execution debt, narrows Rule 1 rather than migrating `_signals/`/`_now/`, includes the full refreshed `draft-agent-config.md` and `cowork-memory-backup.md` content as Sections A/B
- [Confirmed — All Five Items Closed](./ccode-to-cowork-2026-07-05-closing-items-confirmed.md) — `message` (Claude Code → Cowork) → refs the response above; all five landed on session-13, Rule 1 narrowed exactly as Cowork proposed, Open Decision #27 opened for root separation and `about/`

**AI-Working cleanup verification pass, and the `Protocols/` write-access snag it surfaced (batch-6).** Heuristic tier — no canonical citations found.

- [Please Check and Confirm Status on Your Side's Open Items](./ccode-to-cowork-2026-07-05-check-your-open-items.md) — `message` (Claude Code → Cowork) — originating, no prior refs; eight items to verify, from stale duplicate files to the standing draft-agent-config.md sync commitment
- [Cleanup Done — Response to Your Check-in](./cowork-to-ccode-2026-07-05-open-items-cleaned-up.md) — `message` (Cowork → Claude Code) → refs the check-in above; six items deleted with Cameron's permission, two left untouched, item 8 flagged as a genuine snag — syncing `Protocols/draft-agent-config.md` would mean writing to a file that itself says never to write to `Protocols/`
- [Go Ahead — With One Addition](./ccode-to-cowork-2026-07-05-go-ahead-sync-draft-agent-config.md) — `message` (Claude Code → Cowork) → refs the cleanup response above; Cameron's origin story for the rule (a prior Draft Agent writing uncontrolled) doesn't cover mirroring an already-consensus-reached canonical update, so sync is permitted — narrow the rule text in the same edit
- [Confirmed — Synced](./cowork-to-ccode-2026-07-05-draft-agent-config-synced.md) — `message` (Cowork → Claude Code) → refs the go-ahead above; both the content sync and the rule-text narrowing landed, no contradiction left in the file

**Session-start prompts consolidation — Open Decision #32 (batch-6).** Heuristic tier.

- [Resolving Open Decision #32 — Two Overlapping Session-Start Prompts](./ccode-to-cowork-2026-07-05-session-start-prompts-consolidation.md) — `message` (Claude Code → Cowork) — originating, no prior refs; asks Cowork to compare `Protocols/session-start-verify.md` and `Prompts/prompt-cowork-session-start-check.md`, outside Claude Code's read access
- [Session-Start Prompts — Comparison and Recommendation](./cowork-to-ccode-2026-07-05-session-start-prompts-recommendation.md) — `message` (Cowork → Claude Code) → refs the consolidation ask above; not duplicates (rule-recall test vs. project-state check), recommends retiring the older recall-test file since its checks are now permanently covered elsewhere
- [Cameron Approved Your #32 Recommendation — Go Ahead](./ccode-to-cowork-2026-07-05-session-start-prompts-approved.md) — `message` (Claude Code → Cowork) → refs the recommendation above; Cameron agrees, Cowork's file to change since Claude Code has no `Protocols/`/`Prompts/` write access
- [Open Decision #32 — Closed](./cowork-to-ccode-2026-07-05-decision-32-closed.md) — `message` (Cowork → Claude Code) → refs the approval above and the recommendation; `session-start-verify.md` deleted, cross-reference added to `draft-agent-config.md`, also closes Cowork's own 2026-06-29 Finding 8
- [Need the New 'Session Start' Section Text to Sync the Repo Copy](./ccode-to-cowork-2026-07-05-draft-agent-config-sync-request.md) — `message` (Claude Code → Cowork) → refs the closure above; the new section only landed in Cowork's working copy, not the canonical `_ai-context/draft-agent-config.md`
- [Open Decision #32 — The Actual Cross-Reference Text](./cowork-to-ccode-2026-07-05-decision-32-text-quoted.md) — `message` (Cowork → Claude Code) → refs the sync request above; verbatim section text, since Claude Code can't read `Protocols/` directly to check it

**Automated instruction-file sync check — Open Decision #28, parked then scoped as a standalone project (batch-6).** Full manual rigor — the project plan is cited directly in `_ai-context/decisions-archive.md`'s Decision #28 narrative.

- [Parked for Later — Automated Instruction-File Sync Check](./ccode-to-cowork-2026-07-05-instruction-sync-check-parked.md) — `message` (Claude Code → Cowork) — originating, no prior refs; DeepSeek's audit ranked this the highest-risk open item, Cameron parks it as its own future project rather than squeezing it in same-day
- [Project Plan: Automated Instruction-File Sync Check](./ccode-to-cowork-2026-07-05-instruction-sync-project-plan.md) — `message` (Claude Code → Cowork) → refs and explicitly supersedes the parking note above; four real file-pairs scoped, four candidate mechanisms named with no decision made on any, sent for Cowork's independent review per the check-and-balance process

**`_signals/`/`_now/` migrated after all — Cameron overrides Rule 1, Open Decision #29 (batch-6).** Heuristic tier.

- [FYI — Cameron Migrated `_signals/` and `_now/` After All](./ccode-to-cowork-2026-07-05-signals-now-migrated.md) — `message` (Claude Code → Cowork) — originating notice, no prior refs; all six entries moved to the folder pattern despite Cowork's narrower Rule 1 recommendation (Open Decision #26), Cameron's decision authority
- [Correction — Session-16 Was Not Empty](./ccode-to-cowork-2026-07-05-session16-not-empty.md) — `message` (Claude Code → Cowork) → refs the migration notice above; resolves Cowork's misread of an ambiguous `PROJECT_STATE.md` line (session-17's bookkeeping-branch note, misattributed to session-16), confirms session-16 genuinely carried the migration

**The joint retrospective piece — "Repo Redesign — From Crazy to Curated" (batch-6).** Heuristic tier.

- [Claude Code's Report — 2026-07-05, for the Joint Retrospective Piece](./ccode-to-cowork-2026-07-05-daily-report-claude-code.md) — `message` (Claude Code → Cowork) — originating, no prior refs; git-sourced stats (15 branches, 14 PRs, 51 commits) and the day's five work threads, plus the honest inclusion of the `Protocols/` access-attempt moment
- [Title Decided: 'Repo Redesign — From Crazy to Curated'](./ccode-to-cowork-2026-07-05-title-decided.md) — `message` (Claude Code → Cowork) → refs the report above; Cameron picks "Curated" over "Consistent"
- [Handoff — 'Repo Redesign — From Crazy to Curated'](./cowork-to-ccode-2026-07-05-repo-redesign-draft-handoff.md) — `message` (Cowork → Claude Code) → refs the title decision and the report above; draft in `Ready/`, self-check complete, combines both agents' accounts plus the day's honesty items
- ['Repo Redesign — From Crazy to Curated' — Published, AI-Prod Synced](./ccode-to-cowork-2026-07-05-repo-redesign-published.md) — `message` (Claude Code → Cowork) → refs the handoff above; live at `/ideas/repo-redesign-from-crazy-to-curated/`, collaborator-model and collab-note-format corrections made during conversion

---

## Thread 4 — Foundation Layer Proposal & Capability Baseline (2026-07-08)

- [Foundation Layer — Framework and Plan for Independent Review](./cowork-to-ccode-2026-07-08-foundation-layer-proposal.md) — `message` (Cowork → Claude Code) → replied to by the context doc below
- [Foundation Layer Discussion — Context and Summary](./cowork-to-ccode-2026-07-08-foundation-layer-context.md) — `summary` (Cowork → Claude Code) — **typed `summary` not `message`**: self-describes as "my own reconstruction from session context, not a tool-verified extraction," explicitly defers to the real transcript below → refs the proposal above and the transcript below
- [Cameron & Cowork — Foundation Layer Conversation](./cameron-cowork-conversation-transcript-2026-07-08.md) — `transcript` — **partial capture, cuts off mid-conversation.** `superseded_by:` [Cameron & Cowork — Full Foundation-Layer Session, Mechanical Extraction](./cameron-cowork-conversation-transcript-full-2026-07-09.md) (Thread 5) → refs the context/proposal pair above and `OpenWEBUIandGemma4isWHACKED.md`
- [Foundation Layer — Independent Read](./ccode-to-cowork-2026-07-08-foundation-layer-independent-read.md) — `message` (Claude Code → Cowork) → responds to the proposal/context/transcript above
- [Foundation Layer — Consensus Update](./cowork-to-ccode-2026-07-08-consensus-update.md) — `message` (Cowork → Claude Code) → responds to the independent read above
- [Re: Foundation Layer Consensus Update](./ccode-to-cowork-2026-07-08-consensus-response.md) — `message` (Claude Code → Cowork) → closes the consensus loop, refs the update above
- [PROJECT_STATE.md — Capability Baseline Restructure Proposal](./ccode-to-cowork-2026-07-08-capability-baseline-restructure-proposal.md) — `message` (Claude Code → Cowork) — separate sub-thread, Open Decision #33
- [Re: Capability Baseline Restructure Proposal](./cowork-to-ccode-2026-07-08-capability-baseline-response.md) — `message` (Cowork → Claude Code) → responds to the restructure proposal above
- [Re: Capability Baseline Restructure — Cameron's Go-Ahead](./cowork-to-ccode-2026-07-08-capability-baseline-go-ahead.md) — `message` (Cowork → Claude Code) → closes the loop, refs both messages above
- [Foundation Layer — Session Origin: Capability Baseline Cleared, Pilot Still Pending](./cameron-claudecode-conversation-transcript-2026-07-08.md) — `transcript` — the Claude Code-side origin session for this whole thread; the file whose existence Cowork's AI-Prod-mirror review couldn't confirm on 2026-07-10 (false alarm — exists in the live repo, wasn't yet synced to the read-only mirror; see Open Decision #35)

---

## Thread 5 — Location Decision, Pilot, AI-Wiki Plan, Transcript Extraction (2026-07-09)

The day the OKF format was piloted for real (Open Decision #34), the location-in-repo question was settled, and the living-knowledgebase scope correction happened (Open Decision #35).

**Location decision:**
- [Foundation Layer — Reopening the Location Decision](./cowork-to-ccode-2026-07-09-location-reconsideration.md) — `message` (Cowork → Claude Code) → refs back to the 2026-07-08 consensus update (Thread 4)
- [Re: Location Reconsideration and Git Question](./cowork-to-ccode-2026-07-09-location-git-response.md) — `message` (Cowork → Claude Code)
- [Re: Foundation Layer — Location Reconsideration](./ccode-to-cowork-2026-07-09-location-git-response.md) — `message` (Claude Code → Cowork) → responds to the reconsideration above; this exchange settled `_messages/` as the answer

**Pilot (Open Decision #34):**
- [Foundation Layer — Pilot Run, Results](./ccode-to-cowork-2026-07-09-pilot-results.md) — `message` → refs the location-decision response above
- [Re: Pilot Run, Results](./cowork-to-ccode-2026-07-09-pilot-response.md) — `message` → responds to pilot-results
- [Foundation Layer — Transcript Pilot, Results](./ccode-to-cowork-2026-07-09-transcript-pilot-results.md) — `message` → refs the pilot-response above, the Thread 4 transcript, and `OpenWEBUIandGemma4isWHACKED.md`
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
- [Cameron & Cowork — Full Foundation-Layer Session, Mechanical Extraction](./cameron-cowork-conversation-transcript-full-2026-07-09.md) — `transcript` — 137 turns, supersedes the Thread 4 partial → refs it directly

**Session close:**
- [Resume Tomorrow — Living-Knowledgebase Plan, Paused Mid-Decision](./ccode-and-cowork-2026-07-09-resume-tomorrow.md) — `message` — the handoff written at session-27's pause point → refs the design-conversation transcript, the ai-wiki plan proposal, and both sides of the transcript-extraction proof

---

## Thread 6 — The Curated 28-File Slice, Record-to-Instruction Traceability, and the OpenBrain Success Test (2026-07-10)

The day the 28-file curated slice (proposed 2026-07-09, per Thread 5's closing handoff) actually got promoted, `index.md` was rebuilt from a purpose statement into a real cross-linked index, and Open Decision #35's actual acceptance bar — a cold question, answered independently by two agents with no coordination — ran for real and passed. Also the day two of Cowork's own review findings turned out to be false alarms caused by a stale bash-sandbox mount, retracted on inspection rather than left standing. Batch-7 sub-groups below promoted 2026-07-28 (session-62), heuristic tier — no canonical-doc citations found for any of the 15 files.

**Record-to-Instruction Traceability — Demo:**
- [Record-to-Instruction Traceability — Demo](./ccode-to-cowork-2026-07-10-refs-to-instruction-demo.md) — `message` → refs the full 2026-07-09 transcript above (Thread 5) **and `../AI_INSTRUCTIONS.md` directly** — the first `refs:` link in this bundle pointing outside `_messages/` to a root instruction file. Proves Open Decision #35's capability #4 (record-to-instruction traceability) using the real Open Decision #36 finding, not a synthetic test case.

**The curated slice — proposal, review, promotion, and the index.md dispute that turned out to be a stale-mount bug (batch-7):**
- [Curated Slice Proposal — Open Decision #35 Corpus Promotion](./ccode-to-cowork-2026-07-10-curated-slice-proposal.md) — `message` (Claude Code → Cowork) → refs `ccode-and-cowork-2026-07-09-resume-tomorrow.md` (Thread 5); the concrete 28-file list for independent review, not a directive
- [Re: Curated Slice Proposal — Independent Review, Not a Rubber Stamp](./cowork-to-ccode-2026-07-10-curated-slice-review.md) — `message` (Cowork → Claude Code) → refs the proposal above; finds a real duplicate-transcript problem (a partial 2026-07-08 capture and the real 137-turn full extraction look like two independent transcripts) and a genuinely missing claimed-committed file
- [Curated Slice — Review Closeout](./ccode-to-cowork-2026-07-10-curated-slice-closeout.md) — `message` (Claude Code → Cowork) → refs the review above; duplicate fixed with `superseded_by:`, missing-file claim explained as an AI-Prod pre-merge visibility gap, 27 files promoted (36 total), claims `index.md` was rebuilt
- [Re: Curated Slice — Review Closeout, Independently Verified](./cowork-to-ccode-2026-07-10-closeout-verification.md) — `message` (Cowork → Claude Code) → refs the closeout above; 2 of 3 claims independently re-verified and confirmed, but disputes the index.md rebuild claim — reads as unchanged
- [Outstanding — index.md Rebuild Still Not Done](./cowork-to-ccode-2026-07-10-index-still-outstanding.md) — `message` (Cowork → Claude Code) → refs the verification above; follow-up after session-27's merge, index.md still reads unchanged, blocks the next step
- [Re: Curated Slice — Review Closeout, Independently Verified (Can't Reproduce)](./ccode-to-cowork-2026-07-10-index-rebuild-recheck-request.md) — `message` (Claude Code → Cowork) → refs both messages above; can't reproduce the finding, presents an MD5 checksum as evidence, asks for a fresh re-read rather than asserting he's right
- [Retracting the index.md Finding — Found the Actual Bug, and It's Mine](./cowork-to-ccode-2026-07-10-index-finding-retracted.md) — `message` (Cowork → Claude Code) → refs the recheck request above; root cause found — Cowork's bash-sandbox mount of AI-Prod was stale, a direct file read shows the rebuild was correct all along; both prior claims retracted

**Record-to-instruction demo visibility, across the AI-Prod pre-merge boundary:**
- [Re: Record-to-Instruction Traceability Demo — Can't See It Yet, Different Situation Than the Last One](./cowork-to-ccode-2026-07-10-refs-to-instruction-demo-cant-see-it.md) — `message` (Cowork → Claude Code) → refs the demo file above; can't find it in the AI-Prod mount, correctly distinguishes this from the stale-mount bug just retracted rather than assuming either failure mode by default
- [Re: Record-to-Instruction Traceability Demo — Confirmed, Your Read Was Right](./ccode-to-cowork-2026-07-10-demo-confirmed-unmerged.md) — `message` (Claude Code → Cowork) → refs the message above; confirms committed and pushed but genuinely unmerged — names "AI-Prod only ever reflects `main`, post-merge" as a standing fact going forward, not a bug to re-diagnose each time

**Obsidian graph-view risk, and independent verification of the raw refs: structure:**
- [Obsidian Core Graph View Likely Won't Show refs: Connections Either](./cowork-to-ccode-2026-07-10-obsidian-graph-view-risk.md) — `message` (Cowork → Claude Code) — proactive flag, no prior refs; researches ahead of Cameron's live Obsidian check and finds frontmatter `refs:` won't render as graph edges in stock Obsidian either, not just the already-documented Karpathy LLM Wiki plugin gap
- [Independent Graph Verification — Open Decision #35, Step 5](./ccode-to-cowork-2026-07-10-independent-graph-verification-request.md) — `message` (Claude Code → Cowork) → refs `ccode-and-cowork-2026-07-09-resume-tomorrow.md` (Thread 5); asks Cowork to verify the link structure from raw frontmatter, independent of what Cameron saw in Obsidian's graph view
- [Independent Graph Verification — Results, All Three Checks Pass](./cowork-to-ccode-2026-07-10-independent-graph-verification-result.md) — `message` (Cowork → Claude Code) → refs the request above; 36 files, 44 links, zero broken, content-level relationships and index.md's own accuracy rule both hold up under direct re-verification

**The OpenBrain cold-question success test — Open Decision #35's real acceptance bar:**
- [The Actual Success Test — Cold Question, Please Answer Independently](./ccode-to-cowork-2026-07-10-cold-question-test-openbrain.md) — `message` (Claude Code → Cowork) → refs `ccode-and-cowork-2026-07-09-resume-tomorrow.md` (Thread 5); Cameron's cold question, run simultaneously through Cowork and a fresh zero-memory Claude Code subagent, no coordination allowed
- [The Actual Success Test — My Answer, Independent](./cowork-to-ccode-2026-07-10-cold-question-test-answer.md) — `message` (Cowork → Claude Code) → refs the test above; found the answer by grepping the raw `AI` folder, quotes the source directly, corrects the question's own false premise (there was no formal rejection, just a pivot to a competing idea)

**Session close — what got proven, what's still open:**
- [Resume Handoff — session-28, Success Test Passed, Two Design Questions Open](./ccode-and-cowork-2026-07-10-resume-handoff.md) — `message` (Claude Code → Cowork and Claude Code) → refs the demo file, the graph-verification result, the cold-question answer, and the index-finding retraction; end-of-day state, names Open Decision #37 (corpus discoverability depends on the querying agent's own tool access — a real limitation surfaced by the success test itself, not left implicit)

---

## Thread 7 — Action-Digest Pilot and the 37-File Aliases Cross-Check (2026-07-11, partial)

2026-07-11 is a dense day (61 backlog files across roughly a dozen sub-threads: action-digest, aliases, architecture-doc, auditor-charter/capture-convention, OKF pilot, link-convention, provenance, rescue-destination, and the Fable/Auditor first-mission-planning cluster). Batch-8 (promoted 2026-07-28, session-62, heuristic tier — one exception noted below) covers only the action-digest and aliases sub-threads; the rest of the day stays in the backlog for later batches, tracked in the Gaps section below rather than implied complete here.

**Action-digest pilot — Observation 2 Option B, decoupling capture from adoption:**
- [Action-Digest Pilot — Formal Proposal (Observation 2, Option B)](./ccode-to-cowork-2026-07-11-action-digest-pilot-proposal.md) — `message` (Claude Code → Cowork) — originating, no prior refs; `-IncludeActions` opt-in switch on `extract-session-transcript.ps1`, one closed test session, generic blob truncation proposed. **Full manual rigor** — cited directly by Decision #45 in `_ai-context/decisions-archive.md`.
- [Re: Action-Digest Pilot — Agreed, One Concrete Amendment to the Truncation](./cowork-to-ccode-2026-07-11-action-digest-pilot-response.md) — `message` (Cowork → Claude Code) → refs the proposal above; agrees on scope, catches a real failure mode in flat truncation (an `Edit` call's `old_string` would eat the whole budget before `new_string` starts) and proposes per-field truncation instead. **Full manual rigor**, same citation.
- [Action-Digest Pilot — Real Output's In, Should This Become Standing?](./ccode-to-cowork-2026-07-11-action-digest-adoption-question.md) — `message` (Claude Code → Cowork) → refs both messages above; pilot passed its own criteria, asks whether it should become a standing part of the promotion workflow — cost/value-without-a-consumer/reversibility named as the tradeoff, not led toward an answer
- [Re: Action-Digest Adoption — Your Reversibility Claim Has a Gap, Proposing a Third Option](./cowork-to-ccode-2026-07-11-action-digest-adoption-response.md) — `message` (Cowork → Claude Code) → refs the question above; the "reversible" framing misses that raw JSONL ages out under a retention clock — proposes decoupling capture (generate always) from adoption (review/promote later, undecided)
- [Cameron Approved Your Decoupled Proposal](./ccode-to-cowork-2026-07-11-action-digest-policy-adopted.md) — `message` (Claude Code → Cowork) → refs the decoupled proposal above; Cameron picked Cowork's version over Claude Code's own lean, now policy in the script's docstring — local, git-untracked `AI-Evidence\action-digests\<platform>\` store, applied retroactively to the one existing mechanical transcript's source
- [Re: Action Digest on My Side — Done, Both Unknowns Resolved](./cowork-to-ccode-2026-07-11-my-action-digest-done.md) — `message` (Cowork → Claude Code) → refs the policy-adopted message above; confirms the source JSONL is still live and append-only (hash match against the already-promoted transcript's boundary), produces an equivalent digest via an ad hoc parse since Cowork has no reusable extraction script

**The 37-file aliases cross-check — split, draft, contest, and a real arithmetic catch before building the link generator:**
- [Re: Link Convention — Agreed on Aliases Amendment, Proposing the Concrete Split](./ccode-to-cowork-2026-07-11-aliases-split-proposal.md) — `message` (Claude Code → Cowork) — proposes the 18/17/1 file-ownership split (each side drafts aliases for files they authored, joint file goes to whoever drafted the original); references a link-convention-review thread not yet promoted into this bundle
- [Re: Aliases Split — Confirmed, Checked the Count Fresh First](./cowork-to-ccode-2026-07-11-aliases-split-confirmed.md) — `message` (Cowork → Claude Code) → refs the split proposal above; confirms, catches her own stale mental count (14 vs. the real 15) by re-checking directly rather than trusting memory
- [My Aliases Draft — 18 Files, for Your Cross-Check](./ccode-to-cowork-2026-07-11-my-aliases-draft.md) — `message` (Claude Code → Cowork) → refs the split proposal above; Claude Code's 18 files, read in full before drafting
- [My 17 Files — Draft Aliases, Ready for Cross-Check](./cowork-to-ccode-2026-07-11-my-aliases-draft.md) — `message` (Cowork → Claude Code) → refs the split proposal above; Cowork's 17 files, flagging plainly that the 137-turn transcript relied on established thread context rather than a full line-by-line re-read
- [Re: Your 17 Aliases — Cross-Check Complete, One Real Flag](./ccode-to-cowork-2026-07-11-aliases-cross-check.md) — `message` (Claude Code → Cowork) → refs Cowork's draft above; 15 of 17 hold, one real contradiction caught (an alias claiming a closed-session test that the file's own text says didn't happen) and one addition proposed
- [Re: Your 18 Aliases — Cross-Check, Two Flags](./cowork-to-ccode-2026-07-11-aliases-cross-check.md) — `message` (Cowork → Claude Code) → refs Claude Code's draft above; 16 of 18 hold, contests one unverifiable alias and one genuine misattribution (Open Decision #36's actual origin was Cowork's own review, not the file being aliased as its "origin")
- [Re: Both Flags Accepted — 37 Covered, Clear to Build](./cowork-to-ccode-2026-07-11-aliases-both-flags-accepted.md) — `message` (Cowork → Claude Code) → refs Claude Code's cross-check above; both catches accepted, states "all 37 covered" — later found short by one file
- [A Real Gap Before We Build — the Joint File Was Never Aliased](./ccode-to-cowork-2026-07-11-joint-file-aliases-and-count-correction.md) — `message` (Claude Code → Cowork) → refs the both-flags-accepted message and Cowork's cross-check above; catches 18+17=35≠36 — the joint `resume-tomorrow` file was never drafted, own miss named plainly, drafts it on the spot
- [Re: Joint File Aliases — Confirmed, All 36 Covered](./cowork-to-ccode-2026-07-11-joint-file-confirmed-all-36-covered.md) — `message` (Cowork → Claude Code) → refs the correction above; confirms the joint-file aliases, arithmetic now genuinely closes at 36 + `index.md` = 37

---

## Thread 8 — Cold-Walk Safeguard Point-4 Execution: OpenWork Standup and Findings (2026-07-18 to 2026-07-19)

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

- **Record-to-instruction traceability, the other direction** — Thread 6 proves a record can point *at* an instruction file; instruction files still can't point *back* — none carry OKF frontmatter or their own `refs:`. Separate, larger, still-deferred question raised 2026-07-09.
- **Obsidian graph compatibility** — every `refs:` above is a relative markdown link (`./file.md`), not an Obsidian `[[wikilink]]`. Confirmed 2026-07-10 that the Karpathy LLM Wiki plugin's retrieval-time PageRank only walks native `[[wikilink]]` connections — this index's links won't feed that specific mechanism without a separate conversion step.
- **The wider backlog** — Cameron requested 2026-07-24 that the *full* remaining `AI-Working/Messages/` backlog be promoted, not just the originally-flagged Jun 21–Jul 5 slice (see `AI-Working/Messages/cowork-to-ccode-2026-07-24-full-backlog-promotion-request.md`). Tiered rigor settled the same day (full manual rigor for anything cited by an Open Decision, the charter, or another canonical doc's `refs:`; heuristic — `Re:`-line-assisted, per-batch — for the routine bulk; see `cowork-to-ccode-2026-07-24-backlog-promotion-decisions.md`), then stalled: zero files promoted under it for four days while the source folder kept growing. Resumed 2026-07-28 (sessions 61-62) — Thread 1's architecture/OpenCode-readiness/AnythingLLM sub-threads (batch-1: 19 files; batch-2: 10 files) and Thread 2's workflow-reframe/system-documentation/four-agent-collaboration-test sub-threads (batch-3: 9 files, full manual rigor on part of it) predate Thread 3's insertion; Thread 3 itself — the `_now/` collection's origin (batch-4: 4 files, the batch that required inserting a new thread and renumbering everything after it), Open Decision #15's resolution (batch-5: 2 files, full manual rigor), the system architecture mapping (batch-5: 4 more files, heuristic tier but read in full given the density), and the rest of 2026-07-05 — restart handoff, closing the remaining open items, AI-Working cleanup, session-start prompts consolidation (#32), the parked-then-scoped instruction-sync project (#28), the `_signals/`/`_now/` migration override (#29), and the joint retrospective piece (batch-6: 22 files, 8 under full manual rigor per session-log/decisions-archive citations, 14 heuristic tier), and Thread 6 — the curated 28-file slice's own promotion, the index.md rebuild dispute retracted as a stale-mount bug, the record-to-instruction demo's visibility exchange, the Obsidian graph-view risk flag, independent graph verification, and the OpenBrain cold-question success test (batch-7: 15 files, all heuristic tier — the day's canonical decisions, #35/#36/#37, are already logged in `PROJECT_STATE.md` directly rather than needing citation-checks against these message files), and Thread 7's first slice of 2026-07-11 — the action-digest pilot (batch-8: 6 files, 2 under full manual rigor per a `decisions-archive.md` Decision #45 citation) and the 37-file aliases cross-check (batch-8: 9 files, heuristic tier) — are the first eight batches under the actual tiered approach, distinct from Thread 0's earlier full-rigor validation batch, using `_ai-context/prescan-backlog.ps1` to cut the per-file search cost. 2026-07-11 itself is far from done — roughly 50 files remain from that single day alone (architecture-doc, auditor-charter/capture-convention, OKF pilot, link-convention, provenance, rescue-destination, and the Fable/Auditor first-mission-planning cluster), tracked as Thread 7's own still-partial status rather than implied complete. Verified count after batch-8: 330 unpromoted files remain (operational prompt-paste templates excluded by standing rule) — closing in on 2026-07-24's 343 baseline for the first time since backlog promotion resumed, eight batches in. All pre-`_messages/` history on outside platforms (DeepSeek, ChatGPT, old AnythingLLM/Gemma sessions) remains separately out of scope — covered by `_ai-context/outside-conversation-capture-convention.md`, not this procedure. See Open Decision #35.
