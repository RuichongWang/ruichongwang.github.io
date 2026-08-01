# Voice

**This file is the sentence-level constraint, not the starting point.** It says
how the prose should sound once you know what the piece is for. It does not say
what to write, who for, or what makes it land — that reasoning is per-piece,
belongs to the subject and the reader, and happens before this file is opened
(`skills/writeup/SKILL.md`, "Think the piece through first"). Reach for this
while writing a sentence and in check mode, not while deciding what the piece is.

What it holds is the part the web can't supply: rules worth having precisely
because they cut against writing-advice consensus — no lists, no `however`, a
short verdict after an exhibit, the thesis bolded once. Anything generic advice
would also tell you is not evidence about this author.

Derived from three drafts of one post: `writing/matrix-v0.md`,
`matrix-v1.md`, `matrix-v3.md`.

**The filenames lie about order.** True chronology is **v0 → v1 → v3**. v0 was
recovered from commit `1c8408f`, where it was committed as "v2"; the file now
called v1 is a later rewrite of it. Three drafts on a line, not two.

Every claim below was measured against all three. Rules that earlier extractions
asserted and the corpus refutes are recorded in "Corrections" at the end — read
it before trusting any voice rule you remember from elsewhere.

**The corpus moved once since it was measured.** On 2026-07-30 the Accuracy
paragraph of `matrix-v3.md` was rewritten, because it described a critic step
that was never built. Every rate in the diagnostics table predates that edit.
The change is small enough not to move them meaningfully and large enough that
you should not re-derive from `matrix-v3.md` and expect to reproduce them
exactly.

---

## The rule that outranks the rules

> **If you added it to hit a number, delete it.**

Every rate in this file can be satisfied by moving sentence boundaries instead
of by writing differently. Split a sentence at the comma and the short-sentence
fraction rises. Insert a deletable clause and the em-dash rate rises. Neither
changes the prose; both change the measurement.

A rule that can be satisfied by punctuation surgery will be, and that surgery is
exactly what parody is. So the measured rates in this file are **diagnostics,
not targets** — they tell you a draft is off, they never tell you what to do
about it. Fix an off reading by rewriting the argument, or leave it off.

---

## Tier 1 — structural invariants

Binary, verified true in all three drafts. A violation is a defect. All three
drafts are long-form Markdown posts, so some of these are conventions of that
format rather than of the author — read "Off long form" below before applying
them to a thread or a 小红书 note.

**1.1 No bullet lists. No numbered lists. No H3 or deeper. No exclamation
marks.** Confirmed zero across all three drafts (the only `!` characters in the
corpus are inside HTML comments). Enumerations get converted instead — into a
rule-of-three clause, into bolded inline labels (2.3), or into a code block.
This is the most detectable structural divergence from generic AI prose and the
easiest thing here to check.

**1.2 A horizontal rule between every section.** 12–13 per draft, in all three.
The piece is built as a sequence of separated panels, not a continuous flow.
Earlier extractions missed this entirely; it is one of the most stable features
in the corpus.

**1.3 The opening is H1, then a one-line italic dek, then a rule.** All three
drafts, without exception. The dek is 1–2 short sentences ending on a promise
fragment — "Here's the fix." / "Here's what that means."

**1.4 Exhibits are italic blockquotes.** Real output, quoted verbatim in
`> *…*`, never paraphrased. Roughly three-quarters of blockquote lines carry the
italics; the exceptions are pull-quotes, not exhibits.

**1.5 A bare fenced block containing only a command, standing alone as an
exhibit with prose reacting to it.** Four instances in v1, and it survives the
audience rewrite into v3. Surviving that rewrite is this file's strongest
available evidence, which is why this sits in Tier 1 rather than in Tier 3 with
the other code-related observations.

**1.6 No transition adverbs.** Zero across all three: *furthermore, moreover,
however, additionally, in conclusion, overall, therefore, thus, in other words,
for example, for instance, that said, it's important to note.* Transitions run
on `But`, `And`, `So`, `Or`, on paragraph breaks, and on the rules from 1.2.

**1.7 No hype vocabulary and no intensifiers.** The test is not the word list —
a blacklist is trivially routed around by *elegant, dead simple, just works,
neat*. The test is: **does the word assert quality instead of demonstrating
it?** If a reader could disagree with the adjective and you've given them
nothing to check it against, cut it. Confirmed absent across the corpus:
*revolutionary, game-changer, unlock, empower, harness, seamless, robust,
paradigm, powerful, delve, comprehensive, utilize, facilitate, very, really,
incredibly, dramatically, significantly, essentially, ultimately.*

**1.8 Colons introduce; they never join.** Either they precede a block, or they
unpack the noun immediately before them: "The context engineering stack has
three slots: model (weights), retrieval (RAG), instructions (system prompt)."
· "Domain knowledge compounds across sessions the same way code dependencies do:
you add to the library, you don't rebuild it."

---

## Tier 2 — patterns, with budgets

Each of these appears **about once per 1,500 words** in the corpus. That's the
budget. Using three of them in four hundred words is imitation, not voice — and
the imitation reads worse than plain prose, because it announces itself.

Scale proportionally: a 400-word piece gets one of these, total. Not one of
each.

**2.1 The negation stack.** Two negative fragments, then one positive fragment.
Verbless.
> "Not a retrieval hit. Not a static blob. A reasoning baseline that persists…"

**2.2 The concessive two-beat: "It's not W. It's Z."** Two sentences, never one
sentence with *but*. The concession is always the shorter half.
> "It's not wrong. It's pitched at the wrong level." · "That's not a metric.
> It's a vibe check."

**2.3 Bolded one-word label, then an anaphoric gloss.** The substitute for a
bulleted list. Always three.
> **Frozen.** The one everyone reaches for RAG to solve. · **Generic.** The one
> RAG doesn't touch. · **Stateless.** The one nobody talks about.

**2.4 Rule of three.** Asyndetic or one terminal *and*; never *as well as*.
"readable, editable, version-controllable" appears three times in the corpus.
**If the material has four members, keep four.** A manufactured third or a
dropped fourth is the most visible failure mode in this whole file.

**2.5 Whole-sentence bolding for the thesis**, once per piece, at the turn:
> **"RAG gives your model more facts. It doesn't change how it reasons."**

**2.6 Exhibit, then a one-line verdict.** The author never asserts the thing is
good — the output is displayed and reacted to. Checkable version: **the sentence
after an exhibit is under 20 words and makes a claim the exhibit supports.**

**2.7 Sentence-initial coordinating conjunctions**, roughly one per 250 words:
"But the direction is the same." · "And skills upgrade."

**2.8 Openings have zero throat-clearing.** Sentence one is a concrete image or
a diagnosis — never a definition, never "in recent years." The opening movement
ends on a one-line pivot: "So I built the closest thing I could."

**2.9 Closings are a concessive two-beat that reprises the opening.**
> "The walls are still there. But now there's a door." · "Neo's download was
> instant and perfect. What we have is slower and messier."

**2.10 The limits section is specific and self-damaging.** Checkable version:
**it names the mechanism by which the author's own fix fails**, not the fact
that it has limits. "A critic searching the same web as the generator shares
some blind spots" passes. "No tool is perfect" doesn't.

**2.11 Prior art credited by name, with the claim narrowed to fit.** "The
primitives aren't new. Web search exists. Structured prompts exist. What hasn't
materialized is a clean assembly."

**2.12 Headings: Title Case, 2–7 words, no questions, no colons.** Most open
with a bare `The`. They assert a claim ("The Problem Everyone Misframes") or
name an object ("The Limits") — never a section function. No "Overview",
"Background", "Getting Started", "Conclusion", "Key Takeaways". Numerals are
absent from the corpus but never tested; a numeral in a heading is not a defect.

---

## Off long form — which of these are typography

Every draft in the corpus is a long-form Markdown post. Some rules above are
conventions of that format, and a surface with no headings, no horizontal rules
and no fenced code cannot break them.

**Void where the format has no sections:** 1.2 (a rule between every section),
1.3 (H1, italic dek, rule) and 2.12 (heading style) all presuppose sections, and
1.1's "no H3 or deeper" is the same clause wearing a different hat. 1.4 (italic
blockquote exhibits) and 1.5 (a bare fenced command) presuppose the markup; the
device underneath survives — real output shown verbatim, never paraphrased, with
prose reacting to it — but how output gets shown where there are no code blocks
is `platforms.md`'s question, not this file's.

**Portable, because they are about sentences:** 1.6, 1.7, 1.8, and all of Tier 2
except 2.12. Nothing about a shorter format makes *however* sound like him.

**Untested rather than void: 1.1's ban on bullet lists.** It isn't typographic,
and it is the corpus's most characteristic feature — but the corpus contains no
piece written where lists are the platform norm, as they are on LinkedIn and in
much of 小红书. Keep it and say you kept it on untested grounds. Don't drop it
quietly because the platform likes lists.

**No positive rules exist for those surfaces.** This file cannot say what a
thread or a 小红书 note sounds like in his voice, because there are no samples
of either — the same hole as the Chinese one, one format wider. Naming it is all
it can honestly do; see "What this file can't tell you".

---

## First person — the ruling

The corpus does not settle this by frequency, so don't try to imitate one:
first-person tokens run **15 → 28 → 4** across v0 → v1 → v3. Non-monotonic, and
the biggest single swing in the corpus.

What is stable is *what it's used for*. In the final draft, first person survives
only to name the thing ("I called it `/matrix`") and in the coda. Everywhere
else the address is second person.

**The ruling, because `material.md` requires something this rule would
otherwise forbid:** first person is permitted for **admissions of error, of
ignorance, and of authorship**, and for nothing else. The wrong-first-answer —
`material.md`'s highest-value material — is narrated in first person by design.
Description, opinion, and walkthrough are second person or impersonal.

> Permitted: "I assumed the driver demands more mid-route. Searching showed
> otherwise." · "I didn't know the member read ratio mechanic."
> Not: "I built it so that…" · "I think the interesting part is…"

---

## Diagnostics — read, never target

Measured on author prose only (frontmatter, headings, code fences, blockquoted
exhibits, markdown tables, and `{% include figure.html %}` lines excluded).
**Re-read the rule at the top of this file before using any of these.**

| | v0 | v1 | v3 |
|---|---|---|---|
| Mean sentence (words) | 12.0 | 12.7 | 10.9 |
| Sentences ≤5 words | 24% | 17% | 31% |
| Single-sentence paragraphs | 31% | 27% | 24% |
| Em-dashes per 100 words | 1.66 | 1.76 | 1.85 |
| Semicolons | 1 | 0 | 2 |

A draft averaging over ~14 words per sentence is probably off. That is the only
threshold worth acting on, and the action is *rewrite the argument*, never
*split the sentences*.

Note the semicolon row. An earlier version of this file put "zero semicolons" in
Tier 1; the corpus has three. Near-zero is not zero, and the difference matters
when the tier's contract is "a violation is a defect."

**Length.** All three drafts are 1,450–1,600 words, and v1 states the target
explicitly. Every rate above may be an artifact of that constraint — so the
further a draft sits from ~1,500 words, the less this table can tell you.

The range is not a rule. The author's ruling, 2026-07-30: "字数范围你可以随便改
目标导向 … 怎么容易被audience喜欢怎么来 先认清audience是谁哈". Length serves
the piece's goal — name the audience, size for what they will actually finish.
The only cost of leaving the range is that the diagnostics above stop being
evidence, and that cost is fine to pay.

---

## The edit direction

v0 → v1 → v3 is the author editing himself. Apply as a revision pass, not a
drafting rule.

> **Cut the author out, cut the gimmick out, shorten the headings, link every
> claim, and answer the objection you previously only admitted.**

**It is not monotonic, and the middle draft moves the wrong way on two counts.**
Mean sentence length went 12.0 → 12.7 → 10.9. First person went 15 → 28 → 4. The
author expanded before he compressed. Treat the direction as v0→v3 net, not as a
rule that each pass tightens.

What is clean across the whole line: sections 9 → 6, mean heading 6.0 → 3.5
words, links 1 → 12, exhibit blocks 2 → 5, contractions 8 → 16 (*more* spoken as
it got more technical), parentheses 2 → 16 taking over the qualifying job that
first person used to do.

The two hardest edits to imitate, and the most characteristic:

- **The self-referential gimmick was the spine of the early drafts, and v3
  deletes it.** Two whole sections gone. The author cut his cleverest device
  because it only worked for one audience.
- **The limits section got longer and gained a solution that did not exist.**
  v1 ended it with "There's real work to be done here." v3 replaced that with
  "This is the one we addressed" and described a critic loop writing a
  verification log to the bottom of every skill file. `skills/matrix/SKILL.md`
  has no critic step, and no example carries such a log. The passage was
  rewritten on 2026-07-30 to say the fix is unbuilt.

  **Read this as the edit direction's failure mode, not as a technique.**
  Everything else in the v1 → v3 pass tightened prose against material that
  existed. This one paragraph got more confident than the tool did, and it did
  it while sounding exactly like 2.10 — specific, mechanism-naming,
  self-damaging. A limits section that names a fix is the most persuasive shape
  available here, which is precisely why it needs the fix to be real. **Check
  that a claimed solution ships before praising the honesty of admitting the
  problem.**

---

## Tier 3 — suspect: probably the topic, not the author

**Do not manufacture these.** If the material produces one, fine.

- **The controlling metaphor as a bookend.** A property of a post named after
  *The Matrix*. No evidence the author reaches for controlling metaphors
  elsewhere.
- **The density of hard numbers.** Largely a property of exhibiting a tool whose
  output *is* statistics. In a piece with nothing to quote, expect them to thin.
  (Where numbers do appear, they should be specific and checkable — but that is
  a rule about *how* to use a number, not a reason to find one.)
- **The ship-it self-deprecation** ("not a PhD", "a vibe check"). May be the
  posture of shipping a hobby tool rather than a trait.
- **The two-paragraph italic coda** — install line, then "follow me — I'm
  writing about…". A Medium convention. It should disappear on other surfaces.
- **Inline-code density.** Topic-driven. (The bare-command exhibit *device* is
  not — that's 1.5.)

---

## Corrections

Rules asserted by earlier extractions of this corpus that measurement refutes.
Listed because they are plausible, memorable, and wrong.

| Asserted | Actual |
|----------|--------|
| "Zero semicolons in author prose" | Three across the corpus, including v3:105 joining two independent clauses |
| "Every section lands on a 2–8 word sentence, all 15" | 6 of 15 fail; v3's Architecture section ends on a 34-word sentence closing with a qualifier |
| "Em-dash rate identical in both drafts (1.86)" | 1.66 / 1.76 / 1.85 — the *counts* are near-equal, the rates are not, and the third draft was missing |
| "Second person dominates, first person scarce (Tier 1)" | True of v3 only. v1 runs 28 first-person against 24 second. This is the edit direction, not an invariant |
| "A third of sentences are ≤5 words (Tier 1)" | 24% → 17% → 31%. The largest relative drift in the corpus, and non-monotonic |
| "There is no v2" | There is. Commit `1c8408f`, now `writing/matrix-v0.md` |

---

## What this file can't tell you

Be blunt with the user when you hit one of these.

**The corpus is three drafts of one post about one product.** n=1 on topic,
author, genre, and target. Voice cannot be fully separated from occasion.

**Part of the corpus has a documented LLM co-author.** Commit `1c8408f`, which
introduced v0, carries `Co-Authored-By: Claude Sonnet 4.6`. The later commits
carry no such trailer, which is not evidence they had no assistance. This is a
real problem for 1.1, whose headline claim is that these absences are what
distinguishes the author from generic AI prose — the corpus is not a clean
control. Treat 1.1 as a description of what *these drafts* do, which is still
useful, rather than as proof of a human-versus-machine boundary.

**All three drafts are promotional**, and all three are ~1,500 words with a
consciously optimized length target. Nothing here shows how this author writes
when arguing against a person, narrating, being wrong, or working short.

**No Chinese samples exist at all.** Every rule here comes from English long
form. Applied to Chinese they produce translation-ese, and the author will hear
it in one line. For 小红书 / 即刻 / 公众号 / 知乎, write plain idiomatic Chinese,
say this file doesn't cover it, and offer to build a Chinese sample set.

**To improve this file, add samples** — a non-promotional piece, something
short, and anything in Chinese. Each gap is one file away from closing.
