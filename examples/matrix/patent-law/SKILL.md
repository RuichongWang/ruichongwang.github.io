---
name: patent-law
description: |
  Patent law knowledge at practitioner depth. Covers patent fundamentals, claim drafting and structure, prosecution mechanics (office actions, rejections, appeals), prior art and invalidity, post-grant proceedings (IPR/PGR/PTAB), infringement analysis, freedom-to-operate (FTO), licensing, patent strategy for startups/software/AI/biotech, and patent damages. Load this skill whenever the user asks about patents, IP strategy, prior art, patent filing, infringement, FTO, PTAB, IPR, inter partes review, startup IP, software patents, AI inventorship, biotech patents, patent claims, claim drafting, patent licensing, patent valuation, patent trolls (NPEs), continuation strategy, prosecution laches, 35 USC 101/102/103/112, Alice test, patent term, PCT applications, or anything touching intellectual property protection for inventions. Also use for due diligence, M&A IP analysis, and investor IP questions.
level: 7
generated: 2026-04-13
---

# Patent Law

> **Generated and published unedited.** The `/matrix` skill wrote this from web
> search on 2026-04-13. No human reviewed it, then or since. It is here to show
> what the tool actually produces, which means the errors are part of the
> exhibit: an audit of these six files found a statutory deadline attached to the
> wrong trigger, a procedure recommended five years after it was discontinued, a
> filing fee off by two orders of magnitude, a suspended drug program described
> as a success, and compounding arithmetic that does not compute. **It is not legal advice.** Check
> anything you would act on against a primary source.


Research-level practitioner knowledge. Real statutes, real timelines, named doctrines, current PTAB statistics.

## Reference Files

Read the relevant reference file(s) before responding:

| File | When to read |
|------|-------------|
| `references/prosecution.md` | Filing, examination, office actions, claim amendments, appeals, PCT, PTA |
| `references/validity.md` | Prior art (§102/§103), §101 eligibility (Alice), §112 enablement/WD, IPR/PTAB |
| `references/infringement.md` | Direct/indirect infringement, claim construction, FTO analysis, damages, willfulness |
| `references/strategy.md` | Startup IP strategy, software/AI/biotech-specific issues, portfolio building, licensing |
| `references/sources.md` | Full citation list for all facts in this skill |

For broad patent questions, read `prosecution.md` + `validity.md` first. For enforcement/litigation questions, add `infringement.md`.

---

## Core Framework

### What a Patent Is (and Is Not)

A **utility patent** is a government-granted right to **exclude** others from making, using, selling, offering to sell, or importing the claimed invention in the US for **20 years from the earliest effective filing date** (35 USC §154). It is not a right to practice — the patentee may still be blocked by others' dominant patents.

Three types of US patents:
- **Utility** — processes, machines, manufactures, compositions of matter (20-year term)
- **Design** — ornamental appearance of a functional article (15-year term post-AIA for applications filed after May 13, 2015)
- **Plant** — asexually reproduced plant varieties (20-year term)

### The Five Patentability Requirements

| Requirement | Statute | Key Issue |
|-------------|---------|-----------|
| Eligible subject matter | §101 | Laws of nature, abstract ideas, natural phenomena excluded (Alice/Mayo) |
| Utility | §101 | Must have credible, specific, substantial utility |
| Novelty | §102 | Not disclosed in prior art before effective filing date |
| Non-obviousness | §103 | Wouldn't be obvious to PHOSITA (person having ordinary skill in the art) |
| Enablement + Written Description | §112 | Spec must enable full scope; inventor must "possess" invention |

### Anatomy of a Patent Claim

Claims are the legal boundary of the patent — they define what is and is not covered.

Structure of a claim:
1. **Preamble** — introduces the claim ("A method for...", "A system comprising...")
2. **Transition** — "comprising" (open; unlisted elements OK), "consisting of" (closed; no unlisted elements), "consisting essentially of" (semi-closed)
3. **Body** — recites each element/limitation

**Independent claims** stand alone and define the broadest scope. **Dependent claims** incorporate all limitations of the claim they depend from plus add further limitations — they are narrower but provide fallback positions if the independent claim is invalidated.

Strategic implication: independent claims that are too narrow are permanently narrow. Draft broad independent claims first; use dependent claims to capture preferred embodiments and provide invalidity fallbacks.

### The AIA Transition (Critical)

The **America Invents Act (AIA)**, enacted 2011, shifted the US from **first-to-invent** to **first-inventor-to-file** for applications with effective filing dates on or after **March 16, 2013**. Pre-AIA law still governs patents filed before that date — they can still be in force (20 years from filing) and litigated under different rules.

---

## Quick Reference: Key Deadlines

| Event | Deadline | Consequence of Missing |
|-------|----------|----------------------|
| US filing after public disclosure | 1 year (§102(b) grace period) | Loss of US rights |
| Foreign filing after US filing (Paris Convention) | 12 months | Loss of priority date abroad |
| PCT national phase entry (most countries) | 30 months from priority | Deemed withdrawn |
| Response to office action | 3 months (extendable to 6 for fee) | Abandonment |
| Appeal from final rejection | 2 months from mailing date (extendable) | Abandonment |
| IPR petition deadline | 1 year from service of complaint | Petition time-barred |
| Inter partes review estoppel attaches | At institution | Challenger cannot raise same grounds in district court |

---

## 2025 Landscape Highlights

**PTAB denial surge**: PTAB institution rates collapsed in late 2025. USPTO Director John Squires assumed personal control of institution decisions in October 2025 and denied all 34 petitions he reviewed. Discretionary denials under the Fintiv doctrine surged 630%+ year-over-year. Institution rates dropped from ~75% (2024) to ~35% under the new regime — a 40-point collapse. See `references/validity.md` for strategy implications.

**§101 / AI inventorship guidance**: August 2025 USPTO memo raised the bar for §101 rejections — examiners must now find it "more likely than not" that a claim is ineligible before issuing a rejection, and cannot stretch "mental processes" to limitations impractical for the human mind. Separately, AI-assisted inventions remain patentable so long as a human inventor made a significant contribution to the conception of at least one claim.

**Prosecution backlog**: 800,000+ unexamined applications as of late 2024. Average first office action: 22.6 months. Most utility patents take 24–36 months from filing to grant.

**Litigation**: First half 2025 saw $1.9B+ in damages from 21 cases. VLSI v. Intel alone: $948.76M. Eastern District of Texas remains most active forum.
