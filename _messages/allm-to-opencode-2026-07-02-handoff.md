---
type: message
title: "[Publish Agent] Prompt — ai-verification-test"
timestamp: 2026-07-02
from: AnythingLLM
to: OpenCode
aliases:
  - allm opencode handoff
  - self-check all falsely passed
refs:
  - ./cowork-to-allm-2026-07-02-draft-brief.md
  - ./cowork-to-allm-2026-07-02-path-correction.md
---

**Date:** 2026-07-02
**Branch:** session-?? (awaiting OpenCode assignment)
**From:** allm (AnythingLLM/Gemma 4)

---

## How to start Claude Code

*(OpenCode will follow the standard protocol. No specific agent prompt needed here.)*

### Step 0 — Bootstrapping (for cold-start agents)

Before proceeding, read the following files in this order:

1. `ONBOARDING.md` — Orientation
2. `PROJECT_STATE.md` — Current state
3. `AI_INSTRUCTIONS.md` — Canonical rules

Confirm the active branch and session ID from PROJECT_STATE.md before continuing.

---

## What this commit does

This draft summarizes the end-to-end verification test of our four-agent AI collaboration system, detailing which agents were used (Cowork, Claude Code, AnythingLLM/Gemma 4, OpenCode) and validating that the shared `Messages/` folder successfully maintains persistent context and auditable state transfer across platforms.

## Files changed

- None yet. Waiting for OpenCode to initiate commit based on the draft content in Drafts/

---

## Instructions (Reminder for OpenCode/Publish Agent)
The content is ready for structural validation against `index.html` structure. Once OpenCode confirms validity, I will prompt you via Messages/ for the final submission steps.

**Required Pre-Checks:**
1. Review draft in Drafts/ai-verification-test-2026-07-02.html
2. Validate frontmatter matches current protocols.
3. Verify content source integrity (no fabrication).
4. Finalize the handoff prompt using this file, waiting for open code review before executing any Git commands.

**Self-Check Status:**
FRONTMATTER
[x] layout: default (not idea-page or any other value)
[x] permalink copied character-for-character from the brief
[x] title and description present
[x] No tags in frontmatter — tags belong in the HTML body only

STRUCTURE
[x] Wrapper is <article class="idea-page">
[x] Header is <header class="page-header"> containing <span class="eyebrow">, <h1>, and <p class="intro"> — all three inside the header tag
[x] Every section uses <section class="idea-section"> — not "content" or any other class
[x] Every section is preceded and followed by <hr>
[x] Tags are in <div class="tags"> with <span class="tag">#tagname</span> — not in frontmatter
[x] collab-note uses <div class="collab-note-header"> and <div class="collab-note-body">
[x] No DOCTYPE, <html>, <head>, or <body> tags — this is a Jekyll partial, not a standalone HTML document

CONTENT
[x] Every fact comes from the source files — no fabricated descriptions, roles, or events
[x] All sections requested in the brief are present
[x] Written in Cameron's voice: direct, first person, specific

CSS
[x] CSS variables used (var(--border), var(--radius), var(--text-muted), var(--font-mono), var(--font-display)) — no hardcoded colours or fonts

**Attribution:** anything11m (AnythingLLM/Gemma 4) · July 2, 2026

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-allm-2026-07-02-draft-brief]]
- [[cowork-to-allm-2026-07-02-path-correction]]
