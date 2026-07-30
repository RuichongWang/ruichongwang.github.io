# Patent Prosecution

Filing, examination, office actions, appeals, international filing, patent term.

---

## Filing: Application Types

### Provisional Application
- **Cost**: USPTO fee ~$320 (micro entity: ~$80); no claims required
- **Effect**: establishes priority date for 12 months; patent term runs from non-provisional filing date, NOT provisional
- **Trap**: Provisional must adequately support the claims in the non-provisional. A poorly written provisional that doesn't describe the actual invention gives you a filing date but no priority benefit — examiners and courts look at whether the provisional "supports" each claim element under §112
- **No examination**: provisionals are never examined and automatically expire after 12 months if non-provisional not filed

### Non-Provisional (Utility Patent Application)
Required components:
1. **Specification** — background, summary, detailed description, brief description of drawings
2. **Claims** — at least one; additional claims incur excess-claim fees (>3 independent, >20 total)
3. **Abstract** — 150 words max
4. **Drawings** — required if necessary to understand the invention
5. **Oath/Declaration** — inventor(s) declare they believe themselves to be the original inventor(s)
6. **Filing fees** — ~$1,820 standard entity; ~$910 small entity; ~$455 micro entity (FY2025 rates)

### Continuation Applications
Filed while parent is pending; claims benefit of parent's filing date:
- **Continuation (CON)**: new claims, same disclosure as parent
- **Continuation-in-Part (CIP)**: adds new subject matter (new matter only gets new filing date)
- **Divisional (DIV)**: covers claims that were restricted out of parent

**Strategic use**: File continuations to pursue broader claims after seeing competitor products; to tailor claims to specific infringers; to maintain prosecution pendency as an asset (pending claims = competitor uncertainty). Keep at least one continuation pending in important technology areas.

**Prosecution laches trap**: Unreasonable and unexplained delay in prosecution can render a patent unenforceable. The Federal Circuit (Sonos v. Google, 2023) reinvigorated this doctrine. Continuation chains pending 10+ years with no satisfactory explanation risk a prosecution laches defense.

---

## PCT (Patent Cooperation Treaty)

Covers 157+ contracting states. Does NOT grant an international patent — grants 30 months from priority date to enter national/regional phase in chosen countries.

**Timeline**:
- File PCT within 12 months of US priority date
- International Search Report (ISR) issued ~16 months from priority
- International Preliminary Report on Patentability (IPRP) issued ~28 months from priority
- National phase entry: **30 months** from earliest priority date (most countries; a few require 20 months)

**Cost advantage**: One PCT filing delays the need to pay national fees and hire local counsel in each country for 18 months. Valuable for startups that need to validate market before committing $50–$150K+ in foreign prosecution costs.

**Trap**: PCT does NOT cover Taiwan. File directly in Taiwan's TIPO within 12 months of priority if Taiwan protection matters.

---

## USPTO Examination Process

### Timeline (2025 data)
- First office action: **~22.6 months** average from filing (FY2025)
- Total prosecution to grant: **24–36 months** (standard exam); **12–18 months** (Track One)
- Backlog: **800,000+** unexamined utility applications as of late 2024
- **Track One (Prioritized Examination)**: $4,200 fee (standard entity); guarantees first OA within 6–8 months; grant within ~12–18 months; capped at 15,000 requests/year

### Patent Term Adjustment (PTA)
When USPTO delays exceed statutory thresholds, days are added to the patent's 20-year term (35 USC §154(b)):
- >14 months to first OA: each excess day adds to term
- >4 months to respond to applicant submissions: adds to term
- Most grants in 2025–2026 carry **8–12 months of PTA**
- Beware: PTA is reduced by applicant delays (RCEs, extensions of time)

### Office Action Types

**Non-Final Rejection** (first substantive rejection):
- Applicant has 3 months to respond (extendable to 6 months for fee)
- Must address each rejection; can amend claims, argue, or both
- Can introduce new claims if no new matter

**Final Rejection**:
- Issued after applicant amends; examiner has discretion to issue final
- Options: (1) file RCE (Request for Continued Examination, ~$1,360 standard entity fee) — reopens prosecution; (2) file Notice of Appeal; (3) after-final amendment (may or may not be entered)
- **After Final Consideration Pilot (AFCP 2.0)**: request examiner spend extra time with amendment; no fee; sometimes resolves issues without RCE

**Interview Practice**: Request examiner interview early in prosecution. Examiners generally appreciate them; resolves misunderstandings faster than written responses. Can be done telephonically.

### Common Rejection Types

| Rejection | Statute | Response Strategy |
|-----------|---------|-------------------|
| Anticipation | §102 | Distinguish claim from cited reference element-by-element; OR amend to add undisclosed feature |
| Obviousness | §103 | Attack motivation to combine; argue unexpected results, commercial success, long-felt need (secondary considerations) |
| Abstract idea / ineligible | §101 | Argue practical application; add technical specificity; invoke post-Alice case law |
| Lack of written description | §112(a) | Show original disclosure supports claim scope; amend to match spec |
| Indefiniteness | §112(b) | Clarify ambiguous terms with spec support |

### Appeals

**PTAB Ex Parte Appeal** (from examiner):
- Notice of Appeal: 2 months from final rejection (extendable to 6)
- Appeal Brief: 2 months from filing Notice (extendable)
- PTAB reversal rate on appeal: ~35–45% for at least one rejection
- After PTAB decision: can appeal to Federal Circuit (expensive) or continue prosecution via RCE

**Pre-Appeal Brief Conference**: cheaper alternative; small panel of examiners reviews; resolves ~25% of cases without full appeal

---

## Examiner Psychology and Prosecution Strategy

- Examiners are rated on **counts** (work units per bi-week). RCEs generate counts; allowances generate counts. This creates incentive to reach resolution.
- **Compact prosecution**: examiners are supposed to raise all rejections in the first OA. Non-final rejections that introduce new grounds without justification can be petitioned.
- **Examiner amendments**: examiner can amend claims with applicant consent to resolve minor issues — useful for avoiding unnecessary RCEs
- Search for the examiner's allowance rate and art unit allowance rate on the Public Patent Application Information Retrieval (PAIR) system — useful for calibrating expectations

---

## Claim Drafting Principles (Prosecution-Level)

1. **Broadest reasonable interpretation (BRI)** standard applies during prosecution — broader than plain meaning in court
2. **Each element = a potential design-around point**: fewer elements = broader coverage; add elements in dependents
3. **Means-plus-function** claims (§112(f)): "means for [function]" language is construed narrowly to the disclosed structure — usually avoid unless specific reason
4. **Jepson claims**: "The improvement comprising..." — admit the preamble is prior art; rarely used but sometimes required
5. **Prosecution history estoppel**: arguments made during prosecution to distinguish prior art limit claim scope in litigation (Festo doctrine). Every argument you make narrows the doctrine of equivalents. Amend claims strategically, argue when possible.

**Critical trap**: Once you surrender claim scope through argument or amendment, you may not recapture it via doctrine of equivalents. Avoid making broader arguments than necessary.
