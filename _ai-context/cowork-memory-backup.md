# Cowork Memory Backup — cameronloudon.github.io
**Last updated:** 2026-07-05
**Purpose:** Plain-language export of Cowork's memory context. Readable by any AI taking over the Draft Agent role. Not a memory-format file — do not import as memory.

---

## About Cameron

Cameron Loudon is a marketing professional (30+ years, higher education, health, technology sectors). He is not technical — he cannot verify code solutions independently and relies on the check-and-balance workflow for technical decisions. He works with AI as a genuine thinking partner, not a drafting tool.

He owns every decision and every published conclusion. The AI brings structure and friction without ego.

---

## Key conventions Cowork has learned

### Always include PowerShell startup steps in Claude Code prompts
Cameron cannot remember how to start Claude Code. Every Claude Code prompt must begin with:
```
Open PowerShell:
    cd "C:\Users\camer\Documents\GitHub\cameronloudon.github.io"
    claude

Paste this prompt:
```
Cameron has corrected the Draft Agent for omitting this more than once. No exceptions.

### Never push to GitHub from the Draft Agent environment
Cowork's bash sandbox does not have GitHub credentials. All git operations go through Claude Code on Cameron's machine. Prepare files and write prompts — do not attempt git operations directly.

### Branch numbering is GitHub-based, not session-based
Session branches are `session-N`. The number tracks GitHub working branches, not Cowork sessions. Do not increment the branch number unless Cameron explicitly instructs it. Check `PROJECT_STATE.md` for the current active branch — never assume a number from memory.

### Check-and-balance for technical problems
For any non-trivial technical implementation (CSS, JS, Jekyll config, layout files): give both Draft Agent and Claude Code the same problem independently, cross-review each other's solutions, Cameron decides. Do not lead Claude Code with the Draft Agent's solution.

### Structural/architecture changes need consensus, not a directive
Learned 2026-07-05: for repo structure changes (new collections, folder patterns, config, instruction-file changes) — as distinct from technical bug fixes — the process is propose → independent review → consensus → Cameron decides. Neither agent hands the other an execution-ready directive before that consensus exists. See the dated `AI-Working/Messages/` threads from 2026-07-05 (Now-collection conversion, repo architecture mapping) for the pattern in practice.

### Signals section definition
"People and ideas that have shaped how I think." — both relational and editorial. Confirmed correct by Cameron. Do not reframe as exclusively one or the other.

---

## Current state — how to find out, not a snapshot

This section deliberately contains no dated facts. Two prior versions of this file each held a "project state as of [date]" section, and both went stale and misled whoever read them next — 8 days stale when first audited, 14 days stale the second time. The fix is structural, not another refresh: nothing dated belongs in this file.

- **Current branch, page inventory, open decisions:** read `PROJECT_STATE.md` fresh, every time. It states explicitly that it wins over every other file on current state — including this one.
- **Recent history and rationale:** read `_session-logs/` (most recent first) and, for anything still being negotiated between agents, the dated threads in `AI-Working/Messages/`.
- **Never treat a "current state" claim in this file, or any other file in `Protocols/`, as current without checking `PROJECT_STATE.md` first.**

---

## Folder structure

```
C:\Users\camer\Documents\AI\
├── AI-Working\          ← Draft Agent's workspace (not published)
│   ├── Projects\        ← Active project folders
│   ├── Protocols\       ← This file and cowork-conventions.md
│   ├── Prompts\         ← Saved Claude Code prompts
│   ├── Drafts\          ← Work in progress
│   ├── Ready\           ← Approved, waiting for Publish Agent
│   └── Completed\       ← Published and verified
├── AI-Prod\             ← Mirror of live repo (read for current state)
└── AI-Prod-Archive\     ← Historical audit record (read-only)
```

---

## What is NOT in this file

This file captures conventions and context that don't change often. It does not capture:
- Content decisions (see `PROJECT_STATE.md` open decisions)
- Session history (see `_session-logs/`)
- Technical spec (see `AI_INSTRUCTIONS.md` and `_ai-context/`)
- Cameron's professional background in detail (see `about.html`)
- The full two-agent workflow (see `two-agent-system-process-reference.md` and `draft-agent-config.md`)

---

*Created: 2026-06-21 · Last refreshed: 2026-07-05 · Companion to `cowork-conventions.md`*
