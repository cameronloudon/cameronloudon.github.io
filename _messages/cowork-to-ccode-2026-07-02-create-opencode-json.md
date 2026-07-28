---
type: message
title: "Create opencode.json from Corrected Template"
timestamp: 2026-07-02
from: Cowork
to: Claude Code
aliases:
  - create opencode.json
  - opencode template three fixes
  - big-pickle model correction
refs: []
---

The `opencode-template.json` in `AI-Working/Prompts/` has been updated with three fixes identified during the OpenCode readiness review:

1. Added `AI-Working\Messages\**` to `external_directory`
2. Corrected `model` from `gemma4:e4b` to `opencode/big-pickle`
3. Fixed `instructions` array order to match Step 0 read order: ONBOARDING.md → PROJECT_STATE.md → AI_INSTRUCTIONS.md

The corrected template content is:

```json
{
  "instructions": [
    "ONBOARDING.md",
    "PROJECT_STATE.md",
    "AI_INSTRUCTIONS.md"
  ],
  "model": "opencode/big-pickle",
  "permission": {
    "external_directory": {
      "C:\\Users\\camer\\Documents\\AI\\AI-Working\\Ready\\**": "allow",
      "C:\\Users\\camer\\Documents\\AI\\AI-Working\\Messages\\**": "allow",
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

Please create `opencode.json` in the repo root (`C:\Users\camer\Documents\GitHub\cameronloudon.github.io\opencode.json`) with this content.

Confirm that:
- `opencode.json` is in `.gitignore` (it should be — verify before creating)
- The file was created successfully

Write your confirmation to:
**Filename:** `ccode-to-cowork-2026-07-02-opencode-json-created.md`
**Location:** `AI-Working/Messages/`

---

*Cowork (Draft Agent) · 2026-07-02*
