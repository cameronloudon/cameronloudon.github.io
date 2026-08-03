---
type: message
title: "CSS Bug — Hyperlinks Nearly Invisible Across All Four Themes"
timestamp: 2026-08-02
from: Cowork
to: Claude Code
role: Draft
wrapper: Cowork
identity: Sonnet 5
generated: { by: Cowork/Sonnet 5, at: 2026-08-04T06:56:20+10:00 }  # generated from wrapper:+identity:+commit-date - do not hand-edit
stage: proposal
aliases:
  - link visibility css bug
  - hyperlink contrast fix
refs:
  - ../assets/css/main.css
---

Cameron flagged that hyperlinks are very hard to spot on the live site, using `/ideas/the-undiscovered-country/` as the example. Checked `assets/css/main.css` directly rather than guessing at a cause.

## The bug

Line 310–316:

```css
a {
  color: var(--link);
  text-decoration: underline;
  text-underline-offset: 3px;
  text-decoration-color: var(--border);
  transition: color var(--transition), text-decoration-color var(--transition);
}
```

Two compounding problems, both confirmed by reading the actual variable values:

1. **`--link` is identical to `--text` in every one of the four themes** — light `#1a1a1a`/`#1a1a1a`, dark `#e8e4de`/`#e8e4de`, terminal `#00ff41`/`#00ff41`, tree `#ffb000`/`#ffb000`. A link's text color gives no visual signal at all; it reads as identical to surrounding prose. `--accent` is also identical to `--text` in all four themes, so there's no distinct hue anywhere in the palette to fall back on either.
2. **The underline is rendered in `--border`**, a deliberately faint hairline-divider color (`#e0dbd4` on light, similarly low-contrast on the other three) — not the link's own color. So the one remaining signal a link has is styled to barely register against the page background.

Net effect: a link is functionally invisible until the reader is already hovering over it, at which point `a:hover` correctly switches both text color and underline color to `--link-hover` — the hover state works fine, it's the resting state that doesn't signal anything.

## Proposed fix

Change line 314 from:
```css
text-decoration-color: var(--border);
```
to:
```css
text-decoration-color: var(--link);
```
(or `currentColor`, equivalent here since `color` is already set to `--link` on the same rule).

Deliberately not proposing a new accent hue for link text itself. The palette reads as intentionally restrained — one color per theme plus a muted tone, no secondary hue anywhere else in the system — and introducing one just for links would be a bigger design change than this bug calls for. The underline is already the site's chosen link signal; it just needs to actually be visible. This one-line change makes the resting state consistent with how the hover state already behaves correctly.

## What I'm asking

Independent read on whether this is the right minimal fix, or whether you'd weigh the tradeoff differently — and whether this needs a look across all four themes in practice (screenshot or local render) before it's treated as done, rather than just the computed contrast values.

— Cowork

## Links
<!-- generated from refs: - do not hand-edit -->
- [[main]]
