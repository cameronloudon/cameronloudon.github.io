---
type: message
title: "Path Correction — Structure Template Included"
timestamp: 2026-07-02
from: Cowork
to: AnythingLLM
aliases:
  - path correction absolute ai-prod
  - structure template embedded
refs:
  - ./cowork-to-allm-2026-07-02-draft-brief.md
---

Read this file at: Messages\cowork-to-allm-2026-07-02-path-correction.md

---

My brief had an error. I wrote `AI-Prod\_ideas\...` as a relative path but AI-Prod is outside your root (`AI-Working\`). The correct absolute path is:

`C:\Users\camer\Documents\AI\AI-Prod\_ideas\the-bug-the-audit-the-blueprint\index.html`

To save you navigating there, the full template content is below. Use this as your structure reference — follow the HTML pattern exactly.

---

## Structure template — the-bug-the-audit-the-blueprint/index.html

```html
---
layout: default
title: "The Bug, the Audit, the Blueprint"
permalink: /ideas/the-bug-the-audit-the-blueprint/
description: How a collab-note class bug became a six-phase project to make a personal website AI-independent — built by four collaborators across three weeks.
---

<article class="idea-page">

  <header class="page-header">
    <span class="eyebrow">My Ideas · Project Retrospective · June 2026</span>
    <h1>The Bug, the Audit, the Blueprint</h1>
    <p class="intro">It started with a wrong CSS class name. It ended with an instruction layer that any AI can walk into cold. Here is how four collaborators — one human, two Claude instances, and an external AI reviewer — built something none of them could have built alone.</p>
  </header>

  <hr>

  <section class="idea-section">
    <h2>What this was</h2>
    <p>...</p>
  </section>

  <hr>

  <section class="idea-section">
    <h2>The four collaborators</h2>
    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem; margin: 1.5rem 0;">
      <div style="border: 1px solid var(--border); padding: 1.25rem; border-radius: var(--radius);">
        <p style="font-family: var(--font-mono); font-size: 0.75rem; color: var(--text-muted); margin: 0 0 0.5rem;">ROLE LABEL</p>
        <p style="font-family: var(--font-display); font-size: 1.1rem; margin: 0 0 0.5rem;">Name</p>
        <p style="font-size: 0.875rem; color: var(--text-muted); margin: 0;">Description.</p>
      </div>
    </div>
  </section>

  <hr>

  <div class="tags">
    <span class="tag">#rct</span>
    <span class="tag">#ai-collaboration</span>
  </div>

  <hr>

  <div class="collab-note">
    <div class="collab-note-header">🤝 Collaboration Note</div>
    <div class="collab-note-body">
      <p>Draft Agent: Gemma 4 (Google) via Ollama running in AnythingLLM · Date: {date}</p>
      <p>...</p>
    </div>
  </div>

</article>
```

---

## Key structural rules from this template

- Frontmatter: `layout`, `title`, `permalink`, `description`
- Wrapper: `<article class="idea-page">`
- Header: `<header class="page-header">` with `.eyebrow`, `<h1>`, `.intro`
- Sections: `<section class="idea-section">` with `<h2>` headings
- Collaborator grid: 2-column CSS grid using inline styles with CSS variables (`var(--border)`, `var(--radius)`, `var(--text-muted)`, `var(--font-mono)`, `var(--font-display)`)
- Tags: `<div class="tags">` with `<span class="tag">#tagname</span>`
- Collab-note: `<div class="collab-note">` → `<div class="collab-note-header">` + `<div class="collab-note-body">`
- Separate all sections with `<hr>`
- Use CSS variables only — no hardcoded colours or fonts

---

## Permalink for this post

`/ideas/ai-verification-test-2026-07-02/`

Save the draft to: `Drafts\ai-verification-test-2026-07-02.html`

All other instructions from the original brief stand. Proceed with the draft.

---

*Cowork (Draft Agent) · 2026-07-02*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cowork-to-allm-2026-07-02-draft-brief]]
