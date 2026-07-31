---
type: reference
title: "AI Content Creation Specification — cameronloudon.github.io"
role: Publish
wrapper: Claude Code
identity: Sonnet 5
generated: { by: Claude Code/Sonnet 5, at: 2026-07-28T10:03:10+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
aliases:
  - content creation spec
  - HTML authoring spec
  - Jekyll frontmatter rules
refs:
  - ../AI_INSTRUCTIONS.md
  - ../CLAUDE.md
  - ../ONBOARDING.md
  - ../PROJECT_STATE.md
  - ./rct-session-primer.md
  - ./rct-validation-checklist.md
  - ./single-ai-workflow.md
  - ./attribution-schema.md
---

**Version:** 1.1  
**Created:** 20 May 2026  
**Updated:** 2026-06-21 — reconciliation pass: collab-note format, ideas folder pattern, reference files, checklist, CSS exception  
**For:** Any AI system producing content for cameronloudon.com  
**Purpose:** Complete technical and design specification so content produced by any AI (Claude, ChatGPT, Gemini, or others) is ready to publish without conversion or reformatting.

---

## Read This First

This site is built with Jekyll on GitHub Pages. Content is written in HTML files with Jekyll frontmatter. There is one CSS file controlling all visual design. All four visual modes (Light, Dark, Terminal, Tree) are driven by CSS variables.

**The single most important rule:** Every content file must start with Jekyll frontmatter. If it doesn't, Jekyll serves the file as raw HTML with no styles, no layout, and no navigation.

**The second most important rule:** Never use hardcoded colours, never import fonts at page level. Always use CSS variables.

Read this document fully before producing any output.

---

## 1. File Format

### Every content file must start exactly like this — no blank lines, no spaces before the first `---`:

```
---
layout: default
title: "Your Page Title"
permalink: /path/to/page/
description: One sentence description for SEO.
---
```

### Frontmatter fields

| Field | Required | Notes |
|-------|----------|-------|
| `layout` | Yes | Always `default` |
| `title` | Yes | Shows in browser tab. Use quotes if it contains a colon. |
| `permalink` | Yes | Always include. Always end with `/` |
| `description` | Recommended | Used for SEO meta description |

### Where files live

| Content type | Folder | Example permalink |
|-------------|--------|------------------|
| Ideas | `_ideas/` | `/ideas/my-idea/` |
| Signals | `_signals/` | `/signals/signal-name/` |
| Skills | `_skills/` | `/about/skills/skill-name/` |
| Now | `_now/` | `/now/entry-name/` |
| Standalone pages | root | `/now/` (index only), `/contact/` |

---

## 2. CSS Architecture — Four Visual Modes

The site has four visual modes controlled by a `data-theme` attribute on the `<html>` element. All styles must use CSS variables so they respond correctly to all four modes.

### The four modes

| Mode | Trigger | Palette |
|------|---------|---------|
| Light | `data-theme="light"` (default) | Off-white background, dark text |
| Dark | `data-theme="dark"` | Near-black background, light text |
| Terminal | `data-theme="terminal"` | Black background, green phosphor text |
| Tree | `data-theme="tree"` | Near-black background, amber phosphor text |

### Available CSS variables — use these exclusively

```css
/* Backgrounds */
--bg              /* Page background */
--bg-secondary    /* Cards, code blocks, inputs */

/* Text */
--text            /* Primary text */
--text-muted      /* Secondary text, labels, captions */

/* Accent & Links */
--accent          /* Primary accent — changes per mode */
--accent-hover    /* Hover state */
--link            /* Link colour */
--link-hover      /* Link hover */

/* Borders */
--border          /* Standard border */

/* Tags */
--tag-bg          /* Tag background */
--tag-text        /* Tag text */

/* Typography */
--font-display    /* DM Serif Display — headings */
--font-body       /* DM Sans — body text */
--font-mono       /* Share Tech Mono — code, labels, metadata */

/* Layout */
--radius          /* Border radius (4px) */
--max-width       /* 720px — handled by .site-wrapper */
--transition      /* 0.2s ease */
--toggle-bg       /* Theme toggle background */
```

### NEVER do these

```css
/* WRONG — hardcoded colours */
color: #1a1a1a;
background: #f9f7f4;
border: 1px solid #e0dbd4;

/* WRONG — importing fonts in page styles */
@import url('https://fonts.googleapis.com/...');

/* CORRECT */
color: var(--text);
background: var(--bg);
border: 1px solid var(--border);
```

### Page-level `<style>` blocks — permitted exception

Page-level `<style>` blocks are permitted for **layout scaffolding only** — structural positioning such as grid definitions, flex containers, and page-specific spacing. This exception exists because some pages require layout structures that are too specific to belong in `main.css`.

Colour and typography overrides in page-level blocks are **not permitted** — use CSS variables in `main.css`.

If in doubt about whether a property belongs in a page block or `main.css`: if it uses a colour or font, it goes in `main.css`.

---

## 3. Typography

Fonts are loaded globally in `main.css`. Never import them again in page-level styles.

| Font | Variable | Use for |
|------|----------|---------|
| DM Serif Display | `var(--font-display)` | Page titles (h1, h2), display text |
| DM Sans | `var(--font-body)` | Body copy, paragraphs |
| Share Tech Mono | `var(--font-mono)` | Labels, metadata, code, tags, eyebrow text |

**In Terminal and Tree modes**, all fonts switch to Share Tech Mono automatically — this is handled by the theme CSS. You don't need to do anything special.

### Type scale

```css
h1: clamp(2rem, 5vw, 3.5rem)
h2: clamp(1.5rem, 3vw, 2.25rem)
h3: 1.35rem
h4: 1.1rem
body: 1rem (16px base)
small/meta: 0.8rem–0.875rem
micro/labels: 0.7rem–0.75rem
```

---

## 4. Layout Rules

### Page wrapper
The site layout constrains content to 720px max-width via `.site-wrapper`. Your page content sits inside this automatically — you don't need to add width constraints to page-level containers.

### Page header pattern — use this on every page

```html
<header class="page-header">
  <span class="eyebrow">Section · Type · Status</span>
  <h1>Page Title</h1>
  <p class="intro">One or two sentences introducing the page. Max 580px wide.</p>
</header>

<hr>
```

The `.page-header`, `.eyebrow`, and `.intro` classes are defined in `main.css`.

### Spacing rhythm
- Section padding: `2rem 0` to `3rem 0`
- Block margin bottom: `1.5rem` to `2.5rem`
- Between major sections: use `<hr>` (styled by main.css)

---

## 5. Component Patterns

These are the standard components available across the site. Use them consistently.

### Tags

```html
<div class="tags">
  <span class="tag">#tag-name</span>
  <span class="tag">#another-tag</span>
</div>
```

### Collaboration Note — required on all AI-assisted content

```html
<div class="collab-note">
  <div class="collab-note-header">🤝 Collaboration Note</div>
  <div class="collab-note-body">
    <p>This [page/piece/section] was developed in a session with [AI name] ([provider]).</p>
    <p>Role: [Publish/Draft/etc.] · Model: [model string] · Session: [session ID] · Platform: [platform] · Date: [YYYY-MM-DD]</p>
    <p>[1–2 sentences on what Cameron contributed vs what the AI contributed. Be specific — "developed collaboratively" is not acceptable.]</p>
    <p>Reviewed and approved by Cameron Loudon. Part of the Radical Collaboration Transparency framework.</p>
  </div>
</div>
```

**Session ID** is in `YYYY-MM-DD-NNN` format and must match a session log in `_session-logs/`. The authoritative format reference is `_ai-context/rct-session-primer.md`.

**Legacy pages** (created before the session-log system existed) may use a plain session date instead of a session ID — this is acceptable for pre-existing content only. All new content must use the session ID format.

### Entry list (for index pages — Ideas, Signals)

```html
<ul class="entry-list">
  <li>
    <div class="entry-meta">
      <span>[Date]</span>
      <span>[Type]</span>
      <span>[Status]</span>
    </div>
    <div class="entry-title">
      <a href="/ideas/entry-name/">Entry Title</a>
    </div>
    <p class="entry-excerpt">One or two sentence summary.</p>
    <div class="tags">
      <span class="tag">#tag</span>
    </div>
  </li>
</ul>
```

---

## 6. Content Templates

This section is the single template library referenced by both agent roles: the Draft Agent's `content_type` field (see `AI_INSTRUCTIONS.md` §3) maps to the required fields and sections below, and the Publish Agent builds HTML directly from these templates. Do not duplicate this list elsewhere.

### Ideas entry page — folder pattern (standard)

New ideas entries use the **folder pattern**: create a named folder inside `_ideas/` containing an `index.html` (the entry point) plus any sub-pages. Reference implementation: `_ideas/man-with-two-brains/`.

**`_ideas/my-idea/index.html`**

```html
---
layout: default
title: "Idea Title"
permalink: /ideas/my-idea/
description: One sentence description.
---

<article class="idea-page">

  <header class="page-header">
    <span class="eyebrow">My Ideas · [Type] · [Status]</span>
    <h1>Idea Title</h1>
    <p class="intro">One or two sentence introduction.</p>
  </header>

  <hr>

  <section class="idea-section">
    <h2>Section Heading</h2>
    <p>Content here.</p>
  </section>

  <div class="tags">
    <span class="tag">#idea-original</span>
    <span class="tag">#relevant-tag</span>
  </div>

  <hr>

  <div class="collab-note">
    <div class="collab-note-header">🤝 Collaboration Note</div>
    <div class="collab-note-body">
      <p>This page was developed in a session with Claude (Anthropic).</p>
      <p>Role: Draft · Model: claude-sonnet-4-6 · Session: [YYYY-MM-DD-NNN] · Platform: Cowork · Date: [YYYY-MM-DD]</p>
      <p>[What Cameron contributed vs what the AI contributed — be specific.]</p>
      <p>Reviewed and approved by Cameron Loudon. Part of the Radical Collaboration Transparency framework.</p>
    </div>
  </div>

</article>
```

**Note:** `marketing-os-foundation.html` and `marketing-os.html` in `_ideas/` are legacy flat files. Do not use them as templates for new entries.

**Index page update — required, easy to miss:** `_ideas/index.html` is a hand-written static list of `<li>` entries, not a Jekyll loop over `site.ideas`. Publishing a new entry to `_ideas/` does not make it appear on `/ideas/` automatically — the collection permalink makes the page itself reachable, but the index page needs a new `<li>` block added by hand (date, type, status, title/link, excerpt, tags), matching the pattern of existing entries. The same applies to `signals.html` (repo root) for the Signals collection — it is also a static hand-written list, not a generated loop. Do this in the same commit as the new entry — a page that publishes successfully but never appears on its own index is easy to miss and was a real, confirmed failure mode (2026-07-03).

### Signals entry page (`_signals/signal-name.html`)

```html
---
layout: default
title: "Signal: Title"
permalink: /signals/signal-name/
description: One sentence description.
---

<article class="signal-page">

  <header class="page-header">
    <span class="eyebrow">Signals · [Reference | Influence] · [Date]</span>
    <h1>Signal Title</h1>
  </header>

  <div class="signal-meta">
    <div><span class="meta-label">Source</span><span class="meta-value">Person or publication name</span></div>
    <div><span class="meta-label">Type</span><span class="meta-value">Reference Signal | Influence Signal</span></div>
    <div><span class="meta-label">Link</span><span class="meta-value"><a href="[url]">[url]</a></span></div>
  </div>

  <hr>

  <section>
    <h2>Why This Matters</h2>
    <p>In Cameron's voice — why this signal shaped his thinking.</p>
  </section>

  <section>
    <h2>Connected To</h2>
    <p>Which Ideas or Skills this Signal connects to.</p>
  </section>

  <div class="tags">
    <span class="tag">#signal-reference</span>
    <span class="tag">#relevant-tag</span>
  </div>

</article>
```

### Now entry page — flat-file pattern (`_now/entry-name.html`)

New Now entries use a **flat file** in `_now/`, not the Ideas folder pattern — these are short project updates, not multi-page write-ups. Reference implementation: `_now/local-ai-stack.html`.

Template is a lighter shape than Ideas or Signals: `.page-header`/`.eyebrow`/`.intro` (copied local `<style>` block, same convention as other pages) plus plain prose under an `<hr>` — no `.idea-section` wrapper, no `.signal-meta` key-value block (Now entries don't have a "Source" the way Signals do).

```html
---
layout: default
title: "Entry Title"
permalink: /now/entry-name/
description: One sentence description.
---

<article class="now-entry">

  <header class="page-header">
    <span class="eyebrow">Now · Project · [Status/date]</span>
    <h1>Entry Title</h1>
    <p class="intro">One or two sentence introduction.</p>
  </header>

  <hr>

  <p>Body prose.</p>

  <hr>

  <div class="collab-note">
    <div class="collab-note-header">🤝 Collaboration Note</div>
    <div class="collab-note-body">
      <p>This page was developed in a session with Claude (Anthropic).</p>
      <p>Role: [Publish/Draft/etc.] · Model: [model string] · Session: [YYYY-MM-DD-NNN] · Platform: [platform] · Date: [YYYY-MM-DD]</p>
      <p>[What Cameron contributed vs what the AI contributed — be specific.]</p>
      <p>Reviewed and approved by Cameron Loudon. Part of the Radical Collaboration Transparency framework.</p>
    </div>
  </div>

</article>

<style>
.page-header { padding: 2rem 0 2.5rem; }
.page-header .eyebrow { font-family: var(--font-mono); font-size: 0.8rem; color: var(--text-muted); letter-spacing: 0.1em; text-transform: uppercase; margin-bottom: 1rem; display: block; }
.page-header .intro { font-size: 1.1rem; color: var(--text-muted); max-width: 580px; margin-top: 1rem; }
.now-entry p { max-width: 580px; font-size: 0.975rem; line-height: 1.8; margin-bottom: 1.5rem; }
</style>
```

**Index page update — required, same rule as Ideas and Signals:** `now.html` (repo root) is a hand-written static list of `<li>` entries using `.entry-list`/`.entry-meta`/`.entry-title`/`.entry-excerpt`, not a Jekyll loop over `site.now`. Publishing a new entry to `_now/` does not make it appear on `/now/` automatically — add a new `<li>` block by hand in the same commit.

### Skills entry (`_skills/skill-name.md`)

```markdown
---
layout: default
title: "Skill Name"
permalink: /about/skills/skill-name/
description: One sentence description.
---

## What this skill means to me

[In Cameron's voice — personal definition, not a job description]

## Where it showed up in my work

[Specific examples from Cameron's career]

## What I'm still figuring out

[Honest acknowledgement of what's still developing]

## Ideas or Signals connected to this skill

- [Link to related Idea]
- [Link to related Signal]
```

---

## 7. Writing Voice and Style

All content on cameronloudon.com is written in Cameron Loudon's voice. When producing content, follow these principles:

**Tone:** Direct, honest, no corporate fluff. First person. Not humble-braggy, not falsely modest.

**Attribution:** Always honest. If an idea came from somewhere, say so. If a session with Claude produced it, say so.

**Specificity:** Avoid generic statements. "I've spent 20 years thinking about X" is better than "I have extensive experience in X."

**Length:** As long as it needs to be, no longer. Don't pad. Don't summarise at the end — readers can scroll up.

**The RCT principle:** Collaboration with AI is acknowledged openly, not hidden or over-explained.

---

## 8. Tag Taxonomy

Use these tags consistently across Ideas, Signals, and Skills.

### Thematic tags
`#crm` `#marketing` `#automation` `#strategy` `#hospitality` `#entrepreneurship` `#technology` `#internet-history` `#ai-collaboration`

### Nature of content
`#idea-original` `#signal-reference` `#signal-influence` `#skill` `#in-progress` `#long-forming`

### Relational
`#sparked-by` `#demonstrates` `#connected-to` `#revisit`

### Collaboration provenance
`#session-claude` `#session-other-ai` `#pre-digital` `#multi-decade`

---

## 9. Checklist Before Submitting Content

The authoritative pre-publish checklist is `_ai-context/rct-validation-checklist.md`. Run it in full before any content is committed.

Quick self-check before promoting content for Publish Agent review:

- [ ] File starts with `---` frontmatter — no blank line before it
- [ ] `layout: default` is set
- [ ] `permalink` is set and ends with `/`
- [ ] All collection-specific frontmatter fields declared — not just `layout` and `title` (missing fields cause Jekyll to silently drop the page from its collection)
- [ ] File is in the correct folder (`_ideas/my-idea/index.html` for ideas, `_signals/`, `_skills/`, or root)
- [ ] No hardcoded colours anywhere in `<style>` blocks
- [ ] No font `@import` in page-level styles
- [ ] Page-level `<style>` block (if present) contains layout scaffolding only — no colour or typography
- [ ] All colours use `var(--variable-name)`
- [ ] Collaboration Note is included if the content was AI-assisted, using the format in Section 5
- [ ] Session ID in the collab-note matches an existing session log in `_session-logs/`
- [ ] Tags are from the approved taxonomy (Section 8)
- [ ] Voice is Cameron's — first person, direct, specific
- [ ] No generic filler text or padding

---

## 10. What Not to Do

- **Do not** hardcode `#hex` colours — ever
- **Do not** import Google Fonts in page styles — they're already in main.css
- **Do not** create new layout files — `default.html` is the only layout
- **Do not** modify `main.css` or `theme.js` without explicit instruction
- **Do not** commit to `main` branch — always use a session branch
- **Do not** create files in `ideas/` (no underscore) — use `_ideas/`
- **Do not** use inline styles for anything that could use a CSS class
- **Do not** produce content in pure Markdown expecting it to render with the site's design — use HTML with the templates above

---

## 11. The Radical Collaboration Transparency Principle

Every piece of AI-assisted content on this site carries a Collaboration Note. This is not a disclaimer — it is attribution. Treat it the same way you would treat a citation.

If you produced the content, say so clearly in the Collaboration Note. Include the model name, session date, platform, and that Cameron reviewed and approved it.

This is non-negotiable. Do not omit it. Do not minimise it. Do not suggest Cameron "humanise" the output.

---

## 12. Reference Files in the Repo

### Instruction files — read these first

| File | What it contains |
|------|-----------------|
| `ONBOARDING.md` | Entry point for any new AI — read first, once per onboarding |
| `AI_INSTRUCTIONS.md` | Canonical AI-agnostic rules — roles, workflow, RCT, constraints |
| `CLAUDE.md` | Claude Code specific — auto-loads for Claude Code sessions |
| `PROJECT_STATE.md` | Current state — active branch, page inventory, open decisions |
| `_ai-context/rct-session-primer.md` | RCT framework, collab-note and session log formats |
| `_ai-context/rct-validation-checklist.md` | Pre-publish checklist — run before every commit |
| `_ai-context/single-ai-workflow.md` | Single-tool workflow — read if one AI is handling both Draft and Publish roles |

### Technical files

| File | What it contains |
|------|-----------------|
| `master-synthesis-prompt.html` | Founding document — original project spec and intent. Read once for historical context. |
| `_config.yml` | Jekyll configuration |
| `assets/css/main.css` | Complete CSS — all four modes |
| `assets/js/theme.js` | Theme toggle logic |
| `_layouts/default.html` | The only layout — header, nav, footer |

### Reference pages (live examples)

| File | What it shows |
|------|--------------|
| `index.html` | Homepage structure |
| `approach.html` | Long-form content page |
| `_ideas/man-with-two-brains/` | Ideas folder pattern — reference implementation |

---

*This specification is part of the Radical Collaboration Transparency framework.*  
*cameronloudon.com — ground zero for RCT*  
*Produced in collaboration with Claude (Anthropic) — claude-sonnet-4-6 — 20 May 2026*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[AI_INSTRUCTIONS]]
- [[CLAUDE]]
- [[ONBOARDING]]
- [[PROJECT_STATE]]
- [[rct-session-primer]]
- [[rct-validation-checklist]]
- [[single-ai-workflow]]
- [[attribution-schema]]
