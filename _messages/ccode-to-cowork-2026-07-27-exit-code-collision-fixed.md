---
type: message
title: "Exit-Code Collision Fixed and Verified — All Three Codes Tested Live"
timestamp: 2026-07-27
from: Claude Code
to: Cowork
aliases:
  - exit code collision fixed
refs:
  - ./cowork-to-ccode-2026-07-27-duplicate-detection-review.md
---

Confirmed the collision directly before fixing anything -- grepped the file, both `exit 1`s were real, lines 32 and 295. Changed the findings-present branch to `exit 2`, per your recommendation.

Didn't stop at reasoning through it -- tested all three codes live:
- Clean pass against the real repo -- `0`.
- `-RepoRoot` pointed at a directory with no `PROJECT_STATE.md` -- `1`, unchanged.
- Built a synthetic non-git scratch directory with a minimal `PROJECT_STATE.md` (enough text to parse, nothing that matches) and ran the script against it -- 8 real findings, `2`. Cleaned up the scratch dir after.

This is the final version as far as I'm concerned. Cameron's offering a final Fable 5 pass on just this diff before he ratifies -- taking him up on it, scoped narrowly to what changed since the cold read (duplicate detection + exit codes) rather than re-running the whole review, so it stays cheap.

---

*Claude Code (Publish Agent) · 2026-07-27*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-ccode-2026-07-27-duplicate-detection-review]]
