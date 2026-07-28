---
type: message
title: "AI-Prod Examination — Findings, Observation 2 Solution Space, and Proposed Actions"
timestamp: 2026-07-10
from: Claude Code (Fable 5, AI-Auditor workspace — not the Publish Agent)
to: Cameron
refs:
  - ./ccode-to-cowork-2026-07-10-refs-to-instruction-demo.md
  - ./cameron-claudecode-conversation-transcript-2026-07-09.md
  - ../_ai-context/extract-session-transcript.ps1
  - ../AI_INSTRUCTIONS.md
  - ../PROJECT_STATE.md
---

**A note on `refs:` above:** this file lives in `C:\Users\camer\Documents\AI-Auditor\`, which is not git-tracked and sits outside the `_messages/` bundle. The paths above are repo-relative to `cameronloudon.github.io` — durable and checkable there, per the Open Decision #34 rule that citations must point at something git-tracked. This file's own custody status is therefore weaker than `_messages/` standards until/unless it is promoted; that is stated here rather than left implicit.

**A note on `type:`** — this session functioned as an informal preview of the proposed Auditor role: an independent agent examining the system cold, checking claims against filesystem and git state, and reporting findings. It is still typed `message`, not `audit-finding`, because that OKF type was deliberately reserved (Open Decision #34) for the real Auditor track once Cameron scopes it. Claiming it unilaterally would preempt that decision.

---

## 1. What this session was

Cameron asked for a read-only examination of AI-Prod (the post-merge mirror of cameronloudon.github.io) against three goals: AI Independence, transparency under RCT, and capturing all AI interactions for future learning. The model was Claude Fable 5 running in Claude Code, in a separate workspace (`AI-Auditor`) with no Publish Agent responsibilities. No changes were made to AI-Prod or the repo at any point. Mid-session, PR #52 (session-28) merged and the Phase 2 sync ran; the examination was re-baselined against live state (`session-29` open, no work started).

## 2. Findings — the four observations, and where they stand now

**Observation 1 — `.obsidian/` vs. the `/MIR` sync. Confirmed live, fix known, execution pending.**
The Phase 2 robocopy (`/MIR /XD ".git" /XF "opencode.json"`) deletes anything in AI-Prod not present in the repo. The `.obsidian/` vault config created during session-28's graph test was present at examination time and **gone after the PR #52 sync** — the failure mode was observed happening, not just predicted. Session-28 independently identified the same fix ("fix identified, not made"): add `".obsidian"` to the `/XD` list in CLAUDE.md's Phase 2 command. The pre-authorized Bash permission in `.claude/settings.json` is a prefix wildcard (`robocopy <repo> <AI-Prod>*`), so the flag change needs no permission change. Loss this time was trivial (default vault config); it will not be trivial after Dataview is installed or graph views are configured. **This should land before any further Obsidian investment.**

**Observation 2 — transcripts capture words, not actions. Open; solution space in §3.**
`extract-session-transcript.ps1` keeps user/assistant text and drops `thinking`, `tool_use`, and `tool_result` records. Right call for readable transcripts; wrong evidence base for the Auditor, whose core job (Open Decision #36 is the proof case) is checking claims against actions. The current archive can prove what everyone *said* with strong guarantees and what any agent *did* with none. Nothing in session-28 touched this.

**Observation 3 — corpus discoverability. Absorbed into Open Decision #37; nothing further from this session.**
The cold-question test passed, but both answerers used the same mechanism (grep for the literal term "OpenBrain") — dependent on agent tooling and verbatim vocabulary. Already logged with two candidate mechanisms (karpathy-llm-wiki Query; Obsidian search via API/MCP).

**Observation 4 — record-to-instruction traceability. Half done.**
The `refs:`-to-`AI_INSTRUCTIONS.md` demo (session-28) proves records can point *at* instruction files. The reverse — instruction files carrying OKF frontmatter and pointing back at the records that shaped them — remains the open half, correctly logged in `_messages/index.md` as a deferred question.

## 3. Observation 2 — the solution space

Four options, ordered by how much evidence they preserve:

| Option | What it is | What it buys | Cost / risk |
|---|---|---|---|
| **A — Provenance stamping** | Transcript frontmatter gains: source JSONL path, SHA-256 of that file, extraction-script version | Converts "trust this transcript" into a checkable claim; retroactively applicable to existing transcripts | Preserves nothing extra by itself; only useful while the raw JSONL survives |
| **B — Action digest** | Extend the script to emit one compact line per tool call (tool, key parameter, result status) interleaved between conversation turns | Claims and actions in one document, in order — the shape an Auditor reads; mechanizes the existing manual italic-note convention | Medium effort: pairing `tool_use`/`tool_result`, deciding parameter detail and truncation |
| **C — Companion action log** | Transcript stays as-is; a second structured file per session (one record per tool call), OKF-stamped, `refs:`-linked to its transcript | Clean audience separation (humans read transcripts, Auditor reads logs); room to be exhaustive | New OKF type → propose→review→consensus item with Cowork, not unilateral |
| **D — Archive raw JSONL** | The raw log promoted (or copied) as evidence of record; transcripts become derived views | Maximum verbatim guarantee — the session-26 "mechanical beats reconstruction" logic taken to its conclusion | Size, unreadability, git bloat, and **sensitivity** (below) — should not land in the public repo |

**Three constraints that cut across all options:**

1. **The repo is public.** `_messages/` is excluded from Jekyll rendering but world-readable on GitHub. Curated transcripts pass that bar; raw `tool_result` blocks do not — they contain full contents of every file read in a session, paths, and environment detail never reviewed for publication. This argues against D in the site repo and for digest forms (B/C) as the public artifact, with raw evidence in a private store that public records cite by hash.
2. **A retention clock is running.** Claude Code deletes session JSONLs after a retention window (`cleanupPeriodDays`, default ~30 days). This project has lost material twice already; this would be mechanism three, currently armed. Cowork's platform has its own retention, not under Cameron's control.
3. **Platform generality.** The extraction proof was accepted because it worked on both platforms; action capture should meet the same bar. Corollary: "produces an auditable action log" becomes a per-row capability requirement in the Tool/Model/Runtime Matrix, alongside Open Decision #37's "has file search."

## 4. Proposed actions

In order. Owners per the existing role definitions; nothing here was executed this session.

1. **Rescue the raw JSONLs (urgent, forecloses nothing; losing them forecloses everything).** Copy existing session logs for both platforms out of their retention-managed locations into somewhere durable (AI-Working or a dedicated evidence folder); raise `cleanupPeriodDays` on the Claude Code side. Owner: Cameron + Publish Agent; Cowork for her side.
2. **Robocopy exclude fix (Observation 1).** One-line CLAUDE.md Phase 2 edit, `/XD ".git" ".obsidian"`, normal branch flow, first item of session-29 — before any Dataview install. Owner: Publish Agent.
3. **Provenance stamping (Option A).** Extend `extract-session-transcript.ps1` to emit source-path + SHA-256 + script-version frontmatter; retrofit the two existing mechanical transcripts. Owner: Publish Agent.
4. **Action-digest pilot (Option B).** Run against one real closed session — the proven 2026-07-08 session is the natural candidate. Judge from real output: size, sensitivity, readability, and whether a claim can actually be checked against an action. Owner: Publish Agent, reviewed by Cowork.
5. **Decide C and the private-evidence-store question from the pilot's real material,** through propose→review→consensus. This decision is also where the knowledgebase work should intersect the Auditor design (AI-Auditor workspace): the action log's schema is effectively the Auditor's input format. Owner: Cameron decides after both agents converge.

## 5. Honest limits of this session

- This examination read state; it did not verify the full git history, the live site, or any of Cowork's side beyond what the repo records claim.
- The retention-window figure (~30 days default) is from the examiner's own product knowledge, not verified against Cameron's actual settings this session — check `cleanupPeriodDays` before relying on the number. The direction of the risk is not in doubt; the deadline is.
- Fable 5 access is time-limited. Everything here is written so any capable AI — or the existing Publish Agent — can execute it without this session's context, per the project's own AI-independence standard.

---

<div class="collab-note">
<div class="collab-note-header">AI Collaboration Note</div>
<div class="collab-note-body">
This document was written by Claude (Anthropic), model claude-fable-5, running in Claude Code in the AI-Auditor workspace — a separate session from the project's Publish Agent. The examination it reports was conducted read-only against the AI-Prod mirror and the live repo's git state on 2026-07-10; no files in AI-Prod or the repo were created, modified, or deleted. Findings, the Observation 2 solution space, and the proposed action sequence are the AI's analysis; Cameron directed the examination, supplied the goals it was assessed against, corrected its stale-mirror baseline mid-session, and requested this record. Nothing in this document has been actioned — every proposal awaits Cameron's decision through the project's normal propose→review→consensus process.
</div>
</div>

*Written under the Radical Collaboration Transparency framework.*
*Model: claude-fable-5 · Platform: Claude Code · Workspace: AI-Auditor · Date: 2026-07-10*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ccode-to-cowork-2026-07-10-refs-to-instruction-demo]]
- [[cameron-claudecode-conversation-transcript-2026-07-09]]
- [[extract-session-transcript]]
- [[AI_INSTRUCTIONS]]
- [[PROJECT_STATE]]
