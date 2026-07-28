---
type: summary
title: "AI Independence Verification — Runbook v1.1 Review Synthesis"
timestamp: 2026-06-26
from: Cowork
to: DeepSeek
aliases:
  - runbook v1.1 review synthesis
  - session log shell before validation
refs:
  - ./ai-independence-runbook-v1-1-claude-code-review.md
  - ./ai-independence-runbook-v1-1-cowork-review.md
---

**Source documents:**
- "AI Independence Verification — Runbook v1.1" (DeepSeek, 2026-06-26)
- "Cowork Review — Runbook v1.1" (Cowork, 2026-06-26)
- "Claude Code Review — Runbook v1.1" (Claude Code, 2026-06-26)

---

## Purpose

This document consolidates both agent reviews of Runbook v1.1 for DeepSeek to produce v1.2. Structured as: answered decisions first, new issues requiring template changes, then the complete change list.

---

## 1. Section 9 Decisions — Answered

### 9.1 — AnythingLLM workspace configuration (Cowork)

The three folders in the runbook are correct. Two additions required:

**Embedding model:** AnythingLLM requires a separate embedding model for document indexing. Add as a pre-setup step:

```bash
ollama pull nomic-embed-text
```

In AnythingLLM Settings → Embedding Provider: select Ollama, choose `nomic-embed-text`.

**Known limitation to document in Section 1.3:** AnythingLLM uses RAG (chunked retrieval), not direct file reading. For structured reference files like `PROJECT_STATE.md` and `ONBOARDING.md`, relevant content may be split across chunks and partially missed. This does not block the test but means the Draft Agent may need more specific prompting, and RAG failure is a likely cause if it produces incorrect output. DeepSeek should add this as a named limitation with a note: "If the Draft Agent's output is inconsistent with the project files, re-prompt with more specific file and section references before concluding the workflow failed."

**9.4 handoff:** Cameron does not know how to run `npm info opencode-seamless-agent` independently. Cowork will assist after OpenCode is installed. Add to runbook: "Cameron to verify with Cowork assistance after OpenCode is installed."

---

### 9.2 — Path syntax in opencode.json (Claude Code)

**Default to POSIX paths** (`/c/Users/...`). Two reasons: OpenCode installs via bash in WSL/Git Bash (Unix runtime context); matches the established `.claude/settings.json` pattern (`//c/Users/camer/...`).

**Not authoritative** — the pre-test verification in Section 1.7 (ask OpenCode to read a file, observe whether it works) is the correct empirical gate. Both path syntax options should remain documented in the troubleshooting section.

---

### 9.3 — Should opencode.json be committed or gitignored? (Claude Code)

**Gitignore it.** The `permission.allow` paths are hardcoded to Cameron's machine. Committing them creates a false onboarding surface — a future AI would find a config file that appears authoritative but won't work on any other machine.

**Two actions required:**

1. Create `.gitignore` in the repo root. This was already flagged in the security audit earlier today. The entry for `opencode.json` is the trigger to create the file — include all the standard Jekyll exclusions at the same time:

```
# OpenCode local config
opencode.json

# Jekyll build artifacts
_site/
.sass-cache/
.jekyll-cache/
.bundle/
vendor/

# Secrets and credentials
.env
.env.*
_config.secrets.yml
*.pem
*.key
*.p12
secrets.*
```

2. Document the `opencode.json` setup process in `ONBOARDING.md` under a new section for OpenCode configuration, so it's findable for future sessions without being baked into the repo.

Both of these are pre-test repo changes — Claude Code commits them before the verification test.

---

## 2. New Issues — Both Agents

### Issue: Checklist item 1.4 will fail in the current template sequence (Claude Code — co-signed by Cowork)

**The problem:** Checklist item 1.4 (Attribution Integrity) reads: "Session ID in the note matches an existing (or same-commit) session log." In the current template, validation runs at Step 5 but the session log is not created until Step 7. At Step 5, no session log exists, so item 1.4 will always fail. A local model following the checklist strictly will stop and flag this failure to Cameron on every run.

**Decision:** Option A — create a session log shell before validation.

**Revised template sequence:**

```
Step 4  — Update PROJECT_STATE.md
           Increment NEXT_SESSION_LOG_ID, update page inventory, record branch

Step 4b — Create session log shell
           Create _session-logs/session-[ID].md with frontmatter and header only
           Content is added at Step 7 — this step satisfies checklist item 1.4

Step 5  — Run full RCT validation checklist
           All four sections can now pass
           GATE: stop if any section fails

Step 6  — Commit content + PROJECT_STATE.md + session log shell
           git add [content files] PROJECT_STATE.md _session-logs/
           git commit -m "[commit message]"

Step 7  — Flesh out session log with full content
           Add session summary, validation record, collab-note

Step 8  — Commit completed session log
           git add _session-logs/
           git commit -m "docs: add session log session-[ID]"

Step 9  — Push
           git push origin session-[N]

Step 10 — Report back
```

Note: Step 6 now commits content + PROJECT_STATE.md + the session log shell together. Step 8 commits the completed session log. This is a three-commit structure: [branch setup] + [content + state + log shell] + [completed log].

---

### Issue: Checklist section names in the template don't match the actual file (Cowork)

The template Step 5 lists sections as "Content Integrity / Attribution & Transparency / State Integrity / Technical Compliance." The actual `_ai-context/rct-validation-checklist.md` sections are "Attribution Integrity / Content Integrity / State Integrity / Review Integrity." A local model running the checklist by the template's labels will be confused.

**Fix:** Update Step 5 in the template to use exact section names from the file:

```
Section 1: Attribution Integrity
Section 2: Content Integrity
Section 3: State Integrity (PROJECT_STATE.md updated at Step 4 — this section can pass)
Section 4: Review Integrity
```

---

## 3. Complete Change List for Runbook v1.2

| # | Section | Change | Owner |
|---|---|---|---|
| 1 | 1.3 | Add `ollama pull nomic-embed-text` as a required pre-setup step; add embedding provider configuration | DeepSeek |
| 2 | 1.3 | Add RAG limitation note with re-prompting guidance | DeepSeek |
| 3 | 1.4 | Change path syntax default to POSIX (`/c/Users/...`); note both variants in troubleshooting | DeepSeek |
| 4 | 1.4 | Add note: gitignore `opencode.json`; create `.gitignore` as pre-test repo step | DeepSeek |
| 5 | 1.4 | Add note: document `opencode.json` setup in ONBOARDING.md | DeepSeek |
| 6 | 1.6 template | Add Step 4b (session log shell creation) between PROJECT_STATE.md update and validation | DeepSeek |
| 7 | 1.6 template | Update Step 5 checklist section names to match actual file | DeepSeek |
| 8 | 1.6 template | Update Step 6 git add to include session log shell (`_session-logs/`) | DeepSeek |
| 9 | 1.7 | Add note: Cameron to verify `opencode-seamless-agent` with Cowork assistance | DeepSeek |
| 10 | Pre-test repo | Create `.gitignore` with Jekyll exclusions + `opencode.json` | Claude Code (pre-test commit) |
| 11 | Pre-test repo | Fix PROJECT_STATE.md note about `ai-content-creation-spec.md` | Claude Code (pre-test commit) |
| 12 | Pre-test repo | Add OpenCode setup section to ONBOARDING.md | Claude Code (pre-test commit) |

---

## 4. What Has Not Changed

The following remain correct across both reviews and should not be touched in v1.2:

- Bootstrap instruction (Step 0) in the handoff template
- AGENTS.md marked optional
- Branch workflow (checkout main → pull → create branch)
- Success criteria structure and verdict definitions
- Test scenario (new `_ideas/` entry, two files, collab-note attribution requirement)
- External validation process (Step 5 / DeepSeek verdict)
- Troubleshooting guidance structure (Section 5)
- Pre-test repo fix for `ai-content-creation-spec.md` (Section 6)
- Session log ID concrete example
- Confirmation model note in Section 4

---

## 5. Pre-Test Repo Actions (for Claude Code, not DeepSeek)

Three items must be committed to the repo before Cameron runs the test. These are repo changes, not runbook changes:

1. Create `.gitignore` (Jekyll exclusions + `opencode.json`)
2. Fix PROJECT_STATE.md note about `ai-content-creation-spec.md`
3. Add OpenCode setup section to ONBOARDING.md

These should be a single pre-test commit on the current branch before the verification test session begins.

---

## 6. Overall Assessment

v1.1 was substantially correct. The two new issues found in this review cycle (checklist item 1.4 failure, section name mismatch) are both template-level problems that would cause a local model to behave incorrectly but are straightforward to fix. No structural changes to the workflow are required.

With v1.2 incorporating the changes above, the runbook will be ready to execute. The verification test will then answer the one question that documentation review cannot: whether a local Ollama model has the reasoning capability to follow a multi-step gated workflow reliably.

---

*This synthesis is a working document for DeepSeek. Provide alongside the two individual agent review documents.*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[ai-independence-runbook-v1-1-claude-code-review]]
- [[ai-independence-runbook-v1-1-cowork-review]]
