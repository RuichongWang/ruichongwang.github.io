# CRISPR Frontiers — Active Research and Open Questions

## Table of Contents
1. [Personalized / N-of-1 CRISPR](#personalized-crispr)
2. [In Vivo Delivery Beyond the Liver](#beyond-liver)
3. [Epigenome Editing at Scale](#epigenome-editing)
4. [Large-Scale Genome Engineering](#large-scale)
5. [Spatial CRISPR Screens](#spatial-screens)
6. [Agriculture and Non-Human Applications](#agriculture)
7. [Germline Editing: Status and Debates](#germline)
8. [AI-CRISPR Integration](#ai-crispr)
9. [Open Questions and Active Debates](#debates)

---

## Personalized / N-of-1 CRISPR

Baby KJ (2025) demonstrated the regulatory and manufacturing feasibility of patient-specific CRISPR therapies. Key enabling factors:

**Regulatory**: FDA's N-of-1 IND framework (individual patient INDs under 21 CFR 312.310) allows compassionate use with expedited review. Baby KJ IND was authorized in weeks, not months.

**Manufacturing**: LNP-based delivery allows faster manufacturing than viral vectors. mRNA + sgRNA synthesis is faster than AAV production (~weeks vs. months). The base editor ABE8e mRNA + sgRNA can be manufactured GMP-compliant in ~4–6 weeks.

**Scalability challenge**: Current per-patient cost estimates for N-of-1 programs are $1–5M. "Semi-personalized" approaches (correcting one of a handful of common alleles) may extend reach without full bespoke design.

**Next cases**: The CPS1 case is inspiring similar programs for other urea cycle disorders, organic acidemias, and individual rare metabolic diseases. IGI and Children's Hospital Boston have announced infrastructure to scale this approach.

---

## In Vivo Delivery Beyond the Liver

Liver tropism of standard LNPs (ApoE-mediated) is a bottleneck. Active efforts:

### Lung Delivery
- 2024 Nature Biotechnology: LNP encapsulating engineered thermostable iGeoCas9 RNP achieved 16–37% editing in mouse lung after IV injection. iGeoCas9 is >100× more active than native GeoCas9.
- Shuttle peptides (e.g., S10 peptide) can deliver RNPs to lung epithelial cells; fast turnover reduces duration of Cas9 presence → lower off-target accumulation.
- Application: CFTR correction for cystic fibrosis (non-liver target); inhaled delivery under investigation.

### CNS Delivery
- AAV9/AAVrh10 cross the BBB with some efficiency (systemic delivery)
- Direct intrathecal/intracranial injection for localized CNS editing
- CRISPR for Huntington's disease (HTT KO/knockdown): CRISPRi or Cas13 approaches in preclinical
- CRISPRi + AAV for rodent models of ALS (SOD1): ~60% knockdown in motor neurons
- Challenge: immune activation in CNS is particularly dangerous; Cas9 immunogenicity + ASC speck formation documented in mouse CNS

### Muscle
- AAV8 + SaCas9 for exon skipping in DMD: proof-of-concept in mice + dogs
- Cardiac muscle: IV AAV9; cardiac tropism; editing of SCN5A (arrhythmia) and PCSK9 (cardiac-specific) in preclinical

### Eye
- Subretinal AAV delivery for RPE65 (Leber congenital amaurosis): safety established (Editas EDIT-101 in clinical trial)
- Intravitreal for photoreceptors

### GalNAc Conjugation
- GalNAc (N-acetylgalactosamine) binds ASGPR (asialoglycoprotein receptor) on hepatocytes — 500,000 receptors/cell
- Verve's GalNAc-LNP achieves higher hepatic specificity, lower off-tissue dose → improved safety
- Applied to RNAi (Alnylam's inclisiran): clinical precedent for GalNAc-conjugated nucleic acid delivery

---

## Epigenome Editing at Scale

### CRISPRoff (heritable silencing)
Developed by Nunez et al. (2021, Cell) and actively extended 2023–2025. dCas9 + DNMT3A + DNMT3L + KRAB → deposits H3K9me3 + DNA methylation at target promoter. Key feature: once deposited, methylation is maintained through cell division without continued CRISPRoff expression.

Applications:
- Silencing repeat elements (endogenous retroviruses) without DSBs
- Tumor suppressor reactivation (CDKN2A, RB1) context in cell therapy
- HbF induction via BCL11A promoter methylation (alternative to Casgevy)

### CRISPRai (bidirectional, 2024)
Nature Biotechnology 2024: simultaneous activation at one locus + repression at another locus in the same cell. Enables dissecting gene regulatory interactions in a single perturbation experiment.

### Clinical Epigenome Editing
- CRISPRi for hepatitis B (targeting cccDNA): Phase 1 trials initiated; hepatitis B cccDNA persists in hepatocyte nuclei as episomal DNA; CRISPRi can silence transcription without needing to cut
- CRISPRi for muscular dystrophy: dystrophin regulatory circuit modulation

---

## Large-Scale Genome Engineering

Advances in CRISPR-mediated large sequence manipulation (2025, Nature Experimental & Molecular Medicine):

- **Megabase-scale deletions**: CRISPR with two guide RNAs flanking a chromosomal segment → precise deletion of 1+ Mb
- **Chromosomal rearrangement**: creating specific translocations to model cancer mutations
- **Chromatin organization editing**: deleting CTCF sites to reorganize topologically associating domains (TADs) → gene regulatory rewiring
- **Safe harbor loci**: AAVS1, ROSA26, H11 — large, transcriptionally permissive loci used for stable transgene insertion

**Therapeutic application**: CAR-T manufacturing uses TRAC locus as safe harbor for CAR insertion (disrupts TCR while inserting CAR cassette in one step).

---

## Spatial CRISPR Screens

Integration of CRISPR perturbations with spatially resolved transcriptomics:

- **Perturb-FISH**: delivers sgRNAs to cells in tissue sections; reads out transcriptome + guide identity with spatial coordinates
- **Perturb-Multi**: extends to multi-modal readouts (ATAC, protein) with spatial context
- Application: mapping gene function in tumor microenvironment; identifying cell-state-specific dependencies; dissecting cell-cell communication genes

Significance: classic Perturb-seq (single cell) loses spatial context; spatial screens reveal which cells in a tissue change phenotype after gene KO, without disrupting tissue architecture.

---

## Agriculture and Non-Human Applications

CRISPR in agriculture diverges on regulatory treatment:
- **US (USDA SECURE rule, 2020)**: edits that could arise naturally (small indels, single-base changes) are not regulated as GMO
- **EU**: more restrictive; 2023 proposed regulation would relax rules for "NGT1" (small edits similar to conventional breeding); under ongoing legislative debate

### Examples:
- **Waxy corn (Corteva)**: CRISPR KO of GBSS1 → waxy starch phenotype; approved/commercialized
- **Disease-resistant crops**: CRISPR editing of susceptibility genes (e.g., mlo for powdery mildew in wheat)
- **Hornless cattle (Recombinetics)**: POLLED allele insertion — raised concerns about unintended antibiotic resistance gene insertion discovered in FDA review (2019); highlights off-target monitoring necessity even in agricultural CRISPR
- **Reduced-acrylamide wheat**: KO of asparagine synthetase reduces acrylamide formation during baking
- **High-GABA tomatoes (Sanatech, Japan)**: CRISPR KO of GAD gene regulatory domain → elevated GABA; first commercially sold CRISPR food crop (Japan, 2021)

---

## Germline Editing: Status and Debates

### He Jiankui (2018) aftermath
He Jiankui edited CCR5 in human embryos (CRISPR KO to confer HIV resistance) → first reported CRISPR-edited babies (twins Lulu and Nana; third child). Sentenced to 3 years in prison by Chinese court (2019). International consensus: premature, unethical.

### Current consensus (2026 position):
- **Somatic gene editing**: broadly accepted; in clinical trials
- **Germline editing for therapeutic purposes**: moratorium recommended by international commissions (WHO, NASEM) until safety/efficacy demonstrable and societal consensus reached
- **Enhancement germline editing**: widely condemned

### Technical gaps preventing germline editing:
1. No validated safety readout for mosaicism (editing efficiency varies between cells in embryo → some cells corrected, some not)
2. Off-target detection in single-cell/few-cell contexts is unreliable
3. Long-term consequences of heritable edits unknown
4. Alternative (preimplantation genetic testing + IVF) available for most heritable conditions

### Embryo-level research:
- Legal in some jurisdictions (UK, China, US for research) under 14-day rule
- Base editing and prime editing in human embryos: published proof-of-concept; not clinically deployed

---

## AI-CRISPR Integration

Active intersection of ML/AI with CRISPR:

- **Guide RNA design**: deep learning models (DeepCRISPR, CROTON, Azimuth 2.0) predict on-target efficiency + off-target risk from sgRNA sequence; outperform rule-based tools
- **Off-target prediction**: GraphRNA, CRISPR-ML use graph neural networks on sequence + chromatin accessibility data
- **Protein engineering**: AlphaFold2 and RFdiffusion used to design novel Cas variants with altered PAM specificity and/or smaller size
- **pegRNA design**: PrimeDesign and PRIDICT (ML-based) predict prime editing efficiency from pegRNA sequence + local chromatin context; PRIDICT2.0 published 2024 with improved accuracy
- **Base editor design**: BE-DICT predicts base editing outcomes at every position in the window; useful for minimizing bystander edits

---

## Open Questions and Active Debates

### 1. Off-target threshold: what is acceptable clinically?
No consensus on acceptable off-target editing frequency for somatic gene therapy. Current FDA stance: case-by-case. The structural variant discovery (2025) suggests amplicon sequencing is insufficient; long-read WGS may become required.

### 2. Myeloablation alternatives
All current HSC-based therapies require myeloablative conditioning (busulfan/treosulfan). This is toxic (infertility, infection risk, mortality ~1–3%), limits access to tertiary centers, and is prohibitive in low-resource settings. In vivo HSC editing (targeting HSCs directly in the bone marrow via IV delivery) could bypass this — active research area.

### 3. Prime editing efficiency in vivo
PM359 is ex vivo. In vivo prime editing is difficult: pegRNA is large (impairs LNP encapsulation), PE2/PE3 enzymes are large (~210 kDa), efficiency drops sharply in non-dividing cells. Split-intein PE delivery (two AAVs reconstituting PE protein) in preclinical.

### 4. Epigenome editing durability
CRISPRoff methylation is heritable but can be erased. What happens over decades? Stem cell differentiation? Reprogramming events? No long-term human data.

### 5. Access and equity
Casgevy costs $2.2M/patient. Global SCD burden is ~90% in sub-Saharan Africa, Brazil, and India — precisely where this price is least accessible. mRNA/LNP-based in vivo approaches, simpler ex vivo methods, and generic manufacturing are potential levers.

### 6. Cas protein immunogenicity management
Pre-existing anti-SpCas9 antibodies in ~58–79% of humans may neutralize LNP-delivered Cas9 protein. Strategies: SaCas9 (lower human seroprevalence), Cas12a, engineered Cas9 with de-immunized surface epitopes. No clinical trial has yet demonstrated this is a fatal barrier, but it's untested at scale.
