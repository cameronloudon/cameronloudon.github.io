---
type: message
title: "Task Brief — Complete System Documentation, Draft Agent Side"
timestamp: 2026-07-03
from: Cameron
to: Cowork
aliases:
  - system documentation task draft side
  - what you cannot see repo git github
refs: []
---

## Why this exists

We're planning a completely different approach for the Drafting Agent (details next session). Before redesigning that, Cameron wants one complete, accurate map of how the whole system currently fits together — every process, every file, every convention — assembled from both sides, since neither you nor Claude Code can see the other's full working environment.

You have full read/write access to `AI-Working/` (Drafts, Ready, Completed, Messages, Protocols, Prompts) plus a read-only mirror of the published site in AI-Prod. Claude Code has the mirror-image gap: full repo/GitHub access but no visibility into `AI-Working/Drafts/`, `Completed/`, `Protocols/`, or `Prompts/` — only `Messages/` (read-write) and `Ready/` (read-only). This task is to produce your half — the Draft-Agent-side map — honestly, including naming what you can't see rather than guessing at it.

---

## What to produce

A complete system-documentation write-up covering everything visible from your side. Don't just list files — explain how the pieces connect and why they exist. At minimum:

1. **AI-Working/ folder structure** — `Drafts/`, `Ready/`, `Completed/`, `Messages/`, `Protocols/`, `Prompts/` — what each is for, what moves between them and when, who's allowed to write where.
2. **Your operating instructions** — `draft-agent-config.md`, `publish-handoff-template.md`, `cowork-conventions.md`, and any memory-backup files in `Protocols/` — what each contains and how you actually use them when drafting.
3. **The drafting process end-to-end** — from receiving a brief, through the content_type/field-schema self-check, to moving a file from `Drafts/` to `Ready/` and writing the handoff message.
4. **The content/HTML boundary** — what you produce (structured Markdown, no HTML/frontmatter) and why, as you understand the reasoning (this was decided 2026-07-03 after a model-capability failure in an earlier test — worth including that history if you have it).
5. **The `Messages/` folder convention** — naming pattern, what a handoff message must contain, how you know when a reply is waiting for you.
6. **What you can see of the live site** — the AI-Prod mirror: what it's for, how fresh it is, how you use it to know what's actually published versus what's still in flight.
7. **What you cannot see** — an explicit section naming what you have no access to: the actual git repository (branches, commit history, pull requests), GitHub itself, and anything not mirrored into AI-Prod (e.g. `.git/`, `opencode.json`). Note anywhere you've had to infer repo-side behaviour secondhand (from Claude Code's messages) rather than seeing it directly.

---

## Where to save it

Write your output to `AI-Working/Messages/cowork-to-ccode-2026-07-03-system-documentation-draft-side.md`. Cameron will bring both halves (yours and Claude Code's) together next session to assemble the complete picture.
