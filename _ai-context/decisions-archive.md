---
type: reference
title: "Open Decisions Archive — cameronloudon.github.io"
aliases:
  - decisions archive
  - resolved open decisions
  - archived decisions
refs:
  - ../PROJECT_STATE.md
  - ./system-architecture.md
---

**Last updated:** 2026-07-13
**Purpose:** The full resolution narrative for every `PROJECT_STATE.md` Open Decision once it's resolved and no longer needs to be mandatory session-start reading. `PROJECT_STATE.md` keeps a one-line stub per archived entry ("✓ Archived — see this file"); this file keeps the complete original text, unedited, moved verbatim rather than summarized. Cited the same way every decision always has been — by number, in prose, grepped — not by wikilink, since no decision has ever actually been the target of one (checked directly, zero hits across the whole `AI-Working/Messages/` corpus, versus 211 plain-text "#N" citations; see `AI-Working/Messages/cowork-to-ccode-2026-07-13-archive-granularity-pushback.md` and `ccode-to-cowork-2026-07-13-archive-granularity-settled.md`).

**Genuinely open decisions are never here.** They stay in `PROJECT_STATE.md` in full until resolved. Currently open: #35, #37, #38, #43, #47, #48, #53.

**Built 2026-07-13 (session-39), Open Decisions #34/#35 (token-burn structural problem) — full chain in `AI-Working/Messages/`:** `cowork-to-ccode-2026-07-13-token-burn-structural-problem.md` → `ccode-to-cowork-2026-07-13-token-burn-proposal.md` → her review → the granularity pushback (Cameron's direct read: file-per-decision was overkill) → settled here as one shared file, file-level OKF frontmatter only, no per-entry frontmatter.

---

## Decision #1 — ai-content-creation-spec.md reconciliation

**Resolved.** ✓ Done — merged to main

---

## Decision #2 — Remaining CLAUDE.md additions: session-close protocol, ideas folder pattern, _skills/ layout note

**Resolved.** ✓ Done in ae15152

---

## Decision #3 — Promote rct-session-primer.md to _ai-context/

**Resolved.** ✓ Done in f20d068

---

## Decision #4 — master-synthesis-prompt.html: strip Section 8, founding-document note, label "Living" → "Founding", Section 9 update

**Resolved.** ✓ Done — merged to main

---

## Decision #5 — about.html, now.html, signals.html: merge collab-notes to one per page

**Resolved.** ✓ Done — merged to main

---

## Decision #6 — Delete AI-Web-Layer-Framework/ directory

**Resolved.** ✓ Done — merged to main

---

## Decision #7 — cowork-conventions.md — draft and promote

**Resolved.** ✓ Done 2026-06-21

---

## Decision #8 — Memory backup files as plain onboarding documents

**Resolved.** ✓ Done 2026-06-21

---

## Decision #9 — settings.json — verify and implement (.claude/settings.json, POSIX path syntax)

**Resolved.** ✓ Done — merged to main

---

## Decision #10 — AI-Prod mirror sync

**Resolved.** ✓ Done 2026-06-21

---

## Decision #11 — now.html and signals.html two collab-notes

**Resolved.** ✓ Done — consolidated to one per page

---

## Decision #12 — Two-agent workflow — permissions, roles, Phase 2 sync, AI-Working subfolder structure

**Resolved.** ✓ Done 2026-06-29 (session-3b)

---

## Decision #13 — AI Independence Verification pre-test fixes — all 8 test-blockers resolved

**Resolved.** ✓ Done 2026-06-29

---

## Decision #14 — AI-agnostic design principle — structural discussion re: cowork-memory-backup.md and proprietary orientation files

**Resolved.** ✓ Done 2026-07-05 (session-13) — see #25. `cowork-memory-backup.md` refreshed to remove all dated content and committed to `_ai-context/`; the Phase-2-triggered snapshot mechanism is the session-close-owned maintenance this decision was asking for

---

## Decision #15 — Survivable audit findings (9–22 from combined verification report) — 14 non-blocking issues documented

**Resolved.** ✓ Done 2026-07-05 — Cowork established there was never a single "combined verification report" file; it was a live 2026-06-29 synthesis of two independent audits. Cowork's own ~7-finding half was never saved anywhere either side can read and is accepted as permanently unrecoverable. Of Cowork's 15 original findings, 9 were non-blocking; traced against current state: 3 resolved, 1 partial, 1 closed (never a real issue), 1 obsolete, 3 genuinely still open. Cameron accepted **F5** (`Drafts/` mixes config and content drafts, cosmetic), **F8** (superseded — see #32, already closed), and **F14** (check-and-balance not mentioned in the AnythingLLM system prompt) as the final list. None block anything; F14 is worth a line whenever that prompt is next touched, F5 is lowest priority

---

## Decision #16 — AI Independence Verification live test — AnythingLLM + OpenCode + Ollama end-to-end workflow

**Resolved.** ✓ Done 2026-07-03 — status corrected 2026-07-05 (this row was stale, still read "ready to run"). Ran as the "four-agent-collaboration-test": AnythingLLM/Gemma drafted, OpenCode published with Claude Code auditing each claimed step against real repo state. Mixed result — one page published successfully, but only with live supervision; this finding is the origin of the whole day's architecture-rigor effort (2026-07-05). See `session-2026-07-03-002.md`

---

## Decision #17 — Content/HTML boundary — Draft Agent produces structured content only, Publish Agent authors all HTML/frontmatter

**Resolved.** ✓ Done 2026-07-03 (session-5) — `AI_INSTRUCTIONS.md`, `CLAUDE.md`, `_ai-context/single-ai-workflow.md`, `_ai-context/ai-content-creation-spec.md` updated; `draft-agent-config.md` and `publish-handoff-template.md` owned by Cowork per the same decision

---

## Decision #18 — `.claude/settings.json` scoped Messages/Ready permissions — left uncommitted after the 2026-06-29 session-3b close

**Resolved.** ✓ Committed 2026-07-03 (session-5) — matches the permissions already documented in `project-messages-folder-workflow` decision, no behaviour change from what was already active

---

## Decision #19 — Recurring `PROJECT_STATE.md` branch-staleness bug — found 3x during the four-agent-collaboration-test live run (sessions 5–7): Active Branch section named an already-merged branch because nothing required verifying git state at session start

**Resolved.** ✓ Done via #21 (status corrected 2026-07-05 — this row previously read "partially fixed" after #21 had already resolved it). The session-start verification check added 2026-07-03 (session-8) was reactive only and the bug recurred once more (session-9, 2026-07-05); #21's structural fix — correcting state at merge-confirmation time rather than session-start — has held clean across twelve merges since (PRs #34–#45, no recurrence)

---

## Decision #20 — `_ideas/index.html` (and `signals.html`) are static hand-written lists, not generated from the collection — publishing a new entry doesn't make it appear on its own index. Missing entry for `four-agent-collaboration-test` found live on production 2026-07-03

**Resolved.** ✓ Done 2026-07-03 (session-9) — entry added to `_ideas/index.html`; documented as a required step in `ai-content-creation-spec.md` §6 and a new checklist item in `rct-validation-checklist.md` §2

---

## Decision #21 — Open Decision #19's fix was reactive only — the session-start check catches staleness whenever a session happens to start, but nothing runs at the actual moment of merge, since merges happen on GitHub with no AI session present. Root cause: Phase 2 — AI-Prod Sync already fires at exactly that moment (Cameron's merge-confirmation paste) but never touched `PROJECT_STATE.md`

**Resolved.** ✓ Done 2026-07-05 (session-10) — Phase 2 (`CLAUDE.md`) now corrects Active Branch immediately via an immediately-created next session branch, before the AI-Prod sync; general AI-agnostic version added to `AI_INSTRUCTIONS.md` §6. Correction follows normal branch-and-push discipline, not a direct-to-main exception

---

## Decision #22 — Now page → `_now/` collection — `now.html` held two hardcoded blocks with no individual permalinks; converted to a collection matching `_ideas/`/`_signals/` so entries are individually addressable, per Cowork proposal + Cameron's decision on collab-note session citation

**Resolved.** ✓ Done 2026-07-05 (session-11) — `_config.yml`, `_now/local-ai-stack.html`, `_now/enrolment-pipeline-problem.html`, `now.html` rewritten as index; `ai-content-creation-spec.md`, `AI_INSTRUCTIONS.md`, `CLAUDE.md`, `rct-validation-checklist.md` updated

---

## Decision #23 — `_ideas/marketing-os.html` and `_ideas/ai-web-layer-framework.html` were undocumented flat-file deviations from the folder pattern — unlike `marketing-os-foundation.html`, neither had a legacy note explaining why. Found during the repo-architecture-mapping discussion with Cowork

**Resolved.** ✓ Done 2026-07-05 (session-12) — both migrated to `_ideas/marketing-os/` and `_ideas/ai-web-layer-framework/`; the file inside each folder is named after the folder itself, not `index.html`, per the naming convention agreed the same session. Permalinks unchanged (both already declared explicitly), no content changes

---

## Decision #24 — `approach.html` and `master-synthesis-prompt.html` had no `permalink:` declared, unlike every other page — likely serving at unclean, extension-bearing URLs. Found during the repo-architecture-mapping discussion

**Resolved.** ✓ Done 2026-07-05 (session-13) — `permalink: /approach/` and `permalink: /master-synthesis-prompt/` added to both; the one internal link to the latter (in `approach.html`) updated to match

---

## Decision #25 — `draft-agent-config.md`'s move to `_ai-context/` was agreed 2026-07-03 but never executed. Separately, `cowork-memory-backup.md` had gone stale twice (8 days, then 14 days) because it held a dated "project state" section nothing forced anyone to revisit

**Resolved.** ✓ Done 2026-07-05 (session-13) — both committed to `_ai-context/`. `draft-agent-config.md` gained two sections it was missing (check-and-balance workflow, PowerShell prompt convention — Findings #14/#15 from Cowork's 2026-06-29 audit) before becoming the permanent copy. `cowork-memory-backup.md` was structurally fixed by Cowork, not just refreshed — the dated section was removed entirely in favour of pointers to `PROJECT_STATE.md`. Cowork committed to sending updates on change, picked up at the next Phase 2 run — resolves #14

---

## Decision #26 — Merged architecture map's proposed Rule 1 ("folder-per-entry, universally, regardless of content length") was in tension with the same-day, carefully-reached decision to build `_now/`'s two entries as flat files

**Resolved.** ✓ Done 2026-07-05 (session-13) — Rule 1 narrowed per Cowork's review: folder-per-entry when an entry has or is likely to need sub-pages; flat-file remains valid for single-page entries with none in view. `_signals/`'s four entries and `_now/`'s two entries were correctly flat under the narrowed rule at the time. **Superseded 2026-07-05 (session-16), see #29** — Cameron decided to migrate both collections anyway, for full structural consistency over the narrower rule

---

## Decision #29 — Following #26, Cameron decided `_signals/` and `_now/` should be migrated to the folder pattern after all, overriding Cowork's narrower Rule 1 recommendation

**Resolved.** ✓ Done 2026-07-05 (session-16) — all four `_signals/` entries and both `_now/` entries migrated; each file inside named after its own folder, not `index.html`. `_now/local-ai-stack.html` also renamed to `building-a-local-ai-stack.html` in the process, fully resolving the original naming collision with the root `/local-ai-stack/` guide (both folder and filename now match the permalink slug). Permalinks unchanged throughout, no content changes. Cameron is the decision authority in the propose→review→consensus process Rule 1 came out of; Cowork to be notified for record consistency

---

## Decision #27 — Root-level content/instruction separation and the `about/` restructuring — statuses needed locking before the auditor version could be finalized

**Resolved.** ✓ Done 2026-07-05. Both items resolved: root-level separation (was "proposed, not decided") executed in full via #30 across sessions 18–21; `about/` restructuring specifically done as step 5 of that same plan (session-21)

---

## Decision #28 — DeepSeek (Review Agent) audited the standalone architecture reference document 2026-07-05 (session-2026-07-05-005) and ranked manual instruction-file synchronization (`AI_INSTRUCTIONS.md`↔`CLAUDE.md` and the Draft Agent-side equivalents) as the single highest-risk open item — undocumented drift could let a weaker model follow an outdated rule unnoticed, undermining the project's own AI-independence hypothesis

**Resolved.** ✓ **Decided and implemented 2026-07-12 (session-36)**, after sitting parked since 2026-07-05 with no independent review ever returned on the original four-mechanism plan (`ccode-to-cowork-2026-07-05-instruction-sync-project-plan.md`). Revived this session on the strength of two independent incidents since parking that re-derived the same problem shape without being asked to (#43's stale-sandbox-read finding; #52's skipped session-close, whose own closing note named #28 directly). Re-reading DeepSeek's actual recommendation (session log `session-2026-07-05-005.md`) showed it was narrower than the later four-option menu: literally "a pre-commit hook or session-start verification script," nothing about a shared marker or a dedicated role. Cameron's direction: don't overcook it — drop the shared-version-marker candidate, set the pre-commit hook aside as more infrastructure than wanted, and set aside an Auditor-mediated version (considered explicitly, given the ratified charter's Function B is literally "drift detection" — set aside because it entangles this with the Auditor's still-unresolved write-scope question, not because the idea was bad). Landed on the plain session-start version DeepSeek actually asked for, scoped to detection only — no auto-fix, no report file, just stop and tell Cameron. Full propose→independent-review→consensus chain in `AI-Working/Messages/`: `ccode-to-cowork-2026-07-12-instruction-sync-revised-proposal.md` → Cameron caught that the fix must be written into the canonical, role-generic documents (Publish Agent/Draft Agent), not stand as a bilateral Claude-Code/Cowork agreement, since that would be the same failure shape one level up → `ccode-to-cowork-2026-07-12-instruction-sync-role-generic-correction.md` → Cowork's independent review (`cowork-to-ccode-2026-07-12-instruction-sync-role-generic-response.md`) agreed independently on canonical-over-bilateral, corrected the destination to one shared step in `AI_INSTRUCTIONS.md` §2 rather than two role-specific ones split across derivative files (a Draft-Agent-side check living in `cowork-conventions.md` would just relocate the same problem, by the same logic just applied to `CLAUDE.md`), and corrected scope to two real pairs on her side, confirmed by reading each file's own header rather than trusting the six-week-stale original scope table (`cowork-conventions.md`↔`AI_INSTRUCTIONS.md`; `draft-agent-config.md` working copy↔repo canonical) → a residual asymmetry caught before finalizing (her wording still hardcoded `CLAUDE.md` for the Publish Agent side while the Draft Agent side resolved through the Instruction File Index — same problem, one level further down) resolved and confirmed in `ccode-to-cowork-2026-07-12-instruction-sync-final-consensus-check.md` → `cowork-to-ccode-2026-07-12-instruction-sync-final-consensus-response.md`, full agreement, `cowork-conventions.md`'s path confirmed by Cowork reading the file directly (`AI-Working/Protocols/cowork-conventions.md`). `AI_INSTRUCTIONS.md` §2 step 5 rewritten to the converged, fully symmetric wording (both roles resolve their derivative file(s) through the Instruction File Index; `CLAUDE.md` survives only as a present-tense parenthetical example, not a rule branch). The Instruction File Index itself needed two corrections before it could be trusted as that pointer target, both made this session: `draft-agent-config.md`'s row fixed from a stale "currently AnythingLLM" to "currently Cowork," and the missing `cowork-conventions.md` row added — the index had already drifted, an apt catch mid-build of the very fix meant to prevent that class of drift

---

## Decision #30 — Following #27, Cameron decided to proceed with root-level content/instruction separation after all, executed incrementally least-risk-first rather than as one large change

**Resolved.** ✓ Done 2026-07-05, all 8 steps complete across sessions 18–21. (1) `contact/contact.html`; (2) `local-ai-stack.html` → `_now/building-a-local-ai-stack/local-ai-stack.html`, kept its own name (not renamed to match the folder, since that name is already taken by `building-a-local-ai-stack.html`) — the one documented exception to folder-mirrors-URL (Rule 5.6), deliberate per Cameron's request to colocate it with the related Now entry; (3) `approach/approach.html`; (4) `master-synthesis-prompt/master-synthesis-prompt.html`; (5) `about/about.html`, also resolving the separate `about/` restructuring recommendation from #27 ahead of `work-history.html`/`skills.html` being built; (6) `now.html` → `_now/now.html`, revised mid-plan from the original `now/now.html`: moved into the *existing* `_now/` collection folder rather than a new sibling `now/` folder, matching the `_ideas/index.html` precedent and avoiding a confusing `now/`/`_now/` pair, given underscore prefixes are visually invisible to Cameron's own mental model; (7) `signals.html` → `_signals/signals.html`, same corrected approach as step 6; (8) `index.html` — verified as the only content file remaining at repo root, correctly unmoved, the one universal exception (Jekyll's implicit root-index rule). Root now holds only instruction/config files (`AI_INSTRUCTIONS.md`, `CLAUDE.md`, `ONBOARDING.md`, `PROJECT_STATE.md`, `README.md`, `Gemfile`, `_config.yml`, `.gitignore`, `opencode.json`) plus `index.html` — the original goal of Open Decision #27, fully realized

---

## Decision #31 — `opencode.json`'s configured model (`opencode/big-pickle`) doesn't match the Capability Baseline's documented OpenCode model (`gemma4:e4b`) — flagged repeatedly during today's architecture review but never given its own tracked entry until now (2026-07-05)

**Resolved.** ✓ Done 2026-07-05 — Cameron confirmed `big-pickle` is a real, deliberately-configured model (initially assumed to be a joke/placeholder name, but genuinely what was used in the 2026-07-03 live test). `opencode.json` was correct all along; the Capability Baseline table was the stale record and has been corrected to match

---

## Decision #32 — Two overlapping Draft-Agent-side manual session-start prompts exist without referencing each other — `Protocols/session-start-verify.md` and `Prompts/prompt-cowork-session-start-check.md`. Flagged repeatedly during today's architecture review but never given its own tracked entry until now (2026-07-05)

**Resolved.** ✓ Fully done 2026-07-05 — `session-start-verify.md` deleted on Cowork's side; a new "Session start" cross-reference section added to both `Protocols/draft-agent-config.md` (Cowork's working copy) and the repo's canonical `_ai-context/draft-agent-config.md`, placed after "Your role" and before "Check-and-balance for technical problems." Also resolves Cowork's Finding F8 from the 2026-06-29 self-audit

---

## Decision #33 — `PROJECT_STATE.md`'s Capability Baseline table conflated Tool/Model/Runtime/Purpose into a single "Current Tool" cell per role — the root cause of the original three-way Draft Agent tool ambiguity. Raised during the 2026-07-08 foundation-layer discussion, tracked separately as its own smaller fix (not the first step of the foundation-layer/OKF pilot)

**Resolved.** ✓ Done 2026-07-09 (session-25) — split into a Role Access table (unchanged in spirit, plus a new proposed-not-active Auditor row) and a new Tool/Model/Runtime Matrix table (multiple rows per role, each with a cited, checkable Status). Publish Agent's Access row also corrected to include the `Write: AI-Working/Messages/` grant already enforced in `.claude/settings.json` but previously undocumented here. Proposed in `AI-Working/Messages/ccode-to-cowork-2026-07-08-capability-baseline-restructure-proposal.md`, agreed in `cowork-to-ccode-2026-07-08-capability-baseline-response.md` (evidence-citation condition), cleared in `cowork-to-ccode-2026-07-08-capability-baseline-go-ahead.md`

---

## Decision #34 — Foundation-layer `_messages/` OKF bundle pilot (from the 2026-07-08 foundation-layer proposal, Open Decision context in the Auditor row of the Tool/Model/Runtime Matrix above) — does the OKF bundle format actually hold up against real files, not just proposals

**Resolved.** ✓ Core question answered 2026-07-09 (session-26), commits `bbb6526`/`86cb356`. Piloted against real files across three of four OKF types — `message` (3 files from the location-reconsideration thread), `transcript` (genuine verbatim capture, required a `participants:` list rather than `from`/`to` — authored vs. captured content need different shapes), and `summary` (a file initially assumed to be a transcript, reclassified on inspection — `type` has to come from reading content, not trusting a filename/self-description). Two corrections surfaced and fixed: `refs:` can only point to bundle-relative paths, not out to `AI-Working/` (which isn't git-tracked and, as this pilot demonstrated live, isn't even a reliable guarantee the cited file exists at all — see the `OpenWEBUIandGemma4isWHACKED.md` recovery in the `_messages/` bundle table above); and citations meant to be durable/checkable must point at something git-tracked generally, not just within this bundle. `type: audit-finding`, the fourth OKF type, deliberately left untested — Cameron's decision: "Auditor is on the agenda for later. It needs a lot of thought on how it will actually function," so it waits for the real Auditor track to produce genuine material rather than a synthetic test file. Full chain in `AI-Working/Messages/`: `ccode-to-cowork-2026-07-09-pilot-results.md` → `cowork-to-ccode-2026-07-09-pilot-response.md` → `ccode-to-cowork-2026-07-09-transcript-pilot-results.md` → `cowork-to-ccode-2026-07-09-transcript-pilot-response.md` → `ccode-to-cowork-2026-07-09-pilot-close.md`. Not the same as closing the wider foundation layer — the Auditor role and the full Messages/Conversations unification remain open, no timeline. Commit cadence for promoting future `AI-Working/Messages/` files into `_messages/` (session-close only vs. also at session-start) also remains an open question, raised by Cowork in `cowork-to-ccode-2026-07-09-location-git-response.md`, not decided this session. **Scope correction, session-27:** "core question answered" was true only for the chain-of-custody/audit-trail goal (does an Auditor trust this record wasn't altered). Cameron's original 2026-07-02 framing — a living, traversable knowledgebase that generates new learning over time — is a separate, larger goal this pilot never touched. See Open Decision #35

---

## Decision #36 — Open Decision #16 and the published `_ideas/four-agent-collaboration-test/` page both diagnose AnythingLLM's 2026-07-03 failure as a tool-connectivity gap ("filesystem tools weren't wired into the workspace"). Found wrong 2026-07-10 during the curated-slice review: Cowork's full 137-turn transcript (`_messages/cameron-cowork-conversation-transcript-full-2026-07-09.md`) shows tools were connected — AnythingLLM hallucinated a file path ("AI-Workung"), insisted the typo existed in a file it had just read even after being told directly it wasn't there, and edited `draft-agent-config.md` in the read-only Protocols folder without authorization. That's a reliability/instruction-following failure, not a wiring problem — matters because RCT's whole premise is accurate attribution, and this is a published page's diagnosis, not just an internal note

**Resolved.** ✓ Corrected 2026-07-11 (session-34). Cameron chose the fuller Edison-reframe over a minimal line swap. Handoff: Claude Code gave Cowork the false claims, primary-source evidence, and scope decision (`ccode-to-cowork-2026-07-11-four-agent-test-page-correction-handoff.md`) — explicitly not drafting the content itself, since that's Cowork's role, not Claude Code's (Cameron's own correction mid-session). Cowork drafted the full rewrite, reviewed question-by-question with Cameron directly, and found a third false line beyond the two originally flagged ("it just wasn't told it had a chance") plus a collab-note credit line that would have carried the old diagnosis forward if left unedited. "What Passed" and the tags were checked and confirmed to need no change, not left untouched by default. Published: "Connectivity Gap"/"Configuration Issue" replaced with the real diagnosis in both "What Failed" and "The Diagnosis"; "The Fix" gains one sentence stating it doesn't solve the reliability failure; "Why This Matters" fully reframed around Edison's "99 ways not to" rather than the prior triumphant tone; collab-note folded to one note (not two) attributing both the original page and the correction specifically, per RCT — not blended into "developed collaboratively." One process note, not blocking: the `Ready/` draft file's own trailing "Open questions for Cameron" section was stale by the time it reached Claude Code — every question it posed was already resolved and reflected in the file's actual content, confirmed by checking rather than assumed from the handoff message alone

---

## Decision #39 — `_ai-context/extract-session-transcript.ps1` had no UTF-8 BOM — Windows PowerShell 5.1 misread the script's own non-ASCII characters (the em-dash in its closing `Write-Output` string) and refused to parse the file at all, a hard blocker reproduced on every invocation, not a cosmetic issue. Found 2026-07-11 (session-29) while running the script — Cameron having authorized Claude Code's own rescue following #38 — against all 43 JSONLs rescued from Claude Code's retention-managed session storage (cameronloudon-github-io workspace + AI-Auditor workspace)

**Resolved.** ✓ Fixed and verified 2026-07-11 (session-29), commit `4d77276` — added the UTF-8 BOM only; `git diff` confirms a single-line change, no logic touched. Re-ran the script against all 43 rescued session JSONLs post-fix: 0 errors, 0 zero-turn extractions, one output spot-checked for readability. Distinct from the encoding bug already recorded in Open Decision #35 ("PowerShell UTF-8 encoding bug found and fixed") — that one concerned reading the *log file* with explicit encoding (which this script already does internally, `[System.IO.File]::ReadAllText($LogPath, [System.Text.Encoding]::UTF8)`); this one is the *script's own source file* lacking a BOM, a distinct failure mode surfaced only now because this was the first time the script had been run against this many sessions since #35

---

## Decision #40 — Auditor Charter v0.1 (Fable 5's 2026-07-10 discussion draft) needed independent review from Cowork and Claude Code, then Cameron's ratification decision, per the charter's own propose→review→consensus status line

**Resolved.** ✓ Ratified 2026-07-11 (session-29) as `_ai-context/auditor-charter.md`. Both independent reviews (`AI-Working/Messages/cowork-to-cameron-2026-07-11-auditor-charter-independent-review.md`, and Claude Code's review folded into `ccode-to-cowork-2026-07-11-auditor-proposals-consensus-request.md`) converged with no structural disagreement; four refinements carried into the ratified text: the finding cap tiered by severity rather than flat at ten, a reserved (not yet populated) failure-kind field alongside severity, the uncited "15 findings, 3 mattered" claim corrected to what its source actually supports, and one sentence distinguishing Function B's drift check from the Publish Agent's existing session-start ritual. §7's system architecture document and §10's provenance-sidecar mission are now explicitly tracked as new deliverables rather than implicit side effects of ratification. Full detail in the charter's own Ratification Record section

---

## Decision #41 — Following #40's ratification, the audit-finding file's permanent home (staging + durable location) was left open rather than decided unilaterally — a genuine repo-structure question

**Resolved.** ✓ Approved by Cameron 2026-07-11 (session-29): staging at `AI-Working/Audit/` (path-scoped grant, replacing the `AI-Auditor\` prototype folder — `.claude/settings.json` updated with a matching `Read` permission), durable home at `_audit-findings/` (new git-tracked collection, sibling to `_messages/`, excluded from Jekyll via `_config.yml`, same non-rendered treatment). Reached through Cowork's initial recommendation (`AI-Working/Messages/cowork-to-ccode-2026-07-11-audit-finding-home-view.md` — her deciding argument: write boundaries in this project are enforced by folder scope, not by convention about `type:`, and a shared `_messages/` folder would make the Auditor's independence a documented courtesy rather than a checkable boundary), a concurring second read from a separate AI-Auditor design session with three riders (`fable-to-cameron-2026-07-11-audit-finding-home-concurrence.md`), and Cowork's full concurrence including a fix to a real collision the review surfaced — the original "byte-identical, no touch-ups" verbatim-promotion rule contradicted the not-yet-built link convention's generated `[[wikilink]]` footers; resolved as two separate mechanical checks (footer-stripped content must match the staged original; regenerated footer must match what's present) rather than picking one rule over the other. `_ai-context/auditor-charter.md` §5/§6 updated to reflect the decided state directly, with an addendum in its Ratification Record documenting how it was reached; `_audit-findings/index.md` created, empty pending the Auditor's first run

---

## Decision #42 — Link/wikilink convention (`refs:` canonical, `aliases:` + generated `[[wikilink]]` footer derived from it) needed a formal proposal, Cowork's independent review, and a build — Cameron scoped this round deliberately to the existing 36-file `_messages/` slice, not the wider backlog or the separate outside-conversation capture convention

**Resolved.** ✓ Built, run, merged (PR #54, session-30, commit `9388f7b`), and synced to AI-Prod 2026-07-11 (session-31) — `.obsidian` survived the sync (the fix from earlier this session holding). Formal proposal sent (`ccode-to-cowork-2026-07-11-link-convention-proposal.md`), Cowork agreed on scope and three of four design defaults, amended the fourth (aliases drafted by whichever side authored each file, not one side guessing at the other's intent — same principle as the capture-prompt review, applied inward). Both sides drafted their aliases from actual file content (not filenames), cross-checked each other's work rather than rubber-stamping — caught and fixed two real issues in Cowork's draft and one gap in the process itself (the joint file `ccode-and-cowork-2026-07-09-resume-tomorrow.md` was never actually drafted by either side despite the original split proposal saying it would be — caught before building, not after). `_ai-context/generate-links-footer.ps1` built and tested for correctness/idempotency in isolation before touching real files; run against all 36 content files plus `index.md`: 32 got footers, 4 correctly skipped (no `refs:` field), 0 failures. 289 insertions, 0 deletions — purely additive. **Acceptance test passed 2026-07-11 (session-31):** mechanically verified 32 files carry the real generated marker (matches the generator's own report exactly; the one extra `[[` hit in a raw regex sweep was `index.md`'s own prose discussing wikilink syntax, checked and ruled out, not a stray link) — then Cameron opened Obsidian pointed at `AI-Prod\_messages\` and confirmed directly: the graph looks connected, not `index.md`'s hub with the rest as disconnected dots (the exact failure state from before this work, per session-28's live test). **Cowork's independent re-verification also complete and clean** (`AI-Working/Messages/cowork-to-ccode-2026-07-11-link-convention-verification-result.md`): all 36 files carry `aliases:`, exactly the same 32/4 split confirmed independently, five footers spot-checked line-by-line against their actual `refs:` (including the `../AI_INSTRUCTIONS.md` out-of-bundle edge case, correctly producing `[[AI_INSTRUCTIONS]]` — not explicitly covered in the design, good that it held), both of her flagged corrections confirmed landed correctly, no corruption in any of the 36 files including the full 1,064-line transcript

---

## Decision #44 — Observation 2 Option A (provenance stamping) from the 2026-07-10 AI-Prod examination — converts "trust this transcript" into a checkable claim by recording what a mechanical extraction actually came from

**Resolved.** ✓ Done 2026-07-11 (session-31), commit `5477017`, formal proposal and Cowork's review in `AI-Working/Messages/` (`ccode-to-cowork-2026-07-11-provenance-stamping-proposal.md`, `cowork-to-ccode-2026-07-11-provenance-stamping-response.md`). `_ai-context/extract-session-transcript.ps1` (v1.1.0) now computes and prints `source-path`/`source-sha256`/`extraction-script-version` for the operator to paste into a promoted file's frontmatter — the script still only writes the plain body, not YAML. Retrofitted the two genuinely mechanical transcripts (excluded the 07-09 live-capture transcript and anything manually pasted, per the same mechanical-vs-reconstructed line held all session): Claude Code's own file used a directly-computed hash after confirming the source JSONL was still exactly 203 lines, unchanged since extraction — a genuinely closed, stable session, no complication. Cowork's file surfaced a real one: her raw log was the *same still-open session* she was writing the reply in, grown from 786 to 1,625 lines by the time she checked — a full-file hash would have been a misleading claim that looked verifiable and wasn't. She computed and supplied the correct 786-line hash instead, plus an explicit `source-sha256-note` disclosing that append-only-log behavior is assumed, not independently provable from her side (no version history under her own log). Both supplied hash strings verified as genuinely valid 64-character hex before use, not eyeballed

---

## Decision #45 — Observation 2 Option B (action digest) from the 2026-07-10 AI-Prod examination — a genuine pilot, not a commitment: can `extract-session-transcript.ps1` mechanize the existing manual italic-note convention into something the Auditor can actually check a claim against

**Resolved.** ✓ Piloted 2026-07-11 (session-31), commit `a41bc1e`. Formal proposal and Cowork's review in `AI-Working/Messages/` (`ccode-to-cowork-2026-07-11-action-digest-pilot-proposal.md`, `cowork-to-ccode-2026-07-11-action-digest-pilot-response.md`) — her one amendment (per-field truncation, not per-blob, since a flat 200-char cap on a multi-field tool like `Edit` would exhaust its budget on `old_string` and never show `new_string`) was built directly rather than let the predicted failure occur first. New opt-in `-IncludeActions` switch; default (no switch) output confirmed byte-identical to the pre-change script's output — no regression. Piloted against the same proven test session (`30112467-...jsonl`): 88 entries (28 conversation turns + 60 `[TOOL_CALL]`/`[TOOL_RESULT]` lines), 26.8KB, both real `Edit` calls in the session correctly show both `old_string` and `new_string`, one genuinely useful catch — a rejected tool use correctly surfaces as `status=error`, exactly the kind of claim-checkable event this format exists to support. Pilot output itself was not committed anywhere — stays local, per the sensitivity constraint both sides agreed on (tool inputs/outputs can contain full paths and command text)

---

## Decision #46 — Four real conventions landed across Open Decisions #34/#42/#44/#45 (frontmatter fields, generated Links footer, provenance stamping, action-digest capture) with nothing written down as one canonical procedure — flagged as a remaining gap in each of #42's, #44's, and #45's own closure notes

**Resolved.** ✓ Done 2026-07-11 (session-31). `_ai-context/messages-promotion-procedure.md` written, consolidating all four into one reference: required frontmatter fields and where `aliases:`/`refs:` come from, when and how to run `generate-links-footer.ps1`, when and how to run provenance stamping (including the still-open-log hashing caveat), when and how to run action-digest capture, and how `index.md` gets updated. Explicitly scoped to what's already decided — doesn't invent new policy, just stops it from being scattered across four Open Decision entries. Two items named as still genuinely open rather than papered over: commit cadence for promotions (session-close only vs. also session-start), and whether the outside-conversation capture convention's fields fold into this procedure once that convention is actually drafted

---

## Decision #49 — Auditor Charter §7's system architecture document — prerequisite for Function B (drift detection), never started. Cameron asked where it would be saved and whether it should be OKF-stamped/Obsidian-discoverable, which surfaced a real, previously-undecided question: `_ai-context/` files have never carried OKF frontmatter

**Resolved.** ✓ Full rewrite done 2026-07-11 (session-32) as `_ai-context/system-architecture.md`, superseding `AI-Working/Messages/audit-reference-standalone-2026-07-05.md` (the DeepSeek-audited 2026-07-05 version, Open Decision #28) — used as a structural template, explicitly not a binding one per Cameron's direction. OKF-treatment piloted on this one file only, per full consensus with Cowork (`ccode-to-cowork-2026-07-11-instruction-file-okf-pilot-proposal.md` → her review, verified-not-assumed, found a real gap in the generator's ref-resolution granularity → `ccode-to-cowork-2026-07-11-okf-pilot-agreed.md`, Option 1 adopted: file-level `refs:`, Open Decision numbers in prose, not fragment-anchored): `type: reference` (new value, confirmed non-colliding), `aliases:`, `refs:` pointing at `PROJECT_STATE.md`/`AI_INSTRUCTIONS.md`/`CLAUDE.md`/the other three ratified `_ai-context/` conventions. Explicitly single-sourced against `PROJECT_STATE.md` — no duplicated Open Decisions log, Capability Baseline, or file inventory; describes structure, not current state, exactly per charter §7's own design requirement. Running the generator against `_ai-context/` as a mixed OKF/non-OKF folder surfaced a real script bug, found and fixed same session: (1) files with no frontmatter block at all were hard-erroring instead of skipping gracefully — fixed to match the already-agreed-with-Cowork behavior (only opted-in files participate); (2) the footer-strip logic used a literal-LF substring search that silently failed once a file's line endings were CRLF-normalized by a git checkout, duplicating the footer instead of refreshing it — caught live across all 32 `_messages/` files during a regression check, not theoretical. Fixed with a line-ending-tolerant regex; re-verified idempotent across two consecutive runs post-fix, confirmed via `git diff` (not `git status`, which flagged a benign mtime artifact that looked like a false positive at first) that no `_messages/` content actually changed. **Content review, same day:** first request sent before the document was merged/synced anywhere Cowork could actually read it — she correctly refused to review a description of the file instead of the file itself (`cowork-to-ccode-2026-07-11-cant-access-architecture-doc.md`); fixed by pasting the full text into a message. Her review then caught two real content errors, both verified before fixing: §2's Draft Agent access line had dropped the `Read-only: AI-Prod` clause entirely (checked against `PROJECT_STATE.md`'s own Role Access table), and §5's action-digest bullet read as one shared script running on two platforms when Cowork built and ran an independent Python equivalent — attribution corrected. She also confirmed §6's Open Decision #38 characterization as accurate against her own firsthand experience (stated explicitly, not just silently passed over), and flagged that both §2 and §6 cite Open Decision #47, which doesn't exist in her `AI-Prod` mirror (tops out at #46, correctly reflecting session-31's last sync) — confirmed as a legitimate same-branch forward reference, not an error, resolving once session-32 merges

---

## Decision #50 — `cleanupPeriodDays` — the actual retention-window setting behind the JSONL rescue urgency (Open Decision #39) — was confirmed unset (default ~30 days) but never actually raised; only the one-time rescue copy was done

**Resolved.** ✓ Done 2026-07-11 (session-33). Set to `90` in `~/.claude\settings.json` (global, user-level — not part of this repo, protects every project's session logs, not just this one). Chosen as a meaningful multiple of the 30-day default without being excessive; no strong external signal for a specific number, Claude Code's own choice, not run through Cowork consensus since it's a Claude-Code-side technical setting, not a shared convention — same class of decision as the `.obsidian` robocopy fix

---

## Decision #51 — Provenance sidecar (Auditor Charter §10, mission 3) — Fable's original 2026-07-10 analysis was addressed to Cameron only, never sent to Cowork; the charter's mission-list entry named it but no concrete design existed at ratification time, so her charter agreement didn't cover this deliverable's actual content

**Resolved.** ✓ Built 2026-07-11 (session-33) as `_ai-context/instruction-provenance.md`, full consensus with Cowork first (`ccode-to-cowork-2026-07-11-provenance-sidecar-proposal.md` → her review, which independently verified both worked examples directly against `AI_INSTRUCTIONS.md` and the cited Open Decisions before agreeing). Format/location/scope (two worked examples, not an exhaustive audit) all agreed with no objection. Her one substantive addition: §6's merge-time correction rule already carried an informal inline citation to #19/#21 in its own prose, so that entry formalizes something partially already there, while §5's attribution clause had no citation at all — a clean zero-to-one case. Both distinctions stated explicitly in the file itself per her suggestion, so a cold reader doesn't assume both examples started from the same blank state. Mapping every remaining clause is deliberately deferred, same next-touch discipline as the rest of `_ai-context/`'s OKF rollout (#49)

---

## Decision #52 — Session-34 (the four-agent-test page correction, PR #58) closed without a session log — the session-close protocol was skipped entirely, going straight from publishing into the Phase 2 handoff for session-35

**Resolved.** ✓ **Closed 2026-07-13 (session-38), root cause fixed, not just patched again.** Caught by Cowork 2026-07-11, verified directly rather than assumed — a `Read` on `_session-logs/session-2026-07-11-003.md` plus a raw directory listing, specifically *not* the bash sandbox, which has a documented staleness pattern right after merges (Open Decision #43) that could otherwise have produced a false "it's just unsynced" explanation. Confirmed genuinely absent, not a mirror artifact. Fixed retroactively in session-35: `session-2026-07-11-003.md` written to cover session-34's actual work, `NEXT_SESSION_LOG_ID` advanced past it, the gap and its retroactive fix both stated openly in the backfilled log itself rather than silently patched as if it had never happened. **Recurred 2026-07-12 (sessions 36 and 37, Open Decisions #28 and #53) — caught this time by Cameron asking to wrap up for the day, not by any check.** Neither of the two role-generic checks built the same day (#28's instruction-sync check, §10's capability self-check) covers this gap — both are about content/capability drift, not session-close completion, a different failure class. Both logs written retroactively in session-38 (`session-2026-07-11-004.md`, `session-2026-07-12-001.md`), `NEXT_SESSION_LOG_ID` advanced past both. **Root cause sharpened by Cameron the same session-38, later the same day:** the tool-permission "hard stop" only gates actions actually attempted — it structurally cannot catch a step silently never attempted, which is exactly why "remember to run the checklist" kept failing invisibly. Checked against the historical record rather than assumed: real prior gaps exist (`session-2026-06-21-003` never written), but 2026-07-05 alone had 24 same-day sessions with zero recurrence, while the actual recurrence clustered from session-34 (2026-07-11) onward — a genuine recent shift, cause not fully confirmed. **Fix:** a session-close handshake — "Session-X's DRAFT is ready for consideration to PR" → Cameron "Ok"/"Yes" (or "No"/"keep working," which defers and re-signals later rather than closing out) → mandatory "Please hold while I finalise the session log" → checklist actually runs, gated by the same permission prompts as any other git action → "Session-X finalised — ready for the PR," the only message that clears Cameron to create it. Ties the checklist to an action that already never fails to happen (announcing PR-readiness) instead of to internal judgment about session-end, and lands the log in the *same* PR as the work it describes — closing the "one PR behind" limitation the original Phase-2-triggered idea couldn't avoid. Applied to `CLAUDE.md`; proposed to Cowork, independently reviewed (one wording fix — "Session-X" is the actual identifier, not literal text), and ratified into `AI_INSTRUCTIONS.md` §11 as the canonical role-generic version. `session-2026-07-12-002.md` is the handshake's own first real use — this session closed itself out under the new mechanism rather than being caught after the fact. Cowork is separately adding her own independent, read-only, mechanically-triggered check on the Draft Agent side (tracked in `AI-Working/Messages/`, not this repo) as genuine defense-in-depth, not a duplicate

---

## Links
<!-- generated from refs: - do not hand-edit -->
- [[PROJECT_STATE]]
- [[system-architecture]]
