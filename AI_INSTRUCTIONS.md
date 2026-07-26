# AI Instructions — cameronloudon.github.io
**Last updated:** 2026-07-13
**Authoritative on:** Intent and conventions. For Claude Code-specific detail, see CLAUDE.md. If they conflict, this file wins.

---

## 1. What this project is

cameronloudon.github.io is Cameron Loudon's personal brand website, built on Jekyll and hosted via GitHub Pages. It publishes original thinking, a professional profile, session logs documenting AI collaboration, and a skills collection (currently empty). Cameron works under a framework called Radical Collaboration Transparency (RCT), which requires that every page carrying AI-assisted content attributes that contribution explicitly and auditably. Cameron's long-term goal is to replace Claude with a local AI setup — this file is written so any capable AI can read it and continue the work.

---

## 2. Session-start ritual

Do this at the start of every session, before taking any action:

1. Read `ONBOARDING.md` if you haven't already (first session on this project only)
2. Read `PROJECT_STATE.md` — current branch, page inventory, open decisions, what was last done
3. **Publish Agent only** (§3's role table gives the Draft Agent "No access: repo, GitHub" — it has no way to run this check; see its alternative below): verify PROJECT_STATE.md's Active Branch claim against actual git state (`git status`, `git branch --show-current`, `git log`). The Publish Agent's job ends at push; Cameron merges afterward, in a separate action outside that session. This means the Active Branch section is only ever true for the window before merge — if the named branch has already been merged, or doesn't match the branch you're actually on, correct `PROJECT_STATE.md` before doing anything else. Do not proceed on the assumption that the file is current just because you read it. This exact gap — a branch merges, nothing updates the file, the next session inherits stale state — has recurred multiple times on this project; treat the check as mandatory, not optional. **Draft Agent:** you cannot perform this check — treat the Active Branch section as informational only, and confirm current branch/session state with Cameron directly if it matters to your task.
4. Read the relevant files in `_ai-context/` for your current task
5. Compare every canonical instruction file relevant to your role (this file, and any others — see `PROJECT_STATE.md`'s Instruction File Index) against your own tool-specific derivative file(s), also listed there. If your tool has an equivalent auto-loading instruction file, it has likely already been loaded into your context by this point — for Claude Code, this is `CLAUDE.md`. Check for a rule-level disagreement — not wording, phrasing, or formatting — and if you find one, stop and tell Cameron before taking any other action. This applies to whichever tool is filling either role, not only the tools currently doing so
6. `master-synthesis-prompt/master-synthesis-prompt.html` (published page) is the founding document — it describes the original intent of the project. Read it once for historical context when first onboarding. You do not need to read it every session; `PROJECT_STATE.md` is the current-state reference.

Do not begin work until you have read PROJECT_STATE.md and confirmed its Active Branch claim against real git state. Acting on stale state is the most common source of errors on this project.

This check is a safety net, not the primary defence — see §6's Git note for the fix that closes the gap at the source (correcting PROJECT_STATE.md at merge-confirmation time, not waiting for this check to catch it later).

---

## 3. Role definitions

This project was built with two AI tools in separate roles. Those roles are defined by file system access, not by which AI product is used.

| Role | Responsibilities | Requires |
|---|---|---|
| **Draft Agent** | Drafts structured content only — Markdown, no HTML or Jekyll frontmatter — in AI-Working/Drafts/; moves approved file to AI-Working/Ready/ and writes handoff prompt; does not write PROJECT_STATE.md | Read/write: `C:\Users\camer\Documents\AI\AI-Working\`, `C:\Users\camer\Documents\AI\AI-Evidence\` (raw-material rescue/evidence store, additive only — see Open Decision #38); Read-only: AI-Prod; No access: repo, GitHub |
| **Publish Agent** | Reads approved structured content from AI-Working/Ready/; authors all HTML and Jekyll frontmatter from it using the template library in `_ai-context/ai-content-creation-spec.md` §6; makes all repo changes; commits and pushes; runs pre-publish validation checklist; updates PROJECT_STATE.md at session close; syncs AI-Prod after merge | Read/write: repo (`C:\Users\camer\Documents\GitHub\cameronloudon.github.io`), `C:\Users\camer\Documents\AI\AI-Evidence\` (raw-material rescue/evidence store, additive only — see Open Decision #38); Read-only: AI-Working/Ready/; Write: AI-Prod (sync only, post-merge); No access: AI-Working/Drafts/, AI-Working/Completed/ |
| **Review Agent** | Independent review of plans, implementation, and output; cold-start context; no file write access | Read access to documents provided by Cameron |
| **Auditor** | Cold-context instruction fitness (the "cold walk"), drift detection, and sampled protocol-compliance checks — reports findings, never fixes anything; full brief in `_ai-context/auditor-charter.md`, kickoff text in `_ai-context/auditor-kickoff-prompt.md` | Read: AI-Prod mirror only, any document Cameron provides — no access to the live repo (see `_ai-context/auditor-charter.md` §5); Write: its own `type: audit-finding` files, to its own designated workspace only — never to `AI-Working`; No write access: repo, all of `AI-Working`, instruction files, GitHub |

**The content/HTML boundary is canonical**, not a workaround for any one model's limitations. The Draft Agent role never produces HTML, page structure, or frontmatter — it produces content (prose, headings, required fields) tagged with a `content_type`. The Publish Agent owns all structural and markup decisions, selecting the matching template from `_ai-context/ai-content-creation-spec.md` §6. This applies to every tool filling either role, not just the tools listed below.

**Current tools filling these roles:**
- Draft Agent: Cowork (Claude, Anthropic)
- Publish Agent: Claude Code (Claude, Anthropic)
- Review Agent: External AI (rotating; most recently DeepSeek)
- Auditor: charter ratified, candidate platform AnythingLLM/DeepSeek — first genuine Function A run 2026-07-19, see `PROJECT_STATE.md` Capability Baseline

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

**Citation on correction.** Any time an Open Decision's own text is corrected because it was found stale, wrong, or incomplete — not a normal status update, but a factual fix to what the entry itself claims — the patch must cite the specific evidence that revealed it: a commit hash, session log, or message file, not "checked and fixed." Same standard already applied to mechanical transcripts (provenance stamping, `_ai-context/messages-promotion-procedure.md` §4) and to the Auditor's own findings (`_ai-context/auditor-charter.md` §4, "evidence or silence") — extended here to `PROJECT_STATE.md` self-corrections specifically, since this file's own accuracy is exactly what the rest of the project trusts without re-checking. Role-generic: applies to whichever tool holds the Publish Agent role, not tied to any one tool's convention file. Added 2026-07-17, Open Decision #54.

---

## 9. When uncertain

At the start of each session, confirm your task with Cameron before beginning work.

During a session, ask Cameron before acting on structural decisions — file structure, new collections, architectural changes, anything that affects how the site is built or how AI tools interact with it. Do not make structural changes on your own judgment.

For operational questions (CSS patterns, frontmatter format, collab-note structure), the answer is in `_ai-context/`. Read it before asking.

Cameron's email: cameronloudon@gmail.com

---

## 10. Capability self-check

Any tool taking on a role for the first time — a pairing not yet reflected in `PROJECT_STATE.md`'s Tool/Model/Runtime Matrix — checks, before proceeding, whether it actually has the tools and access its role's instructions describe. If something's missing or unclear, stop and tell Cameron rather than proceed on assumption or improvisation.

A pairing with a proven track record in that Matrix can skip the heavy version — but not permanently. Re-verify periodically, reusing whatever cadence the Auditor charter settles on (`_ai-context/auditor-charter.md` §8 — monthly by default, plus Cameron's own on-demand invocation), rather than inventing a separate schedule. Proven-once can go stale: access gets revoked, a tool updates. This isn't a one-time graduation.

Not limited to session start. A capability gap can surface mid-task, partway into a specific step no earlier check would have caught. When that happens, the same rule applies: stop, disclose, ask — don't route around it silently.

This applies to whichever tool is filling any of the three roles (Draft, Publish, Auditor), not only the tools currently doing so. Added 2026-07-12, Open Decision #53, following the same role-generic reasoning as §2's instruction-sync check (Open Decision #28).

---

## 11. Session-close handshake (Publish Agent)

The Publish Agent's own "is this done" judgment is not a reliable trigger for closing out a session — the checklist can be silently skipped when it isn't tied to an action Cameron actually sees and approves. Use this exact two-message handshake instead, every time, before any PR is created. ("Session-X" below means the actual branch/session identifier in use, e.g. `session-38` — not literal text.)

1. When the work feels done, signal it as a draft, not a go-ahead: **"Session-X's DRAFT is ready for consideration to PR."**
2. Wait for Cameron's response:
   - **"No" / "keep working"** → keep working on the branch. Nothing is finalized. Re-send the same draft-ready signal the next time the work feels done — a "no" defers this step, it does not close it out.
   - **"Ok" / "Yes"** → proceed to step 3.
3. Say: **"Please hold while I finalise the session log."** Mandatory, sent before doing anything below — this is what forces the following steps to actually happen, rather than being silently skipped in the rush toward the next task.
4. Run the session-close checklist in full: update `PROJECT_STATE.md`, write the session log, confirm validation if content was published, flag any instruction-file drift, and — for any Open Decision being patched or closed in this pass — first run `.\_ai-context\cascade-check.ps1 -DecisionNumber N` and review what it surfaces before editing (mandatory whenever an Open Decision is touched, not optional; see `CLAUDE.md`'s Session-Close Protocol for full operational detail). Commit and push — this goes through the same tool-permission prompts as any other git action, so Cameron sees it happen rather than taking it on trust. (Corrected 2026-07-24: this step previously cited "§5 above" for the checklist — §5 is the RCT framework section, not a session-close checklist, and the cascade-check requirement was missing entirely. Found as Function A's Finding 6, independently confirmed against this file and `CLAUDE.md` directly during the 2026-07-19 run's write-up — Open Decision #28's predicted highest-risk drift, materialized for real.)
5. Say: **"Session-X finalised — ready for the PR."** Only this message clears Cameron to create the PR. The draft-ready message in step 1 is never itself the go-ahead.

This closes a specific failure mode: the session-close checklist had no external trigger of its own and could be silently dropped under back-to-back-session pressure (`PROJECT_STATE.md` Open Decision #52). Tying it to a message Cameron must acknowledge — rather than to the Publish Agent's own sense of "the session is over" — makes the checklist part of an action that already reliably happens, instead of a separate step that can quietly not happen. It also lands the session log in the *same* PR as the work it describes, closing the "one PR behind" gap of the earlier Phase-2-triggered proposal.

Scoped to the Publish Agent specifically, not both roles — this handshake is about the moment before a PR is created, which has no direct Draft Agent equivalent. Ratified 2026-07-13 with Cowork's independent review (`AI-Working/Messages/cowork-to-ccode-2026-07-13-session-close-handshake-response.md`); she is separately adding her own read-only, mechanically-triggered check to `cowork-conventions.md`/`draft-agent-config.md` as a genuinely independent second observer, not a copy of this mechanism.
