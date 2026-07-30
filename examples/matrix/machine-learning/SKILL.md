---
name: machine-learning
description: |
  Machine learning and deep learning knowledge skill. Load whenever the user asks about ML, AI models, transformers, LLMs, neural networks, deep learning, model training, fine-tuning, embeddings, attention mechanisms, scaling laws, inference optimization, backpropagation, gradient descent, loss functions, regularization, CNNs, RNNs, SSMs, diffusion models, RL from human feedback (RLHF), alignment, PEFT/LoRA, quantization, or any aspect of building or understanding AI systems. Also load for questions about specific architectures (GPT, BERT, Llama, Mamba, DeepSeek, Mistral, Gemini, Claude), benchmarks (MMLU, HELM, ARC, BIG-Bench), training infrastructure, or ML research findings. Use this skill even when the user doesn't say "machine learning" explicitly — if they're asking how an LLM works, why a model hallucinates, how to fine-tune, what attention does, or how scaling affects capability, load this skill.
level: 9
generated: 2026-04-13
---

# Machine Learning

> **Generated and published unedited.** The `/matrix` skill wrote this from web
> search on 2026-04-13. No human reviewed it, then or since. It is here to show
> what the tool actually produces, which means the errors are part of the
> exhibit: an audit of these six files found a statutory deadline attached to the
> wrong trigger, a procedure recommended five years after it was discontinued, a
> filing fee off by two orders of magnitude, a suspended drug program described
> as a success, and compounding arithmetic that does not compute. Check
> anything you would act on against a primary source.


Level-9 reference covering the full ML stack with emphasis on transformers, large language models, and 2024–2025 architectural developments. This skill is organized for depth-first lookup: the parent overview (here) gives orientation; the references/ directory holds deep dives.

## When to read what

| Topic | File |
|---|---|
| Transformer internals, attention variants, positional encoding, MoE, SSMs, interpretability, open problems | `references/transformers.md` |
| All citations, paper links, URLs | `references/sources.md` |

Always read `references/transformers.md` for any question involving transformer architecture, LLM internals, or 2024–2025 model findings. It is the primary content file.

---

## Foundations

### Core paradigm

Modern deep learning is function approximation via gradient descent on parameterized differentiable functions. The transformer — introduced in Vaswani et al. 2017 — dominates language, vision, code, and multimodal tasks. Its key innovation: replace recurrence with global self-attention, enabling full parallelism over the sequence during training.

### Loss landscape and optimization

- **Loss**: cross-entropy over next-token prediction (causal LM) or masked token prediction (BERT-style)
- **Optimizer**: AdamW with weight decay is standard; Adafactor used when memory is tight (no second-moment full matrix)
- **Learning rate schedule**: warmup + cosine decay; some 2024–2025 models use WSD (warmup-stable-decay) for continued pretraining flexibility
- **Gradient clipping**: norm clipping at ~1.0 prevents spike destabilization

### Scaling laws

Kaplan et al. 2020 showed power-law scaling of loss with compute, parameters, and data. Hoffmann et al. 2022 (Chinchilla) revised this: for fixed compute, model size and token count should scale equally (~20 tokens/parameter is approximately optimal for training loss). **Critical 2024 revision**: Chinchilla optimality is compute-optimal for training, not deployment. When inference cost matters, train smaller models on far more tokens (up to 10,000 tokens/parameter) — this is now standard practice (Llama 3, Mistral, Gemini Nano).

---

## Architecture taxonomy (2025)

| Class | Examples | Key property |
|---|---|---|
| Dense transformer | GPT-4, Claude 3/3.5/3.7, Llama 3 | All parameters active per token |
| Sparse MoE transformer | DeepSeek-V3, Mixtral, Grok-1 | Subset of experts activated per token |
| SSM | Mamba, Mamba-2 | O(L) inference, no KV cache |
| Hybrid SSM+Attn | Jamba, Zamba, Mamba-2-Hybrid | SSM layers + selective attention layers |
| Diffusion LM | MDLM, Plaid | Non-autoregressive, denoising objective |

---

## Key mechanisms (summary; full detail in references/transformers.md)

**Self-attention**: O(L²) compute and memory in sequence length L. Each token attends to all others; queries, keys, values derived by learned linear projections. Multi-head attention runs h parallel heads, concatenated and projected.

**KV cache**: At inference, previously computed K/V tensors are cached per layer, enabling O(L) per-step cost. Memory bottleneck at long context: a 70B model with 32 KV heads × 8192 ctx uses ~16 GB KV cache in fp16.

**MLA (Multi-head Latent Attention)**: DeepSeek-V2/V3 innovation. Compresses KV into low-rank latent vectors (93% KV cache reduction, ~6× generation throughput increase). Now being retro-fitted to other architectures.

**MoE routing**: Top-k gating over N experts per FFN layer. Load balancing historically required auxiliary loss; DeepSeek-V3 pioneered auxiliary-loss-free load balancing via bias-based routing correction.

**Positional encoding**: RoPE (Rotary Position Embedding) is the 2024–2025 standard — encodes relative position via rotation in complex space, applied to Q and K. ALiBi (Attention with Linear Biases) trains faster and extrapolates better in some long-context regimes. Both displace absolute sinusoidal encodings.

---

## 2024–2025 inflection points

1. **Inference-time scaling** (OpenAI o1, Sept 2024): Extended chain-of-thought with hidden reasoning tokens enables test-time compute scaling — AIME 2024 pass rate jumped from ~9% (GPT-4) to 79% (o1). New axis of scaling orthogonal to parameter count.

2. **DeepSeek-V3** (Dec 2024): 671B MoE, 37B active params, trained on 14.8T tokens for 2.788M H800 GPU-hours — roughly 10× cheaper than comparable dense models. Matched or exceeded GPT-4o on most benchmarks.

3. **Sparse autoencoders for interpretability**: Anthropic scaled SAE decomposition to Claude 3 Sonnet (May 2024), finding millions of interpretable monosemantic features addressing the superposition problem.

4. **SSM competitive parity**: Mamba-2-Hybrid (8B) exceeded matched-size transformer on 12/12 standard evals (+2.65 avg), with up to 8× faster inference. Pure SSMs still lag on in-context learning and phonebook-style copying tasks.

---

## Open problems (brief; see references/transformers.md for full treatment)

- Theoretical account of in-context learning mechanism
- Reliable long-context faithfulness (>100K tokens)
- Compositional generalization and systematic reasoning
- Whether test-time scaling saturates and at what point
- KV cache compression without quality degradation at extreme context
- Mechanistic understanding of why certain features emerge at scale

---

## Read next

For any deep-dive question: **`references/transformers.md`** — covers attention math, MLA, MoE internals, Mamba/SSM theory, mechanistic interpretability findings, positional encodings, open problems, and named 2024–2025 results with citations.
