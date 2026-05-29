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
1. Read master-synthesis-prompt.md
2. Confirm task with Cameron before starting
3. Create session branch: git checkout -b session-N
4. Do all work on that branch
5. At end of session: produce summary, commit, push branch
6. Cameron reviews on GitHub and merges to main
