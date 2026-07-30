---
name: ai-agent-evals
description: |
  AI agent evaluation knowledge at practitioner depth. Load whenever the user asks about evaluating LLM agents, agent benchmarks, trajectory evaluation, LLM-as-judge, tool-use metrics, success rate measurement, silent failures, multi-agent failure modes, SWE-bench, GAIA, AgentBench, TRAJECT-Bench, or production eval pipelines. Also load for questions about eval frameworks (Braintrust, LangSmith, DeepEval, TruLens, Arize), calibrating LLM judges, agent failure taxonomy, or the difference between offline and online evaluation. If the user is building or shipping an agent and asking how to know if it's actually working, load this skill immediately.
level: 7
generated: 2026-04-13
---

# AI Agent Evals

> **Generated and published unedited.** The `/matrix` skill wrote this from web
> search on 2026-04-13. No human reviewed it, then or since. It is here to show
> what the tool actually produces, which means the errors are part of the
> exhibit: an audit of these six files found a statutory deadline attached to the
> wrong trigger, a procedure recommended five years after it was discontinued, a
> filing fee off by two orders of magnitude, a suspended drug program described
> as a success, and compounding arithmetic that does not compute. Check
> anything you would act on against a primary source.


Level-7 reference on evaluating LLM agents in production. Assumes familiarity with LLM basics and agentic systems.

## Why Agent Evals Are Different

Evaluating a single LLM call: one input → one output → score the output.

Evaluating an agent: a sequence of reasoning steps + tool calls + sub-agent invocations → final output. A correct final output does not mean the agent worked correctly.

**The silent failure problem:** An agent tasked with reporting current inventory gives the right number — pulled from last year's report by mistake. Final output: pass. Process: wrong. Standard accuracy metrics miss this entirely. Silent failures are the dominant failure mode in production agents and the hardest to catch at scale.

The field has converged on three evaluation layers:
1. **Final output** — did the task succeed? (success rate, task goal completion)
2. **Trajectory** — did the agent take the right steps in the right order? (trajectory match, tool selection accuracy, argument correctness)
3. **Component** — is each individual reasoning step or tool call correct in isolation?

You need all three. Final output alone tells you what broke. Trajectory tells you why.

---

## Trajectory Evaluation

Trajectory = the full sequence of messages, tool calls, and reasoning steps an agent took to reach the final output.

**Two modes:**
- **Reference trajectory match**: compare agent's trajectory against a gold-standard trajectory. Strict match (exact tool sequence) vs. loose match (same tools, any order). Use when there's a correct procedure, not just a correct answer.
- **LLM-as-judge on trajectory**: feed the full trace to a judge model, ask whether the reasoning and tool use was appropriate. Use when multiple valid paths exist.

**TRAJECT-Bench** (2025): trajectory-aware benchmark with fine-grained metrics — tool selection correctness, argument correctness, dependency/ordering satisfaction — reported per step, not just at the end.

**AgentEvals** (LangChain, 2025): open-source library for trajectory match and LLM-judge eval of agent traces. Integrates with LangSmith for logging.

**Key metric gap:** tool selection accuracy and argument correctness are distinct. An agent can select the right tool with wrong arguments (fails silently), or the wrong tool that happens to return a usable result (passes incorrectly). Track both separately.

---

## LLM-as-Judge: Documented Failure Modes

LLM-as-judge is the dominant automated eval approach, and it has well-characterized failure modes every practitioner should know:

**Position bias:** In 10–30% of pairwise comparisons, the verdict flips when responses are swapped. The judge is partly ranking position, not quality.

**Length bias:** Systematic over-preference for longer outputs, even when humans rate length neutrally.

**Self-preference bias:** GPT-4 rates its own outputs ~10% higher win rate vs. other models' outputs in blind comparisons.

**Agreeableness bias:** High true positive rate (>96%) with very low true negative rate (<25%) — the judge says "good" to almost everything, inflating apparent performance in class-imbalanced datasets.

**Expert domain calibration:** Even SOTA judges average Fleiss' Kappa ≈ 0.3 on expert knowledge tasks. Agreement rates drop to 64–68%, below inter-expert baselines of ~72–75%.

**Mitigation in practice:**
- Always run position-swapped comparisons; if verdict flips >20%, the judge is unreliable for that dimension
- Maintain a small human-labeled calibration set; run judge against it monthly; recalibrate when judge-human agreement drops below threshold
- Prompt iteration alone won't close the gap — systematic alignment to human preferences requires deliberate iteration with real disagreement cases, not just prompt tweaking
- For high-stakes decisions: ensemble judging + human review

**Emerging pattern (2025):** Agent-as-a-Judge and Multi-Agent-as-Judge — specialized judge agents that reason step-by-step through the evaluated trajectory rather than producing a single score. Better on complex multi-step tasks; not yet standard.

---

## Benchmarks

| Benchmark | Domain | Top Score (2025) | Notes |
|---|---|---|---|
| SWE-bench Verified | Software engineering, 500 problems | ~78% (Claude Opus 4.6, GPT-5.4) | Human-validated subset; standard coding agent eval |
| SWE-bench Pro | Harder SE problems | ~23% (GPT-5, Claude Opus 4.1) | Massive drop from Verified — reveals generalization gap |
| GAIA | Tool use + reasoning | ~90% | Human baseline 92%; near-solved for top models |
| AgentBench | 8 environments (OS, DB, games, embodied) | Varies | Reveals commercial/open-source gap; multi-environment stress test |
| TRAJECT-Bench | Tool-use trajectory eval | — | Step-level diagnostics, not just final accuracy |

**The SWE-bench Pro gap is the most important recent finding:** models that score 70%+ on Verified collapse to ~23% on Pro. The current eval infrastructure is measuring something, but not generalized real-world coding ability. Practitioners should treat SWE-bench Verified scores as a floor, not a target.

---

## Multi-Agent Failure Modes

Berkeley's **MAST taxonomy** (Multi-Agent System Taxonomy) documents 14 distinct failure modes in multi-agent pipelines — none detectable by evaluating individual agents in isolation:

- Error propagation: wrong output from agent A feeds uncritically into agent B
- Competence miscalibration: agents cannot reliably evaluate each other's output quality
- Partial information compounding: each agent operates on a subset of context; errors compound across handoffs
- Exponential state space: system states grow combinatorially with agent count

**Practical implication:** pass@1 on individual agents is a poor predictor of multi-agent system reliability. System-level evals with injected failures at each handoff point are necessary.

---

## Eval Frameworks (2025 Landscape)

| Tool | Strength | Best for |
|---|---|---|
| Braintrust | Versioned evals, human review UI | Production eval pipelines |
| LangSmith | Trace logging + AgentEvals integration | LangChain-based agents |
| DeepEval | Metrics library (trajectory, tool use, reasoning) | Unit-test-style evals |
| TruLens | OpenTelemetry-based tracing | Framework-agnostic tracing |
| Arize Phoenix | Observability + eval in one | Monitoring + offline eval |

**LangChain's Agent Evaluation Readiness Checklist** (2025): defines what "eval-ready" means for a production agent — minimum viable: task success on a golden dataset, trajectory logging, at least one human calibration pass before LLM-judge deployment.

---

## What Good Looks Like in Production

From Amazon's published lessons on agentic systems at scale:

- Separate eval by agent layer: don't let final output success mask trajectory failures
- Build a golden trajectory set early; curate it, don't crowd-source it
- Run eval on worst-case scenarios and encode them as automated tests — reliability against adversarial inputs predicts production behavior better than average-case benchmarks
- Hybrid evaluation is non-negotiable: automated scoring for scale, human judgment for calibration and edge cases
- Track eval-production gap: offline eval scores consistently overestimate production performance; measure the gap and account for it in deployment decisions

---

## References

- `references/sources.md` — Full citation list with URLs
