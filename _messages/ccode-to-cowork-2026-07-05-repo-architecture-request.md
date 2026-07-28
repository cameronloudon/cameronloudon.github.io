---
type: message
title: "Request — complete the instruction-file map together"
timestamp: 2026-07-05
from: Claude Code
to: Cowork
aliases:
  - repo architecture map request
  - draft agent config move intended
  - openwiki completeness reference
refs: []
---

## Why this message exists

Cameron and I spent a working session mapping out a proposed restructuring of the repo (`cameronloudon.github.io`) — folder-per-entry consistency across collections, root-level content separated from instruction files, no more generic `index.html` naming inside entry folders, that kind of thing. Full detail is pasted below.

Partway through, Cameron pointed out something I'd missed: the document I produced only covers what's visible from the repo side (`Users\camer\Documents\GitHub\cameronloudon.github.io`). It has no visibility into whatever instruction files, orientation documents, memory/config files, or folder structure you operate from. He was clear that this separation is deliberate — a security boundary so neither of us can accidentally touch the other's files — but it means my map can't actually claim to be "complete" the way it's trying to be. It's the Publish Agent half of the picture only.

He also confirmed you don't have access to `Users\camer\Documents\GitHub`, so I can't just point you at files there — everything relevant has to travel through this Messages folder, same as always.

## The ask

Before Cameron takes this to a third-party auditor, he wants the full picture assembled from both sides. Could you produce the same kind of inventory for your own environment — whatever you have access to under `AI-Working/` plus anything else you read from (orientation files, memory backups, protocol documents, whatever exists) — with the same level of detail as the map below: what each file is for, who/what reads it, when, and how it relates to the others. Doesn't need to match my format exactly, just needs the same rigor: nothing orphaned, no undocumented file.

Once that comes back, Cameron will have both halves and can decide how to merge them (or whether I should) before anything goes to the auditor.

## Also worth knowing before you start

Cameron separately confirmed Open Decision #14 (`PROJECT_STATE.md`) is directly relevant here — the "AI-agnostic design principle re: cowork-memory-backup.md and proprietary orientation files" question. If any of your orientation files are proprietary/non-portable in a way that affects how they'd be described in a shared architecture document, flag that explicitly rather than leaving it implicit — same "no undocumented deviation" principle the repo-side document below argues for.

---

## The repo-side document, in full, for reference

# Repo Architecture Plan — Discussion Draft
**For:** Cameron and Cowork, to read and discuss together
**Status:** Planning only. Nothing in this document has been implemented. No decision has been made yet.
**Purpose:** Lay out what was found, what's being proposed, and why — so the two of you can reach your own conclusion, not be steered toward one.

---

### 1. Why this document exists

Over a working session, Cameron and Claude Code found and discussed a series of structural inconsistencies in the repo — some cosmetic, some genuinely confusing, one a repeat instance of an already-logged bug. Rather than fix things piecemeal as they were noticed, Cameron asked for the whole picture written down once: every instruction file, every content file, what's proposed to change and why, so nothing is orphaned and nothing is assumed-but-undocumented.

Two things motivated this beyond tidiness:

1. **A live AI-Independence test largely failed.** Over roughly 10 hours in the days before this planning session, a Gemma-class local model (via AnythingLLM) was tested in the Draft Agent role, and OpenCode was tested in the Publish Agent role. The Draft Agent role failed. The Publish Agent role mostly failed. The one piece of content that did get published only worked because Claude Code was supervising and correcting OpenCode's actions in real time. This plan does not claim structural consistency would have fixed that on its own — but the reasoning below rests on the hypothesis that a weaker model needs fewer undocumented special cases and less inference to act reliably without supervision, and that untested hypothesis is worth taking seriously given what was just observed.

2. **Cameron named [OpenWiki](https://github.com/langchain-ai/openwiki) (LangChain)** — an open-source tool that generates and maintains agent-facing documentation for a codebase, keeps it updated via git diffs, and points coding agents at it — as the *kind* of completeness he has in mind, explicitly saying it doesn't have to be that specific tool. The relevant idea borrowed from it here is: nothing orphaned, nothing undocumented, structured so an agent (or a person) can rely on the documentation instead of inferring intent. Whether to actually adopt OpenWiki or a similar tool is a separate decision, out of scope for this document.

---

### 2. Complete instruction-file map (repo side only)

This project has accumulated several instruction and config files over multiple sessions. Cameron said directly that he doesn't fully understand how they all relate to each other despite having done a lot of the underlying work — so mapping this out is treated as a primary goal of this document, not a side effect.

| File | What it's for | Who/what reads it | When | Relationship to others |
|---|---|---|---|---|
| `README.md` | One-line repo description for anyone landing on the GitHub repo page | Humans browsing GitHub | On arrival | Doesn't reference or get referenced by the AI-instruction files — it's the outward-facing GitHub blurb, not part of the AI workflow |
| `ONBOARDING.md` | Entry point for any new AI assistant on this project — explains the two-agent workflow, where content lives, which files are Claude-specific | Any AI, once, on first contact with the project | First session only, per its own instruction | Points to `AI_INSTRUCTIONS.md` and `PROJECT_STATE.md` as the next reads; explicitly says it is *not* a live state tracker |
| `AI_INSTRUCTIONS.md` | Canonical, AI-agnostic rules: roles, session-start ritual, RCT framework, technical constraints (git, frontmatter, CSS) | Any AI filling the Draft or Publish Agent role | Every session | **States its own authority explicitly**: "Authoritative on: Intent and conventions... If they conflict, [with CLAUDE.md] this file wins." Cross-references `PROJECT_STATE.md`, `_ai-context/*` |
| `CLAUDE.md` | Same conventions as `AI_INSTRUCTIONS.md`, plus Claude-Code-specific operational detail (exact commands, About page content spec, Phase 2 sync procedure) | Claude Code specifically | Auto-loads every session | Is *not* the authority if it conflicts with `AI_INSTRUCTIONS.md` — that file wins by its own stated rule. In practice the two have been kept in sync manually; there is no automated check that they stay that way |
| `PROJECT_STATE.md` | The one file that changes constantly: current branch, page inventory, open decisions log, capability baseline | Any AI, every session, before doing anything | Every session, read first, updated last | Explicitly states "if this file and any other file conflict on current state, this file wins" — it outranks even `AI_INSTRUCTIONS.md` on *current state* (not on *conventions*, which is `AI_INSTRUCTIONS.md`'s domain) |
| `_ai-context/ai-content-creation-spec.md` | The template library: exact HTML/frontmatter shape for every content type (ideas, signals, now, skills), CSS rules, tag taxonomy | Whichever agent is authoring content | Before drafting or publishing new content | Referenced by both `AI_INSTRUCTIONS.md` and `CLAUDE.md` as the canonical template source — "do not duplicate this list elsewhere" is stated in the file itself |
| `_ai-context/rct-session-primer.md` | Defines the Radical Collaboration Transparency framework itself: collab-note format, session-log format, self-identification rules | Whichever agent is publishing content or closing a session | Before any publishing task | Referenced by `AI_INSTRUCTIONS.md` §5 as the format authority for collab-notes and session logs |
| `_ai-context/rct-validation-checklist.md` | The literal pre-publish checklist — attribution integrity, content integrity, state integrity, review integrity | Whichever agent is about to commit content | Before every commit that adds/changes published content | Enforces the rules `ai-content-creation-spec.md` and `rct-session-primer.md` describe; if any item fails, the instruction is to stop and flag Cameron, not commit anyway |
| `_ai-context/single-ai-workflow.md` | What to do when one AI (not two) is filling both Draft and Publish roles | Any single AI operating solo | Read once that situation applies | Explicitly frames the two-role split as "contingent, not permanent" — this file exists so a single-AI session doesn't get stuck trying to simulate two roles |
| `.claude/settings.json` | Claude Code's permission allowlist — what it can read/write without prompting (AI-Working/Messages, AI-Working/Ready read-only, the robocopy sync command) | The Claude Code harness itself, not a human or the model | Every tool call | Purely mechanical — encodes the access boundaries `AI_INSTRUCTIONS.md` §3 describes in prose, for one specific tool |
| `opencode.json` | OpenCode's equivalent config: which instruction files to auto-load, model provider, permission rules | The OpenCode harness | Every OpenCode session | Gitignored — never committed, each machine running OpenCode needs its own copy. Currently points at a model identified as `opencode/big-pickle`, which doesn't match `PROJECT_STATE.md`'s documented baseline of `gemma4:e4b` — a small drift worth reconciling separately from this plan |
| `_config.yml` | Jekyll's own build configuration: collections, permalinks, plugins, markdown engine, build excludes | The Jekyll build process | Every build | Excludes `_ai-context/` from the built site — confirms that folder is purely for agents/humans reading the repo, never published |
| `Gemfile` | Ruby dependency manifest — which gems (Jekyll itself, the `minima` theme, `jekyll-feed`) the build needs | Ruby's `bundler` tool | At build time | Build plumbing, not a project-convention file — same category as `_config.yml`, unrelated to the AI workflow |
| `.gitignore` | What git should never track (build artifacts, secrets, the local `opencode.json`) | git | Every commit | Plumbing, not a convention file |

**One thing not yet enforced anywhere:** the "sync check" step in `CLAUDE.md`'s Session-Close Protocol says to flag Cameron if a session's changes affect `AI_INSTRUCTIONS.md`/`CLAUDE.md` conventions "so the two files don't drift" — but this is a manual instruction to remember, not a check anything runs automatically.

---

### 3. Full content inventory — current state (repo side only)

#### Root-level standalone pages

| File | Permalink (as currently declared) | Notes |
|---|---|---|
| `index.html` | *(none declared — relies on Jekyll's implicit rule that a literal `index.html` at the true source root maps to `/`)* | The one legitimate universal exception discussed below |
| `about.html` | `/about/` | Planned but unbuilt sub-pages `about/work-history.html`, `about/skills.html` are documented in `CLAUDE.md`'s About Page Specification |
| `approach.html` | *(none declared)* | Newly found during this write-up — same latent issue as `master-synthesis-prompt.html` below |
| `contact.html` | `/contact/` | — |
| `local-ai-stack.html` | `/local-ai-stack/` | The full 18-phase guide; distinct from the short `_now/local-ai-stack.html` update that links to it |
| `master-synthesis-prompt.html` | *(none declared)* | Likely-latent bug — probably serving at an ugly URL. Not yet confirmed against the live site |
| `now.html` | `/now/` | Rewritten this session as a hand-written index for the new `_now/` collection |
| `signals.html` | `/signals/` | Hand-written index, same pattern as `_ideas/index.html` |

#### `_ideas/` collection

| File/Folder | Structure | Notes |
|---|---|---|
| `_ideas/index.html` | Flat (collection's own index, not an entry) | Hand-written list — not a Liquid loop over `site.ideas` |
| `_ideas/man-with-two-brains/` | Folder — `index.html` + `first-principles.html` | Documented in `CLAUDE.md` as the "reference implementation" |
| `_ideas/four-agent-collaboration-test/` | Folder — `index.html` only | Single-page entry; folder pattern with just one file |
| `_ideas/the-bug-the-audit-the-blueprint/` | Folder — `index.html` + `retrospective.html` | — |
| `_ideas/marketing-os-foundation.html` | Flat file | Documented as legacy: "do not use as pattern for new entries" |
| `_ideas/marketing-os.html` | Flat file | Not documented as legacy anywhere — no explanation on record |
| `_ideas/ai-web-layer-framework.html` | Flat file | Not documented as legacy anywhere — same gap |

#### `_signals/` collection

All four entries (`anthony-smith.html`, `paul-mckey.html`, `peter-sefton.html`, `terry-hilsberg.html`) are flat files, no folders.

#### `_now/` collection

`local-ai-stack.html` (permalink `/now/building-a-local-ai-stack/`) and `enrolment-pipeline-problem.html` — both flat files, created this session.

#### `_skills/` collection

Declared in `_config.yml` but the folder does not exist yet — zero entries.

#### `_session-logs/` collection

Twelve flat `.md` files. Explicitly kept **out of scope** for this restructuring — Cameron confirmed this directly, it's an append-only audit trail, not a folder-per-entry candidate.

#### System folders

`_layouts/` (`default.html`), `assets/` (`css/main.css`, `js/theme.js`, `audio/`), `_ai-context/` (excluded from the Jekyll build).

---

### 4. Proposed rules under discussion (not yet decided)

1. **Folder-per-entry, universally**, regardless of content length — every collection entry gets its own folder, whether it holds one file or several.
2. **No file named `index.html` inside a collection entry folder** — name it after the folder/topic instead (verified safe: entries already declare explicit `permalink:` front matter, so Jekyll doesn't care what the file is named). Exception: the true site-root `index.html` stays, since that's a universal convention with no topic to name itself after.
3. **Keep `_ideas/`, `_signals/`, `_now/`, future `_skills/` as real Jekyll collections** — confirmed via codebase search that nothing uses `site.ideas`/`site.now`/`site.signals` Liquid loops anywhere; every index is hand-typed. Keeping real collections preserves the option to auto-generate indexes later (permanently fixing the "forgot to add the `<li>`" bug — Open Decision #20), which flattening to plain folders would foreclose.
4. **Separate root-level content pages from root-level instruction/config files** — permalinks decouple file location from URL, so pages can move into folders mirroring their own URLs without breaking anything.
5. **`about/` specifically** — restructure as a folder now, before its documented-but-unbuilt sub-pages (`work-history.html`, `skills.html`) get created, avoiding a later migration.
6. **Every undocumented deviation from a stated pattern needs a written reason** — `marketing-os-foundation.html` is fine (documented legacy); `marketing-os.html` and `ai-web-layer-framework.html` are not (no explanation anywhere) — flagged as needing a decision, not resolved here.

Two incidental findings: `master-synthesis-prompt.html` and `approach.html` both have no `permalink:` declared, likely serving at unclean URLs — not part of the folder-structure discussion, just surfaced while building this inventory.

---

### 5. Underlying design principles

1. Folder path should visually mirror URL path.
2. Every file name should be self-describing — no placeholder names like `index`, except the one universal site-root exception.
3. No undocumented deviation from a stated pattern.
4. One canonical reference example per pattern, explicitly named as such.
5. Prefer whichever option needs the least extra configuration for the same visible result.

---

### 6. What this document deliberately isn't doing

- Not proposing a migration order, timeline, or task list.
- Not deciding the `marketing-os.html` / `ai-web-layer-framework.html` question.
- Not deciding whether to adopt OpenWiki or any similar tool.
- No files have been touched.

---

*Claude Code (Publish Agent) · 2026-07-05*
