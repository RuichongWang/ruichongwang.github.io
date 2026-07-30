# CRISPR Mechanisms — Deep Reference

## Table of Contents
1. [Cas9 Conformational Dynamics](#cas9-conformational-dynamics)
2. [PAM Recognition and R-loop Formation](#pam-recognition)
3. [Repair Pathway Engineering](#repair-pathway-engineering)
4. [Base Editor Architecture Details](#base-editor-architecture)
5. [Prime Editor Architecture Details](#prime-editor-architecture)
6. [Editing Window Rules and Design Considerations](#editing-window-rules)
7. [Cas Variant Comparison](#cas-variant-comparison)
8. [Off-Target Detection Methods](#off-target-detection)
9. [Structural Variant Risk](#structural-variant-risk)
10. [High-Fidelity Cas9 Variants](#high-fidelity-variants)

---

## Cas9 Conformational Dynamics

SpCas9 (1368 aa) has two lobes: recognition (REC) lobe and nuclease (NUC) lobe. The HNH domain sits between the two Mg²⁺-dependent active sites.

**Three-state model:**
1. **Apo state**: disordered HNH, no DNA
2. **Surveillance state**: R-loop formed, HNH docked against target strand but not yet cleaved — this is the 2024-identified gatekeeper state (phys.org/Nature Biotechnology 2024). This intermediate interrogates whether the seed region (PAM-proximal 10–12 nt) fully matches. Mismatches here prevent HNH activation.
3. **Cleavage-competent state**: full R-loop + seed match → HNH swings into active conformation → DSB

The surveillance state explains why seed region mismatches are far more disruptive to activity than distal mismatches. This has practical implications: sgRNAs with strong seed complementarity to off-target sites are high-risk regardless of total mismatch count.

**Allosteric coupling**: RuvC and HNH are not independent — conformational change of HNH is required before RuvC cuts. Mutations in the REC lobe (e.g., HiFi Cas9: R691A) reduce non-specific DNA contacts and shift the surveillance state equilibrium toward requiring near-perfect complementarity.

---

## PAM Recognition

SpCas9 reads the PAM (5'-NGG-3') via two arginine residues (R1333, R1335) in the PAM-interacting (PI) domain. The PAM is on the non-target strand; Cas9 reads it directly in dsDNA prior to unwinding.

**PAM-proximal seed**: nucleotides 1–10 (counting from PAM) are most critical. Mismatches here: near-complete loss of activity. Distal mismatches (11–20): tolerated at 1–3 nt.

**PAMless SpRY variant** (2021, David Liu lab): engineered to accept NRN > NYN PAMs — dramatically expands targetable sites but comes with reduced specificity.

**PAM-flexible Cas9 variants**: SpCas9-NG (NG PAM), xCas9 (NG, GAA, GAT). Trade-off: expanded targeting range at cost of ~2–5× higher off-target rates.

---

## Repair Pathway Engineering

### Boosting HDR
- **Cell cycle synchronization**: HDR is restricted to S/G2; treatment with nocodazole or RO-3306 (CDK1i) can enrich for S/G2 cells
- **NHEJ inhibition**: M3814 (DNA-PKcs inhibitor), NU7441 — but see structural variant concerns below
- **RAD51 stimulation**: RS-1 compound modestly enhances HDR
- **ssDNA donors**: single-stranded oligo donors (ssODN) can achieve 20–40% HDR in some cell types without the large structural variant risk of dsDNA donors

### MMEJ (Microhomology-Mediated End Joining)
Predictable deletions when 5–25 bp microhomologies flank the cut site. Tools like MENTHU and inDelphi predict MMEJ outcomes. Exploited therapeutically when a specific deletion is the goal (e.g., exon skipping for Duchenne muscular dystrophy).

### Base Excision Repair (BER) in Base Editing
CBEs create U:G mispairs. BER pathway (UNG enzyme) can excise U → abasic site → random transversion. Modern CBEs co-express UGI (uracil glycosylase inhibitor) to block this, increasing C→T conversion efficiency and reducing indels from abasic sites.

---

## Base Editor Architecture

### CBE (Cytosine Base Editor)
- **BE4max**: nCas9(D10A) – APOBEC3A/APOBEC1 – UGI × 2; editing window positions 4–8 (counting PAM-distal nt as 1)
- **evoAPOBEC-BE4max**: engineered APOBEC with narrower window, fewer off-target RNA edits
- **Key issue**: APOBEC deaminases can edit off-target ssDNA and RNA (transcriptome-wide RNA off-targets documented by Dagan et al. 2019)

### ABE (Adenine Base Editor)
- **ABE8e**: nCas9 – TadA-8e (evolved from E. coli TadA); editing window positions 4–7
- TadA-8e has ~590× higher activity than original ABE7.10 but also higher off-target RNA editing. ABE8.20-m (additional mutations) reduces RNA off-targets while maintaining DNA editing efficiency.
- A→G conversion; installs G at target → useful for restoring splice donor/acceptor sites, correcting gain-of-function point mutations

### Glycosylase Base Editors (GBE)
Fusion of nCas9 + UNG + cytidine deaminase to install all four base types at C positions; achieves C→A, C→G transversions (not possible with standard CBE/ABE). Still largely pre-clinical.

---

## Prime Editor Architecture

### pegRNA Structure
A standard sgRNA extended at the 3' end with:
1. **Linker sequence** (typically 4–16 nt hairpin to block RNase H)
2. **RT template**: encodes the desired edit sequence (10–30 nt)
3. **Primer binding site (PBS)**: complementary to 3' flap generated by nicking; 8–15 nt typically

**epegRNA**: pegRNA with structured 3' motifs (evoPreQ1, mpknot) that protect the 3' extension from degradation → 3–4× efficiency improvement over standard pegRNA. Now standard practice.

### PE2 vs PE3 vs PE5
- **PE2**: nCas9 + MMLV RT; pegRNA only; single nick on target strand
- **PE3**: PE2 + second sgRNA to nick opposite strand ~40–90 nt from edit; forces mismatch repair to use edited strand; ~3× efficiency improvement; ~10× more indels
- **PE3b**: second sgRNA designed to nick only after edit is installed (nick site created by edit); reduces indels relative to PE3
- **PE5**: PE3 + MLH1dn (dominant-negative MLH1) to suppress mismatch repair → further efficiency gains

### Efficiency Benchmarks
Typical prime editing efficiency in primary human HSCs: 10–40% for point mutations. In HEK293T: 20–60%. Efficiency drops sharply for large insertions (>50 bp) and transversions at GC-rich sites. ClinVar suggests ~89% of pathogenic variants are theoretically addressable by prime editing.

---

## Editing Window Rules

### CBE Window
- Count nt from PAM-distal end: nt 1 (most distal) to nt 20 (PAM-proximal)
- CBE BE4max edits C at positions 4–8
- If multiple C residues in window: all may be edited (bystander editing); use BE variants with narrower windows or target site design to avoid

### ABE Window
- ABE8e: positions 4–7 most efficiently edited
- Adenines outside window can still be edited at lower rates

### Prime Editing
- No strict window; edit defined by pegRNA RT template
- Typical range: PAM-proximal installs most efficiently; edits >30 nt from nick are possible but less efficient
- Larger RT templates (>30 nt) reduce efficiency; optimal ~10–20 nt edit + 8–13 nt PBS

---

## Cas Variant Comparison

| Variant | Size (aa) | PAM | DSB type | Key use case |
|---|---|---|---|---|
| SpCas9 | 1368 | NGG | Blunt | Standard editing, most guides available |
| SaCas9 | 1053 | NNGRRT | Blunt | AAV delivery (smaller) |
| Cas12a/Cpf1 | ~1200 | 5'-TTTV | 5' overhang staggered | Multiplex editing, AT-rich targets |
| Cas12b | ~1100 | TTN | Blunt | In vivo with AAV |
| CasΦ | ~700 | 5'-TBN | DSB | Ultra-compact phage origin, minimal PAM |
| Cas13 | ~1000 | None (RNA) | RNA cleavage | RNA knockdown, diagnostics (SHERLOCK) |
| dCas9 | 1368 | NGG | None | CRISPRi, CRISPRa, CRISPRoff, imaging |
| nCas9 (D10A) | 1368 | NGG | Nick (target strand) | Base editors, prime editors |
| SpRY | 1368 | NRN | Blunt | Near-PAMless; reduced specificity |

---

## Off-Target Detection Methods

### Unbiased Genome-wide Methods
| Method | Principle | Sensitivity | Notes |
|---|---|---|---|
| GUIDE-seq | dsDNA oligo integration at DSBs → sequencing | High (~0.1%) | Requires oligo transfection; misses low-frequency events |
| CIRCLE-seq | Circularized genome + in vitro cleavage | Very high | In vitro only; doesn't capture cellular context |
| DISCOVER-seq | ChIP with MRE11 (DSB marker) → sequencing | High | Works in primary cells; no exogenous tag |
| HTGTS | Translocation-based; reporter target + bait | High | Detects translocations specifically |
| CRISPRoffT | Database of predicted + empirical off-targets | Computational | ~2024 update; good for guide screening |

### Computational Prediction
Tools: Cas-OFFinder, CHOPCHOP, CRISPOR, CRISPR-ML (ML-based). Predictive accuracy remains insufficient — in vitro predictions do not reliably capture cellular off-target profiles. Population-specific variants can create novel PAM sites not in reference genome.

---

## Structural Variant Risk

Nature Communications 2025 identified that DSBs near repetitive elements and during DNA-PKcs inhibition can cause:
- **Megabase-scale deletions** (up to several Mb)
- **Chromosomal translocations** between edited chromosomes
- These occur at rates that can be missed by standard amplicon sequencing but are detectable by long-read WGS

**Risk mitigation**:
- Prefer base editors / prime editors (no DSBs) when target permits
- Avoid DNA-PKcs inhibitors unless absolutely necessary
- Use long-read whole-genome sequencing as safety QC, not just amplicon sequencing
- For clinical programs: karyotyping + ddPCR for translocation detection is now increasingly standard

---

## High-Fidelity Cas9 Variants

| Variant | Key mutations | Off-target reduction | Activity retention |
|---|---|---|---|
| eSpCas9 | K848A, K1003A, R1060A | ~10–100× | ~80–90% |
| SpCas9-HF1 | N497A, R661A, Q695A, Q926A | ~10–100× | ~70–90% |
| HiFi Cas9 | R691A | ~10× | ~95% |
| evoCas9 | M495V, Y515N, K526E, R661Q | ~10–100× | ~80% |
| Sniper-Cas9 | E782K, K890N, C1252W | ~10–100× | ~85% |

Note: HiFi Cas9 (R691A) has become preferred for clinical development due to minimal activity loss. eSpCas9 and SpCas9-HF1 sometimes show reduced editing at difficult target sites.
