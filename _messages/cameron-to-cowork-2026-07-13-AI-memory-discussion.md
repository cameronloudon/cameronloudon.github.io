---
type: reference
title: "Codacus — 'understory,' a Self-Wiring OKF Memory Layer for Local AI (YouTube Transcript)"
timestamp: 2026-07-13
from: Cameron
to: Cowork
aliases:
  - AI memory discussion
  - understory video transcript
  - Codacus OKF Karpathy LLM-wiki local memory
refs: []
---

Codacus YouTube Channel (https://www.youtube.com/@Codacus) is about running real AI on hardware you already own

I gave every local AI I run ONE shared, permanent memory — teach something to one agent, and every other agent already knows it. No vector database, no cloud API, no re-embedding. Just a folder of markdown files, a "librarian" agent, and MCP.

It's built on Andrej Karpathy's LLM-wiki idea and Google's OKF (Open Knowledge Format) spec, and the whole loop runs on my own box: the harness, the memory, AND the model (same llama.cpp server everything else uses).

In this video I build understory, a drop-in memory layer for ANY local AI setup. AnythingLLM, llama.cpp web UI, coding agents, anything that speaks MCP, and I show you exactly what broke along the way: the cold-start problem (the AI never thought to check its own memory), the junk-drawer problem (every fact became an orphan file), and how a deterministic harness makes it all work on a small local model. Deterministic rules, the LLM only for decisions.

🌱 understory (free & open source): https://github.com/thecodacus/understory

0:00So, you've set up your local AI. It's running without a sweat. You even got an always on rig you can hit from a coffee shop. But every time you start a new
0:077 secondssession, you're feeding all your important context back to it again and again. So, you think, fine, let me add a
0:1515 secondsmemory system. But most of them either eat too many resources or they're hosted in the cloud or your local model just isn't sharp enough to call the right
0:2323 secondstool at the right moment. And no, rag is not the answer here either. I'll get to why later. Here's the real problem. Most
0:3232 secondsof these systems are built for frontier models, the ones that can handle tools even with halfbaked instructions. Andre
0:3939 secondsKarpati shared his LLM wiki idea and Google standardized something similar with OKF. But asking a regular local
0:4646 secondsmodel to follow that spec to the letter while also doing the actual job you gave it, that's a huge ask. You're diluting
0:5454 secondsits intelligence across too many things at once. So I tried to shift the memory burden off the AI and onto the tool
1:021 minute, 2 secondsitself. One dead simple tool built on Karpathi's LLM wiki and Google's OKF.
1:081 minute, 8 secondsAnd spoiler alert, it did not go as smoothly as I thought. So did it work?
1:141 minute, 14 secondsWhat broke when I ran it on my own local setup? And can this really become the permanent memory for a local AI stack?
1:211 minute, 21 secondsLet's find out.
1:251 minute, 25 secondsOkay, so before we move any further, let's talk about why not just use rag.
1:311 minute, 31 secondsRag is good and efficient when you've got a knowledge base that's almost fixed, GBs or TBs of data that barely
1:391 minute, 39 secondschanges and you want fast answers. But look at how it works. It uses semantic indexing to do similarity matching. The
1:481 minute, 48 secondsintelligence of the LLM is never used during retrieval. It's just vector matching and that's the trade-off you
1:551 minute, 55 secondstake to get fast retrieval out of huge data. But a textbased LLM wiki is different. It's like actual memory. It
2:042 minutes, 4 secondsneeds careful retrieval with linked memories and precise refinement leveraging the intelligence of the AI.
2:122 minutes, 12 secondsIt reads one file and from there it reads another and then another to precisely find the exact thing we need
2:212 minutes, 21 secondsout of our memory. And we are not storing GBs of data here. We are storing personal context, the things the AI
2:292 minutes, 29 secondsdecides are important to remember for the future. And since that's constantly evolving and updating, we don't want to
2:372 minutes, 37 secondsbe rerunning, chunking, and embedding every single time the AI updates something. If you've ever used a coding
2:452 minutes, 45 secondsagent, you already know this works. Your coding agent browses the files to find exactly where a piece of code lives and
2:552 minutes, 55 secondshow it links to the rest of the codebase just by reading and following the breadcrumbs like a detective.
3:043 minutes, 4 secondsMy first attempt was the obvious one, a skill file. It embeds the OKF spec plus instructions telling the AI where the
3:123 minutes, 12 secondsroot of the memory folder is. And it didn't really work. I mean, it kind of worked, but a lot of the time the AI
3:193 minutes, 19 secondswouldn't use the root path. It would create the folder in the wrong place instead, and it would forget to update the index after creating a new file. It
3:283 minutes, 28 secondswas a mess. The concept works fine when you've got a clawed opus level model or higher, but a local LLM struggles to
3:353 minutes, 35 secondsfollow instructions with that kind of precision. So, does that mean it's over?
3:403 minutes, 40 secondsThat a local LLM just isn't good enough for this kind of job? Well, not really.
3:453 minutes, 45 secondsWe just need to get a little more creative to make it work.
3:503 minutes, 50 secondsSo, I needed a way to make this actually work. And there are a few ways to magnify an AI's capability using sub
3:583 minutes, 58 secondsaents and harnesses. Because here's the thing, why burden your AI with all these extra instructions when it already has
4:054 minutes, 5 secondsits own actual problems to solve. We've already solved this in real life. We store human knowledge and history in
4:134 minutes, 13 secondslibraries. And every library has, you guessed it, a librarian. And it's the librarian's job to take care of the
4:214 minutes, 21 secondsbooks, organize them, keep them maintained. If I want to know something, I just ask the librarian and he goes and
4:284 minutes, 28 secondsfinds it for me. I have no idea how the library is organized, what index it uses, what registry, anything at all.
4:354 minutes, 35 secondsAnd that's exactly what we are going to use here. So the setup is simple. a library to store the memories and knowledge and a librarian agent that
4:444 minutes, 44 secondstakes a query goes and finds it in the library and hands you the answer and when new or updated knowledge comes in
4:524 minutes, 52 secondsthe librarian organizes it the best way it can so it can be found on the next query now in technical terms that means
4:594 minutes, 59 secondsa carefully organized memory indexed at every level with an index MD laid out so it's intuitive for the LLM to traverse
5:085 minutes, 8 secondswith links between the memory files. So when it's searching, it can refer to the right sections. And the system is deterministic. The rules are fixed and
5:175 minutes, 17 secondsit only uses the LLM when it actually needs to make a decision. That way we never drift away from the spec.
5:265 minutes, 26 secondsSo I built the whole system and I added a web UI so I could actually talk to the librarian agent directly and I chatted with it for a while watching the memory
5:355 minutes, 35 secondsgrow on the side as we talked. I also added a graph visualizer that shows all the memories and how they link to each
5:425 minutes, 42 secondsother. And here's the fun part. It also records the traces of every query the agent runs to find an answer. It's a
5:505 minutes, 50 secondsneat way to actually see how the agent is finding things because if it's easy to visualize, it's easy to debug.
5:595 minutes, 59 secondsOkay, but now I need my other AI systems to plug into this and use it as their memory layer. And that comes down to a
6:076 minutes, 7 secondshandful of MCP tools. Query here. The librarian only has read tools. Any of my local systems that needs to look
6:156 minutes, 15 secondssomething up just asks the librarian and the librarian finds it and answers.
6:206 minutes, 20 secondsUpdate memory. Now the librarian gets read and edit. If the AI finds a memory that's outdated, it just asks the librarian to update it. And add memory.
6:316 minutes, 31 secondsRead, edit, and write. If the AI runs into something worth keeping, it calls add memory and the librarian either adds
6:396 minutes, 39 secondsit to an existing file or creates a new one for it. And because the librarian handles all of this itself, I never have
6:476 minutes, 47 secondsto bloat my actual agents context with the OKF spec or a pile of memory instructions. And one more thing, the
6:546 minutes, 54 secondslibrarian is an agent itself, so it needs a brain of its own, right? Well, it just connects to the same llama.cb CBB server that everything else in my
7:037 minutes, 3 secondsstack is already using. It even autodiscovers whatever model is currently loaded. It works behind llama swap 2 and it prefers the loaded model.
7:127 minutes, 12 secondsSo a memory query never triggers a model swap. So think about it. The harness, the memory and the model, the whole
7:207 minutes, 20 secondsloop, everything is running on my own box. There's no cloud API hiding anywhere in the chain. This thing is
7:287 minutes, 28 secondstruly local. Real quick before we get into the challenges, if you're into building local AI, this channel is for you. I figure this stuff out in the open
7:367 minutes, 36 secondsso you don't have to subscribe and let's take back control together. Okay, back to it.
7:447 minutes, 44 secondsSo on paper it was done. Then I plugged the real model into it over MCP and that's exactly where it fell apart. It had a kind of amnesia it didn't even
7:527 minutes, 52 secondsknow it had. All the client model could see was the tool names. Query, add, update, status. That's it. So when you
8:008 minutesasked it something, it just answered from its own head. It never thought to check the memory first because it had no idea the memory even had anything useful
8:098 minutes, 9 secondsin it. The knowledge was sitting right there on disk, but the model couldn't see it. So it never looked. And here's the ironic part. The internal agent was
8:188 minutes, 18 secondstotally fine. We'd been feeding it an overview of the knowledge base in its system prompt the whole time. It was the client model out on the other end of the
8:278 minutes, 27 secondswire that was flying blind. So the fix was to give it a reason to look first.
8:338 minutes, 33 secondsThe moment a session connects, we generate a seed memory, a small live summary of what's actually in the knowledge base and we push it through
8:418 minutes, 41 secondsthe two channels that reach the client model at startup. The MCP instructions field and the description of the query
8:488 minutes, 48 secondstool. Now the model opens every session already knowing okay there's a segment about billing one about people one about
8:558 minutes, 55 secondsinfrastructure and that's enough. It stops guessing and starts querying. We tightened it even more later. Instead of
9:039 minutes, 3 secondslisting file names the seed lists what each concept is about because your question is way more likely to run into
9:109 minutes, 10 secondsa 100 requests per minute per client than into a file called rate limits.md.
9:189 minutes, 18 secondsOnce it was reliably writing to memory, a subtler problem showed up. It treated memory like a junk drawer. Every new
9:259 minutes, 25 secondsfact became its own file. I tell it I live in Hyderabad and it would create a standalone Hyderabad MD just floating
9:339 minutes, 33 secondsthere disconnected from the concept about me that already existed. So the memory kept growing but none of it was
9:409 minutes, 40 secondsconnected. It was a pile of nodes not actual knowledge. A person taking notes would never do that. they just add lives in Hyderabad to your existing profile.
9:519 minutes, 51 secondsSo I gave it two rules. First, enrich before you create. Before writing anything, search for the concept this
9:589 minutes, 58 secondsfact belongs to. If it's just an attribute of something that already exists, patch it into that. Don't spawn
10:0410 minutes, 4 secondsa new file. Second, link both ways. when it genuinely is a new thing, say a YouTube channel called Kodakus, create
10:1310 minutes, 13 secondsthat concept, but then go back and patch the related ones too. So now my profile says runs the Kodakus channel and the channel says created by Anurban.
10:2410 minutes, 24 secondsNow one honest note on the model. I first tried this with Gemma the 12B. On the mechanical side, it was fine, but it
10:3210 minutes, 32 secondsjust wasn't strong enough on the agentic side. the actual decisions about how to organize the memory, what to enrich,
10:3910 minutes, 39 secondswhat to link. It kept getting those wrong. So, I went back to my trusty Quen 3.6, the 35B A3B. It never fails me. And
10:4910 minutes, 49 secondsI watched that model running on a single consumer GPU do exactly this on its own.
10:5510 minutes, 55 secondsEnrich the small fax, wire up the big ones. No handholding. By now, the memory was behaving itself.
11:0311 minutes, 3 secondsBut I had a feeling I was reinventing a wheel someone smarter had already drawn.
11:0811 minutes, 8 secondsSo I went back to what Karpati actually laid out in his LLM wiki idea. And there were a few things I was still missing.
11:1611 minutes, 16 secondsFirst graph health. I added a lint step completely deterministic that walks all the links between concepts and flags two
11:2411 minutes, 24 secondsthings. Orphans concepts nothing links to and broken links that point nowhere.
11:3011 minutes, 30 secondsOne catch that really mattered. The autogenerated index files had to be excluded as link sources otherwise
11:3811 minutes, 38 secondseverything looks connected and orphan detection is useless. Then a maintain tool that acts on that.
11:4511 minutes, 45 secondsThe lint finds the orphans and an internal agent wires them back into the concepts they relate to both directions.
11:5311 minutes, 53 secondsI ran it on my local Quen. It found an orphan playbook and patched both related concepts to point at it. Orphans went
12:0112 minutes, 1 secondfrom one to zero on its own. And the last one contradictions. If I told it I moved from Hyderabad to Bangalore, the
12:1012 minutes, 10 secondsold version would just append Bangalore and leave Hyderabad sitting in the file. So now the concept claims both cities.
12:1812 minutes, 18 secondsThe fix was to make the rule mechanical. The old fat has to be gone everywhere. Rewrite the whole thing if you have to.
12:2712 minutes, 27 secondsAfter that, it cleanly said Bangalore and only Bangalore.
12:3412 minutes, 34 secondsAnd here's the part that actually made it really amazing. Because it's all going through the MCP layer, every AI agent I use can share the same memory.
12:4312 minutes, 43 secondsSo whichever tool I'm in, it already knows what happened in the other one.
12:4712 minutes, 47 secondsIt's fully personalized. It knows what's going on in my system, what tool I prefer, what the IP of my local box is without me reminding it every session.
12:5812 minutes, 58 secondsSo, did it work? Yeah, it became the memory of my AI. It's the thing I use now every day. Every tool I open already
13:0713 minutes, 7 secondsknows my projects, my context, what I've been working on. I don't reintroduce myself anymore. But I'll be honest with
13:1413 minutes, 14 secondsyou, this isn't finished. And that's actually my favorite part. It's a living thing and I'm going to keep building on
13:2113 minutes, 21 secondsit long after this video goes up. Like the next thing I'm adding is a cache layer, a hot tier of your most recent
13:2913 minutes, 29 secondsmemories that the agent always keeps close so it never has to go digging through the whole library just to remember what happened 5 minutes ago.
13:3813 minutes, 38 secondsRecent stuff instantly there. And after that, this is the one I'm actually excited about. A dreaming feature. At
13:4613 minutes, 46 secondscertain points in the day when it's idle, the memory goes off on its own and reorganizes itself, cleans things up,
13:5313 minutes, 53 secondslinks what should be linked. The way your brain consolidates everything while you sleep. So, it's not just storing
14:0014 minuteswhat you tell it. It's getting better at remembering while you're not even using it. And there's more after that because
14:0714 minutes, 7 secondshere's what I keep coming back to. A model on your own machine is already great. Private yours. Nothing leaves the
14:1514 minutes, 15 secondsbox. But without memory, it's still a stranger. The moment you give it a memory that follows you around, one that
14:2314 minutes, 23 secondslives on your disk as plain markdown you can open and read yourself, it stops being a generic chatbot and starts being
14:3114 minutes, 31 secondsyour personal AI, one that knows you across different harnesses. And that's what personal AI was always supposed to
14:4014 minutes, 40 secondsmean. Running it locally is only half of it. The other half is owning what it knows about you. We took back the model,
14:4814 minutes, 48 secondsthe hardware, the privacy. Memory is the next thing to take back and now it's just sitting there in your control. The
14:5614 minutes, 56 secondswhole project's open, built on Karpathi's LLM Viki and Google's OKF spec, links in the description. Clone
15:0315 minutes, 3 secondsit, plug it into your own setup, give your local AI a memory, and keep an eye on it because it's only going to get
15:1115 minutes, 11 secondsbetter. If you build something on top of it or there's something you want to see in it, tell me in the comments.

Sync to video time
