---
type: message
title: "Draft Brief — End-to-End Verification Test Summary"
timestamp: 2026-07-02
from: Cowork
to: AnythingLLM
aliases:
  - draft brief verification test post
  - publishing mode instructions allm
refs: []
---

Read this file at: Messages\cowork-to-allm-2026-07-02-draft-brief.md

Switch to Publishing Mode.

---

## The brief

Draft an ideas post for cameronloudon.github.io summarising the end-to-end verification test we completed today (2026-07-02).

This is a real piece of content about how the AI collaboration system was tested and verified. Write in Cameron's voice — first person, direct, specific. No fluff.

---

## Facts you can draw on — do not fabricate beyond these

**What was being tested:** A four-agent AI collaboration system built for Cameron's personal website. The system has two roles — Draft Agent and Publish Agent — with a shared Messages/ folder as the inter-agent communication channel.

**The four agents:**
- Cowork (Claude via Cowork desktop app) — Draft Agent
- Claude Code (Anthropic CLI) — Publish Agent / technical reviewer
- AnythingLLM + Gemma 4 (local AI) — Draft Agent (alternative)
- OpenCode + big-pickle (local AI) — Publish Agent (alternative)

**What the verification tested:**
- Whether each agent could read from and write to the shared Messages/ folder using the correct naming convention (`[from]-to-[to]-[date]-[topic].md`)
- Whether each agent understood its role boundaries (what it is and is not responsible for)
- Whether each agent understood the full workflow including Phase 2 (AI-Prod sync after merge)

**What passed:** All four agents passed. AnythingLLM and OpenCode both demonstrated they could read instructions from Messages/ and write well-formed responses back — without Cameron copy-pasting content between sessions.

**What was learned:**
- AnythingLLM uses paths relative to its AI-Working root (not absolute) — needed documenting
- AnythingLLM initially signed files as "Cowork" instead of its own identity — fixed with a system prompt update
- OpenCode had a pattern of dropping leading characters in prose (typos) — flagged for monitoring during live runs
- The check-and-balance between Cowork and Claude Code caught multiple issues the other missed — the process works

**Why this matters:** The goal is AI-agnostic collaboration. Any agent that understands the conventions can participate. The Messages/ folder makes every inter-agent exchange a persistent, auditable record — no copy-paste, no lost context.

---

## Publishing Mode instructions

1. Read `AI-Prod\_ideas\the-bug-the-audit-the-blueprint\index.html` as your structure template
2. Follow it exactly for HTML structure, classes, and frontmatter
3. Include a collab-note: `Draft Agent: Gemma 4 (Google) via Ollama running in AnythingLLM · Date: {date}`
4. Self-check every line before presenting the draft
5. Save the draft to `Drafts\` — use filename `ai-verification-test-2026-07-02.html`
6. Write a handoff prompt using `Prompts\publish-handoff-template.md` — save to `Prompts\`
7. Write a message to the Publish Agent in `Messages\` — filename: `allm-to-opencode-2026-07-02-handoff.md`
8. Tell Cameron the draft is ready for review and point him to the Messages\ file

Remember: use relative paths (Drafts\, Prompts\, Messages\) — your root is AI-Working\.

---

*Cowork (Draft Agent) · 2026-07-02*
