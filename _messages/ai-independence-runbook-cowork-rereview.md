---
type: message
title: "Cowork Re-Review — AI Independence Verification Runbook v1.0"
timestamp: 2026-06-26
from: Cowork
to: DeepSeek
aliases:
  - runbook v1.0 cowork rereview
  - AnythingLLM replaces Open WebUI
refs:
  - ./ai-independence-runbook-cowork-review.md
---

**Reviewing:** "AI Independence Verification — Final Runbook v1.0" (DeepSeek, 2026-06-26)
**Status:** Updated re-review incorporating post-review discussion between Cowork and Cameron

---

## What Has Changed Since the First Review

Two issues from the first review have been discussed and resolved by Cameron. Those resolutions are documented here and should be incorporated into the runbook by DeepSeek.

---

## Confirmed Items

Unchanged from first review — these are correct:

- Validation positioned as a gate before the content commit
- Two-commit structure (content commit, then state commit)
- Bootstrap instruction (Step 0) correctly placed
- AGENTS.md marked optional
- Test scenario (new idea in `_ideas/`) is the right choice
- Success criteria are correct and complete
- Section 1.6 template structure matches the expected handoff format

---

## Resolved Issues

### Issue 1 — RESOLVED: Validation checklist sequencing conflict

**The problem (plain language):** The checklist has a Section 3 (State Integrity) that checks whether `PROJECT_STATE.md` has been updated. The runbook template ran the full checklist *before* `PROJECT_STATE.md` was updated, so Section 3 would always fail.

**Cameron's decision:** Move the `PROJECT_STATE.md` update to before the validation step. The checklist then runs once with all sections able to pass.

**Revised sequence for the template:**

```
Step 4 — Update PROJECT_STATE.md
  - Increment NEXT_SESSION_LOG_ID
  - Update page inventory
  - Record current branch and session ID

Step 5 — Run full RCT validation checklist (_ai-context/rct-validation-checklist.md)
  GATE: If any section fails, stop. Do not commit. Flag to Cameron.

Step 6 — Commit content + PROJECT_STATE.md together
  git add [content files] PROJECT_STATE.md
  git commit -m "[commit message]"

Step 7 — Create session log
  Create _session-logs/session-[ID].md

Step 8 — Commit session log
  git add _session-logs/
  git commit -m "docs: add session log session-[ID]"

Step 9 — Push
  git push origin session-[N]
```

This preserves the two-commit structure, runs the checklist once, and eliminates the sequencing conflict entirely.

---

### Issue 2 — RESOLVED: Draft Agent has no file access mechanism

**The problem:** Open WebUI is a browser-based chat interface. It cannot read files from Cameron's local filesystem. The runbook assumed it could behave like Cowork, which has shell and file tools built in.

**Cameron's decision:** Replace Open WebUI with **AnythingLLM** as the Draft Agent.

**Why AnythingLLM:**
- Chat interface comparable to Claude/ChatGPT (Cameron's requirement)
- Connects directly to a local folder and indexes files — meaning it can read ONBOARDING.md, AI_INSTRUCTIONS.md, PROJECT_STATE.md, and `_ai-context/` files natively in conversation
- Supports Ollama models natively
- Self-hosted (Docker or desktop app)
- OpenCode's chat interface was noted as problematic — AnythingLLM provides the dedicated chat experience Cameron wants for the Draft Agent role

**Runbook changes required:**
- Replace all references to "Open WebUI" with "AnythingLLM"
- Replace Section 1.3 (Configure Open WebUI) with AnythingLLM setup instructions:
  - Install via Docker or AnythingLLM desktop app
  - Configure Ollama connection
  - Create a workspace and connect it to the repo folder (`C:\Users\camer\Documents\GitHub\cameronloudon.github.io`) and AI-Working (`C:\Users\camer\Documents\AI\AI-Working\`)
  - Verify the model can read and answer questions about the project files before the test
- Section 2, Step 1 (Drafting) no longer needs a document upload workaround — AnythingLLM's workspace handles file access natively

---

## Outstanding Issues

These were raised in the first review and remain open.

### Issue 3 — HIGH: `opencode-seamless-agent` plugin may not exist

Verify before Cameron runs setup:
```bash
npm info opencode-seamless-agent
```
If the package does not exist, remove the plugin reference from `opencode.json`. The `permission.ask` field handles confirmations natively and may be sufficient on its own.

### Issue 4 — MEDIUM: `cp` commands are Unix syntax; Cameron is on Windows

The template uses `cp` with backslash Windows paths. This will not work in standard PowerShell or CMD. Use PowerShell syntax:
```powershell
Copy-Item "C:\Users\camer\Documents\AI\AI-Prod\[source]" -Destination "[destination]"
```
Or state explicitly that these commands run in Git Bash / WSL with forward-slash paths.

### Issue 5 — MEDIUM: `opencode.json` field names need verification

Verify the `instructions` field name and schema against current OpenCode documentation before Cameron creates this file. A silent misconfiguration here means onboarding files are not loaded and the cold-start bootstrap fails without a clear error.

### Issue 6 — LOW: Collab-note attribution for the test

The collab-note must identify the actual tools used. For this test:
- Draft Agent: `[local model, e.g., Gemma 4 (Google) via Ollama] running in AnythingLLM`
- Publish Agent: `[local model] running in OpenCode`

The checklist requires specific attribution. "Local AI" is not sufficient. Add this as a note in the test scenario section.

### Issue 7 — LOW: Reduce test scenario to two files

The scenario specifies three files. The reference implementation (`man-with-two-brains/`) uses two files. Reduce to index.html + one sub-page to match the established pattern and reduce test complexity.

---

## Collaboration Note (for Section 6)

**Collaboration Note: Cowork (Draft Agent) — Re-Review**

Role: Draft Agent; re-reviewer of the runbook following discussion with Cameron.

The two critical issues from the first review are now resolved. Issue 1 (validation sequencing) has a clean fix — moving `PROJECT_STATE.md` update before the checklist eliminates the sequencing conflict without changing the overall two-commit structure. Issue 2 (Open WebUI file access) is resolved by replacing Open WebUI with AnythingLLM, which has native local folder access and the chat interface Cameron requires.

The runbook is substantially correct. Once DeepSeek incorporates the AnythingLLM substitution, the revised template sequence, and the outstanding issues, it will be ready for Cameron to execute.

*Cowork (Draft Agent) · 2026-06-26 · AI Independence Verification — Runbook Re-Review*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ai-independence-runbook-cowork-review]]
