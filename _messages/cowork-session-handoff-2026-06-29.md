---
type: message
title: "Cowork Session Handoff"
timestamp: 2026-06-29
from: Cowork
to: Cowork
aliases:
  - cowork session handoff
  - agreed two-agent system
  - drafts ready completed permissions table
refs:
  - ./cowork-verification-findings-2026-06-29.md
---

**Status:** Claude Code has been given the implement prompt — file changes may or may not be done yet. Verify first.

---

## What happened this session

We ran a full audit of the two-agent workflow (Draft Agent + Publish Agent) and found significant gaps between what the instruction files said and how the system was actually intended to work. Cameron, Cowork, and Claude Code worked through all gaps together and reached full consensus on a corrected process.

This was not a small tweak. The old files described a process that was wrong in several places. The new process is agreed and documented. The instruction files are being updated by Claude Code to match.

---

## The agreed two-agent system

### Actors
- **Cowork** — Draft Agent. Thinks, drafts, organises. Never touches the repo.
- **Claude Code** — Publish Agent. Executes the technical publish workflow. Never authors content.
- **Cameron** — Human bridge. Approves all gates. Triggers both phases.

### Data stores
- **AI-Working** — Cowork's workspace. Three subfolders:
  - `Drafts/` — work in progress
  - `Ready/` — approved, waiting for Publish Agent. Should be empty most of the time.
  - `Completed/` — published, verified in AI-Prod, closed out
- **AI-Prod** — Mirror of the live repo. Cowork reads this to see what's published. Never a staging area. Never written to by Cowork. Updated by Claude Code after Cameron merges.
- **Local repo** — Claude Code's domain. Cowork has no access.
- **GitHub** — Claude Code pushes. Cameron merges.

### Permissions
| Actor | AI-Working/Drafts | AI-Working/Ready | AI-Working/Completed | AI-Prod | Local Repo | GitHub |
|-------|------------------|-----------------|---------------------|---------|-----------|--------|
| Cowork | Read/Write | Read/Write | Read/Write | Read only | No access | No access |
| Claude Code | No access | Read only | No access | Write | Read/Write | Push |
| Cameron | All | All | All | All | All | All |

### Publish workflow — two phases

**Phase 1:**
1. Cowork writes draft → `AI-Working/Drafts/`
2. Cameron reviews and approves
3. Cowork moves file to `AI-Working/Ready/` and writes handoff prompt
4. Cameron passes handoff prompt to Claude Code
5. Claude Code checks exactly one file in Ready/ — stops if empty or multiple
6. Claude Code reads from `AI-Working/Ready/`, branches, copies to repo, validates, commits, pushes
7. Cameron reviews PR on GitHub and merges
8. Cameron confirms merge to Claude Code

**Phase 2** (new Claude Code session, Cameron triggers):
1. `git checkout main && git pull origin main`
2. `robocopy [repo] → AI-Prod /MIR /XD ".git" /XF "opencode.json"`
3. Claude Code confirms sync complete
4. Cowork verifies content visible in AI-Prod
5. Cowork moves file from `Ready/` → `Completed/`

### Key decisions made
- PROJECT_STATE.md is owned by the Publish Agent only. Cowork does not update it.
- AI-Prod is read-only for Cowork. No exceptions.
- OpenCode (when used as Publish Agent) uses `permission.ask` for robocopy — Cameron confirms at runtime.
- `.claude/settings.json` covers Claude Code permissions. `opencode.json` covers OpenCode. Separate files, separate models.

---

## What Claude Code has been asked to do

The implement prompt is at: `AI-Working/Prompts/claude-code-implement-prompt.md`

Five file changes:
1. `.claude/settings.json` — add specific robocopy Bash permission
2. `CLAUDE.md` — add two-agent pointer + Phase 2 session-close protocol
3. `AI_INSTRUCTIONS.md` — correct permissions, correct PROJECT_STATE.md ownership
4. `ONBOARDING.md` — fix AI-Prod definition, document AI-Working subfolders
5. `AI-Working/Prompts/publish-handoff-template.md` — change source to Ready/, add pre-commit check, add Phase 2 section

Claude Code was told NOT to commit yet — Cameron reviews changes first.

---

## What this session needs to do

### Step 1 — Verify Claude Code's changes
Read each of the five files and confirm the changes were made correctly and match the agreed process. Use the permissions table and workflow above as the reference. Flag anything that doesn't match.

Files to check:
- `AI-Prod/.claude/settings.json` (or repo root `.claude/settings.json`)
- `AI-Prod/CLAUDE.md`
- `AI-Prod/AI_INSTRUCTIONS.md`
- `AI-Prod/ONBOARDING.md`
- `AI-Working/Prompts/publish-handoff-template.md`

Also confirm:
- `AI-Working/Drafts/`, `AI-Working/Ready/`, `AI-Working/Completed/` all exist
- `AI-Working/Ready/` is empty
- `Session-Drafts/` folder is gone

### Step 2 — Run a test
Once files are verified, run a simple workflow test:
- Write a short test draft, place it in `AI-Working/Ready/`
- Write a minimal handoff prompt
- Give to Claude Code and confirm it reads from Ready/, not AI-Prod
- After Claude Code pushes, confirm Phase 2 sync works
- Confirm Cowork can see updated content in AI-Prod
- Move test file to Completed/

This does not need to be a real page — a test file is fine. The goal is to confirm the workflow runs end to end.

### Step 3 — Update AnythingLLM
AnythingLLM (Draft Agent running Gemma 4) needs to understand the new process. Update:

**a) AnythingLLM system prompt** (CameronLoudonAI workspace settings):
- Replace any reference to "promoting to AI-Prod" with the Ready/ folder workflow
- Confirm AI-Prod is read-only for the Draft Agent
- Add the Drafts/Ready/Completed/ subfolder structure
- Remove any reference to Draft Agent updating PROJECT_STATE.md

**b) AnythingLLM file system access paths** (Agent Skills settings):
- Confirm these three paths are configured and correct:
  - `C:\Users\camer\Documents\GitHub\cameronloudon.github.io` (read)
  - `C:\Users\camer\Documents\AI\AI-Working` (read/write)
  - `C:\Users\camer\Documents\AI\AI-Prod` (read only — verify this is not write)

### Step 4 — Update OpenCode
`opencode.json` needs to reflect the agreed Publish Agent role. The file is gitignored and lives locally at the repo root.

Update or create `opencode.json` with:
```json
{
  "instructions": [
    "ONBOARDING.md",
    "AI_INSTRUCTIONS.md",
    "PROJECT_STATE.md"
  ],
  "model": "gemma4:e4b",
  "permission": {
    "external_directory": {
      "C:\\Users\\camer\\Documents\\AI\\AI-Working\\Ready\\**": "allow",
      "C:\\Users\\camer\\Documents\\AI\\AI-Prod\\**": "allow"
    },
    "bash": {
      "*": "ask",
      "git status *": "allow",
      "git diff *": "allow",
      "git log *": "allow"
    },
    "edit": {
      "*": "ask"
    }
  }
}
```

Key points:
- OpenCode only needs read access to `AI-Working/Ready/` — not all of AI-Working
- AI-Prod is write (for sync) but the robocopy step uses `permission.ask` — Cameron confirms at runtime
- Bash is ask for everything except safe read-only git commands

### Step 5 — Final check
Once all of the above is done, check that these files all agree with each other and with the agreed process:
- `CLAUDE.md`
- `AI_INSTRUCTIONS.md`
- `ONBOARDING.md`
- `cowork-conventions.md` (already updated this session)
- `AnythingLLM system prompt`
- `opencode.json`

If they all agree, the system is consistent and documented. That is the end state.

---

## Reference files
- Full process diagram: shown in the Cowork session from 2026-06-29 (not saved as a file — rebuild from this document if needed)
- Process reference document: `AI-Working/two-agent-system-process-reference.md`
- Implement prompt (given to Claude Code): `AI-Working/Prompts/claude-code-implement-prompt.md`
- Consensus prompt (full record): `AI-Working/Prompts/claude-code-final-consensus-prompt.md`
- Updated Cowork protocol: `AI-Working/Protocols/cowork-conventions.md`

---

*Prepared by Cowork (Draft Agent) · 2026-06-29 · Session handoff*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-verification-findings-2026-06-29]]
