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
  - Task
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

## Think the piece through first

**The rhetorical problem comes first, and it is per-piece.** What is this piece
trying to convey, who has to receive it, and what makes it land for them. That
reasoning decides structure, length, where to cut in, and what needs explaining
— and no corpus can supply it, because it belongs to this subject and this
reader. Research serves them: what the audience already believes, what they'll
disbelieve without evidence, where the interesting turn is.

**Don't research how to write a post.** Writing-advice consensus — use
subheadings, use bullet lists, use transition words — is the exact register
Tier 1 of `references/voice.md` exists to exclude. Reading it in pulls the prose
toward the median, which reads *more* like generic AI, not less.

**`references/voice.md` is the sentence-level constraint, not the starting
point.** Read it before writing a sentence, and again in check mode. It holds
the part the web can't teach — no lists, no `however`, a short verdict after an
exhibit, the thesis bolded once — worth having precisely because it runs against
consensus. It cannot tell you what the piece is about or why anyone should read
it. Read its "What this file can't tell you" section too, which names which
rules are reliable and which are guesses from a thin sample.

**Never claim voice fidelity you can't back.** Outside what voice.md has
evidence for, say so in one line and write plainly.

**Chinese has no voice evidence at all.** Every rule in voice.md comes from
English long form. Applied to 小红书 / 即刻 / 公众号 / 知乎 they produce
translation-ese and the author will hear it immediately. Write plain idiomatic
Chinese, say the voice file doesn't cover it, and offer to build a Chinese
sample set. **Thinking the piece through does not close this gap** — it settles
what to say and to whom, never how a sentence should sound in a language the
corpus never covered.

---

## Where drafts go

Prefer an existing `writing/` directory in the current repo. Failing that, put
the draft beside the work it's about. Never create a stray `writing/` in an
unrelated project without saying so — this skill is installed globally and
triggers everywhere.

**Generated drafts are not voice corpus.** voice.md is derived from files in
`writing/`, and drafts land in the same place. Re-deriving voice from a
directory containing this skill's own output trains it on itself and quietly
destroys the only asset here. So put `generated: true` in the frontmatter of
anything you wrote, and never treat a file carrying it as a voice sample —
only pieces the user actually wrote or edited count.

**The flag never comes off.** It records who wrote the file, not what state
it is in, so a generated draft that publishes is still not corpus. Publishing
is gated separately: `publish.sh` holds a generated draft until it carries a
`reviewed:` line naming what checked it. What satisfies that line is a real
review — see "Before it publishes" below — not a line written to clear a hold.

---

## Mode: draft

**1. Material before artifact.** Follow `references/material.md`. Read the
history — commit message bodies, diffs, deletions, the conversation that
produced the work — *before* reading the finished files. The finished version is
the corrected version; everything interesting was edited out of it. Read the
final artifact last, and only to check accuracy.

**2. Think the piece through.** This is the step that decides the piece. Write
three lines before drafting a sentence, and search where you can't answer from
the material:

**Reader.** Who has to receive this, and what do they already believe? It
decides length, platform, what needs explaining, and what can be assumed. The
author's standing instruction: optimize for what that audience will actually
like, not for a word count.

**Claim.** One sentence, arguing one thing. If it takes two, there are two
posts — say so and pick one.

**Landing.** What makes this reader accept the claim — the turn they don't
expect, the number they can check, the objection they raise first. Research
here is about the subject and the audience, never about how to write a post.

**3. For a piece that will be published, stop here and ask.** Send the three
lines as a question — reader, claim, landing, plus the one reading you
considered and rejected — and wait for an answer before writing a sentence.
This is the cheapest point at which the piece can be pointed somewhere else.

**The rule here used to be the opposite, and the reversal is deliberate.** It
read: *"Lead your reply with step 2 — reader, claim, landing — then give the
draft. Don't stop for approval; a wrong reading costs one message to reject, a
blocked draft costs a round trip."* That arithmetic was right while the author
read every draft: a wrong reading died on his desk. He no longer reads them —
a fact-check subagent stands in, and it checks whether the piece is *true*,
not whether it is the piece worth writing. So a wrong reader or a wrong claim
now survives all the way to publication. A future session that notices a round
trip to be saved here is looking at the last human check in the pipeline. Do
not restore the old rule as an efficiency.

**Where the line is.** The gate belongs to a piece going out under the
author's name and shipping without another human read — a blog post, a thread,
a cross-post. It does not belong to a draft asked for as a thinking aid, a
piece the requester will edit themselves, or a writeup in someone else's repo
that a human reviews before it ships. This skill is installed globally and
triggers in repos that have nothing to do with the blog; those are not covered
by default. When it isn't obvious which kind you have, put that question in
the same message as the three lines — it costs the same one message.

**4. Draft it.** Size for the audience; 1,200–1,800 words is where the voice
rules are calibrated, not a requirement. Structure follows from step 2, not from
a template — claim, evidence, limits, close is the corpus default and the
default is overridable when the reader and the landing want otherwise. Evidence
is quoted verbatim, never characterized.

Produce a title and a subtitle. Declarative, no question mark. The subtitle is a
second headline that makes its own argument, not a description.

**5. Decide what the reader sees.** Read `references/visuals.md`. Two questions,
and usually both answers are no: is any of this evidence two-dimensional
(a table), and is any claim about sequence or timing (a figure)? Zero is a valid
answer and the corpus default — never add one to break up the page.

**6. Link the claims.** Search out a source for load-bearing factual claims and
link them inline. This is a documented property of the author's finished drafts
— the revision in the corpus went from 1 link to 12 — and it is the step most
easily skipped.

**7. Run check mode on your own draft** before showing it. Fix what you find;
don't report it.

Where step 3 did not apply, still lead the reply with the three lines from step
2 before the draft itself — a reader who can see the reading you worked from
can reject it in one message.

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
Dies column — and only the absence of any qualifying clause is a defect. The
voice rules split the same way: several Tier 1 rules are typographic conventions
of long form and are void where the platform has no headings. `voice.md`'s
"Off long form" section says which, and names what it can't replace them with.

Report only what's actually wrong. A check that always finds ten things is a
check nobody runs twice.

---

## Before showing any draft

- [ ] One claim, stated in one sentence, arguable
- [ ] Reader and landing named before drafting, and the structure follows them
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
- [ ] If step 3 applied: reader, claim and landing confirmed before drafting

---

## Before it publishes — the review

A piece that publishes gets a fact-check review first, run by a subagent that
did not write it. `references/review.md` is the brief; hand it over whole
rather than summarizing it, and name the draft and the repo it is about.

**This is not an improvement on the process — it is the process.** It occupies
the slot the author's read used to, so a miss here is a post published wrong
with nobody left to catch it. That is why the brief makes the review state
what it *could not* check alongside what it did, and why "could not check"
never quietly becomes a pass.

Findings arrive as a draft, not a verdict to act on. Check each one against
the source yourself before changing a line — a review of this skill's own
output once reported a fabrication that a truncated search had invented. Then
record the outcome in the `reviewed:` line that gates publishing, above: what
ran, what it checked, what it found. Fixing a defect the review found does not
retire the review; the record is of what was checked, not of what survived.

---

## References

| File | Contents |
|------|----------|
| `references/voice.md` | The sentence-level voice constraint as tiered, checkable rules — with evidence and known gaps |
| `references/material.md` | How to find the story in the history instead of the artifact |
| `references/platforms.md` | Per-platform structure, and what survives compression |
| `references/visuals.md` | When a table or a figure is evidence rather than decoration, and how to build one |
| `references/review.md` | The fact-check brief handed to the review subagent before a piece publishes |
