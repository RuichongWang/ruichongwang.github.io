# Claude Code skills

My personal [Claude Code](https://claude.ai/claude-code) skill library. One repo, many skills — clone it, run `./install.sh`, and every skill in `skills/` becomes available in every Claude Code session.

This repo is also my GitHub Pages user site: `docs/` builds the blog at
[ruichongwang.github.io](https://ruichongwang.github.io), and the posts there are mostly about the skills below. The two live together because a free GitHub account only gets Pages from a public repo, and this is the public one.

## Skills

| Skill | What it does |
|-------|-------------|
| [`matrix`](./skills/matrix/SKILL.md) | Downloads domain knowledge on demand — searches the web, synthesizes expertise, saves it as a permanent skill. `/matrix <domain> [subtopic] [level]` |
| [`tourist-trap`](./skills/tourist-trap/SKILL.md) | Tells you whether a price is a rip-off and what to counter with, what to do while a scam is happening, and what to watch for before a trip. `/tourist-trap <the quote, the situation, or the city>` |
| [`writeup`](./skills/writeup/SKILL.md) | Writes about your own finished work in your own voice — drafts from the project's history rather than its finished state, adapts a draft to a platform, and audits one against your voice. `/writeup <what to write about, or a draft>` |

`./install.sh --list` prints the same list from whatever is currently in the repo.

## Install

```bash
git clone https://github.com/RuichongWang/ruichongwang.github.io.git
cd ruichongwang.github.io
./install.sh                # all skills
./install.sh matrix         # just one
```

Or without cloning first — the script fetches the repo into `~/.claude/.skills-src/` and installs from there:

```bash
curl -fsSL https://raw.githubusercontent.com/RuichongWang/ruichongwang.github.io/main/install.sh | bash
```

Skills are **symlinked** into `~/.claude/skills/`, so `git pull` updates all of them at once. Options:

| Flag | Effect |
|------|--------|
| `--list` | Show available skills and their descriptions |
| `--copy` | Copy instead of symlink (for machines that shouldn't keep the clone) |
| `--force` | Replace an existing `~/.claude/skills/<name>` |
| `--uninstall [name...]` | Remove installed skills (all, or the named ones) |
| `--dir <path>` | Install somewhere other than `~/.claude/skills` |

Restart Claude Code after installing so it picks up new skills.

## Layout

```
skills/<name>/SKILL.md        ← the skill itself; one directory per skill
skills/<name>/references/     ← detail loaded on demand, not upfront
examples/<skill>/             ← real output produced by that skill
template/SKILL.md             ← starting point for a new skill
install.sh                    ← install / uninstall / list
adopt.sh                      ← pull a skill from ~/.claude/skills into this repo
validate.sh                   ← check frontmatter of every skill (also runs in CI)
docs/                         ← the Jekyll site GitHub Pages builds
```

The skills, the examples, and the site are written in a separate private
workspace and mirrored here, so this repo's history is a record of what was
published rather than of how it got written. Drafts of the posts, and the
sessions that produced the skills, are not public.

`SKILL.md` follows the standard skill convention: YAML frontmatter with `name` and `description` (plus optional `allowed-tools`), then Markdown instructions. The `description` is the only part Claude sees before deciding whether to load the skill, so it has to state the triggers explicitly.

## Adding a skill

Write it by hand:

```bash
mkdir -p skills/my-skill
cp template/SKILL.md skills/my-skill/SKILL.md
$EDITOR skills/my-skill/SKILL.md
./install.sh my-skill
```

Or generate it and adopt it. `/matrix` writes straight into `~/.claude/skills/<domain>/`; `adopt.sh` moves that directory into this repo and symlinks it back, so it's version-controlled without changing how it loads:

```
/matrix crispr 8
```
```bash
./adopt.sh crispr
git add skills/crispr && git commit -m "add crispr skill"
```

Either way, keep `SKILL.md` short and push depth into `references/` — SKILL.md enters the context window every time the skill triggers, references only when read.

## The matrix skill

```
/matrix <domain> [level]
/matrix <domain> <subtopic> [level]
```

| Example | What happens |
|---------|-------------|
| `/matrix biology` | Broad survey of biology — cells, DNA, evolution, energy |
| `/matrix biology 2` | Same, at introductory level (plain English, no jargon) |
| `/matrix biology photosynthesis 9` | Deep dive on photosynthesis at research level |
| `/matrix patent-law` | How patent law works — claims, prior art, prosecution |

**Level 1–10** (default: 5): `1–3` introductory · `4–6` mechanisms and current consensus · `7–8` research-level, active debates · `9–10` frontier, open problems.

Re-running at a higher level enriches the existing file rather than starting over. Real output lives in [`examples/matrix/`](./examples/matrix) — [crispr](./examples/matrix/crispr/SKILL.md), [patent-law](./examples/matrix/patent-law/SKILL.md), [negotiation](./examples/matrix/negotiation/SKILL.md), [machine-learning](./examples/matrix/machine-learning/SKILL.md), [ai-agent-evals](./examples/matrix/ai-agent-evals/SKILL.md), [ai-engineer-llm-pain-points](./examples/matrix/ai-engineer-llm-pain-points/SKILL.md).

### About those examples

They are machine-generated from web search and published **unedited and unreviewed**. That is the point of showing them — a demo that had been hand-corrected would misrepresent what the tool does — but it means they are wrong in places, and some of the errors are the kind a reader would act on.

An audit of the six found: a patent deadline attached to the wrong trigger (IPR estoppel attaches at final written decision, not institution); a defensive procedure recommended five years after it stopped accepting petitions (CBM review, sunset 2020); a filing fee off by roughly two orders of magnitude; a clinical program described as an unqualified success a year after its sponsor suspended it; a salary claim whose own arithmetic does not reach the total it states; and second-hand statistics presented as read from primary reports.

None of it is legal, medical, or financial advice. Each `references/sources.md` lists what the synthesis drew on, in bulk rather than per claim — so a specific number cannot be traced to a specific page. Verify anything load-bearing against a primary source.

This is a property of the tool, not a bug in these six files: `skills/matrix/SKILL.md` does not instruct the model to record sources or to check its own claims, so a skill you generate today has the same exposure.

## The tourist-trap skill

```
/tourist-trap 开罗机场到市区要 400 埃镑，贵吗
/tourist-trap 出租车半路停下来要加钱
/tourist-trap 下周去伊斯坦布尔，有什么坑
```

Three modes, picked from how the question is phrased: a **price check** (a
multiple and a counter-offer), a **live situation** (one action, one line to say,
one thing not to do), or a **pre-trip brief** (a card you can screenshot).

Three design decisions worth knowing about:

- **It answers twice.** Tier 1 ships immediately with no searching — four lines you
  can act on while someone is standing over you. Tier 2 arrives after, once it has
  searched: the exact report path and deadline, the wording that gets refunded,
  what the route should have cost. Tier 2 leads with whether tier 1 still holds,
  and a correction goes first and in bold. The fast answer is allowed to be wrong;
  a correction that arrives buried is not.

- **Safety outranks money.** If you're isolated, outnumbered, in a moving
  vehicle, or your passport or luggage is being held, the skill stops analyzing
  the price and tells you to pay and leave — then recovers the money through the
  app, the card, or the tourist police. It will not coach you into winning an
  argument somewhere you can't walk away from.
- **Methods are baked in, prices are not.** Scam playbooks and the price-anchoring
  method live in `references/`; actual prices get searched live, because in the
  countries where this matters the currency moved 40% since anything on the web
  was written. With no signal it falls back to purchasing-power anchors — a bus
  ticket, a bottle of water, a local lunch — which still yield a verdict.

## The writeup skill

```
/writeup 把这个 skill 写成一篇博客
/writeup 这稿改成 X thread
/writeup 看看这段像不像我写的
```

Four modes — draft, adapt, revise, check. Three things make it more than "help me write a blog post":

- **It drafts from the history, not the artifact.** Commit bodies, diffs, deletions, and the conversation that produced the work — read *before* the finished files. The finished version is the corrected version; the wrong first answer, the fork not taken, and the constraint discovered were all edited out of it. Those are the post.
- **The voice file is tiered by confidence.** `references/voice.md` sorts rules by whether they held constant across the author's own revisions. Rules that survived a rewrite get enforced; rules that look like properties of the *topic* are marked "never manufacture." Enforcing a topic artifact as if it were voice produces a parody, which is harder to spot than plain generic prose.
- **Measured rates are diagnostics, not targets.** Every rhythm metric can be hit by moving sentence boundaries rather than by writing differently — and that surgery is what parody is. So one rule outranks the rest: *if you added it to hit a number, delete it.*

The voice file also names what it doesn't know: the corpus is three drafts of one promotional post, part of it has a documented LLM co-author, and there are no Chinese samples at all — so Chinese posts get plain idiomatic prose and an explicit note rather than English rules in translation.

## License

MIT
