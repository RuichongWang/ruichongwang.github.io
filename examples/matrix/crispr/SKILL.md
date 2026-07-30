---
name: crispr
description: |
  CRISPR and gene editing knowledge skill. Load whenever the user asks about CRISPR, Cas9, base editing, prime editing, gene therapy, gene editing mechanisms, sgRNA design, PAM sequences, HDR, NHEJ, off-target effects, delivery (LNP, AAV), sickle cell disease, beta-thalassemia, BCL11A, fetal hemoglobin reactivation, Casgevy, CPS1 deficiency, chronic granulomatous disease, PM359, Verve Therapeutics, PCSK9, ANGPTL3, genomics, synthetic biology, epigenome editing, CRISPRi, CRISPRa, CRISPRoff, in vivo editing, ex vivo editing, or any genetic disease with an editing-based treatment angle. Also load for biotech investment analysis involving gene editing companies, CRISPR agricultural applications, and regulatory questions about gene-edited organisms or therapies. If the user is asking anything about heritable gene editing, designer babies, or germline editing ethics, load this skill.
level: 8
generated: 2026-04-13
---

# CRISPR Knowledge Skill

> **Generated and published unedited.** The `/matrix` skill wrote this from web
> search on 2026-04-13. No human reviewed it, then or since. It is here to show
> what the tool actually produces, which means the errors are part of the
> exhibit: an audit of these six files found a statutory deadline attached to the
> wrong trigger, a procedure recommended five years after it was discontinued, a
> filing fee off by two orders of magnitude, a suspended drug program described
> as a success, and compounding arithmetic that does not compute. **It is not medical advice.** Check
> anything you would act on against a primary source.


Level-8 reference for CRISPR biology, editing modalities, clinical translation, and active research frontiers. Assumes familiarity with molecular biology vocabulary.

## Contents

- [Core Mechanism (Cas9)](#core-mechanism) — below
- [Editing Modalities](#editing-modalities) — below (overview); deep detail in `references/mechanisms.md`
- [Clinical & Applications](#clinical) — overview below; full data in `references/clinical.md`
- [Delivery](#delivery) — below
- [Safety & Off-Target](#safety) — below; details in `references/mechanisms.md`
- [Frontiers & Debates](#frontiers) — `references/frontiers.md`
- [Sources](#sources) — `references/sources.md`

---

## Core Mechanism

CRISPR-Cas9 is a two-component RNA-guided nuclease system. The **guide RNA** (sgRNA, a fusion of crRNA + tracrRNA) base-pairs with a ~20 nt target sequence adjacent to a **PAM** (protospacer adjacent motif; 5'-NGG for *S. pyogenes* Cas9). Cas9 undergoes conformational change upon R-loop formation, activating its two nuclease domains:

- **RuvC domain** — cleaves the non-target (non-complementary) strand
- **HNH domain** — cleaves the target strand

Together they produce a **blunt-ended double-strand break (DSB)** ~3 bp upstream of the PAM. A 2024 study (phys.org/Nature) identified an intermediate "surveillance complex" that serves as a gatekeeper: Cas9 interrogates DNA in two stages, and only when both seed region + full sgRNA match is HNH activated. This structural checkpoint explains much of the on/off-target discrimination.

**Repair pathway outcomes:**
| Pathway | Trigger | Result |
|---|---|---|
| NHEJ | DSB, no template | Indels → gene KO |
| MMEJ | DSB, microhomology flanking | Predictable deletions |
| HDR | DSB + donor template | Precise correction (low efficiency, S/G2 only) |

NHEJ dominates in post-mitotic cells. HDR efficiency in HSCs is ~1–10%, limiting its clinical utility without enrichment strategies.

---

## Editing Modalities

### Classic Cas9 (DSB-based)
Used for knockouts (NHEJ) or corrections (HDR). Casgevy uses this approach — see Clinical section.

### Base Editors (CBE / ABE)
Fuse **Cas9 nickase (nCas9, D10A)** to a deaminase; no DSB required.
- **CBE (cytosine base editor)**: APOBEC/AID deaminase converts C→U→T within a ~4–8 nt editing window
- **ABE (adenine base editor)**: evolved TadA converts A→I→G

Both create single-strand nicks (not DSBs), dramatically reducing large structural variants. Window-based editing can cause bystander edits if multiple C or A residues fall in the window.

### Prime Editing
Cas9 nickase + reverse transcriptase (RT) fused protein, guided by a **pegRNA** (prime editing guide RNA) that carries both the target-binding sequence and a 3' RT template + primer binding site (PBS).

Mechanism: nCas9 nicks the non-target strand → 3' flap is reverse-transcribed from pegRNA template → 5' flap displaced → mismatch repair resolves in favor of edit. Can install all 12 base-pair substitutions, small indels, and combinations. No DSB; PAM-to-edit distances up to >30 bp.

**PE3/PE3b strategies** add a second nick on the complementary strand to bias repair toward the edited strand, improving efficiency.

For comparative details (editing window, efficiency, delivery size constraints), see `references/mechanisms.md`.

### Epigenome Editors (no sequence change)
- **CRISPRi**: dCas9 + KRAB domain → H3K9me3 + DNA methylation → silencing
- **CRISPRa**: dCas9 + VP64/VPR/SAM → transcriptional activation
- **CRISPRoff**: dCas9 + DNMT3A/DNMT3L + KRAB → heritable methylation-based silencing that persists without continued CRISPRoff expression

---

## Clinical

### Approved Therapies
**Casgevy (exagamglogene autotemcel)** — Vertex/CRISPR Therapeutics
- FDA approved December 8, 2023; EMA approved February 2024
- Indications: sickle cell disease (SCD) + transfusion-dependent beta-thalassemia (TDT)
- **Mechanism**: ex vivo editing of autologous HSCs; sgRNA targets GATA1-binding site in the **erythroid-specific enhancer of BCL11A**; disrupts BCL11A expression in erythroid lineage → derepresses γ-globin → fetal hemoglobin (HbF) reactivation; HbF forms HbF tetramers that don't sickle
- Clinical data: 29/31 SCD patients free of severe vaso-occlusive crises ≥12 months; TDT patients transfusion-independent
- 64 patients treated in 2025 (3× increase over 2024)

### First-in-Human Milestones (2024–2025)
See `references/clinical.md` for full trial data. Key highlights:
- **PM359 (prime editing, CGD)**: first prime editor in humans; published in NEJM 2025 — see Frontiers
- **Baby KJ (personalized LNP-CRISPR, CPS1 deficiency)**: first truly personalized CRISPR therapy; designed and delivered in 6 months; NEJM May 2025
- **VERVE-102 (base editing, PCSK9)**: 53% mean LDL-C reduction at 0.6 mg/kg; no SAEs in Heart-2 Phase 1b (April 2025)
- **Beam Therapeutics BEAM-101**: base editing for severe SCD; Phase I/II dosing began January 2024

---

## Delivery

Two dominant clinical modalities:

### Ex Vivo (HSC editing)
Patient HSCs extracted → edited with RNP electroporation → myeloablative conditioning → reinfusion. Avoids systemic delivery problem. Used by Casgevy, BEAM-101, PM359.

**Bottleneck**: requires myeloablation (busulfan), which is toxic and limits access in resource-limited settings. Engraftment time is a key metric — PM359 patients engrafted on Day 14/19 vs. Day 27/35 median for approved gene therapies.

### In Vivo (systemic delivery)
**LNPs (lipid nanoparticles)**: deliver Cas9 mRNA + sgRNA or RNP. Liver tropism is natural due to ApoE-mediated uptake. Advantages: no insertional mutagenesis risk, lower immunogenicity vs AAV, redosable.
- Verve programs, CTX310, Baby KJ treatment all use LNPs
- LNP-CRISPR clears within days → reduces off-target accumulation
- Challenge: Verve-101 pause (2024) due to elevated LFTs + thrombocytopenia; VERVE-102 uses improved GalNAc-LNP with better hepatic targeting and cleaner safety profile

**AAV**: packages sgRNA + smaller Cas9 variants (SaCas9, CjCas9). Pre-existing immunity (~50% of humans have anti-AAV5 antibodies) and cargo size limit (~4.7 kb) are core constraints. Non-redosable.

**Engineered delivery**: shuttle peptides for lung epithelial cells; GalNAc conjugation for hepatocyte targeting; LNP engineering for tissue-specific delivery beyond liver is an active frontier.

---

## Safety

**Off-target cleavage**: sgRNA can tolerate mismatches, especially distal to PAM. Detection methods: GUIDE-seq, CIRCLE-seq, DISCOVER-Seq, CRISPRoffT database. High-fidelity Cas9 variants (eSpCas9, HiFi Cas9, evoCas9) reduce off-target 10–100×.

**Structural variants (2025 concern)**: Nature Communications 2025 paper identified megabase-scale deletions and chromosomal translocations in cells treated with DNA-PKcs inhibitors (used to boost HDR). This is a significant safety signal for HDR-based therapies.

**SNP-dependent off-targets**: novel PAM sites created by SNPs can generate population-specific off-target profiles — particularly relevant for individuals of African ancestry given sgRNA design on reference genome.

**Immunogenicity**: both Cas9 protein and AAV capsids are immunogenic. SpCas9 antibodies found in ~58–79% of humans; pre-existing T cell responses documented. LNP delivery mitigates but doesn't eliminate.

**p53 activation**: DSBs trigger p53 → growth arrest/apoptosis in edited cells; may select against corrected cells in some contexts.

---

## Quick Reference: Cas Variants

| Variant | PAM | Cut type | Notes |
|---|---|---|---|
| SpCas9 | 5'-NGG | DSB | Most used; large (4.2 kb) |
| SaCas9 | 5'-NNGRRT | DSB | Smaller, AAV-compatible |
| Cas12a (Cpf1) | 5'-TTN | Staggered DSB | Cleaves distal to PAM |
| CasΦ | 5'-TBN | DSB | Ultracompact phage-origin |
| dCas9 | N/A | None | Epigenome/transcription tools |
| nCas9 (D10A) | N/A | Nick | Base editors, prime editors |

---

For detailed protocol-level information, go deeper:
- `references/mechanisms.md` — PAM biology, editing window rules, pegRNA design, Cas variant properties, structural variant risks
- `references/clinical.md` — Full trial data, BCL11A biology, PM359 NEJM data, Verve trial timelines, Baby KJ
- `references/frontiers.md` — Personalized CRISPR, in vivo base editing beyond liver, epigenome editing, spatial CRISPR screens, agriculture, germline debate
- `references/sources.md` — Full citation list with URLs
