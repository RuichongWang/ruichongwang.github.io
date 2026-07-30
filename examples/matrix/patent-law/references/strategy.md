# Patent Strategy

Startup IP, software/AI patents, biotech patents, portfolio building, licensing, M&A due diligence.

---

## Startup Patent Strategy: Core Principles

### The Investor Signal
- EPO/EUIPO 2023 study: startups with patents + trademarks are **~10x more likely** to secure VC funding
- Patents create defensible IP moat; signal technical depth and R&D commitment
- In Series A/B due diligence, VCs routinely ask: "Do you have any patents or pending applications?"

### When to File
**File before you disclose.** This means:
- Before presenting at conferences, meetups, or demos
- Before any non-confidential investor conversations
- Before product launch / public beta
- Before publishing any research or blog posts about the technology

**One-year US grace period is a trap**: You technically have 1 year after public disclosure to file in the US, but this permanently destroys foreign patent rights in most jurisdictions. If you may ever want European, Chinese, Japanese, or Korean protection, file before you disclose — period.

### Provisional First Strategy
For cash-constrained startups:
1. File a **detailed provisional** (~$500–$2,000 with attorney) immediately — establishes priority date
2. Within 12 months, file non-provisional (and PCT if foreign protection desired)
3. This buys 12 months to validate the market, raise funding, and build the product before committing to full prosecution costs (~$10,000–$20,000 for non-provisional + prosecution)

**Trap**: A thin provisional that doesn't adequately describe what you actually build gives a filing date but no protection. Write provisionals with the same care as non-provisionals — or at least describe every embodiment and use case you anticipate.

### Portfolio Building
- **Quantity matters**: A single patent is easy to design around. A thicket of 5–20+ claims covering different aspects of a system is much harder to circumvent
- **Continuation strategy**: File continuations to pursue claims tailored to actual infringers; pending applications keep competitors uncertain about scope
- Protect the core invention (independent claims), the commercial embodiment (dependent claims), and manufacturing methods separately

---

## Software Patent Strategy

### The Alice Problem
Software patents face §101 subject-matter eligibility rejections under the Alice framework (see `validity.md`). Strategy:

**What survives Alice**:
- Technical improvements to computer operation (lower latency, less memory, faster processing — quantified)
- Specific novel algorithms tied to concrete technical output
- Unconventional arrangements of hardware achieving specific technical results

**What fails Alice**:
- "Do it on a computer" claims — traditional mental processes / business methods automated
- Abstract data collection and display
- Generic ML/AI applied to a business domain (without technical specificity)

**Drafting approach**:
- Start with the technical problem the software solves (not the business problem)
- Recite the specific technical mechanism (the algorithm steps, data structures, network architecture elements)
- Claim the system embodiment AND the method embodiment AND the CRM (computer-readable medium) embodiment
- Add dependent claims with progressively more technical specificity

### AI-Specific Issues (2025)

**Inventorship for AI-assisted inventions**:
- USPTO 2024 guidance (reinforced 2025): AI cannot be a named inventor
- Human inventor must have made a **significant contribution to conception** of at least one claim
- Using AI as a tool (suggestion, drafting assistance, analysis) does not disqualify human inventors
- Merely directing an AI to achieve a result, where the AI determines the method, may be insufficient

**Patentable AI subject matter** (despite Alice concerns):
- Novel neural network architectures with specific technical improvements
- Training methods with specific data processing steps achieving measurable improvements
- AI applications in biotech/pharma (easier at EPO than USPTO)
- Systems with specific hardware configurations required for claimed AI function

**Claim drafting for AI**:
- Claim specific training procedures, not just "trained on data"
- Claim specific architectures, not just "a neural network"
- Claim measurable technical improvements in output quality, speed, accuracy
- Claim hardware-software combinations that achieve results unachievable in software alone

---

## Biotech Patent Strategy

### Timeline Reality
Biotech prosecution is slow and expensive:
- Typical prosecution: 3–5 years to grant
- Costs: $15,000–$50,000 prosecution per patent family (not counting expert declarations, interviews)
- Biotech patents have complex enablement requirements post-Amgen v. Sanofi (2023 SCOTUS)

### The Amgen Problem (Antibody and Genus Claims)
Amgen v. Sanofi (2023 SCOTUS) upheld invalidation of Amgen's broadly-claimed antibody genus covering "antibodies that bind to PCSK9 and block its activity." The Court held the claims were not enabled because the specification only described a small number of examples from a vast genus.

**Post-Amgen strategy**:
- Narrow genus claims to specific antibody sequences (or structural features) actually characterized in the spec
- File multiple applications covering different characterized species
- Include extensive characterization data in the specification (binding affinities, in vitro/in vivo data)
- Consider claiming by structure, not just function

### Continuation/Divisional Use in Pharma (Evergreening)
Pharmaceutical companies routinely file continuation applications covering:
- Formulations
- Dosing regimens
- Methods of treatment
- Metabolites and prodrugs
- Combination therapies
- Crystalline forms (polymorph patents)

This "evergreening" strategy extends effective market exclusivity beyond the core compound patent. Regulators and courts have become more scrutinizing of evergreening tactics (FTC actions; PTAB challenges by generics).

### Orange Book and Hatch-Waxman
Drug patents can be listed in the FDA Orange Book. When a generic manufacturer files an ANDA (Abbreviated New Drug Application), they must certify either (Paragraph IV) that listed patents are invalid or not infringed. This triggers a 30-month stay of generic approval and an automatic Hatch-Waxman patent infringement suit. This creates a defined litigation funnel for pharma patent battles.

### EPO Biotech Advantage
At the European Patent Office:
- AI and software are significantly easier to patent in the biotech context (technical character found more readily)
- Claims to computer-implemented methods for bioinformatics analysis, protein structure prediction, etc. are routinely granted if tied to specific technical improvements
- Broader genus claims for biologics can survive that would fail US §101 or Amgen enablement challenges

---

## Patent Licensing

### Types of Licenses
- **Exclusive license**: licensee is the only one who can practice the patent (may or may not include right to sublicense or sue infringers)
- **Non-exclusive license**: licensor retains right to license others
- **Field-of-use restricted**: license limited to specific application domain
- **Geographic**: limited to specific jurisdictions

### License Agreement Key Provisions
1. **Scope**: what patents, what fields, what geography
2. **Royalty structure**: running royalty (% of revenue), lump sum, milestone payments
3. **Minimum royalties**: guaranteed annual payment regardless of sales
4. **Sublicensing**: allowed? Licensor gets % of sublicense fees?
5. **Improvement patents**: who owns improvements; cross-license obligations
6. **Audit rights**: licensor can audit licensee's books
7. **Termination**: for breach, for non-payment, bankruptcy of licensee
8. **Patent marking**: licensee required to mark products with patent numbers (affects damages)

### Patent Marking (35 USC §287)
Patentees must mark products with the patent number (or a URL to a marking page) to recover **pre-suit damages**. Without marking, damages run only from the date of actual notice of infringement (cease-and-desist letter). This can cut off years of damages.

**Virtual marking**: Can use format "Patent: www.example.com/patents" with the URL listing applicable patent numbers — avoids need to retool packaging when new patents issue.

---

## M&A and Due Diligence

### Patent Due Diligence Checklist
1. **Ownership verification**: recorded assignments in USPTO; unrecorded assignments may not be effective against bona fide purchasers
2. **Chain of title**: confirm inventor(s) → employer/assignee → current owner; missing assignment breaks chain
3. **Encumbrances**: existing licenses (especially exclusive); royalty obligations; co-ownership (any co-owner can license without consent of others — a major issue)
4. **Prosecution history review**: assess strength; identify potential estoppel issues
5. **Maintenance fee status**: patents lapse if maintenance fees not paid (3.5, 7.5, 11.5 years for utility patents)
6. **Pending proceedings**: any IPR, PGR, reexam, litigation?
7. **FTO for target's products**: does target have freedom to operate in its market?

### Key Trap: Co-Ownership
Under US law (35 USC §262), any co-owner of a patent can **practice the invention or license others without the consent of, and without accounting to, co-owners**. If an inventor was a co-inventor on a patent and their assignment was not properly captured, they may have co-ownership rights and could independently license to your competitors. Always audit inventorship and assignment records in diligence.

---

## International Patent Strategy

### Major Jurisdictions
| Jurisdiction | Key Characteristics |
|-------------|---------------------|
| EPO (European Patent Office) | Single application; national validation required after grant; software/AI more patent-eligible than US in biotech context |
| China (CNIPA) | World's largest patent filer; examination improving; local enforcement increasingly effective; separate utility model system |
| Japan (JPO) | Strong manufacturing base; software more eligible than EPO; fast prosecution |
| South Korea (KIPO) | Strong semiconductor/electronics coverage; fast examination |

### Cost Reality
International patent prosecution is expensive:
- European national validation: €1,000–€3,000 per country per year in renewal fees; translation costs
- Full international portfolio (US + EU + China + Japan + Korea): $50,000–$200,000 through prosecution per patent family

**Prioritization**: File PCT, then narrow to countries where: (1) competitors manufacture, (2) key customers/markets are, (3) you might license or sell. Skip jurisdictions where enforcement is impractical.

### Trade Secrets as Alternative
For process innovations (manufacturing methods, algorithms embedded in products), trade secrets may be superior to patents:
- No disclosure requirement
- No 20-year expiration
- Protects against independent development only if misappropriation occurred
- Destroyed by reverse engineering of a publicly sold product
- Requires active confidentiality measures (NDAs, access controls, documented policies)

Decision framework: If the innovation is (a) extractable by reverse engineering of the product or (b) must be disclosed to work with partners/standards bodies, trade secret protection is weak → file patent. If the innovation is a manufacturing process or internal algorithm that can be kept truly secret → consider trade secret first.
