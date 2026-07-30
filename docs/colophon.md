---
layout: page
title: Colophon
subtitle: What this site is made of, and how the writing actually gets made.
---

## How the posts are written

I draft these with Claude Code, and I should say so on the site rather than
only in the commit log.

The process is not "ask a model for a blog post." A skill reads the project's
git history — commit bodies, diffs, deletions, and the conversation that
produced the work — before it reads any finished file, on the theory that the
interesting material was edited out of the final version. It proposes a claim.
It drafts. Then I edit, and the editing is where most of the shape comes from.

The skill also checks a draft against rules extracted from my own earlier
drafts: sentence length, how sections end, which words never appear. Those
rules are sorted by how much evidence stands behind each one, and the ones that
look like properties of a single topic rather than of my writing are marked
*never enforce*.

The honest caveat is that the rules come from three drafts of one post, and one
of those three carries a Claude co-author trailer in its commit. So the corpus
this site's voice is measured against is itself partly machine-written. That is
a real weakness and I would rather state it than have someone find it.

The skill and the rules it enforces are public — `skills/writeup/SKILL.md` and
its `references/voice.md` are in
[the repository](https://github.com/RuichongWang/ruichongwang.github.io), along
with every skill this site writes about. The corpus is not. The drafts and their
full history live in a private workspace, so the paragraph above — three drafts
of one post, one of them carrying a co-author trailer — is something you now have
to take on my word rather than check against the commits.

---

## What runs it

Jekyll, built by GitHub Pages from Markdown in a public repository. There is no
database, no build pipeline of my own, and nothing to maintain.

No analytics, no trackers, no cookies, no fonts loaded from anyone else's
server. I do not know who reads this, which is a real cost and one I am
accepting for now.

There is [a feed]({{ '/feed.xml' | relative_url }}). It is the only way to
follow this that does not depend on a platform deciding to show it to you.

---

## Type and color

The reading face is whatever serif your system provides — Charter, Georgia, or
their equivalent. Everything structural is set in monospace: the name, the
dates, the section labels, the footer. Two roles, split cleanly, and no
webfonts to download.

The accent is a petrol blue, chosen partly because the obvious palette for a
writing site right now — warm cream, serif display, terracotta accent — has
become the house style of machine-generated design, which would be an awkward
look for a site that talks about telling the two apart.

Sections in a post are separated by a short accent bar rather than a full-width
hairline. That is not decoration. I put a rule between every section when I
write, consistently, across every draft I have — so the separator is the
rhythm of the page and it may as well be visible.
