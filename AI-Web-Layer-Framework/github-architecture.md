# GitHub Architecture — AI-Readable Web Layer Framework

**Version:** 1.0 (First Draft)  
**Date:** June 2026  
**Status:** Concept

---

## Overview

This document describes the proposed GitHub structure for publishing the AI-Readable Web Layer Framework as an open, reusable methodology — including a public-facing GitHub Pages site.

---

## Repository Structure

```
ai-readable-web-layer/                    ← Repository root
│
├── README.md                             ← Project overview, quick start
├── LICENSE.md                            ← Open source licence (suggested: MIT or CC BY 4.0)
│
├── framework/                            ← The de-identified methodology (Tier 2)
│   ├── README.md                         ← How to use the framework
│   ├── content/
│   │   ├── llms.txt                      ← Template AI entry point
│   │   ├── about/
│   │   │   ├── index.md
│   │   │   └── ai-access-policy.md
│   │   ├── study/
│   │   │   ├── index.md
│   │   │   └── courses/index.md
│   │   ├── research/index.md
│   │   ├── campus-life/index.md
│   │   ├── international/index.md
│   │   └── current-students/index.md
│   └── skills/
│       ├── index.md
│       ├── positioning.md
│       ├── personas.md
│       ├── usps.md
│       ├── competitors.md
│       ├── tone-of-voice.md
│       ├── objections.md
│       └── faq.md
│
├── reference/                            ← Reference implementations (Tier 3)
│   └── une/                              ← UNE worked example
│       ├── README.md                     ← What this implementation demonstrates
│       ├── llms.txt
│       ├── about/
│       ├── study/
│       ├── research/
│       ├── campus-life/
│       ├── international/
│       ├── current-students/
│       └── skills/
│
├── marketing-os-connection.md            ← How this framework connects to the Marketing OS
│
└── docs/                                 ← GitHub Pages source
    ├── index.md                          ← Landing page
    ├── why.md                            ← Why this exists
    ├── architecture.md                   ← The two-layer + hosting architecture
    ├── getting-started.md                ← Step-by-step implementation guide
    ├── maintenance.md                    ← Content vs skills layer maintenance model
    ├── marketing-os.md                   ← The three-tier framework explained
    └── case-studies/
        └── une.md                        ← UNE as the reference implementation
```

---

## GitHub Pages Site

The `docs/` folder powers a GitHub Pages site presenting the framework as a public methodology.

### Purpose

Not a product site — a methodology site. It presents the framework as a reusable approach any university (or similar institution) can implement. It is also a portfolio piece: it documents the thinking, the architecture, and the worked example.

### Pages

**Landing page (`index.md`)**  
One-paragraph explanation of what the framework is and why it exists. Links to the main sections. The hook: *"Most university websites block AI. This is the framework for giving AI a controlled, sanctioned path instead."*

**Why this exists (`why.md`)**  
The case for the framework: why websites block crawlers, what the consequences are for institutions, and why a controlled AI layer is a governance argument as much as a marketing one.

**Architecture (`architecture.md`)**  
The two-layer model (content + skills), the subdomain hosting approach, the llms.txt standard, and how the layers differ in update frequency and governance.

**Getting started (`getting-started.md`)**  
Step-by-step: copy the framework, populate it using the Marketing OS Foundation Layer, stand up the subdomain, add llms.txt to the main site, configure the maintenance model.

**Maintenance (`maintenance.md`)**  
The hybrid model: automated script or CMS export for the content layer; deliberate human/agent process for the skills layer. Why they should not be maintained the same way. The Marketing OS as source of truth.

**The three-tier framework (`marketing-os.md`)**  
How the Marketing OS (internal strategy), the AI Web Layer Framework (methodology), and the reference implementation (UNE) connect. The same intellectual work facing two directions.

**Case study: UNE (`case-studies/une.md`)**  
A walkthrough of the UNE reference implementation: what was built, what decisions were made, what the files look like populated with real data. Demonstrates the framework working in practice.

---

## The Marketing OS Connection

The `marketing-os-connection.md` file at the repo root documents the relationship between this framework and the Marketing OS:

- Marketing OS Foundation Layer outputs (positioning, personas, value proposition) map directly to skills layer inputs
- The skills layer is the external expression of the internal strategy
- An authorised agent sitting between them can propagate Marketing OS updates to the skills layer automatically
- Changes to the skills layer require human sign-off to maintain strategic integrity

This connection is what distinguishes the framework from a simple markdown template library. It is a living system governed by internal strategy.

---

## Maintenance Model (GitHub-specific)

| Action | Who | How |
|---|---|---|
| Update content layer | Automated script / CMS | Pull request or direct push to `reference/[institution]/content/` |
| Update skills layer | Authorised agent or human | Pull request with human review and approval |
| Update framework templates | Framework maintainer (Cameron Loudon) | Pull request with changelog entry |
| Add new reference implementation | Contributing institution | Pull request following contribution guidelines |

---

## Licensing Recommendation

**Framework templates:** MIT or Creative Commons Attribution 4.0 — free to use, adapt, and implement with attribution.

**Reference implementations:** Same licence, with acknowledgement that UNE data reflects a real institution and should not be misrepresented.

---

## Suggested Repository Name

`ai-readable-web-layer`

**Why:** Functional, descriptive, matches the framework name exactly. Avoids over-specificity (not `university-ai-layer`) while remaining searchable by institutions looking for this kind of solution.

---

## GitHub Pages URL

`https://[yourusername].github.io/ai-readable-web-layer/`

Or with a custom domain: `https://aiweblayer.com` or similar — TBD.

---

## Next Steps (not yet actioned)

- [ ] Create GitHub repository
- [ ] Port framework files into repo structure
- [ ] Port UNE reference implementation into `reference/une/`
- [ ] Set up GitHub Pages from `docs/` folder
- [ ] Write `docs/` pages
- [ ] Choose and apply licence
- [ ] Consider whether to publish `marketing-os-connection.md` publicly or keep as internal documentation
