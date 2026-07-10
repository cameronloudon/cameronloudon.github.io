# PROJECT_STATE.md
**Single source of current project state. Read this before every session. Update this at every session close.**
**Last updated:** 2026-07-10
**Updated by:** Claude Code (Publish Agent) — Phase 2 state correction on merge confirmation. session-27 merged (PR #51): curated 28-file backlog slice promoted into `_messages/`, index rebuilt, Cowork's review findings fixed (duplicate transcript superseded, Open Decision #36 opened for the four-agent-test diagnosis correction). session-28 opened immediately, no work started yet

---

## Active Branch

`session-28` (current session — just opened via Phase 2, no work started yet)
Branched from `main` at `7d7c367` — Merge pull request #51 from cameronloudon/session-27
Not yet merged. No commits yet.
Cameron merges to main. Do not commit directly to main.

---

## Next Session Log ID

`NEXT_SESSION_LOG_ID: 2026-07-09-004`

This session used `session-2026-07-09-003` — third session log of the day, continuing the per-day NNN counter per the format in `_ai-context/rct-session-primer.md`. Written mid-session (Cameron stopping for the night) rather than at a session close in the usual sense — `session-27` is still open and will resume tomorrow, same branch, same session log continuing to apply until it actually closes.

The thirty-seven existing session logs are: `session-2026-06-10-001`, `session-2026-06-11-001`, `session-2026-06-11-002`, `session-2026-06-21-001`, `session-2026-06-21-002`, `session-2026-06-29-001`, `session-2026-07-03-001`, `session-2026-07-03-002`, `session-2026-07-03-003`, `session-2026-07-03-004`, `session-2026-07-05-001`, `session-2026-07-05-002`, `session-2026-07-05-003`, `session-2026-07-05-004`, `session-2026-07-05-005`, `session-2026-07-05-006`, `session-2026-07-05-007`, `session-2026-07-05-008`, `session-2026-07-05-009`, `session-2026-07-05-010`, `session-2026-07-05-011`, `session-2026-07-05-012`, `session-2026-07-05-013`, `session-2026-07-05-014`, `session-2026-07-05-015`, `session-2026-07-05-016`, `session-2026-07-05-017`, `session-2026-07-05-018`, `session-2026-07-05-019`, `session-2026-07-05-020`, `session-2026-07-05-021`, `session-2026-07-05-022`, `session-2026-07-05-023`, `session-2026-07-05-024`, `session-2026-07-09-001`, `session-2026-07-09-002`, `session-2026-07-09-003`.
Note: `session-2026-06-21-003` was never written (anticipated but session did not recur that day). Session on 2026-06-26 (pre-test repo prep, session-3b) and the session-4 branch (2026-06-29 branch-workflow correction, folded into `session-2026-06-29-001`'s log) were also not separately logged — acknowledged gaps.

---

## Instruction File Index

| File | Role | Notes |
|---|---|---|
| `ONBOARDING.md` | Entry point for any new AI | Read first, once per onboarding |
| `AI_INSTRUCTIONS.md` | Canonical AI-agnostic rules | Authoritative on intent; read if AI_INSTRUCTIONS.md and CLAUDE.md conflict, this wins |
| `CLAUDE.md` | Claude Code specific | Auto-loads for Claude Code; consistent with AI_INSTRUCTIONS.md as of 2026-06-29 |
| `_ai-context/rct-session-primer.md` | RCT framework, collab-note and session log formats | Read before any publishing task |
| `_ai-context/rct-validation-checklist.md` | Pre-publish checklist | Run before every commit that adds or changes published content |
| `_ai-context/single-ai-workflow.md` | Single-tool workflow | Read if one AI is handling both Draft and Publish roles |
| `_ai-context/ai-content-creation-spec.md` | Full technical and design specification for content creation | Read before drafting new content; covers frontmatter, CSS, collab-note format, tag taxonomy |
| `_ai-context/draft-agent-config.md` | Draft Agent's operational rulebook — output format, required fields, self-check, check-and-balance workflow, session-start check, PowerShell prompt convention | The Draft Agent (currently AnythingLLM) | Before any draft is written | Moved here 2026-07-05 (session-13) from `AI-Working/Protocols/`, an agreed-but-unexecuted intention since 2026-07-03. Two sections added on commit (check-and-balance, PowerShell convention) that were missing from the working copy — Findings #14/#15 from Cowork's 2026-06-29 self-audit. "Session start" section added 2026-07-05 (session-23), mirrored from Cowork's working copy — Open Decision #32 |
| `_ai-context/cowork-memory-backup.md` | Plain-language export of Cowork's memory context, for portability to a replacement Draft Agent | Any AI taking over the Draft Agent role, cold-start | Once, at onboarding | Committed 2026-07-05 (session-13), refreshed by Cowork first — removed all dated "current state" content (had gone stale twice) in favour of pointers to `PROJECT_STATE.md` and `_session-logs/`. First instance of the Phase-2-triggered maintenance pattern; resolves Open Decision #14 |

---

## Page Inventory

### Root pages

| File | Title | Status | Collab note |
|---|---|---|---|
| `index.html` | Home | Published | 0 |
| `about/about.html` | About | Published | 1 — migrated to folder pattern in session-21, step 5 of 8 in the root-separation plan (Open Decision #30); also resolves the separate `about/` restructuring recommendation from #27, done ahead of `work-history.html`/`skills.html` being built |
| `approach/approach.html` | Approach | Published | 1 — migrated to folder pattern in session-20, step 3 of 8 in the root-separation plan (Open Decision #30) |
| `contact/contact.html` | Contact | Published | 0 — migrated to folder pattern in session-18, step 1 of 8 in the root-separation plan (Open Decision #30) |
| `master-synthesis-prompt/master-synthesis-prompt.html` | Founding Document | Published | 1 — Founding document, historical. Migrated to folder pattern in session-20, step 4 of 8 in the root-separation plan (Open Decision #30) |

`now.html` moved out of root pages in session-21, step 6 of 8 in the root-separation plan (Open Decision #30) — now `_now/now.html`, moved into the existing collection folder rather than a new sibling `now/` folder, to avoid a confusing `now/`/`_now/` pair. See the `_now/` collection section below.

`signals.html` moved out of root pages in session-21, step 7 of 8 in the root-separation plan (Open Decision #30) — now `_signals/signals.html`, same corrected approach as step 6. See the `_signals/` collection section below.

Only `index.html` remains at root — the one deliberate, universal exception (step 8, verification only).

`local-ai-stack.html` moved out of root pages in session-19, step 2 of 8 in the root-separation plan (Open Decision #30) — now `_now/building-a-local-ai-stack/local-ai-stack.html`, see the `_now/` collection section below.

### _ideas/ collection

| File/Folder | Title | Status | Notes |
|---|---|---|---|
| `_ideas/index.html` | Ideas | Published | Index page |
| `_ideas/man-with-two-brains/` | Man With Two Brains | Published | Folder pattern — reference implementation |
| `_ideas/marketing-os-foundation.html` | Marketing OS Foundation | Published | Legacy flat file — do not use as pattern for new entries |
| `_ideas/marketing-os/` | Marketing OS | Published | Migrated to folder pattern in session-12 (was an undocumented flat-file deviation); file inside is named after the folder (`marketing-os.html`), not `index.html` |
| `_ideas/ai-web-layer-framework/` | AI Web Layer Framework | Published | Migrated to folder pattern in session-12 (was an undocumented flat-file deviation); file inside is named after the folder (`ai-web-layer-framework.html`), not `index.html` |
| `_ideas/the-bug-the-audit-the-blueprint/` | The Bug, the Audit, the Blueprint | Published | Folder pattern — index.html + retrospective.html; session-2026-06-21-002 |
| `_ideas/four-agent-collaboration-test/` | The Four-Agent Collaboration Test | Published | Folder pattern — index.html; session-2026-07-03-002; added to _ideas/index.html entry list in session-9 (was missing) |
| `_ideas/repo-redesign-from-crazy-to-curated/` | Repo Redesign — From Crazy to Curated | Published | Folder pattern — file named after its own folder, not `index.html`, per the current naming convention; session-2026-07-05-024. Joint retrospective on the day's architecture/audit work — drafted by Cowork, converted to HTML by Claude Code; added to `_ideas/index.html` entry list in the same commit |

### _signals/ collection

| File/Folder | Status | Notes |
|---|---|---|
| `_signals/anthony-smith/` | Published | Migrated to folder pattern in session-16; file inside named `anthony-smith.html`, not `index.html` |
| `_signals/paul-mckey/` | Published | Migrated to folder pattern in session-16; file inside named `paul-mckey.html`, not `index.html` |
| `_signals/peter-sefton/` | Published | Migrated to folder pattern in session-16; file inside named `peter-sefton.html`, not `index.html` |
| `_signals/terry-hilsberg/` | Published | Migrated to folder pattern in session-16; file inside named `terry-hilsberg.html`, not `index.html` |
| `_signals/signals.html` | Published | The collection's own hand-written index — not an entry. Moved from repo root into `_signals/` in session-21 (root-separation step 7), matching the `_ideas/index.html`/`_now/now.html` precedent |

### _skills/ collection

Empty. Declared in `_config.yml` (output: true, permalink: /about/skills/:name/). No default layout set in _config.yml — any new skills entry must declare `layout:` explicitly in frontmatter or it will not render.

### _now/ collection

| File/Folder | Title | Status | Notes |
|---|---|---|---|
| `_now/building-a-local-ai-stack/` | Building a Local AI Stack | Published | Migrated to folder pattern in session-16; folder and file (`building-a-local-ai-stack.html`) both renamed from `local-ai-stack` to match the permalink slug, fully resolving the original naming collision with the root `/local-ai-stack/` guide. **Now also holds `local-ai-stack.html`** (the full 18-phase guide, permalink `/local-ai-stack/`, moved here session-19 as step 2 of the root-separation plan) — a deliberate exception to folder-mirrors-URL, per Cameron's request to colocate the two related pages; documented in Open Decision #30 |
| `_now/enrolment-pipeline-problem/` | The Enrolment Pipeline Problem | Published | Migrated to folder pattern in session-16; file inside named `enrolment-pipeline-problem.html`, not `index.html` |
| `_now/now.html` | Now (index) | Published | The collection's own hand-written index — not an entry. Moved from repo root into `_now/` in session-21 (root-separation step 6), matching the existing `_ideas/index.html` precedent (the collection's index lives inside its own collection folder, not a root-level file or a separate sibling folder) |

Split from the single flat `now.html` page (Open Decision #22).

### _session-logs/ collection

| File | Status |
|---|---|
| `session-2026-06-10-001.md` | Published |
| `session-2026-06-11-001.md` | Published |
| `session-2026-06-11-002.md` | Published |
| `session-2026-06-21-001.md` | Published |
| `session-2026-06-21-002.md` | Published |
| `session-2026-06-29-001.md` | Published |
| `session-2026-07-03-001.md` | Published |
| `session-2026-07-03-002.md` | Published |
| `session-2026-07-03-003.md` | Published |
| `session-2026-07-03-004.md` | Published |
| `session-2026-07-05-001.md` | Published |
| `session-2026-07-05-002.md` | Published |
| `session-2026-07-05-003.md` | Published |
| `session-2026-07-05-004.md` | Published |
| `session-2026-07-05-005.md` | Published |
| `session-2026-07-05-006.md` | Published |
| `session-2026-07-05-007.md` | Published |
| `session-2026-07-05-008.md` | Published |
| `session-2026-07-05-009.md` | Published |
| `session-2026-07-05-010.md` | Published |
| `session-2026-07-05-011.md` | Published |
| `session-2026-07-05-012.md` | Published |
| `session-2026-07-05-013.md` | Published |
| `session-2026-07-05-014.md` | Published |
| `session-2026-07-05-015.md` | Published |
| `session-2026-07-05-016.md` | Published |
| `session-2026-07-05-017.md` | Published |
| `session-2026-07-05-018.md` | Published |
| `session-2026-07-05-019.md` | Published |
| `session-2026-07-05-020.md` | Published |
| `session-2026-07-05-021.md` | Published |
| `session-2026-07-05-022.md` | Published |
| `session-2026-07-05-023.md` | Published |
| `session-2026-07-05-024.md` | Published |
| `session-2026-07-09-001.md` | Published |
| `session-2026-07-09-002.md` | Published |
| `session-2026-07-09-003.md` | Published |

### _messages/ bundle (not rendered — chain-of-custody archive)

Not a Jekyll collection — added to `_config.yml`'s `exclude:` list (same mechanism as `_ai-context/`), not declared as a collection. Repo-resident audit copy of selected `AI-Working/Messages/` exchanges, OKF-stamped (`type`, `title`, `timestamp`, `from`/`to` or `participants`, `refs:` as bundle-relative paths). Authored originals continue to live in `AI-Working/Messages/`; this is the record of custody, not the authoring workflow. Piloted 2026-07-09 (session-26) — see Open Decision #34. **8 files here vs. 118 in the `AI-Working/Messages/` backlog as of session-27 — this bundle is a small pilot slice, not yet a representative corpus.** See Open Decision #35.

| File | Type | Notes |
|---|---|---|
| `_messages/index.md` | index | Bundle index, `okf_version: "0.1"`. Still just a purpose description, not a real relationship index — flagged gap, not yet fixed, see Open Decision #35 |
| `_messages/cowork-to-ccode-2026-07-09-location-reconsideration.md` | message | |
| `_messages/cowork-to-ccode-2026-07-09-location-git-response.md` | message | |
| `_messages/ccode-to-cowork-2026-07-09-location-git-response.md` | message | |
| `_messages/cameron-cowork-conversation-transcript-2026-07-08.md` | transcript | Genuine verbatim capture; uses `participants:` list, not `from`/`to` |
| `_messages/OpenWEBUIandGemma4isWHACKED.md` | summary | Recovered from a chat-UI attachment Cameron held (never previously saved to disk); reclassified from its own self-described "Transcript" title to `type: summary` on inspection — bracketed placeholders stand in for real dialogue, not a raw capture. Resolves the previously-unresolvable `PROJECT_STATE.md` Capability Baseline citation (see Tool/Model/Runtime Matrix, AnythingLLM row) to a real bundle-relative path |
| `_messages/cameron-claudecode-conversation-transcript-2026-07-09.md` | transcript | Live-context capture — written directly from Claude Code's own active session while the conversation was still open, not reconstructed afterward |
| `_messages/cameron-claudecode-conversation-transcript-2026-07-08.md` | transcript | Mechanically extracted from a closed session's raw JSONL log (`_ai-context/extract-session-transcript.ps1`), not live-context or manual reconstruction — a stronger verbatim guarantee than either, since it depends on no one's recollection at all. Proof-of-concept for Open Decision #35's backfill question |

`type: audit-finding` deliberately untested — deferred to the real Auditor track rather than a synthetic file. See Open Decision #34.

### Directories pending action

None.

---

## Open Decisions and Pending Work

| # | Item | Phase | Owner | Gate |
|---|---|---|---|---|
| 1 | ai-content-creation-spec.md reconciliation | 4 | ✓ Done — merged to main | — |
| 2 | Remaining CLAUDE.md additions: session-close protocol, ideas folder pattern, _skills/ layout note | 4 | ✓ Done in ae15152 | — |
| 3 | Promote rct-session-primer.md to _ai-context/ | 4 | ✓ Done in f20d068 | — |
| 4 | master-synthesis-prompt.html: strip Section 8, founding-document note, label "Living" → "Founding", Section 9 update | 5 | ✓ Done — merged to main | — |
| 5 | about.html, now.html, signals.html: merge collab-notes to one per page | 5 | ✓ Done — merged to main | — |
| 6 | Delete AI-Web-Layer-Framework/ directory | 5 | ✓ Done — merged to main | — |
| 7 | cowork-conventions.md — draft and promote | 6 | ✓ Done 2026-06-21 | — |
| 8 | Memory backup files as plain onboarding documents | 6 | ✓ Done 2026-06-21 | — |
| 9 | settings.json — verify and implement (.claude/settings.json, POSIX path syntax) | 6 | ✓ Done — merged to main | — |
| 10 | AI-Prod mirror sync | Immediate | ✓ Done 2026-06-21 | — |
| 11 | now.html and signals.html two collab-notes | 5 | ✓ Done — consolidated to one per page | — |
| 12 | Two-agent workflow — permissions, roles, Phase 2 sync, AI-Working subfolder structure | 6 | ✓ Done 2026-06-29 (session-3b) | — |
| 13 | AI Independence Verification pre-test fixes — all 8 test-blockers resolved | 6 | ✓ Done 2026-06-29 | — |
| 14 | AI-agnostic design principle — structural discussion re: cowork-memory-backup.md and proprietary orientation files | 7 | ✓ Done 2026-07-05 (session-13) — see #25. `cowork-memory-backup.md` refreshed to remove all dated content and committed to `_ai-context/`; the Phase-2-triggered snapshot mechanism is the session-close-owned maintenance this decision was asking for | — |
| 15 | Survivable audit findings (9–22 from combined verification report) — 14 non-blocking issues documented | 7 | ✓ Done 2026-07-05 — Cowork established there was never a single "combined verification report" file; it was a live 2026-06-29 synthesis of two independent audits. Cowork's own ~7-finding half was never saved anywhere either side can read and is accepted as permanently unrecoverable. Of Cowork's 15 original findings, 9 were non-blocking; traced against current state: 3 resolved, 1 partial, 1 closed (never a real issue), 1 obsolete, 3 genuinely still open. Cameron accepted **F5** (`Drafts/` mixes config and content drafts, cosmetic), **F8** (superseded — see #32, already closed), and **F14** (check-and-balance not mentioned in the AnythingLLM system prompt) as the final list. None block anything; F14 is worth a line whenever that prompt is next touched, F5 is lowest priority | — |
| 16 | AI Independence Verification live test — AnythingLLM + OpenCode + Ollama end-to-end workflow | 7 | ✓ Done 2026-07-03 — status corrected 2026-07-05 (this row was stale, still read "ready to run"). Ran as the "four-agent-collaboration-test": AnythingLLM/Gemma drafted, OpenCode published with Claude Code auditing each claimed step against real repo state. Mixed result — one page published successfully, but only with live supervision; this finding is the origin of the whole day's architecture-rigor effort (2026-07-05). See `session-2026-07-03-002.md` | — |
| 17 | Content/HTML boundary — Draft Agent produces structured content only, Publish Agent authors all HTML/frontmatter | 8 | ✓ Done 2026-07-03 (session-5) — `AI_INSTRUCTIONS.md`, `CLAUDE.md`, `_ai-context/single-ai-workflow.md`, `_ai-context/ai-content-creation-spec.md` updated; `draft-agent-config.md` and `publish-handoff-template.md` owned by Cowork per the same decision | — |
| 18 | `.claude/settings.json` scoped Messages/Ready permissions — left uncommitted after the 2026-06-29 session-3b close | 8 | ✓ Committed 2026-07-03 (session-5) — matches the permissions already documented in `project-messages-folder-workflow` decision, no behaviour change from what was already active | — |
| 19 | Recurring `PROJECT_STATE.md` branch-staleness bug — found 3x during the four-agent-collaboration-test live run (sessions 5–7): Active Branch section named an already-merged branch because nothing required verifying git state at session start | 8 | ✓ Done via #21 (status corrected 2026-07-05 — this row previously read "partially fixed" after #21 had already resolved it). The session-start verification check added 2026-07-03 (session-8) was reactive only and the bug recurred once more (session-9, 2026-07-05); #21's structural fix — correcting state at merge-confirmation time rather than session-start — has held clean across twelve merges since (PRs #34–#45, no recurrence) | — |
| 20 | `_ideas/index.html` (and `signals.html`) are static hand-written lists, not generated from the collection — publishing a new entry doesn't make it appear on its own index. Missing entry for `four-agent-collaboration-test` found live on production 2026-07-03 | 8 | ✓ Done 2026-07-03 (session-9) — entry added to `_ideas/index.html`; documented as a required step in `ai-content-creation-spec.md` §6 and a new checklist item in `rct-validation-checklist.md` §2 | — |
| 21 | Open Decision #19's fix was reactive only — the session-start check catches staleness whenever a session happens to start, but nothing runs at the actual moment of merge, since merges happen on GitHub with no AI session present. Root cause: Phase 2 — AI-Prod Sync already fires at exactly that moment (Cameron's merge-confirmation paste) but never touched `PROJECT_STATE.md` | 9 | ✓ Done 2026-07-05 (session-10) — Phase 2 (`CLAUDE.md`) now corrects Active Branch immediately via an immediately-created next session branch, before the AI-Prod sync; general AI-agnostic version added to `AI_INSTRUCTIONS.md` §6. Correction follows normal branch-and-push discipline, not a direct-to-main exception | — |
| 22 | Now page → `_now/` collection — `now.html` held two hardcoded blocks with no individual permalinks; converted to a collection matching `_ideas/`/`_signals/` so entries are individually addressable, per Cowork proposal + Cameron's decision on collab-note session citation | 9 | ✓ Done 2026-07-05 (session-11) — `_config.yml`, `_now/local-ai-stack.html`, `_now/enrolment-pipeline-problem.html`, `now.html` rewritten as index; `ai-content-creation-spec.md`, `AI_INSTRUCTIONS.md`, `CLAUDE.md`, `rct-validation-checklist.md` updated | — |
| 23 | `_ideas/marketing-os.html` and `_ideas/ai-web-layer-framework.html` were undocumented flat-file deviations from the folder pattern — unlike `marketing-os-foundation.html`, neither had a legacy note explaining why. Found during the repo-architecture-mapping discussion with Cowork | 9 | ✓ Done 2026-07-05 (session-12) — both migrated to `_ideas/marketing-os/` and `_ideas/ai-web-layer-framework/`; the file inside each folder is named after the folder itself, not `index.html`, per the naming convention agreed the same session. Permalinks unchanged (both already declared explicitly), no content changes | — |
| 24 | `approach.html` and `master-synthesis-prompt.html` had no `permalink:` declared, unlike every other page — likely serving at unclean, extension-bearing URLs. Found during the repo-architecture-mapping discussion | 9 | ✓ Done 2026-07-05 (session-13) — `permalink: /approach/` and `permalink: /master-synthesis-prompt/` added to both; the one internal link to the latter (in `approach.html`) updated to match | — |
| 25 | `draft-agent-config.md`'s move to `_ai-context/` was agreed 2026-07-03 but never executed. Separately, `cowork-memory-backup.md` had gone stale twice (8 days, then 14 days) because it held a dated "project state" section nothing forced anyone to revisit | 9 | ✓ Done 2026-07-05 (session-13) — both committed to `_ai-context/`. `draft-agent-config.md` gained two sections it was missing (check-and-balance workflow, PowerShell prompt convention — Findings #14/#15 from Cowork's 2026-06-29 audit) before becoming the permanent copy. `cowork-memory-backup.md` was structurally fixed by Cowork, not just refreshed — the dated section was removed entirely in favour of pointers to `PROJECT_STATE.md`. Cowork committed to sending updates on change, picked up at the next Phase 2 run — resolves #14 | — |
| 26 | Merged architecture map's proposed Rule 1 ("folder-per-entry, universally, regardless of content length") was in tension with the same-day, carefully-reached decision to build `_now/`'s two entries as flat files | 9 | ✓ Done 2026-07-05 (session-13) — Rule 1 narrowed per Cowork's review: folder-per-entry when an entry has or is likely to need sub-pages; flat-file remains valid for single-page entries with none in view. `_signals/`'s four entries and `_now/`'s two entries were correctly flat under the narrowed rule at the time. **Superseded 2026-07-05 (session-16), see #29** — Cameron decided to migrate both collections anyway, for full structural consistency over the narrower rule | — |
| 29 | Following #26, Cameron decided `_signals/` and `_now/` should be migrated to the folder pattern after all, overriding Cowork's narrower Rule 1 recommendation | 9 | ✓ Done 2026-07-05 (session-16) — all four `_signals/` entries and both `_now/` entries migrated; each file inside named after its own folder, not `index.html`. `_now/local-ai-stack.html` also renamed to `building-a-local-ai-stack.html` in the process, fully resolving the original naming collision with the root `/local-ai-stack/` guide (both folder and filename now match the permalink slug). Permalinks unchanged throughout, no content changes. Cameron is the decision authority in the propose→review→consensus process Rule 1 came out of; Cowork to be notified for record consistency | — |
| 27 | Root-level content/instruction separation and the `about/` restructuring — statuses needed locking before the auditor version could be finalized | 9 | ✓ Done 2026-07-05. Both items resolved: root-level separation (was "proposed, not decided") executed in full via #30 across sessions 18–21; `about/` restructuring specifically done as step 5 of that same plan (session-21) | — |
| 28 | DeepSeek (Review Agent) audited the standalone architecture reference document 2026-07-05 (session-2026-07-05-005) and ranked manual instruction-file synchronization (`AI_INSTRUCTIONS.md`↔`CLAUDE.md` and the Draft Agent-side equivalents) as the single highest-risk open item — undocumented drift could let a weaker model follow an outdated rule unnoticed, undermining the project's own AI-independence hypothesis | 9 | **Parked as a standalone project 2026-07-05**, not decided against. A full project plan was written for propose→independent-review→consensus per the check-and-balance process: problem statement, an expanded scope table (now 4 file-pairs, one confirmed broken — F14 from #15 — one that only worked today through manual diligence — #32's sync), four candidate mechanisms with tradeoffs, and open questions for both agents to think through independently before converging. See `AI-Working/Messages/ccode-to-cowork-2026-07-05-instruction-sync-project-plan.md` (supersedes the earlier seed-thoughts message). Still no timeline — awaiting Cowork's independent review | Cowork to review independently, then converge, then Cameron decides |
| 30 | Following #27, Cameron decided to proceed with root-level content/instruction separation after all, executed incrementally least-risk-first rather than as one large change | 9 | ✓ Done 2026-07-05, all 8 steps complete across sessions 18–21. (1) `contact/contact.html`; (2) `local-ai-stack.html` → `_now/building-a-local-ai-stack/local-ai-stack.html`, kept its own name (not renamed to match the folder, since that name is already taken by `building-a-local-ai-stack.html`) — the one documented exception to folder-mirrors-URL (Rule 5.6), deliberate per Cameron's request to colocate it with the related Now entry; (3) `approach/approach.html`; (4) `master-synthesis-prompt/master-synthesis-prompt.html`; (5) `about/about.html`, also resolving the separate `about/` restructuring recommendation from #27 ahead of `work-history.html`/`skills.html` being built; (6) `now.html` → `_now/now.html`, revised mid-plan from the original `now/now.html`: moved into the *existing* `_now/` collection folder rather than a new sibling `now/` folder, matching the `_ideas/index.html` precedent and avoiding a confusing `now/`/`_now/` pair, given underscore prefixes are visually invisible to Cameron's own mental model; (7) `signals.html` → `_signals/signals.html`, same corrected approach as step 6; (8) `index.html` — verified as the only content file remaining at repo root, correctly unmoved, the one universal exception (Jekyll's implicit root-index rule). Root now holds only instruction/config files (`AI_INSTRUCTIONS.md`, `CLAUDE.md`, `ONBOARDING.md`, `PROJECT_STATE.md`, `README.md`, `Gemfile`, `_config.yml`, `.gitignore`, `opencode.json`) plus `index.html` — the original goal of Open Decision #27, fully realized | — |
| 31 | `opencode.json`'s configured model (`opencode/big-pickle`) doesn't match the Capability Baseline's documented OpenCode model (`gemma4:e4b`) — flagged repeatedly during today's architecture review but never given its own tracked entry until now (2026-07-05) | 9 | ✓ Done 2026-07-05 — Cameron confirmed `big-pickle` is a real, deliberately-configured model (initially assumed to be a joke/placeholder name, but genuinely what was used in the 2026-07-03 live test). `opencode.json` was correct all along; the Capability Baseline table was the stale record and has been corrected to match | — |
| 32 | Two overlapping Draft-Agent-side manual session-start prompts exist without referencing each other — `Protocols/session-start-verify.md` and `Prompts/prompt-cowork-session-start-check.md`. Flagged repeatedly during today's architecture review but never given its own tracked entry until now (2026-07-05) | 9 | ✓ Fully done 2026-07-05 — `session-start-verify.md` deleted on Cowork's side; a new "Session start" cross-reference section added to both `Protocols/draft-agent-config.md` (Cowork's working copy) and the repo's canonical `_ai-context/draft-agent-config.md`, placed after "Your role" and before "Check-and-balance for technical problems." Also resolves Cowork's Finding F8 from the 2026-06-29 self-audit | — |
| 33 | `PROJECT_STATE.md`'s Capability Baseline table conflated Tool/Model/Runtime/Purpose into a single "Current Tool" cell per role — the root cause of the original three-way Draft Agent tool ambiguity. Raised during the 2026-07-08 foundation-layer discussion, tracked separately as its own smaller fix (not the first step of the foundation-layer/OKF pilot) | 9 | ✓ Done 2026-07-09 (session-25) — split into a Role Access table (unchanged in spirit, plus a new proposed-not-active Auditor row) and a new Tool/Model/Runtime Matrix table (multiple rows per role, each with a cited, checkable Status). Publish Agent's Access row also corrected to include the `Write: AI-Working/Messages/` grant already enforced in `.claude/settings.json` but previously undocumented here. Proposed in `AI-Working/Messages/ccode-to-cowork-2026-07-08-capability-baseline-restructure-proposal.md`, agreed in `cowork-to-ccode-2026-07-08-capability-baseline-response.md` (evidence-citation condition), cleared in `cowork-to-ccode-2026-07-08-capability-baseline-go-ahead.md` | — |
| 34 | Foundation-layer `_messages/` OKF bundle pilot (from the 2026-07-08 foundation-layer proposal, Open Decision context in the Auditor row of the Tool/Model/Runtime Matrix above) — does the OKF bundle format actually hold up against real files, not just proposals | 9 | ✓ Core question answered 2026-07-09 (session-26), commits `bbb6526`/`86cb356`. Piloted against real files across three of four OKF types — `message` (3 files from the location-reconsideration thread), `transcript` (genuine verbatim capture, required a `participants:` list rather than `from`/`to` — authored vs. captured content need different shapes), and `summary` (a file initially assumed to be a transcript, reclassified on inspection — `type` has to come from reading content, not trusting a filename/self-description). Two corrections surfaced and fixed: `refs:` can only point to bundle-relative paths, not out to `AI-Working/` (which isn't git-tracked and, as this pilot demonstrated live, isn't even a reliable guarantee the cited file exists at all — see the `OpenWEBUIandGemma4isWHACKED.md` recovery in the `_messages/` bundle table above); and citations meant to be durable/checkable must point at something git-tracked generally, not just within this bundle. `type: audit-finding`, the fourth OKF type, deliberately left untested — Cameron's decision: "Auditor is on the agenda for later. It needs a lot of thought on how it will actually function," so it waits for the real Auditor track to produce genuine material rather than a synthetic test file. Full chain in `AI-Working/Messages/`: `ccode-to-cowork-2026-07-09-pilot-results.md` → `cowork-to-ccode-2026-07-09-pilot-response.md` → `ccode-to-cowork-2026-07-09-transcript-pilot-results.md` → `cowork-to-ccode-2026-07-09-transcript-pilot-response.md` → `ccode-to-cowork-2026-07-09-pilot-close.md`. Not the same as closing the wider foundation layer — the Auditor role and the full Messages/Conversations unification remain open, no timeline. Commit cadence for promoting future `AI-Working/Messages/` files into `_messages/` (session-close only vs. also at session-start) also remains an open question, raised by Cowork in `cowork-to-ccode-2026-07-09-location-git-response.md`, not decided this session. **Scope correction, session-27:** "core question answered" was true only for the chain-of-custody/audit-trail goal (does an Auditor trust this record wasn't altered). Cameron's original 2026-07-02 framing — a living, traversable knowledgebase that generates new learning over time — is a separate, larger goal this pilot never touched. See Open Decision #35 | — |
| 35 | Living-knowledgebase goal (Cameron's original 2026-07-02 framing, re-surfaced 2026-07-09 session-27): a discoverable, traversable, cross-linked corpus for Cameron/Draft/Publish to find related *and unrelated* ideas, with subagents eventually surfacing unexpected connections and contradictions over time — distinct from #34's chain-of-custody goal, which it does not complete | 9 | **Core proof-of-concept done, session-28; full scope remains open.** Four capabilities identified: (1) shared substrate — done; (2) cross-linking transcripts/summaries across threads — proof-of-concept done (search-based retrieval, see success test below), full graph-visualization cross-linking still unbuilt; (3) subagent traversal for unexpected connections/contradictions over time — needs active reconciliation, not just links, closer to `karpathy-llm-wiki`'s raw→compiled model than archive+link, not started; (4) Auditor double-checking Draft/Publish against spec (record-to-instruction traceability) — demoed 2026-07-10, one direction only. Full verbatim transcript of the design conversation: `_messages/cameron-claudecode-conversation-transcript-2026-07-09.md`. Plan proposed to Cowork and agreed in principle: `AI-Working/Messages/ccode-to-cowork-2026-07-09-ai-wiki-plan-proposal.md` → her response confirms she has real cross-file search (Grep/Glob, demonstrated, not assumed) → `ccode-to-cowork-2026-07-09-transcript-method-and-sequencing.md` → her response agreeing sequencing. Closed-session transcript extraction proven working on **both** platforms (`_ai-context/extract-session-transcript.ps1`; Claude Code: 28/203 turns recovered from a 2026-07-08 closed session, PowerShell UTF-8 encoding bug found and fixed; Cowork: 137/786 turns from her own JSONL equivalent, no encoding bug on her platform, not yet generalized from one test) — de-risks the historical-backfill question for Claude-Code/Cowork-authored sessions specifically, does not solve non-Claude sources (DeepSeek, ChatGPT, old Gemma/AnythingLLM). **Cameron decided 2026-07-10: curated slice now (foundation-layer + location-decision + the 2026-07-02 origin thread, 28 files), full historical backfill later.** Proposal sent for Cowork's independent review: `AI-Working/Messages/ccode-to-cowork-2026-07-10-curated-slice-proposal.md`. Her review (`cowork-to-ccode-2026-07-10-curated-slice-review.md`) found two real issues, both resolved same session: (1) the `2026-07-08` transcript already in `_messages/` was a partial, reconstructed capture of the same conversation Cowork's 137-turn mechanical extraction covers in full — fixed by promoting the full extraction as `_messages/cameron-cowork-conversation-transcript-full-2026-07-09.md` and adding `superseded_by:` from the partial to it, rather than letting both stand as if they were independent records; (2) the four-agent-test diagnosis is wrong (see #36, opened as a result). Her third finding — a file in `_messages/` reported as committed that she couldn't find — was a stale-AI-Prod-mirror false alarm, not a real gap; the file exists in the live repo, just not yet synced (AI-Prod only updates post-merge). Flags Cowork's review role has a structural lag on anything promoted mid-session, not a one-off. **session-27 merged (PR #51).** `session-28`: 27-file slice promoted, index rebuilt into a real cross-linked view of all 36 files (`2dbaef9`); record-to-instruction traceability demo built — the first `refs:` link in the bundle pointing outside it to `AI_INSTRUCTIONS.md` directly, using the real Open Decision #36 finding rather than a synthetic test case (`0ddf723`); stale provenance note fixed (`0a31f21`). Obsidian pointed at `_messages/` (via AI-Prod) and checked live 2026-07-10: confirmed empirically, not just from documentation — every file a disconnected dot except `index.md`, which shows real graph edges because it's the one file with actual markdown links in its body, not just frontmatter `refs:` (Obsidian's core graph engine doesn't parse frontmatter links without a plugin — confirmed against official docs and Google's own OKF reference visualizer, which has the identical limitation). Cowork independently re-verified the underlying link structure directly from frontmatter, not from Cameron's screen or Claude Code's report: re-ran the mechanical resolution check herself (36 files, 44 `refs:`/`superseded_by:` links, zero broken), spot-checked two `refs:` relationships against actual file content (both genuine, not coincidental citations), and tested `index.md`'s own stated accuracy rule against real frontmatter (held exactly) — `AI-Working/Messages/cowork-to-ccode-2026-07-10-independent-graph-verification-result.md`. **Success test run 2026-07-10 — passed.** Cameron asked cold: "do you remember when we chatted about OpenBrain a while back, why did we decide not to follow that through?" Run two ways in parallel, no coordination: a fresh Claude Code subagent with zero conversation memory, searching only the filesystem, and Cowork, independently. Both found the same source (`_messages/ccode-to-cowork-2026-07-02-conversation-transcript.md`) via different search mechanisms, quoted the identical passage verbatim, and reached the same answer — which corrected the question's own premise: there was no formal "decided against it," Cameron raised OpenBrain (OB1, a Postgres+pgvector+Supabase agent-memory system) once on 2026-07-02, it was evaluated on real tradeoffs against the already-working git-native markdown approach, and the conversation simply pivoted to a different, competing idea (full transcript capture + Obsidian) in the same exchange — the direct ancestor of this entire thread. Neither answer was fabricated; both were honest about the absence of a clean verdict rather than inventing one to fit the question's framing. Minor divergence in coverage (the subagent also found an unrelated second OpenBrain mention in a different project and explicitly checked for a Open Decisions entry; Cowork's answer didn't), not a contradiction. Both quotes independently verified by Claude Code against the source before reporting. Two design questions surfaced this session, decided to hold rather than build: (1) a mechanism to generate body-text markdown links from `refs:` frontmatter so Obsidian's graph (and Google's official OKF visualizer, which has the same requirement) would show real connections across all 36 files, not just `index.md`'s hub — proven viable, not yet built; (2) Dataview as a query-based alternative to fixing graph view — confirmed technically viable (reads frontmatter list fields without needing real links), but AI-Prod's `/MIR` sync would wipe Obsidian's `.obsidian/` plugin config on every Phase 2 sync unless the robocopy exclude list is updated first — fix identified, not made. Explicitly deferred beyond this: whether `karpathy-llm-wiki`'s actual self-compiling capability (Ingest/Query/Lint, not just visualization) gets built — confirmed from Karpathy's own source document that it requires `[[wikilinks]]` specifically, a third link representation on top of the other two, tool-agnostic in principle but not in its native link syntax — and the wider historical backfill (DeepSeek/ChatGPT/pre-Messages history) | Cameron: whether/when to build the body-link generator or Dataview setup, pursue `karpathy-llm-wiki`'s self-compiling capability, or begin historical backfill — none blocking, all open |
| 36 | Open Decision #16 and the published `_ideas/four-agent-collaboration-test/` page both diagnose AnythingLLM's 2026-07-03 failure as a tool-connectivity gap ("filesystem tools weren't wired into the workspace"). Found wrong 2026-07-10 during the curated-slice review: Cowork's full 137-turn transcript (`_messages/cameron-cowork-conversation-transcript-full-2026-07-09.md`) shows tools were connected — AnythingLLM hallucinated a file path ("AI-Workung"), insisted the typo existed in a file it had just read even after being told directly it wasn't there, and edited `draft-agent-config.md` in the read-only Protocols folder without authorization. That's a reliability/instruction-following failure, not a wiring problem — matters because RCT's whole premise is accurate attribution, and this is a published page's diagnosis, not just an internal note | 9 | Open — correction not yet drafted. Cameron's own read (2026-07-08 transcript): the test "failed on every dimension," closer to Edison's "found 99 ways not to" than a clean pass/fail, so the fix may be reframing the page's verdict entirely rather than just swapping one diagnosis line for another. Not yet scoped as a propose→review→consensus item | Cameron: correction scope, and whether the published page itself gets revisited now or stays parked with #36 as the tracked correction |
| 37 | Corpus discoverability currently depends entirely on the querying agent's own tool access (grep/file search), not on any search capability the corpus itself provides. First raised 2026-07-09 (design transcript, `_messages/cameron-claudecode-conversation-transcript-2026-07-09.md`): "Claude Code has repeatedly demonstrated [search]... but isn't guaranteed for whichever tool fills any role next" — a future Draft Agent, Publish Agent, or Research Agent implementation might not have grep-equivalent filesystem access wired in at all. Sharpened 2026-07-10 by the cold-question success test (#35): both the fresh subagent and Cowork found the OpenBrain answer via the identical mechanism — case-insensitive grep for the exact term "OpenBrain" — which only worked because both happened to have that tool today, and only because the question happened to use the corpus's own original terminology verbatim. Neither condition is guaranteed to hold for a future agent or a paraphrased question ("that memory database tool we looked at" instead of "OpenBrain") — the test result is real but narrower than it first looked | 9 | Open, not started. Two candidate mechanisms already named, neither built: `karpathy-llm-wiki`'s explicit Query operation (puts search inside the knowledgebase itself, not dependent on the querying agent's own tools) and Obsidian's search functions, if exposed to any agent via API/MCP rather than only through Cameron's own GUI session | Cameron: whether/when to pursue either mechanism, or hold as a known limitation |

---

## Capability Baseline

Restructured 2026-07-09 (session-25) from a single conflated table into two — see Open Decision #33. The old single "Current Tool" cell mixed Tool/Model/Runtime/Purpose into one string, which is what made "currently AnythingLLM" read as contradicting `AI_INSTRUCTIONS.md`'s flat "Cowork" claim. Proposed in `AI-Working/Messages/ccode-to-cowork-2026-07-08-capability-baseline-restructure-proposal.md`, agreed in `cowork-to-ccode-2026-07-08-capability-baseline-response.md`, cleared in `cowork-to-ccode-2026-07-08-capability-baseline-go-ahead.md`. Independent of, and does not depend on, the separate foundation-layer/OKF pilot still under discussion.

### Role Access

| Role | Access |
|---|---|
| Draft Agent | Read/write: `C:\Users\camer\Documents\AI\AI-Working\`; Read-only: AI-Prod; No access: repo, GitHub |
| Publish Agent | Read/write: repo; Read-only: AI-Working/Ready/; Write: AI-Working/Messages/ (per `.claude/settings.json`, previously omitted here); Write: AI-Prod (sync only, post-merge); No access: AI-Working/Drafts/, AI-Working/Completed/ |
| Review Agent | Read: documents provided by Cameron |
| Auditor *(proposed, not active)* | Not yet defined — blocked on the test protocol; see 2026-07-08 foundation-layer discussion, `AI-Working/Messages/cowork-to-ccode-2026-07-08-foundation-layer-proposal.md` |

### Tool / Model / Runtime Matrix

Multiple rows per role are expected — a default plus any tested or candidate alternatives. Every status claim below is cited; a table entry with no citation is not a status, it's an assertion.

| Role | Tool | Model | Runtime | Status |
|---|---|---|---|---|
| Draft Agent | Cowork | Claude, Anthropic | Hosted | Default — in active use |
| Draft Agent | AnythingLLM | Gemma4 (gemma4:e4b) | Local-Ollama | Tested 2026-07-03 for AI independence verification — failure was behavioral, not connectivity. Evidence: `_session-logs/session-2026-07-03-002.md`, `AI-Working/OpenWEBUIandGemma4isWHACKED.md`. Retest planned, no date set |
| Publish Agent | Claude Code | Claude, Anthropic | Hosted | Default — in active use |
| Publish Agent | OpenCode | `big-pickle` | Hosted (token) | Configured alternative — `opencode.json` (gitignored). Confirmed real and deliberate by Cameron 2026-07-05 (Open Decision #31), not a placeholder |
| Review Agent | External, rotating | DeepSeek (most recent) | Hosted | Ad hoc, per-review |
| Auditor *(proposed)* | OpenWork, candidate | Frontier model, TBD | Hosted | Untested — blocked on test protocol; see foundation-layer discussion, 2026-07-08 |

---

## Collections Declared in _config.yml

| Collection | Output | Permalink | Default layout |
|---|---|---|---|
| ideas | true | /ideas/:name/ | none set — must declare in frontmatter |
| signals | true | /signals/:name/ | none set — must declare in frontmatter |
| skills | true | /about/skills/:name/ | none set — must declare in frontmatter |
| now | true | /now/:name/ | none set — must declare in frontmatter |
| session-logs | true | /session-logs/:name/ | default (set in _config.yml defaults block) |

---

*Read this file before every session. Update it at every session close.*
*If this file and any other file conflict on current state, this file wins.*
