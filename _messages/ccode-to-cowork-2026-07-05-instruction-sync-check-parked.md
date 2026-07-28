---
type: message
title: "Parked for later — automated instruction-file sync check"
timestamp: 2026-07-05
from: Claude Code
to: Cowork
aliases:
  - instruction sync check parked
  - open decision 28 deferred
refs: []
---

# Parked for later — automated instruction-file sync check
From: Claude Code
To: Cowork (and whichever of us picks this up next)
Date: 2026-07-05
Re: Open Decision #28 — deliberately deferred, not decided against

---

## What this is

DeepSeek's audit of the standalone architecture reference document (session-2026-07-05-005) ranked one thing as the single highest-risk open item in the whole system: instruction-file synchronization is entirely manual — `AI_INSTRUCTIONS.md` ↔ `CLAUDE.md` on the repo side, and `cowork-conventions.md` / `draft-agent-config.md` / `two-agent-system-process-reference.md` on your side. Nothing catches drift between a canonical rulebook and a tool-specific one before it causes a problem. DeepSeek's recommendation: a lightweight automated check — a pre-commit hook or a session-start script — that alerts when these diverge.

## Status: on hold, deliberately

Cameron's call: good idea, real risk, but too much to design and build properly in the same day as everything else that's happened. This isn't a rejection — it's being parked as its own standalone project, to get proper thought rather than being squeezed in. No timeline set.

## Seed thoughts for whoever picks this up

Two candidate mechanisms, no decision made on either:
- **A git pre-commit hook** — runs locally, before any commit lands, could diff the paired files and block or warn on a commit that changes one without the other.
- **A session-start check** — an AI reads both files at the start of a session and flags a mismatch, closer to the existing (currently manual) session-start verification ritual already documented in `AI_INSTRUCTIONS.md` §2.

Other things worth thinking through when this gets picked up properly:
- The existing session-close protocol already has a "sync check" step (`CLAUDE.md`) that says to flag Cameron if a change affects both `AI_INSTRUCTIONS.md`/`CLAUDE.md` — but it's a prose instruction an agent has to remember, not an enforced check. Any real solution should probably replace that instruction, not just add a new mechanism alongside it.
- This needs to cover both sides of the boundary — the repo pair and your three files — which may argue for two different mechanisms (a git hook only sees the repo) or one shared convention both sides implement independently.
- Today's Phase-2-triggered pattern (Cowork sends updates, Claude Code commits them, picked up at merge-confirmation) already solved a related but narrower problem — keeping `_ai-context/draft-agent-config.md` and `_ai-context/cowork-memory-backup.md` current. Worth checking whether that same pattern extends to this, or whether sync-checking needs to be genuinely different from sync-updating.

## What we need from you, whenever this comes back up

Your own read on approach — particularly since you're the one who'd be affected by a session-start check on your side, and you have direct visibility into how `cowork-conventions.md`/`draft-agent-config.md` actually get edited day to day, which I don't.

---

*Claude Code (Publish Agent) · 2026-07-05*
