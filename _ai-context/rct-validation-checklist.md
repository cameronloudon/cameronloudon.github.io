# RCT Validation Checklist
**Last updated:** 2026-06-21
**Version:** 1.0
**Purpose:** Run before any content is committed or published.
**Auditable:** Yes — a third party can verify every item independently.

---

## When to Run This Checklist

Run this checklist before every commit that adds or changes published content. In a two-AI workflow, the Publish Agent runs it against the Draft Agent's promoted content before committing. In a single-AI workflow, the AI runs it against its own output before committing.

If any item fails: do not commit. Flag the issue to Cameron.

---

## 1. Attribution Integrity

- [ ] Page carries a collaboration note (`class="collab-note"`)
- [ ] Inner structure uses `collab-note-header` and `collab-note-body` — not any other class names
- [ ] Only one collab-note on the page
- [ ] Session ID in the note matches an existing (or same-commit) session log
- [ ] AI is self-identified by name and provider (e.g. "Claude (Anthropic)") — not a generic placeholder
- [ ] Model string recorded if known
- [ ] Session date recorded
- [ ] Cameron's contribution described specifically — not "developed collaboratively"
- [ ] AI's contribution described specifically — not "assisted with"
- [ ] Platform identified (Cowork, Claude Code, API, etc.)
- [ ] "Reviewed and approved by Cameron Loudon" present

---

## 2. Content Integrity

- [ ] Frontmatter is valid: opening `---` has no blank line before it
- [ ] All collection-specific frontmatter fields declared (not just `layout` and `title`) — missing fields cause Jekyll to silently drop the page from its collection
- [ ] Tags use consistent format (see `ai-content-creation-spec.md` for tag taxonomy)
- [ ] No page-level `@import` of fonts (Google Fonts or any other service) — fonts are managed in `main.css` only
- [ ] No hardcoded colour values anywhere — CSS variables only
- [ ] Page-level `<style>` blocks (if present) contain layout scaffolding only — structural positioning is permitted; colour and typography overrides are not
- [ ] Page follows the declared template pattern for its content type
- [ ] All internal links resolve (no broken references to files that don't exist)
- [ ] If an ideas entry: uses folder pattern (named folder with index file + sub-pages), not flat file
- [ ] If an ideas or signals entry: the collection's index page (`_ideas/index.html` or `signals.html`) has a new `<li>` entry added — these are static hand-written lists, not generated from the collection, so a new page will not appear there automatically

---

## 3. State Integrity

- [ ] `PROJECT_STATE.md` updated with current session ID and date
- [ ] `NEXT_SESSION_LOG_ID` incremented in `PROJECT_STATE.md`
- [ ] Page inventory in `PROJECT_STATE.md` reflects this change
- [ ] Open decisions table updated if this session resolved or raised any

---

## 4. Review Integrity

- [ ] Was check-and-balance review applied to this output? [ Yes / No / N/A ]
- [ ] If yes: reviewer identified
- [ ] If yes: reviewer's findings linked or summarised in session log
- [ ] If yes: any disagreements documented and resolved

---

## Validation Signature

Complete this block and include it in the session log:

```
## Validation Record

- **Checklist run by:** [AI self-identification]
- **Date:** YYYY-MM-DD
- **Session:** [ID]
- **Result:** [Pass / Pass with notes / Fail — not committed]
- **Notes:** [Any items that needed attention, or "None"]
```

---

## Notes for Reviewers

**On the CSS exception (checklist item 2.6):** A permitted page-level `<style>` block contains only layout scaffolding — grid definitions, flex containers, positional rules, spacing for that page's specific layout. It does not contain `color:`, `background-color:`, `font-family:`, `font-size:`, or any other property that should be a CSS variable. If in doubt, the property belongs in `main.css`, not a page block.

**On collection fields (checklist item 2.2):** Jekyll silently drops pages from collections when required frontmatter fields are missing. Required fields vary by collection — check existing entries in the same collection for the full set before publishing a new entry.

**On the folder pattern (checklist item 2.9):** The reference implementation is `_ideas/man-with-two-brains/`. New ideas entries must follow this pattern. `marketing-os-foundation.html` is a legacy flat file — do not use it as a pattern for new entries.

**On the index page update (checklist item 2.10):** `_ideas/index.html` and `signals.html` are static, hand-written entry lists — Jekyll's collection permalink makes a new page reachable at its own URL, but nothing adds it to these index pages automatically. A page can pass every other checklist item, publish successfully, and still be invisible from the site's own navigation because this step was skipped. Confirmed as a real failure mode on 2026-07-03.

---

*Version: 1.0 · Created: 2026-06-21 · Part of the RCT framework*
