# PROJECT_STATE.md
**Single source of current project state. Read this before every session. Update this at every session close.**
**Last updated:** 2026-06-21
**Updated by:** Cowork (Draft Agent) — Retrospective "The Bug, the Audit, the Blueprint" drafted and promoted; session-2026-06-21-002 written

---

## Active Branch

`main` (session-2 merged)
Last commit: `ae15152` — feat: CLAUDE.md Phase 4 additions (session-close protocol, ideas folder pattern, _skills/ layout note)
Cameron merges to main. Do not commit directly to main.

---

## Next Session Log ID

`NEXT_SESSION_LOG_ID: 2026-06-21-003`

The five existing session logs are: `session-2026-06-10-001`, `session-2026-06-11-001`, `session-2026-06-11-002`, `session-2026-06-21-001`, `session-2026-06-21-002`.
The next session that produces published output or repo changes must write `session-2026-06-21-003.md` to `_session-logs/` and increment this value.

---

## Instruction File Index

| File | Role | Notes |
|---|---|---|
| `ONBOARDING.md` | Entry point for any new AI | Read first, once per onboarding |
| `AI_INSTRUCTIONS.md` | Canonical AI-agnostic rules | Authoritative on intent; read if AI_INSTRUCTIONS.md and CLAUDE.md conflict, this wins |
| `CLAUDE.md` | Claude Code specific | Auto-loads for Claude Code; consistent with AI_INSTRUCTIONS.md as of f20d068 |
| `_ai-context/rct-session-primer.md` | RCT framework, collab-note and session log formats | Read before any publishing task |
| `_ai-context/rct-validation-checklist.md` | Pre-publish checklist | Run before every commit that adds or changes published content |
| `_ai-context/single-ai-workflow.md` | Single-tool workflow | Read if one AI is handling both Draft and Publish roles |
| `_ai-context/ai-content-creation-spec.md` | Full technical and design specification for content creation | Read before drafting new content; covers frontmatter, CSS, collab-note format, tag taxonomy |

---

## Page Inventory

### Root pages

| File | Title | Status | Collab note |
|---|---|---|---|
| `index.html` | Home | Published | 0 |
| `about.html` | About | Published | 1 |
| `approach.html` | Approach | Published | 1 |
| `contact.html` | Contact | Published | 0 |
| `now.html` | Now | Published | 1 |
| `signals.html` | Signals | Published | 1 |
| `local-ai-stack.html` | Local AI Stack | Published | 1 |
| `master-synthesis-prompt.html` | Founding Document | Published | 1 — Founding document, historical |

### _ideas/ collection

| File/Folder | Title | Status | Notes |
|---|---|---|---|
| `_ideas/index.html` | Ideas | Published | Index page |
| `_ideas/man-with-two-brains/` | Man With Two Brains | Published | Folder pattern — reference implementation |
| `_ideas/marketing-os-foundation.html` | Marketing OS Foundation | Published | Legacy flat file — do not use as pattern for new entries |
| `_ideas/marketing-os.html` | Marketing OS | Published | |
| `_ideas/ai-web-layer-framework.html` | AI Web Layer Framework | Published | |
| `_ideas/the-bug-the-audit-the-blueprint/` | The Bug, the Audit, the Blueprint | Pending commit | Folder pattern — index.html + retrospective.html; session-2026-06-21-002 |

### _signals/ collection

| File | Status |
|---|---|
| `_signals/anthony-smith.html` | Published |
| `_signals/paul-mckey.html` | Published |
| `_signals/peter-sefton.html` | Published |
| `_signals/terry-hilsberg.html` | Published |

### _skills/ collection

Empty. Declared in `_config.yml` (output: true, permalink: /about/skills/:name/). No default layout set in _config.yml — any new skills entry must declare `layout:` explicitly in frontmatter or it will not render.

### _session-logs/ collection

| File | Status |
|---|---|
| `session-2026-06-10-001.md` | Published |
| `session-2026-06-11-001.md` | Published |
| `session-2026-06-11-002.md` | Published |
| `session-2026-06-21-001.md` | Published |
| `session-2026-06-21-002.md` | Pending commit |

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

---

## Capability Baseline

| Role | Current Tool | Access |
|---|---|---|
| Draft Agent | Cowork (Claude Sonnet, Anthropic) | Read/write: `C:\Users\camer\Documents\AI\AI-Working\`; Read: repo files by name |
| Publish Agent | Claude Code (Claude, Anthropic) | Read/write: `C:\Users\camer\Documents\GitHub\cameronloudon.github.io` |
| Review Agent | External (rotating; most recent: DeepSeek) | Read: documents provided by Cameron |

---

## Collections Declared in _config.yml

| Collection | Output | Permalink | Default layout |
|---|---|---|---|
| ideas | true | /ideas/:name/ | none set — must declare in frontmatter |
| signals | true | /signals/:name/ | none set — must declare in frontmatter |
| skills | true | /about/skills/:name/ | none set — must declare in frontmatter |
| session-logs | true | /session-logs/:name/ | default (set in _config.yml defaults block) |

---

*Read this file before every session. Update it at every session close.*
*If this file and any other file conflict on current state, this file wins.*
