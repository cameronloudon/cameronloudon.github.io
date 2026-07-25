---
type: summary
title: "AI Independence Verification — Synthesis Document"
timestamp: 2026-06-26
from: Cowork
to: DeepSeek
aliases:
  - ai independence synthesis
  - cold-start bootstrap gap
  - three missing session-close steps
refs:
  - ./ai-independence-cowork-response.md
  - ./ai-independence-claude-code-response.md
---

**Source documents:**
- "AI Independence Verification — Draft Plan for Review" (DeepSeek, June 2026)
- "Cowork Response — AI Independence Verification Document" (Cowork, 2026-06-26)
- "Claude Code Response — AI Independence Verification Document" (Claude Code, 2026-06-26)

---

## Purpose

This document pulls together the findings from both agent responses to give DeepSeek a single, consolidated input for drafting the verification runbook. Where the two agents agreed, this document states the consensus. Where they added distinct findings, both contributions are noted.

---

## 1. Consensus Findings (Both Agents Agree)

These points were independently reached by both Cowork and Claude Code. They should be treated as confirmed.

### 1.1 Cold-start bootstrap gap

The current handoff prompt assumes a warm-start agent that already knows the project. A cold-start OpenCode session will have no project context unless explicitly told where to begin. Both agents independently identified this as the most important gap to close.

**Fix (agreed):** Add a Step 0 to every cold-start handoff prompt:
> "Before proceeding, read ONBOARDING.md. Then read PROJECT_STATE.md. Then read AI_INSTRUCTIONS.md. Do not begin work until you have confirmed the active branch and session ID from PROJECT_STATE.md."

### 1.2 Three steps missing from the proposed workflow

The proposed workflow (Section 4, Step 3) is missing three mandatory steps from the RCT framework:

| Missing step | Where it's documented | Timing |
|---|---|---|
| RCT validation checklist | `_ai-context/rct-validation-checklist.md` | Before commit — it is a gate, not an audit |
| PROJECT_STATE.md update | `_ai-context/single-ai-workflow.md` §5 | After commit, before session close |
| Session log creation | `_ai-context/rct-session-primer.md` | After PROJECT_STATE.md update |

**Critical on validation timing:** the checklist must run *before* committing. If it fails, the commit does not happen. The runbook must reflect this sequence: validate → (if pass) commit → update PROJECT_STATE.md → write session log.

### 1.3 The handoff prompts are already substantially AI-agnostic

Both agents reviewed the actual session-3b handoff prompt and found that the instructions themselves — prose steps, shell commands, file paths, explicit checklists — contain no Claude-specific tool names or invocations. The Claude-specificity is in thin wrappers: the label "Claude Code Prompt," the CLI startup command (`claude`), and the implicit assumption that CLAUDE.md has auto-loaded.

**Implication:** The effort to make prompts AI-agnostic is smaller than the verification document assumes. The content is already transferable; only the framing needs updating.

### 1.4 AGENTS.md approach

If OpenCode auto-loads a specific filename (as Claude Code auto-loads CLAUDE.md), create an `AGENTS.md` in the repo root — a thin wrapper pointing to `AI_INSTRUCTIONS.md` and the `_ai-context/` files. Neither `CLAUDE.md` nor `AGENTS.md` should duplicate content; both point to the same canonical sources.

If OpenCode does not auto-load any file, `AGENTS.md` is not needed — the bootstrap instruction (1.1 above) is sufficient.

**Action required before test:** Confirm whether OpenCode auto-loads a specific filename. This determines whether `AGENTS.md` is a pre-test setup step or an unnecessary addition.

### 1.5 The documentation is more AI-agnostic than assumed

`AI_INSTRUCTIONS.md` §7 ("Claude was here") explicitly addresses non-Claude agents, tells them what CLAUDE.md contains, and explains why they don't need to rely on it. The `_ai-context/` files contain no Claude-specific assumptions. `ONBOARDING.md` is written for any AI. The documentation foundation is solid; the gap is in operational details (confirmation model, prompt template) rather than in the onboarding documents themselves.

---

## 2. Distinct Findings — Claude Code

These findings came from Claude Code's review of the actual repo files and add precision that Cowork's response did not include.

### 2.1 The confirmation model is a tool permission UI, not Y/N chat prompts

Claude Code's "confirm before each action" is a UI mechanism: Cameron sees a permission request and approves or denies each non-pre-approved tool call individually. This is not a chat-level "About to do X. Proceed? [y/n]" pattern.

OpenCode likely implements confirmation differently — probably as explicit chat prompts. These are functionally equivalent but mechanically distinct.

**Runbook implication:** Do not prescribe Claude Code's specific confirmation mechanism. Specify the intent: *the Publish Agent must confirm with Cameron before each destructive action (file write, git commit, git push).* Let OpenCode's native confirmation mechanism satisfy this requirement.

### 2.2 Nothing is automatic except CLAUDE.md loading

Claude Code is explicit on this point. Validation, PROJECT_STATE.md update, and session log creation are all triggered by explicit steps in the handoff prompt — not by Claude Code's default behaviour. The only thing that happens automatically is CLAUDE.md loading at session start.

**Runbook implication:** The full publish handoff prompt template (item 2.4 below) must include all of these steps explicitly. There is no safety net if they are omitted.

### 2.3 session-3b is a fix prompt, not a publish template

The only documented handoff prompt reference implementation (session-3b) is a minimal fix commit — one file copied, no new content, no validation required. It correctly omits the session-close steps. It should not be used as the template for a full content-publishing workflow.

**Runbook implication:** Using session-3b as the model for the verification test would produce an incomplete test. A "pass" result would not be meaningful.

### 2.4 A full publish handoff prompt template does not exist yet

There is no documented artifact showing what a complete content-publishing handoff looks like — one that includes all steps: content creation, collab-note, validation, commit, PROJECT_STATE.md update, session log, push. This needs to be written before the verification test runs, so the comparison is against an explicit standard.

---

## 3. Distinct Findings — Cowork

These findings came from Cowork's review and add context on the Draft Agent side of the workflow.

### 3.1 The Draft Agent workflow has three stages, not one

The proposed workflow's Step 1 (Drafting) is described as "Draft Agent produces content." The actual workflow has three stages:

```
Draft in AI-Working/ → Promote to AI-Prod/ → Write handoff prompt for Publish Agent
```

The AI-Prod folder is a repo mirror that the Draft Agent maintains. Content is drafted in AI-Working, reviewed, then copied to AI-Prod before the handoff prompt is written. The Publish Agent reads from AI-Prod, not AI-Working, to get the source files. The runbook should reflect this three-stage drafting flow.

### 3.2 cowork-conventions.md is outside the repo

The file that documents the Draft Agent's workflow (`AI-Working/Protocols/cowork-conventions.md`) is not in the repo. It is in AI-Working, which Claude Code can access via the `.claude/settings.json` read permission. OpenCode would need an equivalent access grant.

However — Claude Code noted this may not be necessary for the verification test at all, since `cowork-conventions.md` documents the Draft Agent's process, not the Publish Agent's. OpenCode, acting as Publish Agent, may not need it if the handoff prompt is complete and the bootstrap points to the right repo files.

**Resolution:** Treat this as a non-issue for the verification test unless the test scenario requires OpenCode to understand the Draft Agent's process (it shouldn't).

---

## 4. Recommended Pre-Test Setup Steps

These must be completed before the verification test is run. They are not part of the test itself.

| # | Setup step | Owner | Depends on |
|---|---|---|---|
| 1 | Confirm whether OpenCode auto-loads a specific filename | Cameron (to test) | — |
| 2 | If yes: create `AGENTS.md` in repo root (thin wrapper → AI_INSTRUCTIONS.md + _ai-context/) | Cowork drafts, Claude Code commits | Step 1 |
| 3 | Configure OpenCode's equivalent of `.claude/settings.json` (AI-Working read access) | Cameron | — |
| 4 | Write the full publish handoff prompt template | Cowork drafts, Claude Code reviews | — |
| 5 | Confirm test scenario: new idea added to `_ideas/` using the folder pattern | Cameron confirms | — |

---

## 5. Recommended Test Scenario

Both agents independently recommended the same test scenario:

**Add a new idea to `_ideas/` using the folder pattern.**

This scenario exercises the complete workflow:
- New content creation (index.html + at least one sub-page)
- Collab-note (required for any AI-assisted content)
- RCT validation checklist (new published content — checklist is mandatory)
- PROJECT_STATE.md update (page inventory, session ID)
- Session log creation (published content — session log is mandatory)
- Branch, commit, push

A fix commit (like session-3b) does not exercise validation, PROJECT_STATE.md update, or session log. A "pass" on a fix commit would not validate AI independence for content publishing.

---

## 6. Revised Workflow for the Runbook

The proposed workflow in Section 4 of the verification document should be updated as follows:

**Step 1 — Drafting (Open WebUI / Draft Agent)**

1a. Draft content in AI-Working (new idea: index.html + sub-page)
1b. Write the collab-note following RCT conventions
1c. Promote finished files to AI-Prod (the repo mirror)
1d. Write the handoff prompt using the full publish template (see pre-test setup step 4)

**Step 2 — Handoff**
*(No change from the proposed workflow — Cameron copies prompt into OpenCode)*

**Step 3 — Publishing (OpenCode / Publish Agent)**

3a. **Step 0 (new):** Read ONBOARDING.md → PROJECT_STATE.md → AI_INSTRUCTIONS.md. Confirm active branch and session ID before proceeding.
3b. Confirm with Cameron before each destructive action (file write, git commit, git push) — mechanism is OpenCode's native confirmation, not a prescribed Y/N pattern
3c. Create branch (name specified in handoff prompt)
3d. Copy files from AI-Prod to repo (paths specified in handoff prompt)
3e. **Run RCT validation checklist** (`_ai-context/rct-validation-checklist.md`) — **gate: do not commit if any item fails**
3f. Commit with message specified in handoff prompt
3g. Update PROJECT_STATE.md (increment session log ID, update page inventory, record branch and commit)
3h. Write session log to `_session-logs/` using format in `_ai-context/rct-session-primer.md`
3i. Commit PROJECT_STATE.md and session log
3j. Push branch to GitHub
3k. Report: files copied, validation result, commit hashes, branch name. Cameron merges.

**Steps 4 and 5** — No change from the proposed workflow.

---

## 7. Questions Remaining for Cameron

| Question | Why it matters |
|---|---|
| Does OpenCode auto-load a specific filename (e.g., AGENTS.md)? | Determines whether AGENTS.md needs to be created as a pre-test step |
| Does OpenCode have a confirm-before-action mode, and how is it configured? | Required for the test to satisfy the "Cameron confirms each action" requirement |
| Can OpenCode read from `C:\Users\camer\Documents\AI\AI-Working\`? | Required for reading AI-Prod source files in the handoff |
| What local model (Ollama) will be used for the test? | Model capability affects whether the workflow can be followed reliably |

---

## 8. Summary Verdict from Both Agents

**The documentation foundation is sound.** `AI_INSTRUCTIONS.md`, `ONBOARDING.md`, and the `_ai-context/` files are genuinely AI-agnostic and sufficient to orient a cold-start agent — provided the bootstrap instruction is added to the handoff prompt.

**The workflow gaps are fixable before the test.** The three missing steps (validation, PROJECT_STATE.md, session log) and the missing full publish template are addressable with one writing session.

**The fundamental question remains open.** Neither agent can answer from documentation review whether a local Ollama model has the reasoning capability to follow a multi-step validated publish workflow reliably. That is what the verification test will surface — and why the test scenario must be complete enough that a "pass" result is meaningful.

---

*This synthesis document is a working artifact. It is not for publication. It should be provided to DeepSeek alongside the two individual agent response documents as input for the runbook.*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ai-independence-cowork-response]]
- [[ai-independence-claude-code-response]]
