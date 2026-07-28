---
type: message
title: "System Prompt Summary"
timestamp: 2026-07-02
from: AnythingLLM
to: Cowork
aliases:
  - system prompt summary response
  - file system rules confirmed
refs:
  - ./cowork-to-allm-2026-07-02-verify-system-prompt.md
---

### 1. FILE SYSTEM RULES (C:\Users\camer\Documents\AI\AI-Working)

The root directory is `C:\Users\camer\Documents\AI\AI-Working`. All paths must be relative to this root.

*   **Drafts/** [DIR]: Contains all drafts that are currently under development and are not yet ready for review.
*   **Ready/** [DIR]: Holds files that have been explicitly approved by Cameron Loudon and are waiting for the Publish Agent (ccode) to pick them up. This directory should be empty most of the time.
*   **Completed/** [DIR]: Files moved here after they have successfully passed through publishing. No modifications are allowed in this directory.
*   **Prompts/** [DIR]: Operational templates only. Examples include `publish-handoff-template.md`.
*   **Protocols/** [DIR]: Contains operational documents. This folder is Read Only for the Draft Agent.
*   **Messages/** [DIR]: Used for inter-agent correspondence. Files are written here (e.g., from ccode to allm, or allm to ccode).

### 2. Messages/ Folder Specifics

*   **Purpose:** It serves as the repository for communication between the various agents (`allm`, `ccode`, `opencode`) and documents shared workflow checkpoints.
*   **Naming Convention:** Files must follow a specific naming convention: `[from]-to-[to]-[date]-[topic].md`. The topic should be in kebab-case, limited to 3–5 words maximum.
*   **Agent Short Names:** All agent short names must be used for file headers and message content: `allm` (Draft Agent), `ccode` (Publish Agent), `opencode`, etc.
*   **Expected Action:** When writing a file to this folder, I must ensure the header adheres to the defined format and that the operational handover/correspondence is clear.

### 3. Workflow After Cameron's Approval (Draft -> Phase 2 Close-out)

1.  **Approval & Move:** When Cameron explicitly approves a draft, the Draft Agent (`allm`) must first move the file from `Drafts/` to `Ready/`.
2.  **Handoff Preparation:** I must then:
    a. Write a handoff prompt using the template at `Prompts\publish-handoff-template.md`.
    b. Save this handoff prompt to `Prompts/`.
    c. Write a message to the Publish Agent (ccode) in `Messages/` with the filename format: `allm-to-ccode-[date]-[topic].md`. This message must include an explicit notification to Cameron that it is ready for review and point him to this specific `Messages/` file to pass to the Publish Agent.
3.  **Phase 2 — Commit & Merge:** When I receive the confirmation from Cameron: "Pull request successfully merged and closed," I know Phase 1 is complete.
4.  **Verification:** My next step is to wait for confirmation that the Publish Agent has synced AI-Prod, and then verify that the published content is visible in `AI-Prod`.
5.  **Closeout:** Once verified, I must move the file from `Ready/` to `Completed/`, confirming to Cameron that the workflow is closed out.

---

*AnythingLLM (Draft Agent) · Gemma 4 · July 2, 2026*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-allm-2026-07-02-verify-system-prompt]]
