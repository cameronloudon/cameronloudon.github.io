---
type: reference
title: "Repo & Two-Agent System Architecture — Audit Reference"
timestamp: 2026-07-05
from: Claude Code and Cowork (joint)
to: DeepSeek (external Review Agent)
aliases:
  - audit reference document
  - DeepSeek architecture audit
  - instruction-sync risk ranking source
refs: []
---

**Subject:** `cameronloudon.github.io` (a Jekyll site on GitHub Pages) and the two-agent Draft/Publish content system built around it
**Prepared for:** Third-party review. No prior context assumed.
**As of:** 2026-07-05 (repo session-14; verified against git history up to PR #37)
**Status:** Describes current, verified state. A small number of items are explicitly flagged as open — proposed but not decided, or recommended but not yet actioned. Nothing in this document is described as resolved unless it corresponds to an actual, dated commit or merge.

---

## 1. Purpose and scope

This document gives an external reviewer a complete, self-contained picture of:

1. How the repository is organized, and every instruction/configuration file governing how it and its companion content-production system are maintained.
2. Every content file and working file across both halves of the system — the published repository and the Draft Agent's separate working environment — so nothing is left unaccounted for.
3. The structural rules currently in force, which of them were actively decided (with the reasoning behind each), and which remain open by explicit agreement rather than oversight.
4. A dated log of what has been fixed, and what is still outstanding.

**Why this rigor.** The site's own instruction files (`AI_INSTRUCTIONS.md`, `ONBOARDING.md`) state a long-term goal of operating this system's content-production workflow — a "Draft Agent" that writes content and a "Publish Agent" that commits it — using local or smaller AI models rather than a frontier model. A live test of that goal (a Gemma-class model via AnythingLLM in the Draft Agent role, a tool called OpenCode in the Publish Agent role, run over approximately 10 hours) largely failed: the Draft Agent role failed to produce usable output, the Publish Agent role mostly failed to execute correctly unsupervised, and the one piece of content that was successfully published only succeeded because a frontier-model agent (Claude Code) was actively supervising and correcting the weaker tool's actions. This document does not claim that structural consistency alone would have prevented that failure. It documents the working hypothesis that motivated the effort below: a materially less capable model needs fewer undocumented special cases and less inference to act correctly without supervision, and that hypothesis is the reason the items in Sections 6–7 were pursued as a system-reliability concern rather than a stylistic one.

This effort was informed, as a point of reference rather than a specific recommendation, by [OpenWiki](https://github.com/langchain-ai/openwiki) (LangChain) — an open-source tool that generates and maintains machine-readable documentation for a codebase and keeps it synchronized with the code over time. Adopting OpenWiki or an equivalent tool remains a separate, undecided question, referenced here only to establish the completeness standard this document targets: every file accounted for, every deviation from a stated pattern documented, nothing left to inference.

---

## 2. System overview

### 2.1 How Jekyll builds this site

Jekyll is a static site generator. Source files (HTML or Markdown with a metadata header called "front matter") are compiled into static HTML, served directly by GitHub Pages. Two mechanics are load-bearing for the structural decisions described later:

- **A page's published URL is set by its `permalink:` front-matter field, not by where its source file lives.** A file can be relocated anywhere in the source tree without changing its public URL, provided `permalink:` is set explicitly and unchanged.
- **Any plain directory (name not starting with `.` or `_`) is processed automatically as a location for ordinary pages, with no configuration change required.** Directories starting with `_` are either one of Jekyll's reserved names (`_layouts`, `_includes`, `_sass`, `_data`, `_posts`) or a custom "collection," which must be declared in `_config.yml`.

Both mechanics were verified against Jekyll's own documentation and this repository's `_config.yml` and page front matter, not assumed.

### 2.2 The two-agent content system

Content moves through three locations with different access rules, enforced by file-system permissions on each tool:

| Location | Role | Access |
|---|---|---|
| `AI-Working\` (outside the repo) | Draft Agent's workspace — `Drafts/`, `Ready/`, `Completed/`, `Messages/`, `Protocols/`, `Prompts/`, `Projects/` | Draft Agent: read/write. Publish Agent: read-only on `Ready/`, read/write on `Messages/` |
| `<repo>` (this Jekyll source tree) | Where the Publish Agent commits, builds, and publishes | Publish Agent: read/write. Draft Agent: no access |
| `AI-Prod\` (outside the repo) | A read-only mirror of the published repository, kept in sync by the Publish Agent after each merge | Draft Agent: read-only. Publish Agent: write (sync only, post-merge) |

The Draft Agent drafts structured content (no HTML or frontmatter) and hands it to the Publish Agent via a message in `Messages\`. The Publish Agent authors all HTML/frontmatter, commits, and pushes a session branch; a human (Cameron) reviews and merges on GitHub. On merge confirmation, the Publish Agent runs a two-step procedure ("Phase 2"): correct the repository's own state record (`PROJECT_STATE.md`) to reflect the merge, then mirror the repository to `AI-Prod\`. This separation — verified directly, not assumed — exists specifically so neither agent can accidentally modify the other's files.

---

## 3. Complete instruction and configuration file inventory

### 3.1 Repository side

| File | Purpose | Audience | Precedence |
|---|---|---|---|
| `README.md` | Public one-line description on the GitHub repository page | Any GitHub visitor | Independent of the AI-workflow files below |
| `ONBOARDING.md` | Introduces the two-role workflow to any new AI assistant | Any AI, first session only | Directs to `AI_INSTRUCTIONS.md` and `PROJECT_STATE.md` next; explicitly not a state tracker |
| `AI_INSTRUCTIONS.md` | Canonical, tool-agnostic rulebook: roles, session-start verification, content-attribution framework, technical constraints | Any AI in either role, every session | **States its own precedence**: authoritative on intent/conventions; governs over `CLAUDE.md` on conflict |
| `CLAUDE.md` | Restates `AI_INSTRUCTIONS.md`'s conventions with Claude Code-specific operational detail | Claude Code; auto-loads every session | Subordinate to `AI_INSTRUCTIONS.md` by that file's own rule. No automated check keeps the two in sync — a documented, still-open gap |
| `PROJECT_STATE.md` | The one file that changes every session: active branch, page inventory, a dated log of resolved and open decisions | Any AI, required reading first, every session | **States its own precedence on current state** specifically — outranks `AI_INSTRUCTIONS.md` there |
| `_ai-context/ai-content-creation-spec.md` | Authoritative template library: front matter, HTML structure, CSS rules, controlled tag vocabulary per content type | Whichever agent produces or approves content | States in its own text that it is the single source, not to be duplicated |
| `_ai-context/rct-session-primer.md` | Defines the site's content-attribution framework: in-page disclosure format, per-session audit-log format | Whichever agent publishes content or closes a session | Referenced by `AI_INSTRUCTIONS.md` as the format authority |
| `_ai-context/rct-validation-checklist.md` | Itemized pre-publication checklist | Whichever agent is about to commit content | A failed item blocks the commit and must be raised for review, not bypassed |
| `_ai-context/single-ai-workflow.md` | Procedure for a single AI filling both Draft and Publish roles | Any single AI operating without a counterpart | States the two-role division is a historical implementation choice, not a permanent requirement |
| `_ai-context/draft-agent-config.md` | The Draft Agent's operational rulebook: output format, required fields, self-check, check-and-balance workflow, a prompt-formatting convention | The Draft Agent (currently AnythingLLM) | Committed 2026-07-05. Subordinate to `AI_INSTRUCTIONS.md` by its own stated rule. Its working copy (§3.2) remains the version actively edited; this is a synchronized snapshot |
| `_ai-context/cowork-memory-backup.md` | A plain-language, portable export of the Draft Agent's memory context, for a replacement tool taking over the role | Any AI taking over the Draft Agent role, cold-start | Committed 2026-07-05. Deliberately contains no dated facts (see §6, item 5) — points to `PROJECT_STATE.md` instead |
| `.claude/settings.json` | Machine-readable permission allowlist for the Claude Code tool | The Claude Code application | Encodes, for one tool, the access boundaries described in prose in `AI_INSTRUCTIONS.md` §3 |
| `opencode.json` | Equivalent configuration for an alternative agent tool ("OpenCode") | The OpenCode application | Not version-controlled (excluded via `.gitignore`). Its configured model identifier does not match the baseline recorded in `PROJECT_STATE.md` — an open, unresolved discrepancy |
| `_config.yml` | Jekyll's build configuration: declared collections and permalink patterns, plugins, build exclusions | Jekyll build process | Excludes `_ai-context/` from the published site |
| `Gemfile` | Ruby dependency manifest for the build | Ruby's `bundler`, at build time | Build infrastructure, unrelated to the AI workflow |
| `.gitignore` | Specifies files git never tracks | git | Build/version-control infrastructure |

### 3.2 Draft Agent side (`AI-Working\`, outside the repository)

| File | Purpose | Audience | Precedence |
|---|---|---|---|
| `Protocols/cowork-conventions.md` | The Draft Agent's equivalent of `AI_INSTRUCTIONS.md` — role scope, workflow, handoff format, session-close steps | Any AI in the Draft Agent role | States it is a "companion to `AI_INSTRUCTIONS.md`" |
| `Protocols/draft-agent-config.md` | The live, actively-edited version of the file synchronized into the repository (§3.1) | Whichever agent is drafting (currently AnythingLLM) | Subordinate to `AI_INSTRUCTIONS.md` by its own stated rule |
| `Protocols/cowork-memory-backup.md` | The live, actively-maintained version of the file synchronized into the repository (§3.1) | Any AI taking over the Draft Agent role | — |
| `Protocols/session-start-verify.md` | A manual checklist Cameron can run to verify a Draft Agent's memory loaded correctly | Cameron, at his discretion | Not referenced by any other file — an open, undocumented redundancy with the item below |
| `Prompts/prompt-cowork-session-start-check.md` | A second, overlapping manual session-start prompt | Cameron, at his discretion | Overlaps with the item above; neither references the other |
| `Prompts/publish-handoff-template.md` | Template for the Draft-to-Publish handoff message | Draft Agent writes, Publish Agent reads | References `_ai-context/ai-content-creation-spec.md` §6 and the validation checklist — a verified cross-boundary link |
| `Prompts/opencode-template.json` | Template for OpenCode's configuration | Whoever configures OpenCode | Already confirmed drifted from the live `opencode.json` (§3.1) |
| `AI-Working/two-agent-system-process-reference.md` | Full process-and-permissions reference for the two-agent system | Any agent needing the complete picture | States "all critical files should agree with this document." Was found materially out of date in a 2026-06-29 self-audit (contradicted `cowork-conventions.md` on two workflow gaps); confirmed corrected as of this document |

---

## 4. Complete content inventory (current state)

### 4.1 Root-level standalone pages

| Page | Permalink | Notes |
|---|---|---|
| `index.html` | `/` (implicit) | Relies on Jekyll's convention that a literal `index.html` at the source root maps to `/` without a declared permalink — a universal static-site convention |
| `about.html` | `/about/` | Two sub-pages (`about/work-history.html`, `about/skills.html`) are documented as planned; neither exists yet |
| `approach.html` | `/approach/` | Permalink added 2026-07-05; previously undeclared |
| `contact.html` | `/contact/` | — |
| `local-ai-stack.html` | `/local-ai-stack/` | An 18-section technical guide |
| `master-synthesis-prompt.html` | `/master-synthesis-prompt/` | Permalink added 2026-07-05; previously undeclared. This is the project's founding document |
| `now.html` | `/now/` | A hand-authored index (manually maintained list), not a Jekyll collection loop |
| `signals.html` | `/signals/` | Same hand-authored-index pattern |

### 4.2 `_ideas/` collection
Declared in `_config.yml`, permalink pattern `/ideas/:name/`.

| Item | Structure |
|---|---|
| `index.html` | Hand-authored index; not a collection entry |
| `man-with-two-brains/` | Directory: `index.html` + `first-principles.html`. Documented as this project's reference example of the directory-per-entry pattern |
| `four-agent-collaboration-test/` | Directory: single file, demonstrating the pattern with no sub-pages |
| `the-bug-the-audit-the-blueprint/` | Directory: `index.html` + `retrospective.html` |
| `marketing-os/` | Directory (migrated 2026-07-05 from a flat file); its file is named `marketing-os.html`, not `index.html` |
| `ai-web-layer-framework/` | Directory (migrated 2026-07-05 from a flat file); its file is named `ai-web-layer-framework.html`, not `index.html` |
| `marketing-os-foundation.html` | A single flat file, explicitly documented elsewhere as a deprecated pattern, not to be replicated |

### 4.3 `_now/` collection
Declared in `_config.yml`, permalink pattern `/now/:name/`. Two flat-file entries: `local-ai-stack.html` (permalink `/now/building-a-local-ai-stack/`, distinct from the unrelated root-level guide at `/local-ai-stack/`) and `enrolment-pipeline-problem.html`. Confirmed correct as flat files under the structural rule in §5.1 — not a deviation requiring explanation.

### 4.4 `_signals/` collection
Declared in `_config.yml`, permalink pattern `/signals/:name/`. Four flat-file entries (`anthony-smith.html`, `paul-mckey.html`, `peter-sefton.html`, `terry-hilsberg.html`). Also confirmed correct as flat files under §5.1.

### 4.5 `_skills/` collection
Declared in `_config.yml` (permalink pattern `/about/skills/:name/`); contains no entries. The directory does not exist on disk.

### 4.6 `_session-logs/` collection
Fourteen Markdown files, one per recorded working session, an append-only audit log. Not subject to the directory-per-entry rule in §5.1 — no change to this collection is proposed anywhere in this document.

### 4.7 Non-content system directories
`_layouts/` (one file, `default.html` — the only layout in use), `assets/` (stylesheet, script, four audio files), `_ai-context/` (six files, inventoried in §3.1, explicitly excluded from the built site).

### 4.8 Draft Agent working files (`AI-Working\`)
`Drafts/` (11 files — mixes content drafts, tool-configuration drafts, and session-log drafts with nothing distinguishing them; one file violates the Draft Agent's own no-HTML rule, one stale leftover not cleaned up after publication); `Ready/` (empty, correct per its stated purpose); `Completed/` (one file, confirmed matching its published counterpart); `Messages/` (approximately 70 files, inter-agent correspondence, a documented naming convention followed consistently since 2026-06-29); `Prompts/` (one file with content replaced by a superseded notice rather than deleted, since the Draft Agent cannot delete files without per-file permission); `Projects/` (14 subfolders plus one undocumented loose file — source material largely outside the publishing system, including one folder not cleaned up after its repository counterpart was deleted).

---

## 5. Structural rules

Rules 1–3 and 6 are decided and, where applicable, already executed. Rules 4 and 5 have confirmed *statuses* but not execution decisions — both are documented as such, not left ambiguous.

**5.1 — Directory-per-entry when an entry has, or is likely to need, sub-pages; a flat file remains valid for a single-page entry with none in view.** This is a narrower rule than "directory-per-entry universally," which was considered and rejected: a universal rule would have required migrating `_signals/`'s four working entries and `_now/`'s two entries for no functional gain, in direct tension with a same-day decision (independently reached, through a full review process) to build the `_now/` entries as flat files specifically because they have no sub-pages. The narrower rule is satisfied by every current collection without exception.

**5.2 — No file named `index.html` inside a directory-pattern entry; the file is named after the directory/topic instead.** Verified safe because every entry already declares an explicit `permalink:`, so Jekyll's URL resolution depends on that field, not the file's name. Applied 2026-07-05 to the two `_ideas/` migrations (§4.2). The sole exception is the true site-root `index.html`, which maps to `/` via Jekyll's own convention and has no topic to be named after — treated as a universal convention, not a project-specific exception requiring separate justification.

**5.3 — `_ideas/`, `_signals/`, `_now/`, and any future `_skills/` entries remain declared Jekyll collections, not plain undeclared directories.** A full-codebase search confirmed no page or layout currently uses Jekyll's collection-iteration feature — every index page in §4 is manually authored. Retaining the formal collection declaration preserves the option to generate these index pages automatically in the future, which would permanently resolve a confirmed defect class (a previously published entry did not appear on its own index page because no one manually added the link — logged and fixed once already, see §6, item 3).

**5.4 — Root-level standalone content pages would be relocated into directories mirroring their own URLs, separate from the instruction/configuration files they currently share the repository root with.** *Status: proposed, not decided.* This is the highest-impact item in this document — it touches all seven root-level pages — and does not correspond to any known defect; it is a structural preference, not a bug fix. Both parties involved in this review explicitly agreed it should remain open rather than be resolved for the sake of this document's completeness.

**5.5 — The `about/` page specifically would be restructured into a directory now, ahead of its two documented-but-unbuilt sub-pages being created.** *Status: recommended, not yet actioned.* Unlike 5.4, this has a concrete forcing function — `about/work-history.html` and `about/skills.html` are already documented as planned — making it lower-risk to do before those pages exist than to migrate later alongside them. Recommended by the Draft Agent's review; timing remains at the site owner's discretion.

**5.6 — Every deviation from an otherwise-consistent pattern requires an explicit, discoverable written explanation; an undocumented deviation is treated as a defect regardless of its cause.** `marketing-os-foundation.html` (§4.2) is a deviation with a documented reason and is therefore compliant with this rule as-is.

**Design principles applied across the above:** a directory path should be a literal, human-navigable mirror of its published URL; every file name should describe its own content, with a generic name acceptable only where it reflects a convention true of virtually all software of this kind; every deviation from a stated pattern requires a discoverable justification; each structural pattern should have one example explicitly designated as its reference; where multiple implementations achieve the same visible outcome, the one requiring the least additional configuration is preferred.

---

## 6. Resolved issues (dated, for verification against git history)

1. **2026-07-03 (PR #33 and prior):** Recurring staleness in `PROJECT_STATE.md`'s Active Branch record — a session-start verification check was added, but proved reactive only (it caught staleness only if a session happened to start, not at the moment a branch actually became stale).
2. **2026-07-05 (PR #34):** The above was fixed at its source — the repository's post-merge synchronization procedure now corrects `PROJECT_STATE.md` immediately upon merge confirmation, via an immediately-opened session branch, rather than waiting for the next task to surface the correction.
3. **2026-07-03 (PR #33):** A published entry did not appear on its own collection index page because the index is a hand-authored list, not generated — fixed for the specific instance and documented as a required publishing step going forward (see §5.3 for why the underlying collection mechanism was retained rather than removed).
4. **2026-07-05 (PR #36):** Two `_ideas/` entries (`marketing-os.html`, `ai-web-layer-framework.html`) were flat files with no documented reason, unlike the one flat file that does carry a legacy note. Migrated to the directory pattern per §5.2.
5. **2026-07-05 (PR #37):** `approach.html` and `master-synthesis-prompt.html` had no `permalink:` declared, unlike every other page, and were likely serving at unclean URLs. Both fixed.
6. **2026-07-05 (PR #37):** `Protocols/draft-agent-config.md`'s intended relocation to the repository (`_ai-context/draft-agent-config.md`) had been agreed since 2026-07-03 but not executed. Executed, with two sections added first (a check-and-balance workflow description and a prompt-formatting convention) that were confirmed missing from the working copy and directly relevant to the live-test failure described in §1.
7. **2026-07-05 (PR #37):** `Protocols/cowork-memory-backup.md` had gone stale twice (8 days at a prior audit, 14 days at this review) because it held a dated "current state" section nothing forced anyone to revisit. Resolved structurally, not by a further refresh: the dated section was removed entirely and replaced with pointers to `PROJECT_STATE.md` and the session-log collection, which cannot go stale the same way.
8. **2026-07-05:** A maintenance mechanism for keeping repository copies of Draft Agent instruction files current was designed and executed once (items 6–7 above) rather than left as an unexploited option — it reuses the existing post-merge synchronization trigger rather than introducing new infrastructure.

---

## 7. Still-open items

- **No automated check** keeps `AI_INSTRUCTIONS.md`/`CLAUDE.md` in sync on the repository side, or `cowork-conventions.md`/`draft-agent-config.md`/`two-agent-system-process-reference.md` in sync on the Draft Agent side — both rely on a person or agent remembering to check manually.
- **`opencode.json`'s configured model** does not match the baseline recorded in `PROJECT_STATE.md` — an unresolved configuration drift.
- **Two duplicate files at the Draft Agent's working-directory root** (`rct-session-primer.md`, `ai-content-creation-spec.md`) have confirmed diverged from their canonical repository copies.
- **`Prompts/opencode-template.json`** has confirmed drifted from the live `opencode.json`.
- **One file in the Draft Agent's `Drafts/` folder** violates that role's own stated rule against producing HTML output.
- **A stale draft file** was not removed after its finished counterpart was published, and **a one-time repository snapshot file** still names a branch merged many sessions ago.
- **One working folder** was not cleaned up after its corresponding repository directory was deleted in an earlier, separately-logged decision.
- **Two manual session-start-verification prompts** exist on the Draft Agent side without referencing each other.
- **Several historical files** in the Draft Agent's working-directory root are not documented anywhere as historical, as distinct from current.
- **Rule 5.4** (root-level content/instruction separation) — proposed, not decided, by mutual agreement (§5.4).
- **Rule 5.5** (`about/` restructuring) — recommended, not yet actioned (§5.5).

---

## 8. A permanent limit on "complete"

The Draft Agent's environment includes at least one project-level instruction configured through that application's own user interface, not stored as a file anywhere in its working directory or the repository. It reaches the Draft Agent only because the application injects it directly into context at the start of a session. No file-based inventory — including this one — can discover that such a setting exists, or what it contains, by reading any folder.

This is stated explicitly so the completeness standard in Section 1 is understood correctly: it is the right standard for everything that exists as a file, and this document applies it to both halves of the system described. It cannot be extended to configuration that was never a file in the first place. This is a permanent boundary on documentation efforts of this kind, not a gap this document has failed to close.

---

## 9. Explicit scope exclusions

- No migration sequence, timeline, or task breakdown is specified for any item in Section 7.
- The disposition of Rule 5.4 (root-level separation) and Rule 5.5 (`about/` restructuring) is stated as a status, not resolved as a decision — see those sections for why each was left at its current status rather than forced further.
- Whether to adopt OpenWiki or an equivalent tool remains out of scope; it is referenced in Section 1 solely to establish this document's completeness standard.
- This document does not certify that every file in either working directory has been read in full; it certifies that every file identified during the review process that produced it has been accounted for, with its status stated plainly.

---

*Prepared from a joint review between the repository's Publish Agent (Claude Code, Anthropic) and Draft Agent (Cowork, Anthropic), with decisions made by the site owner. 2026-07-05.*
