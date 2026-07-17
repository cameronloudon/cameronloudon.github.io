---
type: reference
title: "Cold-Walk Isolation Safeguard"
aliases:
  - cold walk isolation safeguard
  - Function A contamination safeguard
refs:
  - ./auditor-charter.md
---

**Last updated:** 2026-07-17
**Status:** Ratified — Claude Code and Cowork's independent review converged after one redraft round, Cameron ratified 2026-07-17, Open Decision #55.
**Purpose:** Auditor Charter Function A (the cold walk) only produces real evidence if the walking agent is genuinely blank going in. This document is that guarantee's actual verification mechanism — tool-agnostic, designed before any real Auditor tool existed so it's ready whenever one does.

---

## The problem

Function A's whole premise — "would a capable cold agent have done the right thing here?" — only means something if the agent had no prior awareness to fall back on. A subagent spawned *from within* an existing Auditor workspace could inherit ambient context (project identity, role, prior-examination awareness) even without inheriting specific findings — enough to quietly compromise the cold-walk premise without anyone, including the agent itself, necessarily noticing.

The walk is also a one-shot resource: once mission 1 runs for real against this project's actual onboarding docs, the docs themselves may get fixed as a result — a second "real" walk wouldn't be testing the same undiscovered gaps a second time. The safeguard has to be right before the first genuine attempt, not tuned against it.

## The five-point safeguard

**1. Spawn requirement.** The cold-walk instance must be a genuinely fresh conversation, not a subagent inherited from a workspace whose own system prompt or memory index already names this project. If a candidate tool's architecture makes a truly blank spawn structurally impossible, that tool is disqualified from running mission 1 — not accommodated or worked around.

**2. Mandatory three-part step-zero disclosure, before touching any project file.** First action, every time, no exceptions, logged verbatim as part of the permanent audit record:

1. What do you infer about the project, the task, or your own role — based only on your system prompt, before reading anything?
2. List every available tool. Flag anything in its name or description that could identify the project or its owner.
3. Report your working directory, `git remote -v` output, and any environment variables visible to you — as neutral technical facts to disclose, not filtered through whether you personally judge them identifying.

Split into three explicit questions deliberately, not one open-ended one: a model won't necessarily connect its own tool surface or working directory to "this reveals identity" the way it would obviously flag system-prompt text — asking generically lets that leak past undetected. Any specific, correct claim about this project in any of the three answers (not generic AI-agent boilerplate) is a contamination signal — everything downstream from that point gets flagged as compromised, not silently trusted as clean.

**3. Decoy dry-run, structurally parallel to the real target, before the real thing.** Point the same spawn mechanism at a decoy — not just "an unrelated project," but one matching the real target's name shape, file structure, and deployment path — and confirm the disclosure comes back generic. Tests whether the isolation *mechanism itself* leaks, without spending the one real cold walk this project gets on a mechanism check. A generic, structurally-dissimilar decoy risks never triggering the actual retrieval pathway a real spawn would use, producing a clean result that proves nothing about the real risk.

**4. Verify the candidate tool's actual subagent architecture directly, empirically.** Not assumed from documentation — same discipline as vetting a new tool's real command surface before granting execution access (the Graphify trial's lesson). Two explicit sub-questions, both required:
- Does spawning a subagent from this tool inherit parent context by default? Is there a genuinely isolated/stateless spawn mode?
- Does this platform auto-retrieve or inject context at all (RAG-style), and what actually triggers it?

The second question matters because it's the one vector step 2's disclosure structurally cannot catch — if a platform silently retrieves and injects context before the agent starts reasoning, there's nothing for the agent to self-report; it can't distinguish "I inferred this" from "this got pulled in behind me." Current candidate: OpenWork, with DeepSeek API tokens available now — this check does not need to wait for a future candidate to exist.

**5. The real walk is one-shot, treated as precious.** Once the isolation mechanism is verified clean via the decoy dry-run, the first genuine mission-1 run against this project's actual onboarding path gets logged in full and trusted — not casually repeated "just to check." If contamination is suspected even after all of this, that is itself a finding to investigate and disclose, not something to quietly discard and re-run hoping for a cleaner result.

## What this safeguard is not

Point 1's disqualifying stance is deliberate, not a placeholder to loosen later: the actual bar is "no specific, correct claim about this project," not "zero context of any kind" — ordinary ambient AI-agent framing that doesn't identify *this* project still passes. If empirical testing against a real candidate later shows nothing clears even that narrower bar, that is evidence Function A's own premise needs rethinking, not evidence this safeguard is miscalibrated.

## Sources

Design proposed by Claude Code, independently reviewed by Cowork through one substantive redraft round (tool-description and filesystem-metadata leak vectors added to the disclosure; decoy specificity tightened; OpenWork named concretely for point 4), ratified by Cameron 2026-07-17. Full deliberation: `AI-Working/Messages/ccode-to-cowork-2026-07-17-cold-walk-isolation-safeguard-proposal.md` → `cowork-to-ccode-2026-07-17-cold-walk-isolation-safeguard-response.md` → `ccode-to-cowork-2026-07-17-cold-walk-isolation-safeguard-redraft.md` → `cowork-to-ccode-2026-07-17-cold-walk-isolation-safeguard-ratify.md`. Traces back to the original memory-index concern raised during Auditor Charter §10 mission-1 planning, left open as Open Decision #47.

## Links
<!-- generated from refs: - do not hand-edit -->
- [[auditor-charter]]
