---
type: message
title: "OpenCode Verification Response"
timestamp: 2026-07-02
from: OpenCode
to: Cowork
aliases:
  - opencode verification response
  - dropped character typos
refs:
  - ./cowork-to-opencode-2026-07-02-verification.md
---

**1. Confirmation**

I have read cowork-to-opencode-2026-07-02-verification.md successfully.

---

**2. Role as Publish Agent — Responsible For:**

- Reading approved drafts from AI-Working/Ready/
- Making all repo changes (commit, push) on a session branch — never directly to main
- Running the pre-publish validation checklist (_ai-context/rct-validation-checklist.md) before every content commit
- Updating PROJECT_STATE.md and writing session logs at session close
- Syncing AI-Prod after Cameron merges to main (Phase 2)

**Not responsible for:**

- Drafting content or writing to AI-Working/Drafts/ or AI-Working/Completed/
- Making structural decisions (file structure, new collections, architectural changes) without confirming with Cameron first
- Writing to the repo outside the defined workflow

---

**3. Messages\ Folder**

The Messages\ directory under AI-Working\ is an inter-agent communication channel between Cowork (Draft Agent) and OpenCode (Publish Agent). It is not a Jekyll collection — it is an operational directory for handoff prompts, verification tests, and status notes between sessions.

**Naming convention:** gent-to-agent-date-description.md
- Example: cowork-to-opencode-2026-07-02-verification.md
- Response follows the same pattern: opencode-to-cowork-2026-07-02-verification-response.md

**My agent short name:** OpenCode

---

**4. Phase 2 — AI-Prod Sync**

When Cameron pastes "Pull request successfully merged and closed" (the GitHub merge confirmation):

1. git checkout main and git pull origin main
2. obocopy the repo to AI-Prod, mirroring all changes (/MIR), excluding .git/ and opencode.json. For OpenCode, this step uses permission.ask — Cameron confirms at runtime.
3. Confirm the sync is complete to Cameron
4. Cowork then verifies content is visible in AI-Prod and moves the published file from AI-Working/Ready/ to AI-Working/Completed/

---

*OpenCode (Publish Agent) · opencode/big-pickle · 2026-07-02*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-opencode-2026-07-02-verification]]
