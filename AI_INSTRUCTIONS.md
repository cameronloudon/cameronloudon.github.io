# AI Instructions — cameronloudon.github.io
**Last updated:** 2026-07-12
**Authoritative on:** Intent and conventions. For Claude Code-specific detail, see CLAUDE.md. If they conflict, this file wins.

---

## 1. What this project is

cameronloudon.github.io is Cameron Loudon's personal brand website, built on Jekyll and hosted via GitHub Pages. It publishes original thinking, a professional profile, session logs documenting AI collaboration, and a skills collection (currently empty). Cameron works under a framework called Radical Collaboration Transparency (RCT), which requires that every page carrying AI-assisted content attributes that contribution explicitly and auditably. Cameron's long-term goal is to replace Claude with a local AI setup — this file is written so any capable AI can read it and continue the work.

---

## 2. Session-start ritual

Do this at the start of every session, before taking any action:

1. Read `ONBOARDING.md` if you haven't already (first session on this project only)
2. Read `PROJECT_STATE.md` — current branch, page inventory, open decisions, what was last done
3. Verify PROJECT_STATE.md's Active Branch claim against actual git state (`git status`, `git branch --show-current`, `git log`). The Publish Agent's job ends at push; Cameron merges afterward, in a separate action outside that session. This means the Active Branch section is only ever true for the window before merge — if the named branch has already been merged, or doesn't match the branch you're actually on, correct `PROJECT_STATE.md` before doing anything else. Do not proceed on the assumption that the file is current just because you read it. This exact gap — a branch merges, nothing updates the file, the next session inherits stale state — has recurred multiple times on this project; treat the check as mandatory, not optional.
4. Read the relevant files in `_ai-context/` for your current task
5. Compare every canonical instruction file relevant to your role (this file, and any others — see `PROJECT_STATE.md`'s Instruction File Index) against your own tool-specific derivative file(s), also listed there. (For Claude Code specifically, the derivative is `CLAUDE.md`, which has already auto-loaded by this point.) Check for a rule-level disagreement — not wording, phrasing, or formatting — and if you find one, stop and tell Cameron before taking any other action. This applies to whichever tool is filling either role, not only the tools currently doing so
6. `master-synthesis-prompt.html` (published page, repo root) is the founding document — it describes the original intent of the project. Read it once for historical context when first onboarding. You do not need to read it every session; `PROJECT_STATE.md` is the current-state reference.

Do not begin work until you have read PROJECT_STATE.md and confirmed its Active Branch claim against real git state. Acting on stale state is the most common source of errors on this project.

This check is a safety net, not the primary defence — see §6's Git note for the fix that closes the gap at the source (correcting PROJECT_STATE.md at merge-confirmation time, not waiting for this check to catch it later).

---

## 3. Role definitions

This project was built with two AI tools in separate roles. Those roles are defined by file system access, not by which AI product is used.

| Role | Responsibilities | Requires |
|---|---|---|
| **Draft Agent** | Drafts structured content only — Markdown, no HTML or Jekyll frontmatter — in AI-Working/Drafts/; moves approved file to AI-Working/Ready/ and writes handoff prompt; does not write PROJECT_STATE.md | Read/write: `C:\Users\camer\Documents\AI\AI-Working\`; Read-only: AI-Prod; No access: repo, GitHub |
| **Publish Agent** | Reads approved structured content from AI-Working/Ready/; authors all HTML and Jekyll frontmatter from it using the template library in `_ai-context/ai-content-creation-spec.md` §6; makes all repo changes; commits and pushes; runs pre-publish validation checklist; updates PROJECT_STATE.md at session close; syncs AI-Prod after merge | Read/write: repo (`C:\Users\camer\Documents\GitHub\cameronloudon.github.io`); Read-only: AI-Working/Ready/; Write: AI-Prod (sync only, post-merge); No access: AI-Working/Drafts/, AI-Working/Completed/ |
| **Review Agent** | Independent review of plans, implementation, and output; cold-start context; no file write access | Read access to documents provided by Cameron |

**The content/HTML boundary is canonical**, not a workaround for any one model's limitations. The Draft Agent role never produces HTML, page structure, or frontmatter — it produces content (prose, headings, required fields) tagged with a `content_type`. The Publish Agent owns all structural and markup decisions, selecting the matching template from `_ai-context/ai-content-creation-spec.md` §6. This applies to every tool filling either role, not just the tools listed below.

**Current tools filling these roles:**
- Draft Agent: Cowork (Claude, Anthropic)
- Publish Agent: Claude Code (Claude, Anthropic)
- Review Agent: External AI (rotating; most recently DeepSeek)

---

## 4. Single-AI scenario

The two-role split was a product of the tools available when this project was built. It is not a requirement of the work.

If you are reading this as a single AI handling both roles: you can do this. Draft Agent and Publish Agent responsibilities collapse into a single session. The workflow becomes: draft → self-review → validate (run `_ai-context/rct-validation-checklist.md`) → commit → update PROJECT_STATE.md → write session log.

For the full single-AI workflow, see `_ai-context/single-ai-workflow.md`.

---

## 5. The RCT framework

Radical Collaboration Transparency (RCT) is Cameron's framework for attributing AI contributions on this site. Every page that involved AI assistance must carry a collaboration note. Every session that produces published content must have a session log.

**Attribution is non-negotiable.** Do not publish content without a collaboration note. Do not end a session without writing a session log if content was published or the repo was changed.

**Collaboration note format:** `class="collab-note"` with `collab-note-header` and `collab-note-body` inner structure. One note per page. See `_ai-context/rct-session-primer.md` for the full format specification.

**Session log format:** Filename `session-YYYY-MM-DD-NNN.md` in `_session-logs/`. NNN is a zero-padded three-digit counter. The next session log ID is in PROJECT_STATE.md under `NEXT_SESSION_LOG_ID`. See `_ai-context/rct-session-primer.md` for format.

---

## 6. Key technical constraints

**Git:** Never commit directly to `main`. All work happens on a named branch (current: see PROJECT_STATE.md). Cameron confirms and merges.

**When Cameron confirms a merge** (e.g. pasting a GitHub merge-confirmation message), correct `PROJECT_STATE.md`'s Active Branch section immediately, as the first action of a newly-opened branch created for that purpose — do not wait for the next session's start-of-session verification (§2) to catch the staleness. That check is a safety net for when this step gets missed, not the primary mechanism; relying on it alone is what let the same staleness bug recur (see `PROJECT_STATE.md` Open Decisions #19 and #21). The correction itself still follows normal branch-and-push discipline — it is not an exception to the no-direct-commit rule above, just triggered at merge time instead of whenever the next task happens to start.

**Jekyll frontmatter:** No blank line before the opening `---`. Missing or malformed frontmatter causes Jekyll to silently drop the page from its collection.

**Collection fields:** Files in `_ideas/`, `_session-logs/`, `_skills/`, and `_now/` must declare all collection-specific frontmatter fields, not just `layout` and `title`. Missing fields cause Jekyll to silently drop pages from collections.

**CSS — global rule:** All colours use CSS variables defined in `main.css`. Never hardcode colour values anywhere.

**CSS — exception:** Page-level `<style>` blocks are permitted for layout scaffolding (structural positioning only). Colour and typography overrides in page-level blocks are not permitted — use CSS variables in `main.css`.

**Ideas entries:** New ideas entries use the folder pattern — a named folder containing an index file and sub-pages (see `_ideas/man-with-two-brains/` as the reference). `marketing-os-foundation.html` is a legacy flat file; the folder pattern is the standard going forward.

**Font imports:** No page-level `@import` of Google Fonts or any other font service. Fonts are managed in `main.css` only.

**Pre-publish validation:** Before committing any promoted content, run the checklist in `_ai-context/rct-validation-checklist.md`. Do not commit content that fails the checklist without flagging it to Cameron.

---

## 7. Claude was here

This project was built with Claude (Anthropic) as both Draft Agent (via Cowork) and Publish Agent (via Claude Code). If you are not Claude, here is what that means for you:

- `CLAUDE.md` contains the same conventions as this file plus Claude Code-specific operational detail. It is not wrong — it is a Claude-specific implementation of these instructions. Read it for context if you want the full history of how conventions were established.
- Session logs reference "Cowork" and "Claude Code" by name. Those are the tools that produced the work, accurately attributed under RCT.
- If you have questions about decisions made before your involvement, ask Cameron. Do not guess from partial context.

---

## 8. Current state

Read `PROJECT_STATE.md` before every session. It contains: active branch, session ID, page inventory with status, open decisions, capability baseline, external tools, and instruction file index.

Update `PROJECT_STATE.md` at session close. The Publish Agent owns all PROJECT_STATE.md updates and commits them at session close. The Draft Agent does not write a PROJECT_STATE.md block.

---

## 9. When uncertain

At the start of each session, confirm your task with Cameron before beginning work.

During a session, ask Cameron before acting on structural decisions — file structure, new collections, architectural changes, anything that affects how the site is built or how AI tools interact with it. Do not make structural changes on your own judgment.

For operational questions (CSS patterns, frontmatter format, collab-note structure), the answer is in `_ai-context/`. Read it before asking.

Cameron's email: cameronloudon@gmail.com
