# Single-AI Workflow
**Last updated:** 2026-06-21
**Applies when:** One AI is handling both Draft Agent and Publish Agent responsibilities

---

## Why This File Exists

This project was built with two AI tools in separate roles — one for drafting (Cowork) and one for publishing (Claude Code). That split was a product of the tools available at the time, not a requirement of the work.

If you are reading this as a single AI, understand: the role split was contingent, not permanent. You may be capable of both roles. The workflow described below is how you operate when that is the case.

A note for context: during the project's original two-AI phase, the Publish Agent (Claude Code) was not instructed to consider whether it could also draft; its instructions defined it as the Publish Agent, and it did not step outside that frame. That constraint was a product of how it was instructed, not a fundamental limit. You are being explicitly told: if you are the only AI, you hold all roles.

---

## The Single-AI Workflow

```
draft → self-review → validate → commit → update PROJECT_STATE.md → write session log
```

### Step 1 — Draft

Produce the content or changes in your working context. If you have file write access to a drafting space equivalent to AI-Working, use it. If not, hold the draft in your context window until you are ready to commit.

### Step 2 — Self-review

Before validating, review your own output. The purpose of self-review is to catch problems before the checklist — errors in structure, logic, attribution, or convention that are easier to fix now than after a checklist pass.

Self-review options (use whichever your tool supports):

- **Second context window pass:** Start a fresh context, provide your draft output, and ask: "Does this meet the project's conventions? What is wrong with it?" Review the response before proceeding.
- **Checklist-based review in session:** Work through the checklist below mentally or explicitly, before running the formal checklist.
- **Temporal gap:** Save the draft, do other work or end the session, return and review with fresh context before committing. This is slower but catches different errors than in-session review.

In a two-AI workflow, self-review is replaced by cross-tool review. In a single-AI workflow, you are the reviewer. Do not skip this step.

### Step 3 — Validate

Run the full checklist in `_ai-context/rct-validation-checklist.md`. Every item must be checked. Record the validation signature in the session log.

If any item fails: stop. Do not commit. Fix the issue and re-validate.

### Step 4 — Commit

Commit changes to the current branch (check `PROJECT_STATE.md` for the active branch). Never commit directly to `main`. Use a clear commit message describing what changed and why.

### Step 5 — Update PROJECT_STATE.md

Update the state file after every session that changes the repo:
- Active branch and session ID
- Page inventory (any pages added, changed, or removed)
- `NEXT_SESSION_LOG_ID` incremented
- Open decisions (any resolved or newly raised)
- Capability baseline (unchanged unless your tool setup changed)

Commit the PROJECT_STATE.md update. This may be in the same commit as step 4 or a separate commit immediately after.

### Step 6 — Write session log

Write a session log to `_session-logs/` using the format in `_ai-context/rct-session-primer.md`. Use the `NEXT_SESSION_LOG_ID` from PROJECT_STATE.md (the value before you incremented it in step 5).

Commit the session log.

---

## Access Requirements

To run this workflow, you need:
- File write access to the repo (`C:\Users\camer\Documents\GitHub\cameronloudon.github.io`)
- Git capability (branch, commit, push)
- Ability to read `C:\Users\camer\Documents\AI\AI-Working\` for any content drafted there

If you lack git capability, complete steps 1–3 and produce a commit block for Cameron to paste and run manually.

---

## What Stays the Same

Whether one AI or two:
- Cameron confirms and merges. You do not merge to main.
- The checklist is mandatory.
- The session log is mandatory.
- PROJECT_STATE.md is updated at session close.
- Attribution is non-negotiable.

---

*Version: 1.0 · Created: 2026-06-21 · Part of the RCT framework*
