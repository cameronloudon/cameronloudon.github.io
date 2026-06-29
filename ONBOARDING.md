# Onboarding — cameronloudon.github.io
**Last updated:** 2026-06-21
**For:** Any AI assistant working on this project

---

## You are assisting Cameron Loudon

Cameron is a marketing professional building a personal brand website at cameronloudon.github.io. The site is built on Jekyll and hosted via GitHub Pages. Cameron works under a framework called Radical Collaboration Transparency (RCT), which requires that AI contributions are attributed and auditable on every published page.

Cameron's long-term goal is to run a local AI setup. This project is designed to be AI-independent — any capable AI should be able to read these files and pick up where the last one left off.

---

## Read these files in this order

**Every session, before doing anything else:**

1. **This file** — you are reading it now
2. **`AI_INSTRUCTIONS.md`** (repo root) — the canonical rules for working on this project: your role, the workflow, technical constraints, and what to do when uncertain. Read it in full.
3. **`PROJECT_STATE.md`** (repo root) — the current state of the project: active branch, page inventory, open decisions, what was last done. Read it before every session.
4. **`_ai-context/`** (repo directory) — operational detail: content templates, CSS patterns, collaboration note format, session log format, validation checklist. Read the files relevant to your current task.

---

## How content moves from draft to published

**AI-Working** (`C:\Users\camer\Documents\AI\AI-Working\`) is the Draft Agent's workspace. It has three subfolders that signal content status:

- `Drafts/` — work in progress, not yet approved
- `Ready/` — approved by Cameron, waiting for the Publish Agent to commit. Should be empty most of the time — a file here means something is in flight.
- `Completed/` — published, verified live in AI-Prod, closed out

Content flows: Draft Agent writes to Drafts/, moves approved content to Ready/, then Cameron passes the handoff prompt to the Publish Agent. The Publish Agent reads from Ready/ and commits directly to the repo. AI-Prod is not a waypoint in this flow.

**AI-Prod** (`C:\Users\camer\Documents\AI\AI-Prod\`) is a read-only mirror of the live repo. It is updated by the Publish Agent after Cameron merges to main — never before. The Draft Agent has read-only access to AI-Prod to see what is currently published. It is not a staging area and nothing is written to it until content is live.

**The repo** (`C:\Users\camer\Documents\GitHub\cameronloudon.github.io`) is where the Publish Agent commits changes. GitHub Pages builds and publishes the site automatically from the `main` branch — no manual deploy step.

---

## Which files are Claude-specific

**`CLAUDE.md`** is Claude Code's native instruction file. It auto-loads when Claude Code starts a session in this repo. It contains the same conventions as `AI_INSTRUCTIONS.md` but with Claude-specific detail and formatting. If you are not Claude Code, `CLAUDE.md` will not auto-load — read `AI_INSTRUCTIONS.md` instead. If you are Claude Code, read both: CLAUDE.md loads automatically; cross-check it against AI_INSTRUCTIONS.md if they appear to conflict (AI_INSTRUCTIONS.md is authoritative on intent).

**Cowork memory files** are backed up as plain text in `AI-Working/Protocols/` (outside this repo). If you are not running as Cowork, those files are readable as onboarding context but are not instruction files.

---

## If you are the only AI on this project

This project was built with two AI tools operating in separate roles — one for drafting (Draft Agent) and one for publishing (Publish Agent). That split was a product of the tools available at the time, not a requirement of the work.

If you are reading this as a single AI handling both roles, see `_ai-context/single-ai-workflow.md` for how drafting, validation, and publishing work in a single-tool setup.

---

## Current state

Read `PROJECT_STATE.md` for the live picture. Do not rely on this file for current state — it is an onboarding document, not a state tracker.

---

## Tool-specific setup

**Claude Code** loads `CLAUDE.md` automatically. No additional setup required.

**OpenCode** requires a local `opencode.json` in the repo root. This file is gitignored and is not committed to the repo — you must create it before starting a session. The template and configuration details are documented in the AI Independence Verification runbook (held in AI-Working). The file loads onboarding documents automatically, configures Ollama as the model provider, and sets permission rules for confirmations on destructive actions.

**Config file ownership:** `.claude/settings.json` covers Claude Code permissions. `opencode.json` covers OpenCode permissions. These are separate files with separate permission models — a permission in one does not apply to the other.

---

## If something is unclear

Ask Cameron before acting on structural decisions. Cameron's email: cameronloudon@gmail.com
