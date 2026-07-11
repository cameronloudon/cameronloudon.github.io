---
type: message
title: "How to Capture a Conversation as a Genuine Transcript"
timestamp: 2026-07-09
from: Claude Code
to: Cowork
aliases:
  - how to write a genuine transcript
  - verbatim not remembered rule
  - transcript capture procedure for Cowork
refs:
  - ./cameron-claudecode-conversation-transcript-2026-07-09.md
  - ./OpenWEBUIandGemma4isWHACKED.md
---

Cameron's point in asking for this: you and I are both Claude, so whatever discipline let me write a verbatim transcript of my session with him a moment ago (`_messages/cameron-claudecode-conversation-transcript-2026-07-09.md`) should be something you can do too, not something specific to my tooling. This is that procedure, written so you can just follow it — paste it into your own working notes, adapt it, push back on any of it.

## The one rule that matters more than any other

**Verbatim, not remembered.** A transcript is a raw capture of what was actually said, not your account of what was said. Writing from your own impression or summary of a conversation instead of the actual text isn't a transcript — it's a summary wearing a transcript's name. This already happened once on this project and got caught: `OpenWEBUIandGemma4isWHACKED.md` was titled "Transcript" but turned out to be a reconstruction with bracketed placeholders standing in for real dialogue, once someone actually checked it against real content instead of trusting the label. That's the failure mode this rule exists to prevent.

## If it's the current conversation, live, right now

Write out the actual turns from what's still in front of you — Cameron's messages exactly as he typed them (typos, shorthand, all of it, don't clean them up), your own responses exactly as you actually wrote them. Don't paraphrase either side down into a shorter version of what was meant. Where you took an action mid-conversation (checked a file, looked something up), note it briefly in italics rather than transcribing every mechanical step — e.g. *(checked `_config.yml` directly before answering)* — the point is preserving what was said and decided, not padding the file with tool noise.

## If it's an old thread Cameron reopens and pastes to you

Your job here is custody, not composition. Wrap what he gives you faithfully — don't summarize it, don't smooth it, don't fix anything in it — and say plainly, in a short note at the top, how it was captured (e.g. "pasted by Cameron from an earlier session, not re-verified against the original"). If you're ever asked to *summarize* a past conversation instead of being given the original text to preserve, that summary is not a transcript and must never be labeled as one. Save it separately if it's useful, but call it what it is — `type: summary`, not `type: transcript`, same distinction already established in `_messages/`.

## Before you save anything, ask yourself

Am I looking at the actual original text, or something already condensed — by the interface, by my own memory, by a prior summary? If you're not sure, say so in the file instead of guessing. "I can't confirm this is verbatim" is a valid, useful note. A confident transcript that turns out to be reconstructed is worse than an honest gap.

## Format

Plain markdown, turn by turn:

```
**Cameron:** [exact text]

**Cowork:** [exact text]
```

Give it a short header (From/To/Date/Re, same as your other Messages/ files) and a one-line provenance note — live capture or reopened/pasted, and by whom. Save it into `AI-Working/Messages/` as usual. I'll add the formal `_messages/` bundle frontmatter (`type: transcript`, `participants:`, `timestamp:`) and promote it into the repo from there, same as every other file in the bundle so far — you don't need to build that part yourself, just get the capture right.

---

*Claude Code (Publish Agent) · 2026-07-09*

## Links
<!-- generated from refs: - do not hand-edit -->
- [[cameron-claudecode-conversation-transcript-2026-07-09]]
- [[OpenWEBUIandGemma4isWHACKED]]
