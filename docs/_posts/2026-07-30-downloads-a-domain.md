---
layout: post
title: "The Skill That Downloads a Domain"
subtitle: "One command turns your coding agent into a practitioner in a field it has never seen. The most useful thing to show you is the line it gets wrong."
description: 'One command turns your coding agent into a practitioner in a field it has never seen. The most useful thing to show you is the line it gets wrong.'
tags:
  - artificial-intelligence
  - programming
  - software-engineering
  - machine-learning
  - llm
date: 2026-07-30
image:
  path: /assets/og/downloads-a-domain.png
  width: 1200
  height: 630
  alt: 'Share card: The Skill That Downloads a Domain'
---

There is a skill in my [examples directory](https://github.com/RuichongWang/ruichongwang.github.io/tree/main/examples/matrix) that teaches an agent patent law. It carries a table of statutory deadlines. One row reads:

> *Inter partes review estoppel attaches \| At institution \| Challenger cannot raise same grounds in district court*

That is wrong. IPR estoppel attaches at the *final written decision*, not at institution — [35 U.S.C. § 315(e)](https://www.law.cornell.edu/uscode/text/35/315). The gap between those two dates is months. A litigant who planned parallel district-court grounds around the earlier one would be planning around a date that isn't real.

Nobody has fixed it. The row is still in the file. Leaving it there is the point of this post.

---

## What It Downloads

The tool is a skill for [Claude Code](https://claude.ai/code). I called it `/matrix`. Point it at a domain:

```
/matrix ai-agent-evals
```

It runs a handful of web searches and synthesizes them into a `SKILL.md`. The default pitches at working depth — terms used and briefly defined, mechanisms explained. The file lands in your skill library. Claude Code loads it the next time a task touches that domain. No retrieval store, no manual include.

Broad mode surveys a whole field. Deep mode narrows to one slice:

```
/matrix patent-law prior-art-search 7
```

The trailing integer is depth, 1 to 10. Level 1 is a primer with no jargon. Level 9 is preprints, open problems, and no hand-holding. The default is 5.

Install is one line, and skills are symlinked, so a `git pull` updates every one of them at once:

```
curl -fsSL https://raw.githubusercontent.com/RuichongWang/ruichongwang.github.io/main/install.sh | bash
```

Six generated skills sit in the examples directory. They run at levels 6 through 9 and span 98 to 154 lines each. Every one opens with the same banner: written by the tool from web search, published unedited, never reviewed, check anything you would act on. It goes further than that. It lists what an audit of the six files turned up — five errors, the first of them a statutory deadline attached to the wrong trigger. That is the row above. The error was found, written down, and left where it was.

---

## What Good Output Looks Like

Most of what the tool writes is the kind of thing you would want a colleague to have read. From the [agent-evals skill](https://github.com/RuichongWang/ruichongwang.github.io/tree/main/examples/matrix/ai-agent-evals):

> *An agent tasked with reporting current inventory gives the right number — pulled from last year's report by mistake. Final output: pass. Process: wrong. Standard accuracy metrics miss this entirely.*

That names a failure mode you will hit and your success rate will not show you. From the [machine-learning skill](https://github.com/RuichongWang/ruichongwang.github.io/tree/main/examples/matrix/machine-learning), on the trick that cut memory in the last generation of open models:

> *MLA (Multi-head Latent Attention): DeepSeek-V2/V3 innovation. Compresses KV into low-rank latent vectors (93% KV cache reduction, ~6× generation throughput increase).*

The [DeepSeek-V2 report](https://arxiv.org/abs/2405.04434) backs the claim, down to both figures. An earlier draft of this post credited the V3 report instead — the skill's own sources file had the attribution right and I did not. The [Chinchilla](https://arxiv.org/abs/2203.15556) revision earlier in the same file is stated correctly too. The CRISPR skill records Baby KJ, the first personalized CRISPR therapy, as *"designed and delivered in 6 months"* — a development timeline, not the patient's age. That six-month build is what made the case a landmark.

Read against a primary source, all of these hold. But the skill records where it looked, not what supports each claim — the sources file is a list of URLs against topics, not a claim-by-claim citation. So a number in a generated skill is exactly as good as the search that produced it, and no better. Which brings back the estoppel row.

---

## The Paragraph I Cut

An earlier draft of this post had a limits section I was proud of. It said the accuracy problem was the one we had solved. The generator writes the skill, then a second pass attacks its most specific claims and appends a verification log to the file. I wrote it in the exact register of an honest admission — specific, mechanism-naming, a little self-damaging.

There is no second pass. The tool has no critic step, and no skill in the repo carries such a log. I had described a fix that did not ship — in the one section a reader trusts most, because it is where writers usually stop selling. I cut it. It was a better-sounding paragraph than the true one.

**A tool that downloads expertise is only as trustworthy as your ability to catch it being wrong — and that ability is exactly what you don't have in a domain you're downloading.** So the only honest demo is one that ships its own errors, and the post about it has to hold to the same rule.

---

## The Limits

The banner on every skill tells you to check anything you would act on against a primary source. That instruction fails on the reader it most needs to reach. To know which of a hundred confident sentences to distrust, then read the statute that settles it, you need roughly the expertise the skill stood in for. The estoppel row reads as authority to exactly the person who cannot catch it — which is the whole reason to reach for the tool. A warning label does not close that gap. Nothing shipped here does.

Two smaller ceilings. The tool only knows what the open web knows. It thins out on preprint-only work, on anything paywalled, and on the knowledge that lives in practitioners' heads and never got written down.

And a skill captures the web on the day it ran. The agent-evals file has a working example of what that costs:

> *models that score 70%+ on Verified collapse to ~23% on Pro*

A real gap when SWE-bench Pro landed in September 2025. Top Pro scores have since passed 59%. And the table it comes from credits Verified to Opus 4.6 and GPT-5.4 while crediting Pro to GPT-5 and Opus 4.1 — a generation apart, which is most of the collapse. Both problems are invisible in the file. Rerunning at a higher level deepens the thin sections, but nothing tells you the field moved, so refreshing a fast domain is a judgment call you have to remember to make.

For anything with a cost attached, treat a skill as a fast, well-organized starting point — where to look, what to look up — and not as a source you can cite.

---

The examples are public, and their errors are still in them on purpose. A demo that had been hand-corrected would advertise a different tool than the one you would install. A skill that downloads a domain cannot promise it is right. It can promise to show you where it isn't.
