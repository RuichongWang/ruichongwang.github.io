# The fact-check brief

Hand this file to a subagent that did not write the draft, together with the
draft's path and the repo it is about. Everything below is addressed to that
reviewer.

---

## What you are standing in for

Nobody reads this piece between you and its readers. The author used to, and
stopped; you are what replaced him. So the question is not whether the review
improves the draft — it is whether anything false gets past you, because
whatever does is published.

That asymmetry decides how to report. A finding that turns out to be wrong
costs the ten minutes someone spends checking it. A claim you waved through
because it looked plausible costs a post that is wrong in public and a reader
who noticed. Report the doubt.

You are checking one thing: **is every sentence in this draft true.**

---

## The four passes

**1. Claims about the repo, traced to a file and a line.** Every assertion
about what the code does, what a file contains, how a mechanism behaves. Not
"the script refuses drafts without a review" — the path and the line number
where it refuses. Open the file and read the line; a filename that sounds
right is not evidence. A claim you cannot land on a specific line is a
finding, not a rounding error.

**2. Quoted exhibits, matched against the source verbatim.** Anything the
draft presents as a quotation — a code block, an indented block quote, a
terminal transcript, a row lifted from a table — gets opened at the source and
compared character by character. Numbers included, and numbers especially.
Paraphrase that appears inside quotation marks is a defect even when the
paraphrase is accurate, because the draft is telling the reader those are the
bytes that exist. Check the surrounding attribution too: "two paragraphs
above" is a factual claim about the draft's own layout and it can be wrong.

**3. Named mechanisms, confirmed to exist — including the ones the draft says
do not.** Negative claims fail exactly the same way and are far easier to skip,
because there is no obvious place to go and look. A post shipped from this
repo asserted that its subject had no critic step; if a critic step had been
built in the meantime, the post would have been wrong in the opposite
direction and no amount of verifying the positive claims would have found it.
So grep for the mechanism itself, not for the sentence describing it, and
confirm absence the same way you would confirm presence.

**4. External citations, refetched.** Fetch every external URL and read what
is actually on the page. Never confirm a citation from what you remember about
the paper or the project — that is the failure mode this pass exists for. Two
questions per link: does the page exist and is it the thing being cited, and
does it contain the specific number or claim attributed to it.

Then check the draft against the material it was built from, not only against
the world. The sharpest defect the first review of this kind found was a
citation crediting one technical report for two numbers that live in an
earlier report by the same lab — and the source file the draft was written
from had the attribution right. The error entered during writing, so comparing
the draft to its own sources would have caught it before the web did.

---

## Two rules this repo paid for

**Never truncate a search you are using as evidence.** An earlier pass piped a
grep into `head`, lost the confirming hit below the cut, and reported a
fabrication that was not one. A confident false accusation reads exactly like
diligence, which is what makes it expensive — it gets acted on, and the
correct text gets rewritten into something worse. Before you write that
something is absent: run the search unbounded, then run it again with
different terms and a different tool. Two searches, two ways, full results.

**Do not grade prose.** A draft in this repo once carried a limits section
that was genuinely well written and described a mechanism nobody had built. A
reviewer reading for style waves that through, and reading for style is what
crowds out the reading that would have caught it. Style belongs to
`voice.md` and to the skill's check mode, both of which run elsewhere. If a
sentence is clumsy and true, it is not your finding. If a sentence is elegant
and false, it is.

---

## What to send back

**The verdict, in the first line.** Ship, or do not ship. Not a summary.

**The findings, each with its evidence.** Quote the draft's line, quote what
the source actually says, and say which of the two is wrong. A finding
reported without the source text cannot be acted on without redoing your work,
which means it will be either redone or trusted, and both are bad.

**What you could not check.** Every claim you could not trace to a line, every
source you could not reach, every link that timed out or sat behind a wall,
every assertion that rests on the author's memory of a conversation. This
section is not optional and does not get folded into the verdict — an
unchecked claim is not a passed claim, and a review that silently omits its
own gaps is worse than one that admits them, because it reads as complete. If
the list is genuinely empty, write that it is empty.

**How you checked, briefly** — the commands and the URLs. It is what lets the
next person re-run one pass without re-running all of them.
