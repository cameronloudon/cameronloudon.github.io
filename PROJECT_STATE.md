# PROJECT_STATE.md
**Single source of current project state. Read this before every session. Update this at every session close.**
**Last updated:** 2026-07-05
**Updated by:** Claude Code (Publish Agent) — Wrote a full project plan for Open Decision #28 (DeepSeek's instruction-sync recommendation), sent to Cowork for independent review per the check-and-balance process; still parked, not yet decided

---

## Active Branch

`session-24` (current session — opened immediately by Phase 2 on merge confirmation; no task started on it yet)
Branched from `main` at `24d5a4e` — Merge pull request #47 from cameronloudon/session-23
Cameron merges to main. Do not commit directly to main.

---

## Next Session Log ID

`NEXT_SESSION_LOG_ID: 2026-07-05-024`

This session used `session-2026-07-05-023`.

The thirty-three existing session logs are: `session-2026-06-10-001`, `session-2026-06-11-001`, `session-2026-06-11-002`, `session-2026-06-21-001`, `session-2026-06-21-002`, `session-2026-06-29-001`, `session-2026-07-03-001`, `session-2026-07-03-002`, `session-2026-07-03-003`, `session-2026-07-03-004`, `session-2026-07-05-001`, `session-2026-07-05-002`, `session-2026-07-05-003`, `session-2026-07-05-004`, `session-2026-07-05-005`, `session-2026-07-05-006`, `session-2026-07-05-007`, `session-2026-07-05-008`, `session-2026-07-05-009`, `session-2026-07-05-010`, `session-2026-07-05-011`, `session-2026-07-05-012`, `session-2026-07-05-013`, `session-2026-07-05-014`, `session-2026-07-05-015`, `session-2026-07-05-016`, `session-2026-07-05-017`, `session-2026-07-05-018`, `session-2026-07-05-019`, `session-2026-07-05-020`, `session-2026-07-05-021`, `session-2026-07-05-022`, `session-2026-07-05-023`.
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

---

## Capability Baseline

| Role | Current Tool | Access |
|---|---|---|
| Draft Agent | Cowork (Claude, Anthropic) via AnythingLLM + Ollama (gemma4:e4b) for AI independence verification | Read/write: `C:\Users\camer\Documents\AI\AI-Working\`; Read-only: AI-Prod; No access: repo, GitHub |
| Publish Agent | Claude Code (Claude, Anthropic) primary; OpenCode (`big-pickle`) alternative — `opencode.json` configured, gitignored. Corrected 2026-07-05: this row previously read `Ollama/gemma4:e4b`, which was stale — `big-pickle` is confirmed by Cameron as the actual model used in the 2026-07-03 live test, not a placeholder or typo | Read/write: repo; Read-only: AI-Working/Ready/; Write: AI-Prod (sync only, post-merge) |
| Review Agent | External (rotating; most recent: DeepSeek) | Read: documents provided by Cameron |

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
