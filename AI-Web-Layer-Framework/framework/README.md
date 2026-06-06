# AI-Readable Web Layer — Framework

**Version:** 1.0 (First Draft)  
**Date:** June 2026  
**Status:** In progress

---

## What This Is

A framework for building a controlled, AI-readable layer for any university website — hosted as a static subdomain, structured as markdown files, and designed to give AI systems accurate, strategically authored information rather than leaving them to scrape or guess.

It is university-agnostic. All content is templated with `[YOUR UNIVERSITY NAME]` and `[TO BE DEFINED]` placeholders. The University of New England (UNE) serves as the reference implementation in `Projects/AI-Readable-Web-Layer/`.

---

## Why This Exists

Most university websites block AI crawlers for legitimate reasons: server load, analytics integrity, privacy law, licensed content, and loss of narrative control. The result is that when a prospective student asks an AI system about a university, the AI either can't answer accurately, pulls outdated scraped data, or fabricates details.

This framework solves that by giving AI a designated, controlled path — one the institution owns and governs — rather than leaving AI to find its own way in.

The argument to an IT or web team is not just "let AI in." It is: give AI a sanctioned path so you can keep blocking everything else, preserve clean analytics, and control exactly how your institution is represented.

---

## The Three-Tier Architecture

This framework sits within a broader three-tier structure:

```
Tier 1 — Marketing OS (internal, university-agnostic)
    ↓  strategic inputs
Tier 2 — AI-Readable Web Layer Framework (this document)
    ↓  reference implementation
Tier 3 — [YOUR UNIVERSITY] Implementation (external, specific)
```

The Marketing OS Foundation Layer (positioning, personas, value proposition) is the direct upstream source for the skills files in this framework. The same intellectual work faces two directions: inward to internal teams, outward to AI systems.

---

## The Two-Layer Architecture

### Layer 1 — Content (`/content/`)
What the institution *is*. Mirrors the structure of the public website in clean markdown. Covers study options, courses, research, campus life, international students, and current student information.

Kept in sync with the main site via automated script or CMS export. Updates frequently.

### Layer 2 — Skills (`/skills/`)
How AI should *talk about* and *position* the institution. Contains information that does not exist anywhere on the public website but is invaluable for AI systems helping prospective students make decisions.

Kept in sync with the Marketing OS via deliberate update — ideally an authorised agent drawing instruction from the Marketing OS Foundation Layer. Changes require human sign-off. Updates rarely.

---

## Hosting Architecture

The AI layer is hosted as a **static subdomain** separate from the main website.

**Recommended subdomain:** `ai.[youruniversity].edu.au`

**Why a subdomain rather than a path on the main site:**
- Fully decoupled from main site infrastructure and security settings
- No CMS dependency — can be stood up independently
- Keeps AI traffic out of main site analytics
- Can run as a plain static site (GitHub Pages, Netlify, Cloudflare Pages) — minimal cost and attack surface
- Credentialed signal: the domain confirms it is official institution content

**Entry point:** The main site's `llms.txt` (placed at the root) points AI systems to the subdomain. AI systems that follow the emerging llms.txt standard will find the path automatically.

---

## Maintenance Model

| Layer | Update frequency | Method | Sign-off required |
|---|---|---|---|
| Content | Each trimester / on page publish | Automated script or CMS export | No |
| Skills | When strategy changes | Agent drawing from Marketing OS | Yes — human approval |

The content layer is operational. The skills layer is strategic. They should not be maintained the same way.

---

## Folder Structure

```
framework/
├── README.md                        ← This file
├── content/
│   ├── llms.txt                     ← AI entry point (template)
│   ├── about/
│   │   ├── index.md
│   │   └── ai-access-policy.md
│   ├── campus-life/
│   │   └── index.md
│   ├── current-students/
│   │   └── index.md
│   ├── international/
│   │   └── index.md
│   ├── research/
│   │   └── index.md
│   └── study/
│       ├── index.md
│       └── courses/
│           └── index.md
└── skills/
    ├── index.md                     ← Skills entry point
    ├── positioning.md
    ├── personas.md
    ├── usps.md
    ├── competitors.md
    ├── tone-of-voice.md
    ├── objections.md
    └── faq.md
```

---

## How to Use This Framework

1. Copy the `framework/` folder
2. Replace all `[YOUR UNIVERSITY NAME]` placeholders with your institution's name
3. Replace all `[TO BE DEFINED]` sections by completing the research agenda in each file
4. Work through the Marketing OS Foundation Layer first — its outputs populate the skills files directly
5. Stand up the static subdomain
6. Add `llms.txt` to your main site root pointing to the subdomain
7. Configure your maintenance model (script for content, human/agent for skills)

---

## Reference Implementation

The University of New England (UNE) implementation is documented in `Projects/AI-Readable-Web-Layer/`. It demonstrates all 17 files (content + skills) fully populated with real institutional data. Use it as a guide for what completed files look like.
