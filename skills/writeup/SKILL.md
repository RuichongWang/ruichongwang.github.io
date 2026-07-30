---
name: writeup
description: |
  Write, adapt, revise, and voice-check posts about the user's OWN finished
  work — blog post, 长文, X thread, 小红书 / 即刻 / 公众号 / 知乎, Medium,
  dev.to, LinkedIn, Hacker News, Reddit, launch note, 复盘 / postmortem.
  Drafts from the project's history, not from its finished state.

  Requires something concrete to read: a repo, a diff, a session, or a draft
  the user pastes. With no artifact of the user's own work in reach, this is
  the wrong skill.

  Triggers:
    /writeup 把这个写成博客 · 改成 X thread · 发到 LinkedIn · 搬到知乎
    /writeup 润色一下 · 改短点 · 第二段重写
    /writeup 像不像我写的 · 这读起来太 AI 了
    "write a post about what I built" · "turn this into a thread"
    "write up what I learned building this" · 复盘 · 踩的坑

  NOT for: explaining a topic the user wants to learn about (that is the
  matrix skill), READMEs and documentation, travel or personal anecdotes with
  no build behind them, or ghostwriting in another person's voice.

allowed-tools:
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - WebSearch
  - WebFetch
  - Bash(git log:*)
  - Bash(git diff:*)
  - Bash(git show:*)
---

# Writeup

Four modes: **draft** (work → post), **adapt** (post → platform), **revise**
(post → better post), **check** (does this sound like them?).

---

## Step 0 — the gate

**Is there a concrete artifact of the user's own work you can read?** A repo
with history, a diff, a session transcript, a directory of files they built, or
a draft they pasted.

If not, stop and say so in one line: this skill writes about work that exists,
and there's nothing to read from. Offer the alternative — `matrix` for learning
a domain, or just answering the question directly.

**Do not load the references before this gate passes.** A request like "写一篇
关于 CRISPR 的博客" carries no evidence either way; ask which project it's about
rather than spelunking for a history that isn't there.

---

## Read the voice file first

`references/voice.md` is the point of this skill. Everything else is
scaffolding. Read it before writing a sentence — including its
"What this file can't tell you" section, which names which rules are reliable
and which are guesses from a thin sample.

**Never claim voice fidelity you can't back.** Outside what voice.md has
evidence for, say so in one line and write plainly.

**Chinese has no voice evidence at all.** Every rule in voice.md comes from
English long form. Applied to 小红书 / 即刻 / 公众号 / 知乎 they produce
translation-ese and the author will hear it immediately. Write plain idiomatic
Chinese, say the voice file doesn't cover it, and offer to build a Chinese
sample set.

---

## Where drafts go

Prefer an existing `writing/` directory in the current repo. Failing that, put
the draft beside the work it's about. Never create a stray `writing/` in an
unrelated project without saying so — this skill is installed globally and
triggers everywhere.

**Generated drafts are not voice corpus.** voice.md is derived from files in
`writing/`, and drafts land in the same place. Re-deriving voice from a
directory containing this skill's own output trains it on itself and quietly
destroys the only asset here. Put `generated: true` in a draft's frontmatter,
and never treat a file carrying it as a voice sample — only pieces the user
actually wrote or edited count.

---

## Mode: draft

**1. Material before artifact.** Follow `references/material.md`. Read the
history — commit message bodies, diffs, deletions, the conversation that
produced the work — *before* reading the finished files. The finished version is
the corrected version; everything interesting was edited out of it. Read the
final artifact last, and only to check accuracy.

**2. Find the claim.** One sentence, arguing one thing. If it takes two, there
are two posts — say so and pick one.

**3. Draft it.** Long form by default: 1,200–1,800 words, the length the voice
rules are calibrated at. Structure: the claim, the evidence, the limits, the
close. Evidence is quoted verbatim, never characterized.

Produce a title and a subtitle. Declarative, no question mark. The subtitle is a
second headline that makes its own argument, not a description.

**4. Decide what the reader sees.** Read `references/visuals.md`. Two questions,
and usually both answers are no: is any of this evidence two-dimensional
(a table), and is any claim about sequence or timing (a figure)? Zero is a valid
answer and the corpus default — never add one to break up the page.

**5. Link the claims.** Search out a source for load-bearing factual claims and
link them inline. This is a documented property of the author's finished drafts
— the revision in the corpus went from 1 link to 12 — and it is the step most
easily skipped.

**Lead your reply with the claim, then give the draft.** Don't stop for approval
— a wrong claim costs one message to reject, a blocked draft costs a round trip.

**6. Run check mode on your own draft** before showing it. Fix what you find;
don't report it.

---

## Mode: adapt

A source draft plus a target platform. Read `references/platforms.md`.

The claim and the sharpest evidence carry over. **The opening never does** —
rewrite it every time. A reused opening is the clearest possible tell that
something was cross-published.

Say what you cut. If the limits didn't survive compression, keep one clause of
honest qualification rather than dropping them silently.

---

## Mode: revise

The user has a draft and wants it changed — shorter, sharper, one section
rewritten, a different angle.

Do exactly what was asked first. Then, if the draft is the user's own and they
haven't constrained the edit, apply the documented edit direction from
`voice.md` — cut the author out, cut the gimmick out, shorten every sentence and
every heading, link every claim, answer the objection you previously only
admitted.

Show what changed. Don't silently rewrite paragraphs the user didn't ask about.

---

## Mode: check

Read `references/voice.md` and the material tests in `references/material.md`,
then go through the draft line by line.

| Line | Breaks | Instead |
|------|--------|---------|
| "This powerful, seamless tool…" | 1.7 — no hype vocabulary | "It does X." |
| "- three bullet points" | 1.1 — no bullet lists | fold into a rule-of-three clause |
| a one-column table | 1.1 — a list wearing a hat | fold it in, or find a second axis |
| a figure the prose doesn't react to | 2.6 — exhibits get a verdict | add the line, or cut the figure |

**Respect the tiers.** A Tier 1 violation is a defect. A Tier 2 deviation is a
question, not a finding — report it as "deviates from 2.8, deliberate?" A Tier 3
absence is never a finding at all.

**Branch on the format.** The rubric above is for long form. On an adapted short
piece, a missing limits *section* is correct — `platforms.md` puts it in the
Dies column — and only the absence of any qualifying clause is a defect.

Report only what's actually wrong. A check that always finds ten things is a
check nobody runs twice.

---

## Before showing any draft

- [ ] One claim, stated in one sentence, arguable
- [ ] No paragraph could have been written from the finished repo alone
- [ ] Evidence quoted verbatim, with real numbers
- [ ] Load-bearing factual claims linked
- [ ] Limits honest, and not buried at the bottom
- [ ] Every table two-dimensional, every figure something the reader can check
- [ ] Nothing drawn from a session transcript names a third party, a credential,
      or another project — this skill publishes what it reads
- [ ] The opening could not open a post about a different project
- [ ] Title and subtitle present, declarative
- [ ] Ran check mode against `voice.md`

---

## References

| File | Contents |
|------|----------|
| `references/voice.md` | The author's voice as tiered, checkable rules — with evidence and known gaps |
| `references/material.md` | How to find the story in the history instead of the artifact |
| `references/platforms.md` | Per-platform structure, and what survives compression |
| `references/visuals.md` | When a table or a figure is evidence rather than decoration, and how to build one |
