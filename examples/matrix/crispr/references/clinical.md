# CRISPR Clinical Applications — Deep Reference

## Table of Contents
1. [Casgevy: BCL11A Biology and Trial Data](#casgevy)
2. [PM359: First Prime Editing in Humans](#pm359)
3. [Baby KJ: First Personalized CRISPR Therapy](#baby-kj)
4. [Verve Therapeutics: Cardiovascular Base Editing](#verve)
5. [CRISPR Therapeutics Pipeline (CTX110/CTX112)](#crispr-therapeutics)
6. [Beam Therapeutics: Base Editing in Blood Disorders](#beam)
7. [Intellia: In Vivo Liver Editing Programs](#intellia)
8. [Broader Trial Landscape (2025)](#trial-landscape)

---

## Casgevy: BCL11A Biology and Trial Data

### The BCL11A Switch
**BCL11A** (B-cell lymphoma/leukemia 11A) is a transcription factor that represses γ-globin gene expression (HBG1/HBG2) postnatally. In fetal/neonatal erythropoiesis, BCL11A is low → HbF (α2γ2) predominates. After birth, BCL11A rises → HbF replaced by HbA (α2β2) or, in SCD patients, HbS (α2βS2).

**Therapeutic logic**: BCL11A knockdown in erythroid lineage restores HbF. HbF directly inhibits HbS polymerization — even 20–30% HbF is therapeutically sufficient; patients with hereditary persistence of fetal hemoglobin (HPFH) due to natural BCL11A mutations are largely asymptomatic for SCD.

**The erythroid enhancer**: BCL11A has a hematopoietic stem cell-expressed form and an erythroid-specific enhancer at +58/+62/+55 regions. Casgevy's sgRNA targets the GATA1 transcription factor binding site in the +58 enhancer. This disrupts GATA1 occupancy → BCL11A not expressed in red blood cell precursors → HbF derepressed.

**Why this is elegant**: BCL11A is still expressed in other cell types (lymphocytes, where it's essential). The enhancer edit is erythroid-specific — lymphocyte BCL11A is unaffected. This prevents on-target toxicity from total BCL11A knockout.

### Manufacturing
Ex vivo: mobilize HSCs (G-CSF + plerixafor) → leukapheresis → CD34+ selection → electroporation with RNP (Cas9 protein + sgRNA) → quality testing (editing efficiency, sterility, cell viability) → cryopreservation → patient myeloablation with busulfan → infusion.

Manufacturing timeline: ~3–6 months. Cost: ~$2.2 million USD per patient (2024 list price).

### Trial Data (CLIMB-SCD-121 and CLIMB-THAL-111)
- **SCD (CLIMB-SCD-121)**: 29/31 patients with ≥12 months follow-up free of severe vaso-occlusive crises (VOC). 2 patients had 1 VOC each. Median HbF rose from <1% to >40% of total hemoglobin.
- **TDT (CLIMB-THAL-111)**: 39/42 patients with ≥12 months follow-up became transfusion-independent.
- Safety: no CRISPR-related serious adverse events. Adverse events primarily from myeloablative conditioning (mucositis, cytopenias, infections).
- Long-term follow-up (>48 months in early patients): HbF levels remain stable; no clonal expansion detected.

---

## PM359: First Prime Editing in Humans

### Disease: p47phox-Deficient Chronic Granulomatous Disease
CGD is a primary immunodeficiency where phagocytes cannot produce reactive oxygen species (ROS) via NADPH oxidase. The p47phox-deficient form (autosomal recessive, gene: NCF1) is caused by a founder deletion of GT at the beginning of exon 2 — present in ~25% of CGD patients. Without ROS, patients suffer recurrent life-threatening infections and inflammatory granulomas.

### PM359 Design
- **Edit**: corrects the 2-bp deletion in NCF1 using prime editing (insertion of GT)
- **Delivery**: ex vivo editing of autologous CD34+ HSCs
- **pegRNA**: targets NCF1; RT template restores the deleted GT; epegRNA with evoPreQ1 3' motif for stability
- **PE system**: PE3b configuration (second nick downstream of edit)

### First-in-Human Data (NEJM 2025)
Published: New England Journal of Medicine, 2025. Study: NCT06559176.

**Patient 1 results:**
- Editing efficiency in infused cells: not disclosed in early data cut
- Day 14: neutrophil engraftment confirmed (median ~27 days for Casgevy)
- Day 15: 58% of neutrophils DHR-positive (NADPH oxidase functional; clinical threshold: >20%)
- Day 30: 66% DHR-positive neutrophils, at healthy-donor intensity
- 6-month follow-up: ≥69% DHR-positive neutrophils; NADPH oxidase activity stable
- No serious adverse events related to PM359; busulfan-related AEs as expected

**Patient 2 results** (December 2025 announcement): Prime Medicine stated both patients "effectively cured" — same stable functional NADPH oxidase restoration at 6 months.

### Significance
- First peer-reviewed first-in-human prime editing data (NEJM)
- Faster engraftment vs. DSB-based gene therapies
- Demonstrates PM359 achieves therapeutic levels with no off-target toxicity signals
- Opens clinical path for prime editing for the ~6,000+ NCF1 CGD patients globally

---

## Baby KJ: First Personalized CRISPR Therapy

### Disease: CPS1 Deficiency
Carbamoyl phosphate synthetase 1 (CPS1) deficiency is a urea cycle disorder causing hyperammonemia. Ammonia accumulates → neurotoxicity. Incidence: ~1 in 1.3 million. Treatment: protein restriction + nitrogen scavengers (sodium benzoate, sodium phenylbutyrate) + liver transplant (curative but donor-limited). Without transplant, median survival is poor.

### KJ Muldoon Case
- Born 2024 with CPS1 deficiency (compound heterozygous mutations in CPS1)
- Research team at Children's Hospital of Philadelphia, Penn, IGI (Berkeley) and collaborators
- Custom base editor (ABE8e variant) designed to correct KJ's specific mutation
- **Delivery**: IV infusion of LNPs encapsulating mRNA for the base editor + sgRNA
- **Timeline**: mutation identified at birth → therapy designed, manufactured, FDA IND authorized → first dose administered at ~6 months of age (early 2025)
- Three doses total given (LNP redosability advantage over AAV)
- **Results**: KJ thriving; no serious adverse events; improved clinical stability, reduced medication burden; discharged home
- NEJM publication: May 2025

### Significance
- Proof of concept for "bespoke" CRISPR: one patient, one therapy, designed in 6 months
- Suggests a regulatory + manufacturing pathway for ultra-rare (<10 patients) conditions using N-of-1 IND framework
- LNP redosability demonstrated in a human: three doses delivered safely
- Model for in vivo liver-directed base editing of metabolic disorders

---

## Verve Therapeutics: Cardiovascular Base Editing

### Concept
**In vivo base editing** of hepatocytes to permanently inactivate genes controlling circulating lipoproteins. Single IV infusion; no ex vivo cell handling; LNP delivery.

### VERVE-101 (PCSK9 targeting, ABE)
- Target: PCSK9 (proprotein convertase subtilisin/kexin type 9) — degrades LDL-R
- Edit: A→G at splice site → loss-of-function; mirrors natural PCSK9 LOF variants that confer lifelong low LDL
- Delivery: LNP (lipid nanoparticle) carrying ABE mRNA + sgRNA
- Phase 1b (Heart-1): dose-dependent LDL-C reductions up to 55%; PCSK9 protein reductions up to 84% at potentially therapeutic doses
- **Pause (April 2024)**: one participant developed elevated liver enzymes (transaminitis grade 3) + thrombocytopenia; clinical hold → resumed but pivoted to VERVE-102 with improved LNP

### VERVE-102 (PCSK9, GalNAc-LNP)
- Same edit target; proprietary GalNAc-LNP (GalNAc conjugation targets ASGPR on hepatocytes → improved hepatic uptake, reduced off-tissue distribution)
- Phase 1b (Heart-2): April 2025 data — 53% mean LDL-C reduction at 0.6 mg/kg; maximum 69%; no SAEs; no clinically significant lab abnormalities
- Eli Lilly acquisition of Verve completed June 2025

### VERVE-201 (ANGPTL3 targeting)
- Target: ANGPTL3 (angiopoietin-like protein 3) — inhibits LPL and HL → high TG and LDL
- ANGPTL3 LOF variants (Mendelian) → low TG + low LDL + low CVD risk; no adverse phenotype in humans
- Phase 1b (Pulse-1): ongoing; targets refractory hypercholesterolemia patients
- Also uses GalNAc-LNP; designed to lower both LDL-C and triglycerides simultaneously

---

## CRISPR Therapeutics Pipeline

### CTX110 (CD19 CAR-T, allogeneic)
- Allogeneic ("off-the-shelf") CAR-T cells: donor T cells edited to KO TCRα (TRAC locus) + B2M (prevent rejection) + insert CAR construct
- Phase 1: complete responses in some relapsed/refractory B-ALL patients; durable responses limited by allogeneic rejection

### CTX112 (CD19, 4-edit allogeneic)
- Four edits: TRAC KO + B2M KO + CD52 KO (lymphodepletion resistance) + CAR insertion
- Phase 1/2 in R/R CD19+ B-cell malignancies
- 2024 ASH data: positive efficacy signals; FDA RMAT (Regenerative Medicine Advanced Therapy) designation granted 2024
- RMAT designation allows more frequent FDA interaction, rolling review — de facto accelerated pathway

### CTX310 (ANGPTL3, in vivo)
- CRISPR Cas9 (not base editor) delivered via LNP to liver → KO ANGPTL3
- Phase 1: Cleveland Clinic, first-in-human data 2025 (American Heart Association); LDL-C and TG reductions confirmed; safety acceptable
- First CRISPR Cas9 (DSB-based) in vivo human trial with positive safety readout

---

## Beam Therapeutics: Base Editing in Blood Disorders

### BEAM-101 (SCD, ABE)
- ABE targeting same BCL11A enhancer as Casgevy, but using A→G base edit rather than NHEJ indel
- Rationale: ABE edit is more precise/predictable than indel; potentially more consistent HbF reactivation
- Phase I/II dosing initiated January 2024 (US-based)
- Advantage: no DSB → potentially lower structural variant risk vs. Casgevy

### BEAM-302 (Alpha-1 Antitrypsin Deficiency, in vivo)
- In vivo liver-directed base editing (ABE) to correct Z-allele mutation (E342K) in SERPINA1
- IND filed; trials expected ~2024–2025

---

## Intellia: In Vivo Liver Editing Programs

### NTLA-2001 (Transthyretin Amyloidosis, TTR KO)
- In vivo CRISPR Cas9 DSB + NHEJ → TTR gene knockout in liver
- LNP delivery; liver is natural LNP sink
- Phase 1 data: >90% TTR reduction with single dose; durable for >2 years
- First-in-human in vivo CRISPR (2021), establishing proof-of-concept for LNP CRISPR liver editing

### NTLA-2002 (Hereditary Angioedema, KLKB1 KO)
- KO of KLKB1 (plasma kallikrein) → reduces kallikrein-bradykinin pathway → prevents HAE attacks
- Phase 2: significant reduction in HAE attack frequency

### A1AT Program
- Dual edit: KO Z-allele + insert M-allele via HDR (or insert functional copy)
- More complex than simple KO; trials expected

---

## Broader Trial Landscape (2025)

As of early 2026, CRISPR Medicine News tracks ~250 clinical trials involving gene editing, with >150 active.

### Disease area distribution:
- **Blood disorders** (SCD, TDT, hemophilia): ~40% of active trials
- **Oncology** (allogeneic CAR-T, tumor-infiltrating lymphocyte enhancement): ~35%
- **Liver/metabolic** (TTR, PCSK9, ANGPTL3, A1AT, HAE): ~15%
- **Other** (HIV, Leber congenital amaurosis, Duchenne MD): ~10%

### Key regulatory milestones (2024–2025):
- Casgevy RMAT designation → Priority Review → approval (Dec 2023; EMA Feb 2024)
- CTX112 RMAT designation (2024)
- PM359 IND → first human dose (2024) → NEJM publication (2025)
- Baby KJ N-of-1 IND → three doses → NEJM publication (May 2025)
- VERVE-102 Heart-2 positive safety data (April 2025)
- Eli Lilly acquires Verve (June 2025)
- ~359 active CRISPR companies; total disclosed funding ~$84.5B (2025)
