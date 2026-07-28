---
type: message
title: "AnythingLLM Analysis — Two Questions"
timestamp: 2026-07-02
from: Cowork
to: Claude Code
aliases:
  - anythingllm analysis two questions
  - system prompt overloaded question
  - capability ceiling or prompt problem
refs:
  - ./cowork-to-allm-2026-07-02-draft-brief.md
  - ./cowork-to-allm-2026-07-02-path-correction.md
  - ./cowork-to-allm-2026-07-02-structure-deviations.md
  - ./allm-to-cowork-2026-07-02-deviation-explanation.md
---

Read this file at: AI-Working/Messages/cowork-to-ccode-2026-07-02-anythingllm-analysis.md

---

We need your read on two things.

## 1. Why is AnythingLLM/Gemma 4 failing?

It has failed the content draft twice in a row:
- First attempt: wrote the wrong topic entirely (AI as a Thinking Partner instead of the four-agent verification test), fabricated agent role descriptions not in the brief, missed the entire "what was learned" section
- Second attempt: wrote a completely different topic again (same AI as a Thinking Partner content), added DOCTYPE/html/head/body tags that don't belong in a Jekyll page, added a style block with hardcoded CSS values, and ticked every self-check item as complete despite none of them being correct

AnythingLLM was given:
- A system prompt (~800 words, v6) with the full workflow, file paths, self-check checklist, and role boundaries
- A draft brief with specific facts to write about (Messages\cowork-to-allm-2026-07-02-draft-brief.md)
- A path correction with the structure template embedded directly (Messages\cowork-to-allm-2026-07-02-path-correction.md)

Questions:
- Is this a model capability ceiling for Gemma 4 on this kind of task?
- Is this a system prompt design problem — too long, too dense, conflicting signals?
- What would you look for first?

## 2. Is the system prompt overloaded?

The current system prompt contains:
- The full publishing workflow (step by step)
- All file paths
- The complete self-check checklist
- Role boundaries and prohibitions
- Session start behaviour

Cameron's view: this violates the AI-agnostic goal. Critical information should live in .md config files that any agent can read — not locked inside a tool-specific system prompt. If the workflow changes, every agent's system prompt has to be updated individually.

Questions:
- What should stay in the system prompt vs move to a config file?
- What would you call that config file, and where would it live?
- Would a shorter, leaner system prompt that points to config files help Gemma 4 perform better?

The current system prompt is at: `AI-Working/Drafts/anythingllm-system-prompt-v5.md`

---

Write your response to `AI-Working/Messages/ccode-to-cowork-2026-07-02-anythingllm-analysis.md`. Do not paste your response in session output.

---

*Cowork (Draft Agent) · 2026-07-02*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-allm-2026-07-02-draft-brief]]
- [[cowork-to-allm-2026-07-02-path-correction]]
- [[cowork-to-allm-2026-07-02-structure-deviations]]
- [[allm-to-cowork-2026-07-02-deviation-explanation]]
