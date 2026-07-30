---
name: matrix
description: |
  Download a domain skill on demand — search the web for knowledge in any domain,
  synthesize it into a reusable SKILL.md, and save it under ~/.claude/skills/.
  Like the Matrix: you think of a domain, you know it.

  Two modes:
  - Broad: /matrix DOMAIN [level]            → survey of the whole domain
  - Deep:  /matrix DOMAIN SUBTOPIC [level]   → focused deep dive on one subtopic

  Level is 1–10 (default: 5):
    1–3  = introductory, no jargon, accessible to anyone
    4–6  = undergraduate/graduate, mechanisms, current understanding
    7–8  = research-level, recent papers, active debates
    9–10 = cutting edge — preprints, open questions, frontier findings

  Examples:
    /matrix biology
    /matrix biology 3
    /matrix biology photosynthesis 9
    /matrix patent-law
    /matrix patent-law prior-art-search 7

allowed-tools:
  - WebSearch
  - Write
  - Bash(mkdir -p ~/.claude/skills/*)
---

# Matrix Skill

Synthesizes real domain knowledge from the web into a reusable Claude skill.
One invocation = one new skill permanently available in your skill library.

---

## Step 1: Parse input

Extract:
- `domain` — normalized to lowercase-hyphenated (e.g. "patent law" → `patent-law`)
- `subtopic` — if provided, triggers **deep mode**; otherwise **broad mode**
- `level` — integer 1–10, default 5 if not specified. If ambiguous (e.g. user writes `/matrix biology 3`
  with no subtopic), treat the number as the level, not a subtopic.

---

## Step 2: Choose mode and calibrate searches by level

### Level search calibration

Level controls *what you're looking for and where*, not a literal query modifier to append.
Use it to guide your search intent and source prioritization:

| Level | Search intent | Prioritize these sources |
|-------|--------------|--------------------------|
| 1–3 | Accessible explanations, named concepts, why it matters | Wikipedia, Khan Academy, introductory textbooks, explainer blogs |
| 4–6 | Actual mechanisms, named models/laws/processes, current consensus | University course notes, review articles, Nature/Science explainers, practitioner blogs |
| 7–8 | Specific findings, edge cases, active research directions | PubMed, arXiv, journal papers (2022–2026), expert practitioner writing |
| 9–10 | Open problems, competing hypotheses, frontier findings | bioRxiv, arXiv preprints, cutting-edge reviews, known unresolved debates |

Craft searches to match this intent — don't mechanically append modifiers to every query.

### Broad mode (`/matrix <domain> [level]`)

Goal: a working overview calibrated to the level — from "what is this?" (level 1) to
"what are the open problems?" (level 9–10).

Run **at minimum** these 4 searches:
1. `[domain] overview key concepts fundamentals`
2. `[domain] how it works` (mechanisms, processes, named models)
3. `[domain] major areas subfields`
4. `[domain] important discoveries history`

**If any search returns thin or abstract results** (summaries that a topic exists, paywalled
pages, shallow listicles) — run additional targeted searches to fill the gap. No hard cap.
A technically dense domain at level 5+ typically needs 6–8 searches for complete coverage.
Stop when every section of the output structure has enough concrete facts to fill it.

### Deep mode (`/matrix <domain> <subtopic> [level]`)

Goal: genuine depth on one slice, calibrated to level.

Run **at minimum** these 4 searches:
1. `[subtopic] [domain] mechanism how it works`
2. `[subtopic] [domain] latest research findings`
3. `[subtopic] [domain] explained detail`
4. `[subtopic] [domain] applications real world examples`

Same rule: if results are thin, run more. Deep mode at level 7+ should expect 6–10 searches
to get sufficient depth on mechanisms and frontier findings.

---

## Step 3: Synthesize — write actual knowledge, calibrated to level

The skill file should read like a knowledgeable friend explaining the domain — concrete,
factual, specific. It is NOT a study guide about how to study the domain.

**Write actual content like:**
- "Photosynthesis converts CO₂ + H₂O + light → glucose + O₂ via two stages: light-dependent
  reactions (in the thylakoid) and the Calvin cycle (in the stroma)"
- "In patent law, prior art is any evidence that your invention was already publicly known
  before your filing date — it includes patents, publications, and public use"

**NOT meta-commentary like:**
- "Experts think about biology using mechanistic reasoning"
- "It's important to understand the key frameworks in this domain"

### Level calibration for writing

| Level | Language | Content target |
|-------|----------|----------------|
| 1–3 | Plain English, no assumed knowledge, analogies welcome | Core concepts, named processes, why it matters |
| 4–6 | Technical terms used and briefly defined, mechanisms explained | How things work at a mechanistic level, named pathways/laws/models |
| 7–8 | Assumes domain vocabulary, cites specific studies/papers where relevant | Current consensus, known edge cases, active research directions |
| 9–10 | Dense, no hand-holding, references specific recent findings | Unresolved questions, competing hypotheses, preprint-level findings, where the field is moving |

The level also affects the **"What's still unknown"** section:
- Level 1–3: omit or keep to 1 sentence ("scientists are still figuring out X")
- Level 4–6: 3–5 open questions, briefly described
- Level 7–10: deep treatment of frontiers — specific unresolved debates, recent surprising findings, what the next 5 years might bring

Include the level in the frontmatter so future `/matrix` runs can layer on top (a level-3 file can be upgraded to level-7 without starting over).

---

## Step 4: Structure of the output skill

### Broad mode output structure

```
## What [domain] is
One paragraph — the actual subject matter, scope, and why it matters.

## How it works / Core mechanisms
The fundamental processes, systems, or rules that govern this domain.
Be specific. Use real examples, numbers, named processes.

## Key areas
The major subfields or categories within the domain. For each: what it covers, 1-2 sentence
summary of what's known.

## Important facts to know
A dense, factual list — the things that would come up in any serious conversation about the domain.
Aim for 10–20 concrete facts, not definitions.

## Key vocabulary
Terms with precise meaning in this domain. Format: **term** — what it means (be specific).

## What's still unknown / active frontiers
Where the field is unsettled, actively debated, or rapidly evolving.
```

### Deep mode output structure

```
## What [subtopic] is
Precise definition and scope within the broader domain.

## The mechanism / how it actually works
Step-by-step explanation of the process, system, or rule. Go deep.
Use named components, real numbers where known, causal chains.

## What we know (established)
Settled findings, consensus facts, well-replicated results.

## What we're still figuring out
Active research questions, current debates, open problems.

## Real-world applications
Where this shows up in practice — products, policies, treatments, tools.

## Key vocabulary
Terms specific to this subtopic, with precise definitions.

## Surprising or counterintuitive facts
Things that are true but not obvious — the stuff that surprises people who just started learning.
```

---

## Step 5: Write the file

### Read the skill convention first

Before writing any output skill file, load the official Claude Code skill-creator skill.
It contains the authoritative convention for skill authoring — file structure, frontmatter,
description writing rules, and the progressive disclosure pattern. Follow it when writing
the output skill file.

### File placement

**Broad mode** → `~/.claude/skills/<domain>/SKILL.md`
**Deep mode** → `~/.claude/skills/<domain>/references/<subtopic>.md`

```bash
mkdir -p ~/.claude/skills/<domain>/references
```

### Existing file handling

- **Same or lower level requested**: don't overwrite — deleting a deeper file is expensive to undo. Refresh it in place: re-search, update stale facts, keep the existing level and depth. Say what changed.
- **Higher level requested** (upgrade): read the existing file, rewrite it in place — expand thin sections, keep sufficient ones, update the `level:` field.

---

## Step 6: Confirm

Tell the user:
> "Downloaded: `~/.claude/skills/<domain>/[SKILL|<subtopic>].md`
> [2-3 sentence summary of what's in it]
> Go deeper with: `/matrix <domain> <subtopic>`"

If the file already existed, say what you changed rather than asking what to do — see "Existing file handling" above.

---

## Quality check before writing

**Content:**
- [ ] Does the content contain actual facts, processes, and mechanisms — not just descriptions of the domain?
- [ ] Could someone read this and learn something concrete they didn't know before?
- [ ] Are there specific named examples, numbers, or processes — not just categories?
- [ ] Is it free of filler phrases like "it's important to understand" or "experts know that"?
- [ ] Is the file under ~500 lines? If not, split overflow into `references/<subtopic>.md` files.

**Convention compliance** (check against skill-creator's "Anatomy of a Skill"):
- [ ] Does the description list the domain name AND key subfields AND adjacent contexts — is it pushy?
- [ ] Is the file under ~500 lines? Overflow into `references/<subtopic>.md`.
- [ ] No non-standard frontmatter fields (`type`, `mode`, etc.) — only `name`, `description`, plus optional `level` and `generated`.
