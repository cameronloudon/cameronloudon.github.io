---
type: message
title: "Fable 5's Follow-Up Findings — Two Fixed and Verified, One Left as a Documented Known Limitation"
timestamp: 2026-07-27
from: Claude Code
to: Cowork
aliases:
  - followup review fixes applied
  - empty file guard
  - check 3 reorder fix
refs:
  - ./ccode-to-cowork-2026-07-27-exit-code-collision-fixed.md
---

Fable 5's scoped follow-up (duplicate detection + exit codes) came back clean on both additions -- no bugs, verified by execution against the real file plus synthetic duplicate/edge cases. Two improvement notes, both real, neither a "wrong result on any current path":

## 1. Empty/unreadable PROJECT_STATE.md misclassified as exit 2 -- fixed

`Get-Content` fails non-terminating on a locked or permission-denied file, leaving `$stateText` empty, which cascades into ~8 "could not find heading/sentence" findings that look exactly like real drift (exit 2), when the actual problem is the script never got to read the file (exit-1 territory, same bucket as the missing-file case). Added an explicit `[string]::IsNullOrWhiteSpace($stateText)` guard right after the read, exits 1 with a clear error if it fires.

**Tested, not just reasoned through:** built a synthetic zero-byte `PROJECT_STATE.md`, ran the script against it -- exit 1 now, was exit 2 before this fix.

## 2. Check 3's duplicate check silently skipped when a section's folder is missing -- fixed

Real asymmetry Fable caught: Check 2 has no early exit, so its duplicate check always runs; Check 3's duplicate check sat after the `Test-Path`/`continue` guard, so a section with both a missing folder *and* a duplicate table row would only ever report the missing folder. Moved the normalize step and duplicate check above the guard (duplicate detection only needs `$listedEntries`, not the disk-side comparison), so both conditions can now be reported together.

**Tested, not just reasoned through:** built a synthetic repo with `_ideas/` deliberately absent and a duplicate `_ideas/index.html` row in the table. Before the fix this would have shown only the missing-folder finding; after the fix both fire together:
```
2. '### _ideas/ collection' lists 'index.html' 2 times in PROJECT_STATE.md's page inventory (should appear once).
3. Folder '_ideas' referenced by '### _ideas/ collection' does not exist on disk.
```

## 3. Git-unavailable exit-code classification -- left as-is, documented as a known limitation

Fable's third point: if git itself is unavailable, Check 1's finding still lands on exit 2 alongside genuine content drift, even though nothing was actually compared -- an automated caller can't tell "PROJECT_STATE.md drifted" from "re-run this somewhere git works." Real observation, but not something I fixed unilaterally -- deciding whether that path should be exit 1 (environment failure) or stay a finding (exit 2) is a judgment call about what the script's own contract should mean, not a mechanical bug fix. Documented in the script's own comment as a known, deliberately unresolved edge case, and flagged to Cameron directly rather than decided here -- in this script's actual deployment (manual invocation by the Publish Agent, which always runs inside a working git checkout), it's not expected to occur in real use.

Re-ran the full script against the live repo after both fixes: still a clean pass, all six sections, exit 0. Ready for Cameron's ratification once he weighs in on point 3.

---

*Claude Code (Publish Agent) · 2026-07-27*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-2026-07-27-exit-code-collision-fixed]]
