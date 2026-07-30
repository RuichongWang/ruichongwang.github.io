# Sources and Citations

All URLs and papers referenced in this skill, by section topic.

---

## Foundational Papers

- Vaswani et al. 2017, "Attention Is All You Need" — original transformer
  https://arxiv.org/abs/1706.03762
  Wikipedia summary: https://en.wikipedia.org/wiki/Attention_Is_All_You_Need

- Kaplan et al. 2020, "Scaling Laws for Neural Language Models"
  https://arxiv.org/abs/2001.08361

- Hoffmann et al. 2022, "Training Compute-Optimal Large Language Models" (Chinchilla)
  https://arxiv.org/abs/2203.15556

---

## Attention Variants and Efficiency

- Shazeer 2019, "Fast Transformer Decoding: One Write-Head is All You Need" (MQA)
  https://arxiv.org/abs/1911.02150

- Ainslie et al. 2023, "GQA: Training Generalized Multi-Query Transformer Models" (GQA)
  https://arxiv.org/abs/2305.13245

- Dao et al. 2022, "FlashAttention: Fast and Memory-Efficient Exact Attention" (FlashAttention)
  https://arxiv.org/abs/2205.14135

- FlashAttention v2/v3 throughput figures, Skywork AI technical blog
  https://skywork.ai/blog/llm/transformer-architecture-attention-mechanism-fully-explained/

- "The End of Transformers? On Challenging Attention and the Rise of Sub-Quadratic Architectures"
  https://arxiv.org/html/2510.05364v1
  https://arxiv.org/pdf/2510.05364

---

## Positional Encoding

- Su et al. 2021, "RoFormer: Enhanced Transformer with Rotary Position Embedding" (RoPE)
  https://arxiv.org/abs/2104.09864

- Press et al. 2022, "Train Short, Test Long: Attention with Linear Biases (ALiBi)"
  https://arxiv.org/abs/2108.12409

- Peng et al. 2023, "YaRN: Efficient Context Window Extension of Large Language Models" (ICLR 2024)
  https://proceedings.iclr.cc/paper_files/paper/2024/file/874a4d89f2d04b4bcf9a2c19545cf040-Paper-Conference.pdf

- "Rotary Positional Embeddings as Phase Modulation: Theoretical Bounds on the RoPE Base for Long-Context Transformers" (2025 preprint)
  https://arxiv.org/html/2602.10959v1

- ICLR 2025 Blogpost: "Positional Embeddings in Transformer Models: Evolution from Text to Vision Domains"
  https://iclr-blogposts.github.io/2025/blog/positional-embedding/

- Emergent Mind: Rotary Positional Embeddings overview
  https://www.emergentmind.com/topics/rotary-positional-embeddings-rope

---

## Scaling Laws (Post-Chinchilla)

- Sardana & Frankle 2023, "Beyond Chinchilla-Optimal: Accounting for Inference in Language Model Scaling Laws"
  https://arxiv.org/abs/2401.00448
  HTML version: https://arxiv.org/html/2401.00448v3

- Epoch AI replication: "Chinchilla scaling: A replication attempt"
  https://epoch.ai/publications/chinchilla-scaling-a-replication-attempt

- Chinchilla scaling overview, LifeArchitect
  https://lifearchitect.ai/chinchilla/

- Emergent Mind: Chinchilla Scaling Laws
  https://www.emergentmind.com/topics/chinchilla-scaling-law
  https://www.emergentmind.com/topics/chinchilla-s-scaling-laws

- Brief history of LLM scaling laws, Jon Vet
  https://www.jonvet.com/blog/llm-scaling-in-2025

---

## KV Cache and Memory

- Xiao et al. 2023, "StreamingLLM: Efficient Streaming Language Models with Attention Sinks"
  https://arxiv.org/abs/2309.17453

- Zhang et al. 2023, "H2O: Heavy-Hitter Oracle for Efficient Generative Inference"
  https://arxiv.org/abs/2306.14048

---

## Multi-head Latent Attention (MLA)

- DeepSeek-V2 Technical Report (May 2024) — original MLA introduction
  https://arxiv.org/abs/2405.04434

- "Decoding Multi-Head Latent Attention: The KV Cache Memory Bottleneck, Solved"
  https://vizuara.substack.com/p/decoding-multi-head-latent-attention

- "Understanding Multi-Head Latent Attention"
  https://planetbanatt.net/articles/mla.html

- "MLA: Redefining KV-Cache Through Low-Rank Projections" (Hugging Face blog)
  https://huggingface.co/blog/NormalUhr/mla-explanation

- "TransMLA: Multi-head Latent Attention Is All You Need" (2025)
  https://arxiv.org/html/2502.07864v1

- "Towards Economical Inference: Enabling DeepSeek's Multi-Head Latent Attention in Any Transformer-based LLMs" (ACL 2025)
  https://arxiv.org/html/2502.14837v1
  https://aclanthology.org/2025.acl-long.1597.pdf

- Sebastian Raschka, MLA explainer
  https://sebastianraschka.com/llms-from-scratch/ch04/05_mla/

---

## Mixture of Experts

- Shazeer et al. 2017, "Outrageously Large Neural Networks: The Sparsely-Gated Mixture-of-Experts Layer"
  https://arxiv.org/abs/1701.06538

- Fedus et al. 2021, "Switch Transformers: Scaling to Trillion Parameter Models"
  https://arxiv.org/abs/2101.03961

- DeepSeekMoE paper (ACL 2024)
  https://aclanthology.org/2024.acl-long.70.pdf
  arXiv: https://arxiv.org/abs/2401.06066

- DeepSeek-V3 Technical Report (December 2024)
  https://arxiv.org/abs/2412.19437
  HTML: https://arxiv.org/html/2412.19437v1
  PDF: https://arxiv.org/pdf/2412.19437

- Detailed DeepSeek-V3 analysis, VitaLab
  https://vitalab.github.io/article/2025/02/11/DeepSeekV3.html

- Sebastian Raschka, "A Technical Tour of the DeepSeek Models from V3 to V3.2"
  https://magazine.sebastianraschka.com/p/technical-deepseek

- DeepSeek GitHub
  https://github.com/deepseek-ai/DeepSeek-V3
  https://github.com/deepseek-ai/DeepSeek-MoE

- "A Closer Look into Mixture-of-Experts in Large Language Models" (NAACL 2025)
  https://aclanthology.org/2025.findings-naacl.251.pdf

- MoE architectures 2024–2025 review, Rohan Paul
  https://www.rohan-paul.com/p/mixture-of-experts-moe-architectures

- Cameron Wolfe, "Mixture-of-Experts LLMs"
  https://cameronrwolfe.substack.com/p/moe-llms

- Hugging Face MoE explainer
  https://huggingface.co/blog/moe-transformers

- DeepSeek Technical Analysis (Jinpeng Zhang)
  https://dataturbo.medium.com/key-techniques-behind-deepseek-models-10x-efficiency-1-moe-9bd2534987c8

- DeepSeek MoE and V2 analysis, Chipstrat
  https://www.chipstrat.com/p/deepseek-moe-and-v2

---

## State Space Models and Mamba

- Gu et al. 2021, "Efficiently Modeling Long Sequences with Structured State Spaces" (S4)
  https://arxiv.org/abs/2111.00396

- Gu & Dao 2023, "Mamba: Linear-Time Sequence Modeling with Selective State Spaces"
  https://arxiv.org/abs/2312.00752

- Mamba-2 / SSD framework
  https://arxiv.org/abs/2405.21060

- NVIDIA empirical study, "An Empirical Study of Mamba-based Language Models" (2024)
  https://research.nvidia.com/publication/2024-06_empirical-study-mamba-based-language-models

- Goomba Lab, "On the Tradeoffs of SSMs and Transformers" (2025)
  https://goombalab.github.io/blog/2025/tradeoffs/

- Mamba-2-Hybrid evaluation and benchmark results
  (within NVIDIA empirical study and Goomba Lab post above)

- The Gradient, "Mamba Explained"
  https://thegradient.pub/mamba-explained/

- "Mamba(2) and Transformer Hybrids: An Overview"
  https://n1o.github.io/posts/ssm-transformer-hybrids-guide/

- "Mamba-360: Survey of State Space Models as Transformer Alternative for Long Sequence Modelling"
  https://arxiv.org/html/2404.16112v1
  ScienceDirect: https://www.sciencedirect.com/science/article/abs/pii/S0952197625012801

- "A hybrid model based on transformer and Mamba for enhanced sequence modeling" (Nature Scientific Reports, 2025)
  https://www.nature.com/articles/s41598-025-87574-8

---

## Mechanistic Interpretability

- Elhage et al. 2021, "A Mathematical Framework for Transformer Circuits" (Anthropic)
  https://transformer-circuits.pub/2021/framework/index.html

- Olsson et al. 2022, "In-context Learning and Induction Heads" (Anthropic)
  https://transformer-circuits.pub/2022/in-context-learning-and-induction-heads/index.html

- "Towards Monosemanticity: Decomposing Language Models With Dictionary Learning" (Anthropic, 2023)
  https://transformer-circuits.pub/2023/monosemantic-features

- "Scaling Monosemanticity: Extracting Interpretable Features from Claude 3 Sonnet" (Anthropic, May 2024)
  https://transformer-circuits.pub/2024/scaling-monosemanticity/

- Bricken et al. 2023, "Sparse Autoencoders Find Highly Interpretable Features in Language Models"
  https://arxiv.org/abs/2309.08600
  OpenReview: https://openreview.net/forum?id=F76bwRSLeK

- Anthropic Circuits Updates, January 2024
  https://transformer-circuits.pub/2024/jan-update/index.html

- Anthropic Circuits Updates, July 2025
  https://transformer-circuits.pub/2025/july-update/index.html

- "A Practical Review of Mechanistic Interpretability for Transformer-Based Language Models" (2024)
  https://arxiv.org/abs/2407.02646
  HTML: https://arxiv.org/html/2407.02646v4

- "A Survey on Sparse Autoencoders: Interpreting the Internal Mechanisms of Large Language Models" (2025)
  https://arxiv.org/html/2503.05613v1

- ICML 2025 Tutorial on Mechanistic Interpretability for Language Models
  https://ziyu-yao-nlp-lab.github.io/ICML25-MI-Tutorial.github.io/

- nnterp: "A Standardized Interface for Mechanistic Interpretability of Transformers" (2025)
  https://arxiv.org/abs/2511.14465

- "Revisiting Anisotropy in Language Transformers: The Geometry of Learning Dynamics" (2025)
  https://arxiv.org/html/2604.08764

- "Transformer See, Transformer Do: Copying as an Intermediate Step in Learning Analogical Reasoning" (2025)
  https://arxiv.org/html/2604.06501v1

- Galileo blog, "Monosemanticity: How Anthropic Made AI 70% More Interpretable"
  https://galileo.ai/blog/anthropic-ai-interpretability-breakthrough

- Adam Karvonen, "An Intuitive Explanation of Sparse Autoencoders for LLM Interpretability" (2024)
  https://adamkarvonen.github.io/machine_learning/2024/06/11/sae-intuitions.html

---

## Inference-Time Scaling / Reasoning Models

- "o1: A Technical Primer" (LessWrong)
  https://www.lesswrong.com/posts/byNYzsfFmb2TpYFPW/o1-a-technical-primer

- "Explaining OpenAI's o1 Breakthrough: The Revolution of Test Time Compute"
  https://medium.com/wix-engineering/explaining-openais-o1-breakthrough-the-revolution-of-test-time-compute-ecebe8ef9379

- "Test-Time Compute in Generative AI" (Emerge Haus)
  https://www.emerge.haus/blog/test-time-compute-generative-ai

- "Revisiting the Test-Time Scaling of o1-like Models: Do they Truly Possess Test-Time Scaling Capabilities?" (ACL 2025)
  https://arxiv.org/html/2502.12215v1
  https://aclanthology.org/2025.acl-long.232.pdf

- GitHub: "Replicating O1 inference-time scaling laws"
  https://github.com/hughbzhang/o1_inference_scaling_laws

- "Understanding Reasoning Models & Test-Time Compute: Insights from DeepSeek-R1"
  https://medium.com/@cch.chichieh/understanding-reasoning-models-test-time-compute-insights-from-deepseek-r1-d30783070827

- "Inference-Time Scaling" (Introl Blog, December 2025)
  https://introl.com/blog/inference-time-scaling-research-reasoning-models-december-2025

- "Hugging Face shows how test-time scaling helps small language models punch above their weight" (VentureBeat)
  https://venturebeat.com/ai/hugging-face-shows-how-test-time-scaling-helps-small-language-models-punch-above-their-weight

---

## 2024–2025 Models and Architecture Reports

- Sebastian Raschka, "The State Of LLMs 2025"
  https://magazine.sebastianraschka.com/p/state-of-llms-2025

- Apple Intelligence Foundation Language Models Tech Report 2025
  https://machinelearning.apple.com/research/apple-foundation-models-tech-report-2025

- DeepSeek Transparency Report, CRFM Stanford, December 2025
  https://crfm.stanford.edu/fmti/December-2025/company-reports/DeepSeek_FinalReport_FMTI2025.html

- DeepSeek V3 / R1 analysis, Graphcore Research
  https://graphcore-research.github.io/deepseek/

- "Transformers Provably Solve Parity" (ICLR 2025)
  https://openreview.net/pdf?id=n2NidsYDop

- "What Can('t) Transformers Do?" Workshop @ NeurIPS 2025
  https://transformerstheory.github.io/

- "In Transformer We Trust? A Perspective on Transformer Architecture Failure Modes" (2025)
  https://arxiv.org/html/2602.14318v1

- CMU lecture slides: "Deep Learning Transformer and Newer Architectures" (Spring 2025)
  https://deeplearning.cs.cmu.edu/S25/document/slides/lec19.transformer.pdf

- "Going Beyond LLMs & Transformers" (Przemek Chojecki, Medium)
  https://pchojecki.medium.com/going-beyond-llms-transformers-39f3291ba9d8
