# Visuals

**This file has no corpus behind it.** `voice.md` measures three drafts and
reports what they do. Measured the same way, the corpus says this:

| | matrix-v0 | matrix-v1 | matrix-v3 | answer-twice |
|---|---|---|---|---|
| Tables | 0 | 0 | 0 | 0 |
| Images or diagrams | 0 | 0 | 0 | 0 |
| Code blocks | 8 | 10 | 4 | 0 |

Four posts, zero tables, zero images. So every rule below is **prescription,
not description** — it says what should happen, and the author has never done
it. Treat it at the confidence of a proposal. `voice.md`'s rules outrank it
everywhere they touch.

---

## The rule that outranks the rules

> **A visual is an exhibit, not an illustration. If the reader cannot check
> something against it, cut it.**

This is not a new rule. It is 1.4 (exhibits are quoted verbatim, never
paraphrased) and 2.6 (the sentence after an exhibit makes a claim the exhibit
supports) applied to something that isn't text. A figure that only breaks up
the page is the same defect as an adjective that asserts quality instead of
demonstrating it — 1.7, in a different medium.

---

## Why there are none

Tier 1.1 bans bullet lists, numbered lists, and H3s. That ban is load-bearing
and stays. It offers three replacements: a rule-of-three clause, bolded inline
labels (2.3), or a code block.

**Two of the three are prose, and the third depends on the topic.** 1.5 — the
bare fenced block holding one command — only exists when the thing being
written about has commands. The matrix drafts are about a CLI tool, so they
carry 4 to 10 code blocks each. `answer-twice` is about a design decision. It
has none, and nothing replaced them: 1,593 words across six sections, carried
by six blockquotes and otherwise unbroken prose.

That is the gap. Not "posts should have pictures" — the skill has no way to
show anything that isn't a sentence or a command.

---

## What each form is for

**A table, when the content is genuinely two-dimensional.** Objects down the
side, properties across the top, real values in the cells. The test is that
both axes carry information. A single-column table is a bulleted list wearing a
hat, and 1.1 bans it just as hard.

**A diagram, when the claim is about sequence, timing, or flow.** If the
argument is "this happens, then that happens, and the gap between them is the
problem," prose has to serialize what the reader needs to see at once. That is
the one thing a figure does that a paragraph cannot.

**A chart, only with measured data you own.** Not an illustrative curve, not a
shape drawn to look like the trend. `answer-twice` says "None of this is
measured" in its own limits section — that post is entitled to zero charts, and
a chart in it would be a lie with axes. This is the rule most likely to be
broken by wanting the page to look substantial.

**Real output stays an italic blockquote.** 1.4 already covers it and the site
styles it. Reach for a screenshot only when the visual form *is* the evidence —
a rendering, a layout, a UI — never for text that could be quoted.

---

## Before adding one

- [ ] The reader could disagree with it — there is something in it to check
- [ ] The sentence after it makes a claim it supports (2.6), under 20 words
- [ ] Deleting it would lose information, not just whitespace
- [ ] It is not restating the paragraph beside it — if it is, delete one of them
- [ ] It survives being read at 528px, scrolled, on a phone
- [ ] At most one per section. A 1,500-word post wanting four is two posts

**Never add one to hit a count.** The top of `voice.md` says every rate there is
a diagnostic and not a target; the same applies here, harder, because a figure
takes an hour and therefore feels earned once it exists. Sunk cost is not
evidence. A post with no two-dimensional content and no timing claim correctly
ships with zero figures.

---

## Mechanics

Tables need nothing — write GitHub-flavored markdown, the site styles them with
tabular numerals.

Figures are SVG, inlined by an include so the site's colour tokens reach inside
them. A referenced `<img>` cannot see the manual `[data-theme]` toggle and
breaks in dark mode.

    docs/_includes/figures/<post-slug>-<name>.svg    the figure
    {% include figure.html src="..." alt="..." caption="..." %}   in the draft

The include line goes in the draft in `writing/`, on its own line with a blank
line either side. `publish.sh` copies the body verbatim, so Liquid resolves at
build time and the draft stays one line long.

**Keep figure markup out of `writing/`.** Drafts in that directory are the
voice corpus. Forty lines of inline `<svg>` in a draft would land in the next
voice extraction as prose and corrupt every rate in `voice.md`'s diagnostics
table. The include indirection exists for that reason, not for tidiness.

**Authoring rules for the SVG.** `viewBox` plus `width="100%"`, ~640 units
wide. Text at 11 units or larger. A `<title>` element, and an `alt` on the
include; they serve different readers. No script, no external font, no raster
fallback.

**The figure must be legible with no stylesheet at all.** Give every element
presentation attributes — `fill="currentColor"`, `stroke-opacity`, `font-size`
— and let the `fig-*` classes upgrade them to the theme tokens. CSS outranks
presentation attributes, so nothing is lost when the stylesheet is there.

This is not hypothetical. The first version of the timeline put every colour in
`style.css` alone. GitHub Pages serves CSS with `max-age=600`, so a phone that
had loaded the site ten minutes earlier got the new HTML with the old
stylesheet, and every unstyled SVG element fell back to its default: black fill,
on a black page. The figure was a set of invisible bars for the length of one
cache window. Anything that strips CSS — a reader app, an email client, a
feed — does the same thing permanently.

**Uppercase belongs in the file, not in `text-transform`.** Safari does not
apply `text-transform` to SVG `<text>`.

Check it in both themes before publishing. The build is real and local:

    jekyll build -s docs -d /tmp/site --baseurl ""

---

## What this file can't tell you

**Nothing here is measured, and the file says so twice on purpose.** It is the
same failure `answer-twice` admits to in its own limits: a design changed
because the problem looked obvious, with no evidence that the fix works.

**The one figure that exists was not authored by the author.** `answer-twice-
timeline.svg` was drawn by an assistant to prove the pipeline runs end to end.
It is a reference implementation, not a sample of anyone's taste, and it should
not be treated as a house style until the author has kept or replaced it.

**Nobody has watched a reader use one.** Whether the timeline figure explains
the two-tier design faster than the three paragraphs beside it is unknown, and
the honest possibility is that it is redundant with them.

**On a phone the figure scrolls sideways.** 640 units cannot shrink to a 343px
container without dropping label text under 8px, so `.fig` scrolls instead.
A reader who does not scroll sees the left half. This constrains figure design
more than any rule above: put the argument on the left.
