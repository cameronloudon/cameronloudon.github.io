# Cameron Loudon — cameronloudon.github.io

## Project Overview
Personal brand website and ideas repository. Jekyll site hosted on GitHub Pages.
The complete project specification is in master-synthesis-prompt.md in this repo root.
Read that file fully before starting any session.

## Branch Workflow — CRITICAL
NEVER commit directly to main.
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
_layouts/        → default.html layout only
assets/css/      → main.css (single file, four theme modes)
assets/js/       → theme.js (theme toggle logic)
assets/audio/    → audio files
_config.yml      → Jekyll configuration
index.html       → Homepage
approach.html    → RCT framework page
master-synthesis-prompt.html → Published prompt page

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

## CSS Architecture
Four visual modes in a single main.css file:
- Light (default): :root variables
- Dark: [data-theme="dark"] variables
- Terminal: [data-theme="terminal"] — green phosphor
- Tree: [data-theme="tree"] — amber phosphor

Always use CSS variables — never hardcode colours.
Key variables: --bg, --bg-secondary, --text, --text-muted, --accent, --border, --font-mono, --font-display, --font-body, --radius, --transition

## Design System
Max width: 720px via .site-wrapper
Font display: DM Serif Display
Font body: DM Sans
Font mono: Share Tech Mono
All imported via Google Fonts in main.css — never import fonts in page-level styles.

## Session Workflow
1. Read master-synthesis-prompt.md
2. Confirm task with Cameron before starting
3. Create session branch: git checkout -b session-N
4. Do all work on that branch
5. At end of session: produce summary, commit, push branch
6. Cameron reviews on GitHub and merges to main
