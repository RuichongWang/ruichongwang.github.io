# Finding the material

The single most common failure in writing about your own work: writing from the
finished artifact. Read the final `SKILL.md`, the merged PR, the shipped feature,
and describe what it does. The result is a product description. Nobody finishes
those, including the person who wrote them.

**The story is in the history, not the artifact.** Everything interesting —
what you believed and were wrong about, the fork you didn't take, the constraint
you hit — was deliberately removed from the final version. That removal is what
"finished" means. So go where it still exists.

---

## Read the history first, the artifact last

```bash
git log --oneline -30                     # the shape of the work
git log --format='%B' -20                 # full commit message bodies — where reasoning hides
git log -p --follow <path>                # how one file actually evolved
git diff <first-commit>..HEAD -- <path>   # what changed net
git log --diff-filter=D --name-only       # what got deleted, and when
```

Commit messages that explain *why* are the densest source in the repo. So are
deletions: something that existed and was removed is a decision with a story.

Then read the conversation that produced the work, if it's available — the
session transcript, the issue thread, the review comments. That's where the
wrong first answers live. They are never in the repo.

Only after that, read the finished thing — to check accuracy, not to find the
story.

---

## When there's no history

Often there won't be. The work happened this afternoon, or in a conversation, or
in a directory that was never a repo. Git is the richest source, not the only
one. In order:

1. **Uncommitted work.** `git status`, `git diff`, `git diff --staged`. A dirty
   tree is a record of what's being decided right now.
2. **The conversation that produced it.** Claude Code sessions live under
   `~/.claude/projects/<munged-project-path>/*.jsonl`, newest last. This is
   usually where the wrong first answers are, and they exist nowhere else.
   `Grep` it for the decision rather than reading it whole.

   **Only the directory for the project being written about.** Transcripts are
   the user's whole working life — other clients, other employers, credentials
   pasted into a prompt, code under someone else's NDA. This skill turns what it
   reads into a public post, so a transcript is the one source here that can
   leak a third party. Never widen the grep to `~/.claude/projects/*`, never
   quote a line naming anyone outside the work, and if a passage is the only
   evidence for a point but carries someone else's material, describe the
   decision instead of quoting it.
3. **Ask, once, and specifically.** Not "tell me about the project" — *"what did
   you expect that turned out to be wrong?"* and *"what did you almost do
   instead?"* Those two questions extract in one message what the history would
   have given you.

If none of the four sources yields a surprise, a fork, or a constraint, say
there isn't a post here yet and stop. Writing one anyway produces a feature
tour, which is the failure this whole file exists to prevent.

---

## The four kinds of material that only exist in history

**1. The wrong first answer.** What you believed before the evidence corrected
you. This is the highest-value material in any technical post and it is *never*
in the artifact, because the artifact is the corrected version.

It works because it gives the reader something to be wrong about too. "I assumed
the driver demands more mid-route; searching showed the dominant play is a cash
demand *before* pickup" is a post. "The skill handles pre-pickup cash demands" is
a changelog entry.

**2. The fork you didn't take.** Any decision with a live alternative. Say what
the other option was and what it would have cost. A decision presented without
its alternative reads as arbitrary; with it, the reader gets to disagree, which
is the same thing as being interested.

**3. The constraint you discovered.** The thing that turned out to be impossible,
unavailable, or more expensive than expected — and what you did instead. Readers
trust constraints. Nothing signals "this person actually built it" faster.

**4. The thing that surprised you.** If nothing surprised you during the work,
you don't have a post yet. Say so and don't write one.

---

## The test

For every paragraph:

> **Could someone write this after reading only the finished repo?**

If yes, cut it. It's a feature tour. What's left is the post.

A stricter version, for the opening: could this first paragraph open a post about
a *different* project in the same category? If yes, it's a category intro, not an
opening.

---

## One claim per post

A post argues one thing. Everything else is evidence for it, or it's cut.

Symptom of no claim: sections that could be reordered without loss. If the piece
survives shuffling, it's a list, and a list has no reason to be read in order —
so it won't be.

Write the claim as one sentence before drafting. If it takes two, there are two
posts.

---

## Evidence is quoted, not characterized

Show the artifact. Paste the real output, the real error, the real number, marked
as a quote. Do not write "the results were impressive" — paste the result and let
it be impressive.

Specific numbers beat adjectives every time, and a number you can't source
shouldn't be in the post. If the evidence is long, quote the sharpest 3–5 lines
verbatim and link the rest.

---

## Anti-patterns

| Pattern | Why it fails |
|---------|-------------|
| The feature tour — "it does X, it also does Y" | No claim, so no reason to keep reading |
| The tutorial-with-a-personality | Docs already exist and are better maintained |
| Announcing without evidence | "I built a thing" is not interesting; what you learned building it is |
| Burying the limits at the bottom | Reads as a sales pitch; limits stated early buy credibility for everything after |
| Explaining the category before the specific | The reader either knows the category or won't finish the paragraph |
| The clever framing device that outstays its welcome | See below — this is the most common self-inflicted wound |

**On framing devices:** an extended metaphor or a recursive gimmick ("I used the
tool to write this post about the tool") feels clever while drafting and looks
thin on reread. If the device is doing more work than the evidence, cut the
device. Keep it only where it costs one sentence.
