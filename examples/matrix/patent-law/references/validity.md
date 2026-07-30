# Patent Validity

Prior art (§102/§103), subject matter eligibility (§101), enablement and written description (§112), post-grant proceedings (IPR/PGR/PTAB).

---

## Prior Art Under the AIA (§102)

### What Counts as Prior Art

Under AIA §102(a)(1), a disclosure constitutes prior art if it was:
- Patented
- Described in a printed publication
- In public use
- On sale
- **Or otherwise available to the public**

...before the **effective filing date** of the claimed invention.

The "otherwise available to the public" catch-all is broader than pre-AIA law. It encompasses oral disclosures at conferences, public use without confidentiality obligations, and non-traditional disclosures.

**Geographic and language restrictions eliminated**: Under AIA, prior art is worldwide and in any language. Under pre-AIA §102, certain geographic restrictions applied.

### Secret Prior Art: §102(a)(2)

Earlier-filed US applications become prior art as of their filing date, even if not yet published, when they eventually publish or issue. This is the "secret prior art" problem — an application filed one day before yours can anticipate your claims even though it wasn't publicly available.

Exception (§102(b)(2)(C)): If the earlier-filed application and your application were owned by the same entity at the time of filing, the earlier application is not prior art (common ownership exception). Critical for corporate R&D.

### The One-Year Grace Period

§102(b)(1) creates a 1-year safe harbor for inventor-originated disclosures:
- If **the inventor** discloses the invention, that disclosure is not prior art against the inventor's later-filed application, provided the application is filed within 1 year of the disclosure
- Disclosures by third parties that occur after the inventor's own public disclosure are also excluded (swearing back effect)

**Critical trap**: The US grace period is **unique** — most foreign patent systems (EPO, China, Japan) require absolute novelty with very limited exceptions. Publishing, presenting, or selling before filing destroys foreign patent rights **permanently** in most jurisdictions. File before you disclose in any major foreign market you care about.

### Pre-AIA vs. AIA — Residual Importance

Pre-AIA patents (effective filing date before March 16, 2013) can still be active through the mid-2030s (20 years from filing). These are litigated under different rules:
- First-to-invent: inventor can "swear behind" a reference by showing earlier date of conception + diligence
- §102(g): another person's prior invention in the US (even if never patented) can be prior art

---

## Non-Obviousness (§103)

A claimed invention is unpatentable if the differences between it and the prior art would have been **obvious** to a person having ordinary skill in the art (PHOSITA) at the time of filing.

### Graham v. John Deere Framework (1966)
1. Determine the scope and content of the prior art
2. Ascertain differences between the prior art and the claims
3. Determine the level of ordinary skill in the art
4. Consider **secondary considerations** (objective indicia of non-obviousness)

### KSR International v. Teleflex (2007)
Rejected rigid TSM (teaching-suggestion-motivation) test. Courts and examiners may find obviousness by:
- Combining known elements using known methods to yield predictable results
- Trying a finite number of identified, predictable solutions (obvious to try)
- Common sense or general knowledge in the art

**Secondary considerations** (must be argued with evidence, not just assertion):
- Commercial success (must show nexus to claimed features)
- Long-felt but unsolved need
- Failure of others
- Unexpected results
- Copying by competitors
- Industry praise

Secondary considerations are underused by applicants. They must be supported by evidence (declarations, market data) and a nexus between the commercial success/praise and the specific claimed invention.

---

## Subject Matter Eligibility (§101) — The Alice/Mayo Framework

### What Is Excluded
Three **judicial exceptions** — not in the statute but judicially created:
1. **Laws of nature** (e.g., mathematical relationships, natural correlations)
2. **Natural phenomena** (e.g., isolated DNA, natural products)
3. **Abstract ideas** (e.g., fundamental economic practices, mental processes, mathematical concepts)

### Alice/Mayo Two-Step Test

**Step 1**: Is the claim directed to one of the three judicial exceptions?
- If no: eligible. Stop.
- If yes: go to Step 2.

**Step 2**: Does the claim include an "inventive concept" that amounts to significantly more than the exception alone?
- Merely implementing an abstract idea on a generic computer is NOT enough
- Must identify additional elements that integrate the exception into a practical application, or add significantly more

### USPTO Examination After August 2025 Memo

The August 4, 2025 USPTO memo raised the bar for §101 rejections:
- Examiners must find it **"more likely than not"** that a claim is ineligible before rejecting
- Cannot stretch "mental process" to limitations that **cannot practically be performed in the human mind** (e.g., processing millions of data points simultaneously cannot be a "mental process")
- Must analyze each claim individually rather than collapsing all claims into a single §101 analysis

**Strategy implication**: Push back hard on §101 rejections with claim-specific arguments. Prior to August 2025, examiners were rejecting far more liberally. The new memo strengthens applicant positions in prosecution.

### Practical Guidance for Software/AI Claims

Stronger claim language:
- Recite specific technical problems being solved
- Claim improvements to computer/network functioning, not just computer-implemented business methods
- "Ordered combination" argument: even if individual elements are known, the specific combination achieves a technical result
- Avoid pure "result-functional" claiming ("a processor configured to achieve X") without specifying how

Claims that survive §101:
- Specific algorithms tied to concrete technical improvements (e.g., reduced latency, improved compression, more accurate detection)
- Diagnostic/treatment claims tied to specific biomarkers and specific treatments
- Novel arrangements of hardware components achieving technical benefits

Claims that fail §101:
- Collecting data + analyzing data + displaying results (no technical specificity)
- Software doing what a human could do manually, just faster
- Correlations between natural phenomena and disease states without a treatment step

---

## Enablement and Written Description (§112)

### Enablement (§112(a))
The specification must enable a PHOSITA to **make and use** the full scope of the claimed invention **without undue experimentation**.

**Wands factors** for undue experimentation:
1. Quantity of experimentation necessary
2. Presence/absence of working examples
3. Amount of direction provided in specification
4. State of the prior art
5. Skill level of PHOSITA
6. Predictability of the art

**Amgen v. Sanofi (2023 SCOTUS)**: Struck down broadly-claimed antibody patents covering entire functional genus where only a few examples were disclosed. Now the leading case on enablement for biotech genus claims. Applicants must provide sufficient examples to "enable" the full breadth of the genus — not just the examples actually reduced to practice.

### Written Description (§112(a))
Separate from enablement: inventor must demonstrate they **"possessed"** the claimed invention at the time of filing. The disclosure must describe the claimed invention in sufficient detail to show possession.

**Trap for continuation/CIP applicants**: Adding new claims in a continuation that go beyond what was originally described — even if technically enabled — can fail written description. The disclosure must show the inventor actually invented what is claimed, not just what was later obvious from the disclosure.

### Definiteness (§112(b))
Claims must particularly point out and distinctly claim the subject matter. **Nautilus v. Biosig (2014 SCOTUS)**: "reasonable certainty" standard — a claim is indefinite if it fails to inform PHOSITA with reasonable certainty about the scope of the invention.

---

## Inter Partes Review (IPR) — Post-Grant Proceedings

### Mechanism
IPR is an adversarial proceeding before the PTAB challenging patent validity based on §102 (anticipation) or §103 (obviousness) using **patents and printed publications** only. Filed by third parties (often accused infringers).

| Parameter | Value |
|-----------|-------|
| Who can file | Any person who is not the patent owner (with 1-year bar after service of complaint) |
| Grounds | §102 and §103 based on patents/printed publications only |
| Fee | ~$19,500 + ~$21,500 per claim (for petitions with >15 claims) |
| Institution threshold | Reasonable likelihood that petitioner would prevail on at least 1 claim |
| Discovery | Limited (depositions of declarants; some emails) |
| Final written decision | Within 1 year of institution |
| Estoppel | Cannot later assert same grounds petitioned in district court or ITC |

### 2025 PTAB Denial Surge

This is the most significant PTAB development since the AIA:

**What happened**:
- USPTO Director John Squires assumed personal control of institution decisions in October 2025
- Issued 34 institution decisions; denied all 34 — effectively 0% institution rate
- Discretionary denials (non-merits) surged **630%+ year-over-year**
- 61% discretionary denial rate overall
- 58% of denials based on **Fintiv** factors (parallel district court litigation timing)
- Institution rate fell from ~75% (FY2024) to ~35% under new regime

**Fintiv factors** (the key tool for discretionary denial):
Apple v. Fintiv (2020 PTAB precedent) allows PTAB to deny institution based on:
1. Whether a stay has been requested in parallel litigation
2. Proximity of trial date in district court
3. Investment by district court in the parallel proceeding
4. Overlap between issues raised in petition and district court
5. Whether petitioner and defendant in district court are the same party
6. Other circumstances (including merits strength)

**Strategy implications for patent owners**: File early in EDTX or other fast districts before expected IPR petition; get a trial date set; move to dismiss potential IPR petitions based on Fintiv.

**Strategy implications for petitioners/challengers**: File IPR petition immediately on notice of potential litigation before a complaint is served; consider post-grant review (PGR) in first 9 months; note that if you're a co-defendant with a party that lost an IPR, estoppel may apply to you even without petitioning.

### Post-Grant Review (PGR)
- Must be filed within **9 months** of patent grant
- Can challenge any §101, §102, §103, §112 ground (broader than IPR)
- Same discretionary denial rules apply

### IPR Invalidation Rate
Despite the institution rate collapse, **when cases are instituted**, the all-claims invalidation rate remains high: ~64% (FY2025 through H1), down from 70% in FY2024. Historically: 72% (2015), 70% (2024). When PTAB takes a case, patent claims are more likely to fall than survive.

### Ex Parte Reexamination
Any person (including anonymous) can request reexam based on patents/publications raising substantial new question of patentability. USPTO grants ~92% of requests. No estoppel. Used when IPR petition would be time-barred or estoppel is a concern.

---

## Patent Misuse and Inequitable Conduct

**Inequitable conduct**: Applicant deliberately withheld material prior art or made misrepresentations with intent to deceive USPTO. If found: renders entire patent **unenforceable** (not just invalid). Post-Therasense (2011 Fed. Cir. en banc), very hard to prove — requires both materiality (but-for standard) AND specific deceptive intent. No longer a frequently successful defense.

**Patent misuse**: Antitrust-flavored defense where patentee tries to extend patent rights beyond their scope (e.g., tying licensed product to unpatented goods). Successful defense renders patent unenforceable until misuse is purged.
