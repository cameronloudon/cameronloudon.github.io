# The AI-Readable Web Layer Framework
## A Complete Overview — Including Its Relationship to the Marketing OS

*Prepared for audio production via Google NotebookLM*  
*Cameron Loudon · June 2026*

---

## Introduction

We are at an inflection point in how people find information about universities. For decades, the pathway was predictable: a prospective student visits a website, reads a page, fills in a form. That pathway is changing. Increasingly, students ask an AI system — ChatGPT, Claude, Perplexity, Google's AI Overview — and expect a direct, useful answer about which university suits their situation, what it costs, what the experience is like, and whether it is worth their time.

The universities that understand this shift will govern how they are represented in that conversation. The universities that don't will be represented however an AI system sees fit — based on whatever it can scrape, infer, or in some cases simply invent.

The AI-Readable Web Layer Framework is a response to that shift. It is a practical, implementable methodology for any university that wants to control its AI representation — not by trying to game AI systems, but by giving them something better to work with.

---

## Why Websites Block AI — And Why That Matters

To understand why this framework exists, it helps to understand why most university websites block AI crawlers in the first place.

The reasons are legitimate. Web crawlers and bots — including those used by AI systems to gather training data or answer questions in real time — create real problems for institutions. They inflate website analytics, making it impossible to distinguish genuine prospective student visits from automated traffic. An institution trying to measure campaign effectiveness or optimise its conversion funnel cannot do that if thirty to forty percent of its traffic is noise.

Beyond analytics, aggressive crawlers consume server bandwidth and processing capacity in ways that can degrade performance for real users — particularly on the tighter IT budgets typical of universities. They create exposure risk around licensed library content: universities pay significant sums for access to academic journals and databases, and allowing that content to be scraped violates licensing agreements with publishers.

There are also denial-of-service implications. A sufficiently aggressive crawler is, in practical terms, difficult to distinguish from a low-grade distributed attack. And there is the question of data privacy: student portals, health records, and academic information are protected under Australian privacy law, and any pathway that could inadvertently expose that data is a governance risk.

So IT teams block bots. Often they do it by default, using security infrastructure like Cloudflare that treats any non-browser traffic as suspicious. Many organisations don't even realise they are blocking legitimate AI access — it is a side effect of defences built for a different threat model.

The consequence is a lose-lose situation. The university loses control of its narrative at exactly the moment students are forming opinions. AI systems lose access to accurate, current information and are forced to work with whatever fragments they can find. Students receive guidance that may be outdated, incomplete, or simply wrong.

The argument this framework makes to an IT or web team is not "open the gates." It is: give AI a designated, controlled path — so you can keep blocking everything else, preserve clean analytics, protect licensed content, and control exactly how your institution is represented. This is a governance argument as much as a marketing one.

---

## The Core Concept: A Parallel AI-Readable Layer

The central idea of this framework is straightforward. Rather than trying to make a university's existing website AI-readable — which would require rebuilding it from the ground up — you build a parallel layer alongside it. A clean, structured, deliberately authored representation of the institution, designed from the start to be consumed by AI systems rather than rendered in a browser.

This parallel layer lives on a dedicated subdomain. Something like `ai.youruniversity.edu.au`. It runs as a static site — plain files, no database, no dynamic rendering, no JavaScript required. It is lightweight, fast, cheap to host, and almost impossible to attack because there is nothing to attack. The main site's entry point contains a reference — a file called `llms.txt` — that tells AI systems: if you want accurate information about this institution, go here.

The concept is directly analogous to `robots.txt`, which websites have used for decades to tell crawlers what they can and cannot access. It also connects to an emerging standard called `llms.txt`, proposed in 2024 and adopted by a growing number of websites, which provides AI systems with a structured entry point to quality content. This framework extends that concept with a full architecture: not just an index file, but a complete content and intelligence layer.

Hosting on a subdomain rather than a path within the main website is a deliberate choice with several advantages. It is fully decoupled from the main site's infrastructure and security configuration, so it can be stood up without touching the CMS, without reconfiguring existing security rules, and without involving the web development team in the day-to-day maintenance. AI traffic lands on the subdomain and nowhere else, which means main site analytics remain clean. And the domain authority of the subdomain — the fact that it lives on an official institutional domain — signals to AI systems and users alike that this is authoritative, not third-party, content.

---

## The Two-Layer Architecture

The AI-readable layer is not a single thing. It is composed of two distinct layers that serve fundamentally different purposes and operate on different timescales.

### The Content Layer

The first layer is the content layer. This is what the institution *is*. It mirrors the structure of the public website in clean markdown: study options, courses, research centres, campus life, international student information, current student guidance. It is the factual substrate — the library of accurate, current information that an AI system needs to answer basic questions reliably.

The content layer needs to stay current. Courses change every trimester. Fees are updated annually. Entry requirements shift. So this layer is maintained by automated processes — a script that runs on a schedule, or a CMS export that fires whenever a page is published on the main site. No human needs to review a change to the course fee in the content layer. It just updates.

### The Skills Layer

The second layer is the skills layer, and it is where the framework becomes genuinely distinctive.

The skills layer is not a mirror of the public website. It contains information that does not exist anywhere on the public website — information about *how* an AI system should talk about the institution, not just *what* it should say.

It includes a positioning file: how the university wants to be described, what to lead with for different audiences, which phrases build the right picture and which ones inadvertently undermine it. It includes a personas file: detailed profiles of the different types of students who might be asking questions, what each of them actually needs, and what matters to them. It includes a unique selling points file: the things the institution is genuinely best at, supported by specific evidence — not aspirational claims, but defensible facts. It includes a competitors file: an honest comparison scaffold that acknowledges where other institutions are stronger, because an AI system that only knows how to advocate for one institution is not actually helping students make good decisions. It includes a tone-of-voice guide, an objections file that addresses common hesitations with accurate, honest responses, and a frequently asked questions file that provides pre-formed answers in natural conversational language.

The skills layer transforms the AI layer from a fact sheet into an advisor. Without it, AI systems can answer factual questions accurately. With it, they can give genuinely useful guidance — acknowledging trade-offs, matching students to the right offering, handling objections honestly, and communicating in the institution's voice rather than a generic AI register.

A useful analogy: the content layer is the library. The skills layer is the librarian who knows how to use it.

The skills layer operates on a completely different timescale from the content layer. Positioning does not change every trimester. Personas do not need updating every time a course fee is revised. The strategic intelligence that the skills layer contains is slow-moving and high-stakes — it should only change when the institution's strategy changes, and any change requires deliberate human review and sign-off.

---

## The Three-Tier Architecture and the Marketing OS Connection

To understand the full significance of this framework, it needs to be understood in the context of the broader system it sits within. This is a three-tier architecture, and the AI-Readable Web Layer Framework is the middle tier.

### Tier One: The Marketing OS

The first tier is the Marketing OS — a separate but related framework built for internal university marketing teams. The Marketing OS is university-agnostic. It is a strategic operating system structured as a library of skill files that anchor all marketing execution to rigorous strategic foundations.

The Marketing OS Foundation Layer covers six domains: market definition, objectives and measurement, competitive landscape, value proposition, positioning, and brand strategy. Each domain is built as a skill file with a consistent structure — a purpose statement, substantive strategic content, fields marked for completion through research, and AI Collaborator Instructions that govern when and how an AI agent should use the file.

The Marketing OS is designed for an internal audience — for marketing teams, for strategists, for the AI tools that help them execute. It establishes the strategic operating system for how a university thinks about its market, its students, and its brand.

### Tier Two: The AI-Readable Web Layer Framework

The second tier is this framework — the AI-Readable Web Layer. It is the external expression of everything the Marketing OS defines internally.

Here is the critical insight that connects them: the Marketing OS Foundation Layer and the AI web layer's skills files are, at their core, the same intellectual work facing different directions.

The positioning work done in the Marketing OS — who the university is, who it serves, what makes it the right choice for which students — is exactly the content that needs to populate the positioning file in the AI layer's skills folder. The personas developed in the Marketing OS are exactly the personas the AI layer needs to match students to the right offering. The competitive landscape analysis in the Marketing OS is exactly what informs the honest comparison scaffolding in the competitors file.

The Marketing OS looks inward — toward the teams who run the marketing function, toward the AI tools that help execute campaigns and content. The AI web layer looks outward — toward the AI systems that prospective students use to research their options. Same substance, two directions.

This connection is not just conceptual. It has practical implications for governance and maintenance. Because the Marketing OS is the upstream source of truth for the skills layer, changes to institutional strategy flow through a defined path: they are made in the Marketing OS first, then propagated to the AI layer. An authorised agent — an AI system with write access to the skills files — can sit between them, monitoring the Marketing OS for changes and drafting updates to the skills layer accordingly. Those draft updates go to a human for review and approval before they are deployed. The external representation of the institution never changes without someone in authority signing off.

This is what distinguishes the framework from a simple template library. It is a living system with a defined governance structure and a clear upstream source of truth.

### Tier Three: The Reference Implementation

The third tier is the reference implementation — in this case, the University of New England. UNE is the worked example that demonstrates the framework in practice. Seventeen files: nine content files covering the full public site structure, seven skills files covering positioning, personas, USPs, competitors, tone, objections, and FAQ, plus the `llms.txt` entry point.

The UNE implementation was built through structured AI collaboration. It shows what the framework looks like with real institutional data — real positioning statements, real competitor comparisons, real student personas drawn from UNE's actual profile (eighty percent adult learners studying online, the majority over thirty). It demonstrates that the framework is not theoretical. It has been done.

---

## The Significance of the llms.txt Standard

It is worth pausing on the llms.txt standard, because it matters for the positioning of this work.

In 2024, a proposal circulated in the web standards community for a file called `llms.txt` — analogous to `robots.txt` and `sitemap.xml`, but designed for AI systems rather than traditional search crawlers. The idea is simple: place a file at the root of your website that tells AI systems what you want them to know, where to find quality content, and what is off-limits. A growing number of websites have adopted it. Several major documentation sites, developer tools, and commercial platforms now publish `llms.txt` files as a matter of course.

This framework sits within that emerging ecosystem. A university that implements it becomes part of a small but growing group of organisations that have moved from passive to active governance of their AI representation. In the Australian higher education context specifically, there are very few institutions — possibly none — that have done this deliberately and systematically.

Being early matters. AI systems learn from what they find. A university that publishes accurate, well-structured, strategically authored content in a format AI systems can readily consume is not just helping today's students get better answers. It is shaping the training data and retrieval patterns that will influence AI responses for years.

---

## What This Looks Like in Practice

When a prospective student asks an AI system — any AI system that respects the llms.txt standard — a question about a university that has implemented this framework, something specific happens.

Instead of the AI searching for whatever it can find about the institution, piecing together outdated press releases and scraped course pages and user reviews of uncertain provenance, it follows the `llms.txt` pointer to the AI layer subdomain. It reads the entry point, which tells it what the layer contains and how to navigate it. It reads the skills index, which tells it how to use the intelligence layer. It reads the positioning file, which tells it how to frame the institution for the specific type of student asking the question. It reads the relevant persona, which tells it what this type of student actually needs and what to emphasise. And it constructs a response that is accurate, current, strategically framed, and genuinely useful to the student — in the institution's voice, acknowledging trade-offs honestly, and referring the student to official sources for the things that change too frequently to be reliably captured in any static file.

That is not a trivial outcome. It is the difference between an AI that works against an institution's interests — through inaccuracy, through outdated information, through generic responses that fail to connect the right student to the right offering — and an AI that works with the institution toward the same goal the institution has always had: helping the right students find their way.

---

## Summary

The AI-Readable Web Layer Framework is a methodology for building a controlled, governed, strategically authored AI access layer for any university website.

It is built on a static subdomain, structured as markdown files, organised into a content layer and a skills layer, maintained through different processes that reflect the different natures of operational data and strategic intelligence.

It connects upstream to the Marketing OS, which provides the strategic substance that the skills layer expresses. It connects downstream to a reference implementation — the UNE prototype — that demonstrates the framework working with real data.

It aligns with the emerging llms.txt standard and positions any institution that implements it as a deliberate, early participant in the governance of AI-mediated higher education information.

And at its core, it is built on a simple premise: if AI systems are going to represent your institution to prospective students — and they are, whether you govern it or not — then you should have something to say about how they do it.

---

*This document was produced collaboratively by Cameron Loudon and Claude (Anthropic, claude-sonnet-4-6) in two sessions on 7 June 2026. The framework it describes, and the three-tier architecture connecting it to the Marketing OS, emerged through structured dialogue — not from a single prompt.*

*Prepared for audio production via Google NotebookLM.*
