---
type: message
title: "Task Brief — Complete System Documentation, Repo Side"
timestamp: 2026-07-03
from: Cameron
to: Claude Code
aliases:
  - system documentation task repo side
  - what you cannot see section
refs: []
---

## Why this exists

We're planning a completely different approach for the Drafting Agent (details next session). Before redesigning that, Cameron wants one complete, accurate map of how the whole system currently fits together — every process, every file, every convention — assembled from both sides, since neither Claude Code nor Cowork can see the other's full working environment.

You have full read/write access to the repo but no access to `AI-Working/Drafts/`, `AI-Working/Completed/`, `AI-Working/Protocols/`, or `AI-Working/Prompts/` (see `.claude/settings.json` — you're scoped to `Messages/` read-write and `Ready/` read-only). Cowork has the mirror-image gap: full `AI-Working/` access but no repo/GitHub access, and only a read-only AI-Prod mirror of the published site. This task is to produce your half — the repo-side map — honestly, including naming what you can't see rather than guessing at it.

---

## What to produce

A complete system-documentation write-up covering everything visible from the repo. Don't just list files — explain how the pieces connect and why they exist. At minimum:

1. **Repo structure** — every top-level file/folder and its purpose (Jekyll config, layouts, assets, collections, instruction files, session logs).
2. **Jekyll mechanics** — collections (`_ideas`, `_signals`, `_skills`, `_session-logs`), frontmatter rules, the static-vs-collection distinction (note: `_ideas/index.html` and `signals.html` are hand-written static lists, NOT generated from the collections — this bit anyone building tooling for this site needs to know explicitly, it's caused a real production bug already).
3. **The RCT framework** — collab-notes, session logs, the validation checklist, tag taxonomy, and how attribution threads through every published page.
4. **The multi-agent workflow** — role definitions (Draft/Publish/Review), the content/HTML boundary decision (2026-07-03) and why it exists, the `Messages/` folder handoff mechanism as you understand it from the repo/permissions side, branch workflow, PR/merge/Phase 2 AI-Prod sync mechanics.
5. **The instruction-file hierarchy** — `ONBOARDING.md` → `AI_INSTRUCTIONS.md` → `CLAUDE.md` → `PROJECT_STATE.md` → `_ai-context/*` — what each one is for and which one wins when they conflict.
6. **Known failure modes** — the two bugs found and fixed today (2026-07-03): the recurring `PROJECT_STATE.md` branch-staleness bug (fixed in `AI_INSTRUCTIONS.md` §2 / `CLAUDE.md`), and the missing `_ideas/index.html` entry bug (fixed in `ai-content-creation-spec.md` §6 / `rct-validation-checklist.md`). These are real, documented examples of gaps between "what the system assumes" and "what's actually written down" — worth including as case studies, not just listing the fix.
7. **What you cannot see** — an explicit section naming every AI-Working subfolder you have no access to, and what you'd guess (clearly marked as a guess, not fact) their role might be based on references to them elsewhere (e.g. `draft-agent-config.md` and `publish-handoff-template.md` are referenced in `AI_INSTRUCTIONS.md` and `PROJECT_STATE.md` as owned by Cowork, but you've never read them).

---

## Where to save it

Write your output to `AI-Working/Messages/ccode-to-cowork-2026-07-03-system-documentation-repo-side.md`. Cameron will bring both halves (yours and Cowork's) together next session to assemble the complete picture.
