# Cameron Loudon — cameronloudon.github.io

## Project Overview
Personal brand website and ideas repository. Jekyll site hosted on GitHub Pages.
The complete project specification is in master-synthesis-prompt/master-synthesis-prompt.html — the founding document. Read it once for historical context when first onboarding; PROJECT_STATE.md is the current-state reference for every session after that.

## Two-Agent System
This project uses a two-agent workflow. Claude Code is the Publish Agent. The Draft Agent (Cowork) handles all content creation. The workflow, roles, and permissions are documented in `AI_INSTRUCTIONS.md` — read it before executing any publish task.

**Content/HTML boundary:** The Draft Agent produces structured content only (Markdown, no HTML or frontmatter). All HTML authorship and Jekyll frontmatter for Draft-Agent-sourced content is Claude Code's responsibility, built from that structured content using the template library in `_ai-context/ai-content-creation-spec.md` §6 — not a pass-through or light edit of agent-authored markup. Adopted 2026-07-03; see `_session-logs/session-2026-07-03-001.md`.

## Branch Workflow — CRITICAL
NEVER commit directly to main.
Before creating a session branch, verify PROJECT_STATE.md's Active Branch claim against actual git state (`git status`, `git branch --show-current`, `git log`) — if it names a branch that's already merged, correct PROJECT_STATE.md first (see AI_INSTRUCTIONS.md §2, session-start ritual).
Always create a session branch first: git checkout -b session-N
All work happens on the session branch.
Cameron reviews the diff on GitHub, then merges to main.

## Tech Stack
- Jekyll (static site generator)
- GitHub Pages (hosting)
- Plain HTML files with Jekyll frontmatter
- Single CSS file: assets/css/main.css
- Single JS file: assets/js/theme.js

## File Structure
_ideas/          → Ideas content pages (Jekyll collection)
_now/            → Now project updates (Jekyll collection, flat-file pattern) — now.html (root) is the hand-written index
_layouts/        → default.html layout only
assets/css/      → main.css (single file, four theme modes)
assets/js/       → theme.js (theme toggle logic)
assets/audio/    → audio files
_config.yml      → Jekyll configuration
index.html       → Homepage
approach/approach.html → RCT framework page
master-synthesis-prompt/master-synthesis-prompt.html → Published prompt page

## Jekyll Rules
Every content file MUST start with frontmatter — no blank lines before the first ---
Example:
---
layout: default
title: "Page Title"
permalink: /path/to/page/
---

Files in _ideas/ are processed as a Jekyll collection.
Files without frontmatter are served as static files — CSS will not apply.

## Ideas Folder Pattern

New `_ideas/` entries use the folder pattern: a named folder containing an `index.html` plus any sub-pages.
Reference implementation: `_ideas/man-with-two-brains/`
`marketing-os-foundation.html` is a legacy flat file — do not use it as a pattern for new entries.

## _skills/ Collection — Layout Note

The `_skills/` collection has no default layout set in `_config.yml`.
Every new skills entry must declare `layout:` explicitly in its frontmatter.
Omitting it will cause the page to silently fail to render as a collection page.

## CSS Architecture
Four visual modes in a single main.css file:
- Light (default): :root variables
- Dark: [data-theme="dark"] variables
- Terminal: [data-theme="terminal"] — green phosphor
- Tree: [data-theme="tree"] — amber phosphor

Always use CSS variables — never hardcode colours.
Page-level <style> blocks are permitted for layout scaffolding only (structural positioning: grid, flex, spacing). Colour and typography overrides in page-level blocks are not permitted — use CSS variables in main.css.
Key variables: --bg, --bg-secondary, --text, --text-muted, --accent, --border, --font-mono, --font-display, --font-body, --radius, --transition

## Design System
Max width: 720px via .site-wrapper
Font display: DM Serif Display
Font body: DM Sans
Font mono: Share Tech Mono
All imported via Google Fonts in main.css — never import fonts in page-level styles.

## About Page Specification

The About section has three sub-pages:
- about.html → /about/ — Overview (who Cameron is in his own framing)
- about/work-history.html → /about/work-history/ — Career timeline
- about/skills.html → /about/skills/ — Honest skill files (no progress bars)

### Work History — Chronological Data

**Current Role**
Director Marketing Advisor — University of New England (AU) · Jul 2023–Present
Oracle Eloqua Higher Education Marketing Automation specialist. Accountable for coordination of direct marketing channels for prospective students including direct mail, SMS, and supporting website assets.

**Previous Roles (reverse chronological)**

CRM, Sales And Marketing Specialist — Self Employed · Jan 2021–May 2023
Oracle Service Cloud, CRM systems, Marketing and Sales automation, marketing tech, gaming tech, gaming system admin and networks.

Senior Manager Student Engagement, Sales and Marketing Systems — University of New England · Apr 2013–Dec 2020
Carriage for strategic development of UNE's student engagement strategy. Leadership of student experience strategy. Accountable for strategy, targets, and daily operations of UNE Future Students Team and UNE Student Recruitment Team. Specialist technical direction in CRM strategies, integrated campaigns, lead scoring and conversion pipeline management.

Manager - Customer Relationship Management Systems — Charles Darwin University · Apr 2010–Mar 2013
Led implementation of enterprise CRM at CDU. Established relationship management strategies, integrated multichannel lead generation campaigns, prospective student nurturing processes, lead scoring, and consultative-selling sales strategies.
Award: Silver — 2012 ADMA Awards (Effectiveness: Business Consumer and Services Category)
Award: Winner — AMI Awards 2012 Education Category (CDU 'Next Life' brand campaign)

Manager Digital Marketing — University of Southern Queensland · 2007–Apr 2010
Framed and implemented USQ digital marketing strategy. Managed eMarketing campaigns, enterprise CRM advice, digital marketing strategy.

RUBRIC Project Business and Communications Manager — University of Southern Queensland · Jan 2006–Dec 2006
Managed business, marketing and communications for DEST-funded Regional Universities Building Research Infrastructure Collaboratively project. 5 national and 1 international university partners. Delivered the RUBRIC Toolkit — a blueprint for building institutional repositories.

Manager - Customer Relationship Management Systems (Project) — University of Southern Queensland · Jan 2006–Dec 2006
Established the CRM Centre, implemented RightNow Technologies e-Suite CRM, prototyped relationship management and digital campaign strategies.

Director of Operations — NextEd Pty Ltd · 2003–2004
Managed all Operations Division activities including 24x7 Customer Service Center, Applied Knowledge Systems, Web Publishing (Courseware Development), Materials Management, and Web Design.

IT Business Manager — INDELTA Pty Ltd · 2002–2003
Headed software engineering team developing web-based solutions. Developed the INDELTA Learning Platform (fully featured LMS).

Director of Web Publishing — NextEd Pty Ltd · 1998–2002
Led Materials Management and Courseware Development team. Produced over 2500 fully online university courses. Transitioned from manual conversion to automated and distributed authoring model.

General Manager — CAL Editorial Services · 1994–1997
Production of study guides for Social Sciences Department, School of Distance Education, Queensland Department of Education.

General Manager — Frendale Pty Ltd · 1987–1994
Restaurants and brewing.

### About Page — Voice and Tone
- Written in Cameron's own voice — direct, honest, no corporate fluff
- The career arc is the story: hospitality → early internet → CRM/marketing automation specialist
- "Last century he owned restaurants and a brewery, then fell into IT at the dawn of the internet and never looked back"
- Not a resume — a narrative with evidence
- Skills section: honest Markdown files, no progress bars or percentages

## Session Workflow
1. Read PROJECT_STATE.md (master-synthesis-prompt/master-synthesis-prompt.html is the founding document — read once on first onboarding, not every session)
2. Confirm task with Cameron before starting; also confirm with Cameron before any structural decision made mid-session
3. Create session branch: git checkout -b session-N
4. Do all work on that branch
5. When the work feels done, signal it as a draft, not a go-ahead: **"Session-X's DRAFT is ready for consideration to PR."** Wait for Cameron's response:
   - **"No" / "keep working"** → stay on the branch, keep working. Nothing is finalized, no logs are written. Re-send this same draft-ready signal the next time the work feels done — a "no" does not close this step out, it just defers it.
   - **"Ok" / "Yes"** → proceed to the Session-Close Protocol below, starting with its required "please hold" message.
6. Only after the Session-Close Protocol's final message ("Session-X finalised — ready for the PR") does Cameron create the PR. The draft-ready message in step 5 is never itself the go-ahead.

## Session-Close Protocol

Triggered only by Cameron acknowledging the draft-ready signal above (Session Workflow step 5) — never by internal judgment about "the end of a session." This replaces the previous "at the end of every session that changes the repo" trigger, which had no external forcing mechanism and let the checklist below get silently skipped under back-to-back-session pressure (see `PROJECT_STATE.md` Open Decision #52).

1. Say to Cameron: **"Please hold while I finalise the session log."** This message is mandatory and must be sent before any step below — it is what forces the following steps to actually run, rather than being silently skipped in the rush toward the next task.
2. Update `PROJECT_STATE.md`:
   - Set `Last updated` to today's date
   - Set `Updated by` to your tool name and role
   - Increment `NEXT_SESSION_LOG_ID`
   - Update page inventory if any pages were added, changed, or removed
   - Update Open Decisions if any were resolved or newly raised. For each Open Decision touched this way, first run `.\_ai-context\cascade-check.ps1 -DecisionNumber N` and review what it surfaces — a candidate flagged there may also need updating, may not; the script only surfaces, it doesn't decide. This step is mandatory whenever an Open Decision is patched or closed, not optional or memory-dependent — the exact reason it's wired into this checklist rather than left as a standalone tool (Open Decision #54)
3. Write a session log to `_session-logs/` using the format in `_ai-context/rct-session-primer.md`
   - Filename: `session-YYYY-MM-DD-NNN.md` where NNN is the ID you read from PROJECT_STATE.md *before* incrementing
4. If content was published in this session, confirm the validation checklist in `_ai-context/rct-validation-checklist.md` was run
5. Sync check: if you made changes that affect AI_INSTRUCTIONS.md or CLAUDE.md conventions, flag it to Cameron — do not let the two files drift
6. Commit `PROJECT_STATE.md` and the session log in the same commit or immediately after the content commit, then push. This goes through the normal tool-permission prompts, same as any other git action — Cameron sees it happen rather than taking it on trust.
7. Say to Cameron: **"Session-X finalised — ready for the PR."** Only this message clears Cameron to create the PR.

This lands the session log in the *same* PR as the work it describes, closing the "one PR behind" gap of the earlier Phase-2-triggered approach — Phase 2 below remains as a fallback safety net in case this sequence is itself somehow skipped, not the primary mechanism.

### Phase 2 — AI-Prod Sync and State Correction

**Triggered by Cameron pasting: `Pull request successfully merged and closed` (the GitHub merge confirmation message).** Open a new session and do both steps below — the state correction is not optional, even if you were only asked for the sync.

**Step 1 — Correct `PROJECT_STATE.md` immediately, before anything else:**

The merge that just happened is exactly the event that invalidates `PROJECT_STATE.md`'s Active Branch section, and Cameron's paste is the first reliable moment any AI session knows it occurred. Fix it now, not whenever the next session happens to start — the session-start verification ritual (§2 above) is a safety net for when this step gets missed, not the primary mechanism. Relying on it alone is what let the Active Branch staleness bug (Open Decision #19) recur.

```
git checkout main
git pull origin main
git checkout -b session-N        # N = next unused session number
```

Edit `PROJECT_STATE.md`'s Active Branch section to name `session-N`, branched from `main` at the current commit hash, noting no work has started on it yet. Commit and push `session-N`. This branch becomes the starting point for whatever the next real task is — no separate branch-creation step is needed when that task begins. Do not commit this correction directly to `main`; it follows the normal branch-and-push workflow, just triggered immediately instead of waiting for a task to justify the branch.

**Step 2 — Sync AI-Prod:**

```
robocopy "C:\Users\camer\Documents\GitHub\cameronloudon.github.io" "C:\Users\camer\Documents\AI\AI-Prod" /MIR /XD ".git" ".obsidian" "graphify-out" "sources" "wiki" ".llmwiki" /XF "opencode.json" "log.md"
```

Confirm sync to Cameron. Cowork will then verify content is visible in AI-Prod and move the file from `AI-Working/Ready/` to `AI-Working/Completed/`.

Note: The robocopy Bash permission is pre-authorised in `.claude/settings.json`. For OpenCode as Publish Agent, the robocopy step uses `permission.ask` — Cameron confirms at runtime.
