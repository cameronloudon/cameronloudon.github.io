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

Content moves through three locations before it's live. `AI-Working` (`C:\Users\camer\Documents\AI\AI-Working\`) is the Draft Agent's workspace — drafts are written and revised here, and nothing is published directly from this folder. `AI-Prod` (`C:\Users\camer\Documents\AI\AI-Prod\`) is a mirror of the live repo — read it to see what's currently published without leaving your drafting environment. The repo itself (`C:\Users\camer\Documents\GitHub\cameronloudon.github.io`) is where the Publish Agent actually commits changes. GitHub Pages then builds and publishes the site automatically from the `main` branch — no manual deploy step.

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

## If something is unclear

Ask Cameron before acting on structural decisions. Cameron's email: cameronloudon@gmail.com
