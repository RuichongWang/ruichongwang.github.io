# Patent Infringement and Enforcement

Claim construction, direct/indirect infringement, FTO analysis, litigation, damages, willfulness.

---

## Claim Construction: The Foundation of Every Infringement Analysis

Before any infringement or validity analysis, claims must be construed. Claim construction is a question of law (reviewed de novo on appeal).

### Phillips Standard (District Court / Litigation)
Claims are given their **ordinary and customary meaning** as understood by a PHOSITA at the time of the invention, in view of:
1. The claim language itself
2. The specification (most important intrinsic source)
3. Prosecution history (can limit scope via estoppel)
4. Extrinsic evidence (dictionaries, expert testimony — less weight)

**Critical difference from prosecution**: During USPTO examination, claims are given their **broadest reasonable interpretation (BRI)**. A claim that survives prosecution under BRI may still be construed more narrowly in litigation under Phillips.

### Prosecution History Estoppel (Festo Doctrine)
When an applicant **amends claims** or makes **arguments** during prosecution to distinguish prior art, the doctrine of equivalents is narrowed or eliminated for the surrendered territory. Key rules:
- Narrowing amendment creates presumption of surrender
- Can rebut by showing amendment was for unrelated reasons or equivalent was unforeseeable at time of amendment
- Arguments (without amendment) can also limit claim scope

**Trap**: Patent attorneys sometimes make broader arguments than necessary to overcome rejections. Each such argument is a potential estoppel. Less is more in prosecution arguments.

---

## Direct Infringement (35 USC §271(a))

Whoever **makes, uses, offers to sell, sells, or imports** the patented invention infringes, without authorization, in the United States.

### All-Elements Rule
Every element (limitation) of a claim must be present in the accused device/method, either literally or under the doctrine of equivalents.

**Literal infringement**: The accused product/process includes every element of the claim exactly as written.

**Doctrine of Equivalents (DOE)**: Even if an element is not literally present, infringement if the accused product performs substantially the same function in substantially the same way to achieve substantially the same result (the **function-way-result** test, or the **insubstantial differences** test).

DOE is limited by:
- **Prosecution history estoppel** (see above)
- **Prior art**: Cannot use DOE to claim what would have been in the prior art
- **Specific exclusion**: If the patentee explicitly disclaimed an equivalent, cannot recapture via DOE
- **All-elements rule**: DOE cannot vitiate an entire claim element

### Divided / Joint Infringement
Method claim infringement requires **a single entity** to perform (or direct and control) all steps. If steps are divided between two independent parties, no single-actor infringement under Muniauction/Akamai (Fed. Cir. en banc, 2015). This is a significant gap for software/platform method claims — draft claims carefully to ensure all elements are performed by one party.

---

## Indirect Infringement

### Induced Infringement (§271(b))
Whoever actively **induces** infringement by another is liable. Requires:
1. Knowledge of the patent
2. Specific intent to encourage infringement
3. Actual direct infringement by another party

Sales with instructions that lead users to infringe, if the seller knows the patent exists and intends users to follow the instructions, can constitute inducement.

### Contributory Infringement (§271(c))
Selling a material component of a patented invention, knowing it's especially designed for infringing use and not a staple article of commerce, is contributory infringement.

---

## Freedom to Operate (FTO) Analysis

An FTO analysis asks: can you make/sell/use your product without infringing others' unexpired patents?

### FTO Process
1. **Define the product/process** in claim-like terms — what are the key technical features?
2. **Search** for relevant issued patents and published applications (US and foreign if needed)
3. **Claim map**: for each potentially relevant patent, compare each claim element against the product — does the product meet every element?
4. **Assess risk**: is the patent enforceable? Valid? Who owns it? Are they litigious?
5. **Clearance opinions**: formal written FTO opinion from outside counsel

### FTO Cost-Benefit
- Full written FTO opinion: $15,000–$50,000+ depending on complexity and number of patents
- **Value of FTO opinion**: Evidence of good-faith due diligence; if infringement is later found, a well-reasoned FTO opinion is a factor against willful infringement finding and enhanced damages
- Even without a written opinion, a documented review process helps

### Designing Around
If a blocking patent is identified:
1. **Design around**: modify the product to avoid one or more claim elements
2. **License**: negotiate license with patent owner
3. **Challenge validity**: file IPR, PGR, or ex parte reexamination
4. **Wait it out**: assess when patent expires (check PTA; terminal disclaimers)
5. **Intervening rights**: if patent claims were narrowed during reexam, products made/sold before narrowing may have absolute or equitable intervening rights

---

## Patent Litigation

### Forum Selection
**Eastern District of Texas (EDTX)**: Most active patent court. Patent-friendly history; specialized judges; fast trials. In H1 2025, 12 of 21 high-damages cases filed in EDTX.

**Western District of Texas (WDTX)**: Rose in prominence post-TC Heartland. Less active recently as Judge Albright's docket management changed.

**Delaware**: Major corporate domicile; many patent owners incorporated in Delaware; experienced judges.

**TC Heartland (2017 SCOTUS)**: Patent venue only proper where defendant (1) is incorporated or (2) has committed infringement AND has a regular and established place of business. Eliminated forum shopping to EDTX for defendants without TX presence — but many defendants have sufficient TX presence.

### Litigation Costs
- Average case through trial: **$3M–$4M** per side
- Biotech/pharma complex cases: can exceed $10M per side
- Median patent damages award (2023): **$8.7 million**
- Largest recent award: VLSI v. Intel (H1 2025): **$948.76 million**

### Case Timeline (District Court)
- Scheduling order: claim construction (Markman) hearing typically 6–12 months after filing
- Fact discovery: 12–18 months
- Expert discovery: 3–6 months after fact discovery
- Trial: 24–36 months from filing (EDTX faster; Delaware/NDCal slower)

### ITC (International Trade Commission)
- 337 investigations for articles that infringe patents and are imported into the US
- No damages; remedy is **exclusion order** (blocks imports at the border) and **cease and desist order**
- **Fast**: trial (evidentiary hearing) within 12–16 months of filing
- No jury; Administrative Law Judge
- Powerful leverage in negotiations; often filed simultaneously with district court

---

## Patent Damages

### Types of Damages (35 USC §284)
- **Lost profits**: what the patentee would have made but for the infringement (Panduit test: demand, absence of acceptable alternatives, capability to meet demand, amount of profit)
- **Reasonable royalty**: minimum floor if lost profits not proven; most common
- **Reasonable royalty base**: often the entire market value rule (EMVR) — full product price — but courts now require the patented feature to be the basis for customer demand, or use **apportionment** to isolate the value of the patented feature

### Reasonable Royalty Analysis
**Georgia-Pacific factors** (1970) — 15-factor framework:
- Key factors: comparable licenses, royalties paid by licensee for similar patents, nature of competitive relationship, established royalty for the patent, portion of profit attributable to the invention vs. other elements
- "Hypothetical negotiation" between willing licensor and licensee at time infringement began

### Enhanced Damages (§284) — Willfulness
Courts may award up to **3x compensatory damages** for willful infringement. Standard post-Halo Electronics (2016 SCOTUS): subjective willfulness — did the infringer know of the patent and act despite objectively high risk of infringement?

**Seagate test** (pre-Halo): was overturned. Halo is more plaintiff-friendly — no longer need to show "objectively reckless" conduct.

**Evidence of willfulness**:
- Received a cease-and-desist letter and continued
- Copied a patented product
- Failed to take any action after learning of the patent
- Obtained FTO opinion but did not follow advice

**Evidence against willfulness**:
- Obtained and acted on FTO opinion
- Documented design-around analysis
- Attempted to license

### Attorney Fees (§285)
In **exceptional cases**, prevailing party can recover attorney fees. After Octane Fitness (2014 SCOTUS), lower standard — case can be exceptional based on totality of circumstances including unreasonable claim positions or litigation conduct. NPEs (non-practicing entities) have been hit with fee awards for bringing objectively weak cases.

---

## Non-Practicing Entities (NPEs) / "Patent Trolls"

NPEs hold patents without practicing the invention; monetize through licensing threats and litigation. Characteristics:
- Often target peripheral infringement (patents read on standard features of every product in a category)
- Demand license fees below cost of litigation ($200K–$500K typical demand below litigation threshold)
- File in EDTX or similar plaintiff-friendly venues
- File many parallel suits simultaneously to force settlements

**Defensive responses**:
- IPR petition (now harder given PTAB denial surge — see `validity.md`)
- Challenge on §101 eligibility (Alice — many NPE patents are software/business method patents vulnerable to Alice)
- **Covered Business Method (CBM) review**: available for financial products/services patents; broader grounds than IPR
- Seek attorney fees under §285 if case is weak
- Join coalitions (RPX, Allied Security Trust, Unified Patents) for defensive patent aggregation

**Unified Patents statistics (2025)**: Patent dispute activity increased in 2025, with significant concentration in technology sectors. Unified Patents filed 46+ challenges in 2025.
