---
type: summary
title: "AI Independence Verification — Session Report"
timestamp: 2026-06-27
from: Cowork
to:
  - Claude Code
  - DeepSeek
aliases:
  - ai independence session report
  - anti-hallucination guard mandatory
  - six-step file verification passed
refs:
  - ./ai-independence-synthesis.md
---

**Session:** 2026-06-27 (continuation of AI Independence Verification)

---

## 1. Executive Summary

This report covers the practical execution phase of the AI Independence Verification test. The pre-test repo actions were completed by Claude Code and merged to main. AnythingLLM and OpenCode were configured and tested. The local Ollama model (gemma4:e4b) was verified to be capable of reading project files accurately — with specific conditions. Draft content for the first verified ideas page was produced by AnythingLLM/Gemma 4. The verification test is partially complete.

---

## 2. Pre-Test Repo Actions — Completed

Claude Code committed the following to branch session-3b, which was reviewed and merged to main:

| Action | Status |
|--------|--------|
| Created `.gitignore` (Jekyll exclusions + opencode.json) | ✅ Done — commit 9f5d6f2 |
| Fixed PROJECT_STATE.md (removed incorrect note about ai-content-creation-spec.md) | ✅ Done |
| Added OpenCode setup section to ONBOARDING.md | ✅ Done |

---

## 3. OpenCode Verification — Passed

OpenCode was configured and verified operational. Key findings:

**Working configuration (opencode.json):**
```json
{
  "instructions": [
    "ONBOARDING.md",
    "AI_INSTRUCTIONS.md",
    "PROJECT_STATE.md"
  ],
  "model": "gemma4:e4b",
  "permission": {
    "bash": "ask",
    "edit": "ask"
  }
}
```

**Confirmation mechanism:** The `opencode-seamless-agent` plugin exists on npm but failed to load consistently. The working solution is an explicit in-prompt instruction: *"Before running any command that modifies files, you must ask for my confirmation."* Verified: OpenCode correctly paused before creating test2.txt and waited for approval before executing.

**Key lesson:** With local models, explicit in-prompt instructions are more reliable than structured permission systems designed for cloud APIs.

**Additional discovery:** OpenCode has a browser-based web interface (`opencode web`) that runs a local server and opens in the browser. This is an alternative to the TUI for Cameron's preferred chat-style interaction.

---

## 4. AnythingLLM Configuration — Updated

**Problem discovered:** The original runbook assumed AnythingLLM connected directly to local folders via sync. The reality: standard chat mode uses RAG (chunked document upload). However, Agent Skills mode with File System Access enabled gives direct file reading — this is the correct configuration.

**Current configuration:**
- Model: gemma4:e4b via Ollama (http://localhost:11434)
- Embedding: nomic-embed-text via Ollama
- Temperature: 0.3 (reduced from 0.7 to reduce hallucination)
- File System Access: enabled with permissions for:
  - `C:\Users\camer\Documents\GitHub\cameronloudon.github.io`
  - `C:\Users\camer\Documents\AI\AI-Working`
  - `C:\Users\camer\Documents\AI\AI-Prod`
- System prompt: configured with Draft Agent role, key file paths, anti-hallucination rules, drafting process, and session start confirmation

**Runbook correction required:** Section 1.3 describes AnythingLLM as requiring file uploads. This is incorrect for agent mode. DeepSeek should update the runbook to reflect that File System Access via Agent Skills is the correct mechanism.

---

## 5. Model Capability Findings

### gemma4:e4b

| Capability | Result | Conditions |
|-----------|--------|------------|
| File system tool use (@agent mode) | ✅ Pass | Requires `@agent` prefix |
| Reading files accurately | ✅ Pass | Requires "Do not make up an answer. Cite your response." in prompt |
| Applying file format conventions when generating content | ⚠️ Partial | Required 6+ prompt iterations and example file reference |
| Following multi-step gated workflow | Not yet tested | — |

**Key discovery:** The anti-hallucination guard is mandatory. Without the explicit instruction *"Do not make up an answer. Cite your response."*, the model generates plausible but fabricated content from training data. With it, file reads are accurate and cited.

### qwen2.5-coder:14b

Tested briefly as an alternative. Called the filesystem tool correctly but hallucinated file content. Not pursued further — gemma4:e4b performed better with correct prompting.

---

## 6. Six-Step File Verification — Passed

The following verification prompts were run against AnythingLLM/gemma4:e4b in @agent mode with anti-hallucination guards. All six passed:

| Round | File | Question | Result |
|-------|------|----------|--------|
| 1 | ONBOARDING.md | Reading order | ✅ Pass — quoted correctly |
| 2 | PROJECT_STATE.md | Active branch + next session ID | ✅ Pass — `main`, `2026-06-21-003` |
| 3 | AI_INSTRUCTIONS.md | Most important rule | ✅ Pass — "Attribution is non-negotiable" |
| 4 | rct-validation-checklist.md | Four section names | ✅ Pass — exact names quoted |
| 5 | ai-content-creation-spec.md | Available tags for ideas | ✅ Pass — correct taxonomy quoted |
| 6 | publish-handoff-template.md | Step 4b purpose | ✅ Pass — quoted correctly |

---

## 7. Draft Content Produced

AnythingLLM/Gemma 4 produced a draft ideas page through an iterative prompting process. The final draft is ready for review.

**File:** `_ideas/how-i-verified-a-local-ai-could-read-my-project-files/index.html`
**Topic:** The six verification prompts and the anti-hallucination guard discovery
**Status:** Draft complete — pending session ID insertion and save to AI-Working

**What the iterative process revealed:**
- Prompting iteration 1: correct content, wrong format (markdown not HTML, no frontmatter)
- Prompting iteration 2: HTML but wrong template (copied marketing-os-foundation.html patterns)
- Prompting iteration 3: correct template, correct structure, wrong tags (fabricated taxonomy)
- Prompting iteration 4: correct structure, correct tags, missing collab-note attribution
- Prompting iteration 5: correct structure, correct tags, correct collab-note — **PASS**

**Key lesson:** The model requires an example file to copy structure from. Pointing it at the wrong example (marketing-os-foundation.html) caused it to copy custom CSS classes that don't apply to standard ideas pages. The correct template is `the-bug-the-audit-the-blueprint/index.html`.

**One outstanding item:** The collab-note contains `[Session ID]` as a placeholder. The correct value is `2026-06-21-003` (from NEXT_SESSION_LOG_ID in PROJECT_STATE.md).

---

## 8. AnythingLLM System Prompt — Configured

The CameronLoudonAI workspace now has a system prompt that permanently establishes the Draft Agent role. Key elements:

- Role confirmation at session start
- Key file paths listed
- Anti-hallucination rule as a standing instruction
- Attribution requirement (collab-note mandatory)
- Voice guidelines (Cameron Loudon: direct, first person, specific)
- Drafting process with self-check steps
- Template file reference for HTML pages

This means new threads no longer require a setup primer prompt — the Draft Agent role is loaded automatically.

---

## 9. What Has Not Been Tested Yet

The full end-to-end publishing workflow has not been executed. The following remain outstanding:

| Step | Status |
|------|--------|
| Save draft HTML to AI-Working | Pending |
| Write handoff prompt for OpenCode | Pending |
| OpenCode executes publish workflow | Pending |
| Cameron reviews and merges PR | Pending |
| DeepSeek delivers external verdict | Pending |

---

## 10. Next Steps

### For Cameron
1. Insert session ID `2026-06-21-003` into the collab-note in the draft
2. Save draft to `AI-Working/Drafts/how-i-verified-a-local-ai-could-read-my-project-files.html`
3. Save agent memory items to AnythingLLM (anti-hallucination finding, template file location, temperature setting)

### For Claude Code
1. Review the draft HTML when provided
2. Execute the publish workflow using the handoff prompt (to be produced by Cowork)
3. Note: GitHub token expires 2026-06-28 — renew before next session

### For DeepSeek
1. Update Runbook v1.2 Section 1.3 to correct the AnythingLLM file access description (Agent Skills / File System Access, not document upload)
2. Note the anti-hallucination guard as a mandatory prompt engineering requirement for all agent interactions
3. Note the iterative prompting finding — the local model required multiple prompt iterations to produce correctly formatted content; this is a capability constraint to document
4. Prepare to deliver external verdict once the publish workflow is executed

---

## 11. Overall Assessment

The toolchain infrastructure is operational. AnythingLLM with File System Access + gemma4:e4b can read project files accurately under the right conditions. OpenCode can execute git workflows with explicit confirmation. The Draft Agent produced correctly structured content after iterative prompting.

The central finding of the verification test is emerging: **the local toolchain works, but requires more careful prompt engineering than a cloud AI.** The anti-hallucination guard and example-file-based structure prompting are not optional — they are mandatory operational requirements for this model and configuration.

The full verdict depends on whether OpenCode can execute the multi-step publish workflow reliably. That is the next test to run.

---

*Prepared by Cowork (Draft Agent) · 2026-06-27 · AI Independence Verification Session Report*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ai-independence-synthesis]]
