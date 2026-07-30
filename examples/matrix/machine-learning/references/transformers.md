# Transformers: Deep Technical Reference

Level 9. Dense, minimal hand-holding. 2024–2025 findings emphasized throughout.

## Table of Contents

1. [Attention: Mathematics and Variants](#1-attention-mathematics-and-variants)
2. [Positional Encoding](#2-positional-encoding)
3. [KV Cache and Memory Efficiency](#3-kv-cache-and-memory-efficiency)
4. [Multi-head Latent Attention (MLA)](#4-multi-head-latent-attention-mla)
5. [Mixture of Experts (MoE)](#5-mixture-of-experts-moe)
6. [Scaling Laws: Chinchilla and Post-Chinchilla](#6-scaling-laws-chinchilla-and-post-chinchilla)
7. [Inference-Time Compute Scaling](#7-inference-time-compute-scaling)
8. [State Space Models and Mamba](#8-state-space-models-and-mamba)
9. [Mechanistic Interpretability](#9-mechanistic-interpretability)
10. [Open Problems and Competing Hypotheses](#10-open-problems-and-competing-hypotheses)
11. [2024–2025 Architecture Developments](#11-20242025-architecture-developments)

---

## 1. Attention: Mathematics and Variants

### Core computation

Given input sequence X ∈ ℝ^(L×d_model), project to Q, K, V:

```
Q = XW_Q,  K = XW_K,  V = XW_V   (all W ∈ ℝ^(d_model × d_k))
Attention(Q,K,V) = softmax(QK^T / √d_k) · V
```

Complexity: O(L²·d) in time and O(L²) in memory for naive implementation. The quadratic term is the central bottleneck for long-context models.

### Multi-head attention (MHA)

Run h independent attention heads in parallel, each with dimension d_k = d_model/h. Concatenate outputs, project back:

```
MHA(X) = Concat(head_1, ..., head_h) W_O
head_i = Attention(XW_Qi, XW_Ki, XW_Vi)
```

Each head learns complementary patterns (syntax, coreference, positional relations). Empirically, many heads are redundant at inference — head pruning to ~30-50% of heads incurs minimal performance loss.

### Grouped Query Attention (GQA) and Multi-Query Attention (MQA)

MQA (Shazeer 2019): all query heads share a single K/V head. Reduces KV cache by factor h. Quality drop is tolerable for many applications.

GQA (Ainslie et al. 2023): G groups of query heads share K/V heads (G < h). Llama 2/3, Mistral, Gemini all use GQA. Llama 3 70B uses 8 KV heads for 64 query heads — 8× KV reduction.

### FlashAttention

FlashAttention (Dao et al. 2022) and v2/v3 restructure the computation to avoid materializing the full L×L attention matrix in HBM. Tiles Q, K, V in SRAM, computes softmax incrementally (online softmax). Result: memory O(L) instead of O(L²), IO-optimal. FlashAttention v2 achieves ~32% throughput gain over naive kernels (~145k → ~192k tokens/sec on A100).

FlashAttention v3 (2024) adds hardware-specific optimizations for H100 (async pipeling, warp specialization), reaching >75% H100 FLOP utilization.

### Masking strategies

- **Causal (uni-directional)**: GPT-style, each token attends only to prior tokens. Required for autoregressive generation.
- **Bidirectional (non-causal)**: BERT-style, full attention. Used for encoders, retrieval models.
- **Hybrid**: Some positions causal, some not. Explored in prefix-LM (T5, Gemini) and document-level context windows.

### Sparse and linear attention

- **Sparse attention** (Longformer, BigBird): attend to local windows + global tokens. O(L) complexity, but miss global dependencies.
- **Linear attention**: approximate softmax with kernel trick, O(L) but significant quality degradation on tasks requiring precise token matching.
- **Sliding window + full attention alternation**: used in Mistral and variants; local windows for most layers, periodic global attention.

---

## 2. Positional Encoding

### Absolute sinusoidal (original Transformer)

PE(pos, 2i) = sin(pos / 10000^(2i/d_model))
PE(pos, 2i+1) = cos(pos / 10000^(2i/d_model))

Injected additively into token embeddings. Does not generalize beyond training length.

### Learned absolute embeddings

Directly learn PE(pos) ∈ ℝ^d for each position up to max_len. GPT-2 uses this. Hard cap at max trained length.

### ALiBi (Attention with Linear Biases) — Press et al. 2022

Instead of adding to embeddings, subtracts linear bias proportional to distance from the attention logits:
```
score(q_i, k_j) = q_i · k_j - m · (i - j)
```
where m is a head-specific scalar. Trains faster than RoPE (fewer ops). Better extrapolation in some long-context evaluations. Still used in MPT, BLOOM variants.

### RoPE (Rotary Positional Embedding) — Su et al. 2021, standard by 2023

Encodes position by rotating Q and K vectors in 2D subspaces of d_k:
```
RoPE(q, pos) = q · e^(i·θ_pos)   (in complex notation)
```
Angle θ_k = pos / 10000^(2k/d_k). Applied to Q and K, not V. Inner product then yields relative position automatically: q_m · k_n depends only on m−n.

**Why RoPE dominates in 2025**: parameter-free, encodes relative position exactly, compatible with FlashAttention, and can be extended post-hoc via frequency rescaling (LongRoPE, YaRN).

**Long-context RoPE extensions**: perplexity spikes abruptly when context exceeds training length (not gradual degradation — a sharp cliff). Solutions:
- **YaRN** (ICLR 2024): stretch and interpolate RoPE frequencies, recover performance up to 128K context from 4K training
- **LongRoPE**: frequency reparameterization per layer; different layers get different stretch factors
- **CARoPE** (2025): dynamic, token-and-head-specific rotation frequencies driven by content; improves perplexity and throughput

**Theoretical result** (Feb 2025 preprint): formal bounds derived on the minimum RoPE base frequency required for stable long-context extension. The standard base θ=10000 becomes inadequate above ~32K tokens; Llama 3's 128K context uses θ=500,000.

---

## 3. KV Cache and Memory Efficiency

During autoregressive generation, all past K/V tensors must be retained per layer per token. For a model with L_layers layers, H heads, d_head head dim, dtype bytes:

```
KV cache size = 2 × L_layers × H × d_head × seq_len × dtype_bytes
```

Example: Llama 3 70B (80 layers, 8 KV heads, d_head=128, fp16): 2 × 80 × 8 × 128 × 32768 × 2 ≈ 10.7 GB for 32K context.

At long context (128K+), KV cache dominates VRAM, often exceeding model weights. This is the primary bottleneck for batch throughput in production.

### Compression strategies

- **GQA/MQA**: reduce H, the number of KV heads (see §1)
- **MLA**: compress K/V into low-rank latent (see §4)
- **PagedAttention** (vLLM): manage KV cache in non-contiguous pages, reduce fragmentation, enable high batch sizes
- **Streaming LLM** (Xiao et al. 2023): keep only attention sink tokens (first few) + local window; enables infinite-length generation at fixed memory, with quality tradeoffs
- **H2O (Heavy Hitter Oracle)**: evict KV entries that receive low cumulative attention score
- **Quantized KV cache**: store K/V in int8/int4; 2× memory reduction with minor quality loss; now standard in production deployments

---

## 4. Multi-head Latent Attention (MLA)

Introduced in DeepSeek-V2 (2024), deployed in DeepSeek-V3 and R1.

### Mechanism

Instead of caching K and V for each head directly, MLA projects the joint KV into a low-rank latent vector c^KV ∈ ℝ^(d_c), where d_c ≪ h·d_head:

```
c^KV = X · W^{DKV}                 (down-projection, d_c << n_heads * d_head)
K = c^KV · W^{UK}                  (up-project for keys at compute time)
V = c^KV · W^{UV}                  (up-project for values at compute time)
```

Only c^KV is stored in the cache. Keys and values are reconstructed on-demand during attention computation.

Similarly, queries are projected through a low-rank bottleneck.

### Effect

- **93% KV cache size reduction** vs standard MHA
- **~6× generation throughput increase** in DeepSeek-V2 benchmarks
- No quality degradation on standard benchmarks; MLA outperforms MHA at same parameter count

### Adoption

The 2025 ACL paper "TransMLA" and related work show MLA can be retrofitted into existing transformer models post-hoc. This is becoming a standard KV compression technique.

---

## 5. Mixture of Experts (MoE)

### Architecture

Replace each dense FFN with N expert networks (typically FFN-shaped) and a gating network. For each token, the gate selects top-k experts:

```
gate_scores = softmax(x · W_gate)        (x ∈ ℝ^d_model)
experts_used = top_k(gate_scores)
output = Σ_{i ∈ experts_used} gate_scores[i] · FFN_i(x)
```

Sparse activation: only k/N fraction of parameters activate per token. A 671B MoE model with 256 experts and k=8 uses ~37B parameters per token (5.5% utilization).

### Load balancing

**The core MoE training challenge**: if gating collapses onto a few popular experts, others are undertrained (expert collapse). Historical solutions:

- **Auxiliary loss** (Switch Transformer, GShard): add loss term penalizing uneven expert load. Tradeoff: the auxiliary loss competes with the main LM objective, slightly degrading quality.
- **Expert capacity factors**: hard cap on tokens per expert per batch.

**DeepSeek-V3 breakthrough (2024)**: auxiliary-loss-free load balancing via bias correction in routing logits. Maintains balance without competing loss terms. This is a meaningful training quality improvement; subsequent models will likely adopt this.

### DeepSeekMoE architecture

Two-level specialization beyond standard MoE:
1. **Fine-grained experts**: use mN experts, activate mK (more granular than standard top-k)
2. **Shared experts**: K_s dedicated experts always activated regardless of routing, capturing common cross-domain knowledge
3. **Routed experts**: N_r experts for specialist knowledge

DeepSeek-V3 specific: 256 routed experts + 1 shared expert, activate 8 routed + 1 shared per token. 671B total, 37B active.

### MoE in 2025 landscape

- Mixtral 8×7B/8×22B (Mistral AI): original open-source MoE demonstration
- Grok-1 (314B, xAI): 25% sparsity
- DeepSeek-V3 (671B): state-of-the-art open-source, matched GPT-4o
- Jamba (AI21 Labs): hybrid MoE + Mamba layers — MoE on top of SSM backbone
- CMoE (2025): "carved" MoE — transforms a 7B dense model into MoE via weight carving in minutes, fine-tuning under 1 hour

**Routing collapse problem remains active**: even with load balancing, experts can develop implicit specialization that is difficult to audit. Whether expert specialization is truly compositional or an artifact of routing incentives is not fully understood.

---

## 6. Scaling Laws: Chinchilla and Post-Chinchilla

### Kaplan et al. 2020

Loss scales as power law in compute C, parameters N, and data D:
```
L(N) ∝ N^{-α},  L(D) ∝ D^{-β},  α≈0.076, β≈0.095
```

Suggested: scale N faster than D; very large models are optimal.

### Hoffmann et al. 2022 (Chinchilla)

Re-ran experiments more carefully (400+ models, 70M–16B params). Found equal scaling of N and D is optimal:
```
N_opt ∝ C^{0.5},  D_opt ∝ C^{0.5}
```
Optimal D/N ratio ≈ 20 tokens/parameter. Chinchilla (70B, 1.4T tokens) outperformed Gopher (280B, 300B tokens) trained at same compute.

### Post-Chinchilla revision: inference-optimal training

**Key insight** (Sardana & Frankle 2023, arXiv 2401.00448): Chinchilla minimizes training loss but ignores inference cost. At deployment with large request volumes (>1B), serving a smaller model at lower per-token cost dominates the economics.

Revised recommendation: for large inference demand, train models smaller and longer — up to 10,000 tokens/parameter. At this ratio, loss continues improving monotonically.

**Practical consequence**: Llama 3 8B trained on 15T tokens (~1875 tok/param), Llama 3 405B on same corpus. Both dramatically overtrained relative to Chinchilla. This is now the industry norm.

### Epoch AI replication (2024)

Epoch AI attempted to replicate Chinchilla scaling results and found the original paper's methodology ambiguous; confidence intervals on the optimal D/N ratio are wider than typically assumed. The community consensus is that ~20:1 is a floor, not an optimum, once inference costs are included.

### Data quality and scaling walls

As compute-optimal models require massive token counts, **data quality becomes the binding constraint**. Key 2024-2025 finding: filtering and deduplication matter more than sheer token count at high-quality-data scale. FineWeb (2024), DCLM, and SmolLM corpora emphasize multi-pass quality filtering over raw scale.

---

## 7. Inference-Time Compute Scaling

### Background

Training-time scaling (more FLOPs → better model) has a known ceiling (data, energy, capital). Test-time compute scaling is a new orthogonal axis: spend more FLOPs at inference to solve harder problems without changing model weights.

### OpenAI o1 (September 2024)

First public demonstration of test-time scaling at GPT-4+ quality. Key mechanism: extended internal chain-of-thought with hidden reasoning tokens ("thinking tokens") invisible to users. Model learns to:
1. Decompose the problem
2. Explore multiple solution paths
3. Self-correct intermediate steps
4. Consolidate to final answer

**AIME 2024 results**: GPT-4 ~9%, o1-mini 63.6%, o1 ~79%. Order-of-magnitude improvement on competition math with no architecture change, just more thinking tokens.

Training signal: the model is trained (likely via RL with outcome-based rewards) to generate high-quality reasoning traces. The exact mechanism of o1 training is not publicly documented.

### o3 (early 2025)

Extended the o1 approach; sets new records on ARC-AGI (benchmark previously considered near-impossible for neural networks), graduate-level science (GPQA), and competition coding. Uses search over reasoning trajectories at inference — multiple parallel chains, selection/aggregation.

**Cost implication**: OpenAI's 2024 inference spend reached $2.3B — 15× GPT-4 training cost. Reasoning tokens drive token counts "orders of magnitude" higher than standard generation.

### DeepSeek-R1 (January 2025)

Open-source reasoning model trained via pure RL on reasoning traces, without supervised chain-of-thought data. Key result: R1 matches o1 performance on math/coding benchmarks. Demonstrates that reasoning capability can emerge from RL alone on base model, without pre-labeled thinking traces.

### Test-time scaling saturation (open question)

2025 paper "Revisiting the Test-Time Scaling of o1-like Models" (ACL 2025) questions whether o1-like models truly exhibit monotonic test-time scaling — i.e., whether more thinking tokens always help. Findings suggest scaling is task-dependent; some tasks saturate quickly, others benefit linearly. The precise scaling exponent is unknown.

### Hugging Face: small model upscaling via test-time compute

2025 result: a 1B-parameter model using extensive test-time compute outperforms a 7B model on specific reasoning tasks. Suggests the compute-performance tradeoff can be favorably rebalanced with test-time search.

---

## 8. State Space Models and Mamba

### SSM background

SSMs model sequences as linear dynamical systems:
```
h_t = A·h_t-1 + B·x_t       (state update)
y_t = C·h_t                  (output)
```
A is a structured state-transition matrix. S4 (Gu et al. 2021) parameterizes A as diagonal + low-rank using HiPPO initialization, enabling stable long-range dependencies. Compute: O(L log L) with FFT convolution during training, O(1) recurrence at inference.

### Mamba (Gu & Dao, 2023)

Key innovation: **selective state spaces** — make A, B, C functions of the input x_t, not fixed matrices. This selection mechanism gives the model content-dependent memory, mimicking attention's ability to focus selectively. Hardware-aware parallel scan replaces naive recurrence.

**Mamba advantages**:
- O(L) inference memory (no KV cache)
- O(L) compute (vs O(L²) attention)
- Up to ~8× faster token generation at inference vs transformers at equal parameter count

**Mamba weaknesses** (empirically established by 2024):
- Lagging behind transformers on tasks requiring exact in-context copying/retrieval ("phonebook lookup")
- Worse few-shot in-context learning (5-shot MMLU)
- Transformers still dominate in-context learning benchmarks

### Mamba-2

Structured State Space Dual (SSD) framework unifying SSMs and attention. Shows that selective SSMs are a special case of a broader family also containing linear attention. Enables more efficient kernels.

### NVIDIA empirical study (2024)

Trained Mamba models up to 8B parameters. Key result: pure SSMs match or exceed transformers on many tasks but lag on in-context learning and copying. SSMs are better when matching for data rather than compute (same FLOPs, SSMs see more tokens → win). This implies SSMs are more data-efficient.

### Hybrid architectures

**Mamba-2-Hybrid** (8B): mixes Mamba-2 layers with transformer attention layers. On 12 standard evaluation tasks, exceeds pure transformer by +2.65 average points, with predicted 8× inference speedup. This is the result that makes hybrids compelling.

**Jamba** (AI21 Labs, 2024): alternates transformer layers with Mamba layers, plus MoE on some layers. First large hybrid deployed in production.

**Zamba** (2024): explores different hybrid ratios, finding that adding as few as 6 attention layers to an otherwise-SSM model substantially recovers in-context learning deficits.

### The fundamental tradeoff (Goomba Lab analysis, 2025)

SSMs have O(1) per-step inference state (fixed-size hidden state) vs transformer's O(L) KV cache. The tradeoff:
- **Retrieval tasks**: transformers win (direct key-value lookup via attention)
- **Long-range signal propagation**: SSMs competitive or better (state carries compressed history)
- **Hybrid models**: recover both — a few attention layers for retrieval, SSM for efficiency

Current frontier models (GPT-4o, Claude, Gemini) remain full-attention transformers. No top-10 LMSys model (as of 2025) uses sub-quadratic or hybrid attention.

---

## 9. Mechanistic Interpretability

The field of mechanistic interpretability (MI) reverse-engineers what computations transformers implement internally. Level-9 summary of key findings.

### Circuits framework (Anthropic, Elhage et al. 2021–2023)

Small transformers implement identifiable "circuits" — subgraphs of attention heads and MLP neurons implementing specific algorithms:
- **Induction heads** (layer 1–2 in small models): implement in-context learning by copying patterns from earlier in context
- **Name Mover heads**: copy names across coreferences
- **Backup heads**: redundant circuits that activate when primary circuits are ablated (interpretability challenge: model has multiple mechanisms for same computation)

### Superposition hypothesis

A neural network with d neurons can represent more than d features simultaneously via superposition — different features encoded in overlapping directions in activation space. This explains polysemanticity (one neuron activates for multiple unrelated concepts) and makes circuits analysis harder.

### Sparse Autoencoders (SAE) for feature decomposition

**Towards Monosemanticity** (Anthropic, 2023): train a sparse autoencoder on activations to decompose superimposed representations into monosemantic features. Key constraint: L1 regularization on feature activations forces sparsity.

**Scaling Monosemanticity** (Anthropic, May 2024): Applied SAE to Claude 3 Sonnet's residual stream. Found:
- Millions of interpretable features at production model scale
- Features respond to abstract concepts: specific cities, emotional valences, syntactic roles, multi-token entities
- Features are causally active: steering on "banana" feature reliably changes model behavior in expected direction
- **16× expansion dictionary trained on 8B residual-stream activations from GPT-2 Small's layer 6 extracted ~15,000 latent directions; human raters found 70% cleanly map to single concepts**

### Distributed Interchange Interventions (DII)

DII (Geiger et al.) extends activation patching to arbitrary rotated subspaces. Instead of patching a neuron's value directly, rotate the representation space, patch in the rotated basis, rotate back. This enables testing whether a model uses a specific high-level causal variable in a specific subspace — more precise causal claims than neuron-level interventions.

### Attention head taxonomy

Empirical classification of attention head types:
- **Positional heads**: attend to fixed relative offsets
- **Syntactic heads**: attend along dependency parse arcs
- **Semantic heads**: attend to semantically related tokens
- **Induction heads**: attend to token preceding a match to current token (implements n-gram completion)
- **Anti-heads** (Anthropic finding): actively suppress certain behaviors; ablating them can increase capability on some tasks

### 2025 MI findings

- **Geometry of learning dynamics** (2025 preprint): anisotropy in transformer representation spaces — representations are not uniformly distributed on the hypersphere; certain directions are systematically preferred. This has implications for probing methodology (probes that assume isotropic representations produce biased results).
- **Analogical reasoning circuits** (2025): transformers implement relatively simple algorithmic procedures for analogy tasks — not holistic similarity matching but systematic structured mapping through identifiable circuits.
- **nnterp** (2025): unified MI library supporting 50+ model variants across 16 architecture families, enabling cross-model comparison of interpretability findings.

### Open MI questions

- Whether SAE features discovered at small scale transfer to frontier models
- Whether circuits generalize across models or are implementation-specific
- Whether MI findings will enable reliable behavioral prediction / safety guarantees
- The relationship between training dynamics and final circuit structure

---

## 10. Open Problems and Competing Hypotheses

### In-context learning (ICL)

**What it is**: GPT-style models generalize from examples in the prompt without gradient updates.

**Competing mechanistic hypotheses**:
1. **Induction heads hypothesis** (Olsson et al. 2022): ICL is mediated by induction circuits that extend n-gram matching to abstract pattern completion
2. **Bayesian program synthesis hypothesis**: LLMs are implicitly performing Bayesian inference over latent programs
3. **Gradient descent in activation space** (Akyürek et al., Von Oswald et al.): forward pass of a transformer with attention implements an implicit gradient descent step on a linear model — ICL = mesa-optimization

None fully explains ICL at scale. These hypotheses are not mutually exclusive.

### Reasoning and systematic generalization

Transformers fail on tasks requiring:
- Multi-step arithmetic over long chains
- Tracking state through complex logical sequences
- True compositional generalization (SCAN, COGS)
- Length generalization (trained on short, fails on long)

Chain-of-thought (CoT) partially addresses this by externalizing reasoning. But the theoretical basis for why CoT works is underdeveloped. 2025 finding: transformers with CoT can solve PARITY (a task requiring non-constant depth) — without CoT, constant-depth transformers cannot solve parity in theory.

### Context length and faithfulness

Empirical finding: models degrade non-uniformly on long contexts. "Lost in the middle" effect — information at context boundaries (beginning, end) is better attended than middle. This is not fully explained by attention scores. Positional encoding hypothesis, attention sink hypothesis, and training distribution artifacts all proposed but none fully validated.

### Emergence and phase transitions

Some capabilities appear suddenly as model scale increases (BIG-Bench findings). Competing hypotheses:
1. True phase transition: qualitatively new computation emerges at threshold
2. Metric artifact: smooth underlying capability, discontinuous under threshold-based metrics
3. Data coverage: capability triggers when rare data patterns exceed modeling threshold

Wei et al. 2022 emergence results have been partially explained by metric artifact (Schaeffer et al. 2023) — smoothed metrics show gradual improvement. Active debate: are any emergent capabilities truly discontinuous?

### Hallucination mechanisms

No consensus mechanistic explanation for hallucination. Proposals:
1. **Sycophancy**: model optimizes for human approval signal in RLHF, generates plausible-sounding rather than accurate content
2. **Knowledge boundary confusion**: model cannot reliably distinguish memorized facts from extrapolations
3. **Attention diffusion**: in long contexts, attention spreads too diffusely to precisely retrieve specific facts
4. **Training data artifacts**: conflicting information at scale causes uncertain activation patterns

RAG partially mitigates but introduces its own retrieval errors. The problem is not solved.

### Scaling limits

- **Data wall**: high-quality internet text is finite. Estimates suggest high-quality English text saturates ~10-15T tokens; models like Llama 3 are near this ceiling. Synthetic data (model-generated) partially extends this but introduces distribution shift.
- **Compute efficiency plateau**: hardware gains slowing; transformer FLOPs utilization on H100 is near hardware limits with FlashAttention v3. Next gains from architectural changes (MoE, MLA) or new hardware (Cerebras, Groq, custom ASICs).
- **Test-time compute saturation**: unknown whether test-time scaling continues indefinitely or plateaus on specific task types.

---

## 11. 2024–2025 Architecture Developments

### DeepSeek-V2 / V3 (2024)

**DeepSeek-V2** (May 2024): introduced MLA + DeepSeekMoE. 236B total, 21B active. Established viability of MLA for production.

**DeepSeek-V3** (December 2024): 671B total, 37B active. Key innovations over V2:
- Auxiliary-loss-free load balancing (bias-based routing correction)
- Multi-Token Prediction (MTP) training objective: predicts multiple future tokens at each position, denser training signal
- 14.8T training tokens (near data ceiling)
- 2.788M H800 GPU-hours (dramatically cheaper than GPT-4 class models)
- Outperforms all open-source, matches GPT-4o on most benchmarks

MTP specifics: extra prediction heads for positions t+1, t+2, etc., trained jointly. At inference, MTP heads can be used for speculative decoding (generate candidates, verify in parallel) — inference speedup without quality loss.

### Llama 3 (Meta, April–July 2024)

- 8B, 70B, 405B. All use GQA. RoPE base 500,000 (for 128K context).
- 15.6T training tokens — 5× more than Llama 2 per parameter, deliberately overtrained
- Llama 3.1 extended context to 128K via LongRoPE-style fine-tuning
- 405B dense model (not MoE) at GPT-4 quality — demonstrates dense models remain competitive

### Qwen 2.5 (Alibaba, 2024)

Dense models from 0.5B to 72B. 18T training tokens. Strong multilingual. 128K context. Demonstrates that non-MoE dense training at high token count remains competitive with MoE at much larger parameter counts.

### Gemini 1.5 Pro (Google, 2024)

Native 1M token context. Uses MoE architecture (specific expert count not disclosed). Key finding: at 1M context, model reliably retrieves facts anywhere in context ("perfect recall" on needle-in-haystack). This is the first production model to credibly solve the long-context faithfulness problem.

### Gemini 2.0 / 2.5 (Google, 2025)

Gemini 2.5 Pro introduced "thinking" mode analogous to o1 — extended reasoning tokens before final answer. Competitive with o3 on math/coding benchmarks.

### Apple Foundation Models (2025 Tech Report)

Apple's on-device models (3B) and server models use novel adapter-based architectures optimized for private cloud inference. Private Cloud Compute architecture: inference on Apple Silicon clusters with no persistent storage of user data. Demonstrates that inference architecture innovation is as important as training architecture.

### Attention efficiency in 2025

- **PaTH Attention**: improved perplexity and outcompeted baselines on reasoning benchmarks in 2025 evaluations
- **CARoPE**: content-adaptive rotary positions; 40% attention compute reduction at 100K+ sequences
- No top-frontier model as of April 2026 uses sub-quadratic attention in its primary path; FlashAttention remains the optimization of choice over architectural alternatives

### The inference-training cost inversion

2024 data point: OpenAI's inference cost ($2.3B) was 15× its training cost for GPT-4. This fundamentally changes the optimization target: models should be designed for inference efficiency (smaller active parameter count, faster KV operations, quantization-friendly weights), not just training loss. MoE and MLA are direct responses to this economics.
