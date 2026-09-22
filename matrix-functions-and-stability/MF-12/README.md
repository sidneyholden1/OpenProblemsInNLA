# MF-12 — Realizing arbitrary polynomial growth exponents by finite matrix families

<!-- navigation -->
[All categories](../../README.md) · [Category index](../README.md) · [Read PDF](problem.pdf) · [LaTeX source](problem.tex)
<!-- /navigation -->

**Difficulty:** challenging  
**Importance:** interesting to the community  
**Rating rationale:** Challenging because finite families must realize every exponent at every length; community impact connects switched dynamics and asymptotic matrix-product growth.  
**Status:** Lean verified  
**Last checked:** 2026-09-22  

## Lean verification — 22 September 2026

The complete original target is formally proved: every real exponent α≥0 is realized by two fixed distinct real matrices in a fixed positive dimension. The actual maximal Euclidean operator norm has positive two-sided polynomial bounds at every positive length, and its actual nth-root limit is one. All four exports passed LeanCert kernel audits, two independent nonauthor final reviews, and [isolated Linux Comparator/default-kernel verification](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/35696246513) with rejection and sandbox controls.

[Proof and reviews](https://github.com/sidneyholden1/OpenProblemsInNLA/blob/main/matrix-functions-and-stability/MF-12/lean/README.md) · [Immutable proof revision](https://github.com/sidneyholden1/OpenProblemsInNLA/tree/1231b92f2b0235559e5fe5162f6b76d21249ffd0/matrix-functions-and-stability/MF-12/lean) · [Retained evidence](https://github.com/sidneyholden1/OpenProblemsInNLA/blob/main/docs/lean/verification-2026-09-22/MF-12/README.md). Mathematics: Matthew J. Colbrook, with Varney–Morris antecedents retained. Formalization: Sidney Holden with OpenAI Codex assistance. The proof covers the full canonical target; optional optimal-dimension and rational-entry refinements are not formalized. No novelty, source-author endorsement or external human review is claimed.

<!-- colbrook-jsr-growth -->
## Resolution — 2026-09-11

**Affirmative resolution.** Matthew J. Colbrook's [complete manuscript, Theorem 1 and its proof in §§2–5](../../references/colbrook-jsr-growth-2026-09-11/manuscripts/arbitrary_growth_exponents.pdf) constructs two distinct real matrices for every real $`\alpha\ge0`$, with joint spectral radius one and maximal length-$`k`$ product norm between positive constant multiples of $`k^\alpha`$ for every integer $`k\ge1`$. The matrices and dimension are fixed once the exponent is chosen. Six-dimensional pairs suffice for $`0<\alpha<1`$; every nonnegative rational exponent can be realized with dyadic-rational entries. The proof covers all switching words for the upper bound and every length for the lower bound, including small lengths. It asserts comparability, not convergence of the normalized growth sequence.

The complete original proof passed [independent Codex-agent review](../../references/colbrook-jsr-growth-2026-09-11/verification/reviews/MF-12-review.md). [Authored TeX](../../references/colbrook-jsr-growth-2026-09-11/manuscripts/arbitrary_growth_exponents.tex) · [Submission, authorship and verification record](../../references/colbrook-jsr-growth-2026-09-11/README.md). The proof was developed with AI assistance; no external human peer review or formal verification is claimed. The original statement and prior evidence below are retained, and the ratings above are historical. This entry no longer contributes to the open count.

<!-- /colbrook-jsr-growth -->

## Context and notation

The joint spectral radius of a nonempty compact set $`\mathcal M\subset\mathbb C^{d\times d}`$ is

```math
\widehat\rho(\mathcal M)=\lim_{k\to\infty}
\max_{A_1,\ldots,A_k\in\mathcal M}\|A_k\cdots A_1\|_2^{1/k}.
```

This definition also applies to finite real matrix sets. The ordinary spectral
radius of one matrix is written $`\rho(A)`$.

For a compact nonempty $`\mathcal M\subset\mathbb R^{d\times d}`$ with
$`\widehat\rho(\mathcal M)=1`$, define its maximal product norm at length $`k`$ by

```math
g_{\mathcal M}(k)=\max_{A_1,\ldots,A_k\in\mathcal M}\|A_k\cdots A_1\|_2.
```

This problem concerns growth within one family over time. [MF-07](../MF-07/README.md) instead requests
a dimension-dependent bound uniform across families.

## Problem statement

For every real $`\alpha\ge0`$, do there exist a positive integer
$`d`$, a finite nonempty $`\mathcal M\subset\mathbb R^{d\times d}`$ with
$`\widehat\rho(\mathcal M)=1`$, and constants $`0< c\le C<\infty`$ such that

```math
c k^\alpha\le g_{\mathcal M}(k)\le C k^\alpha
\qquad\text{for every integer }k\ge1?
```

## Reference and status evidence

Varney and Morris,
[On marginal growth rates of matrix products](https://arxiv.org/html/2209.00449),
§7, Question 2. Corollary 6.1 realizes exponent $`1/3`$; the all-exponents question
remains posed. Searches for the title, authors, and marginal-growth exponents
through 2026 located no complete answer. Infinite compact families and
subsequence-only lower bounds do not meet the finite-family, every-length target.

## Audit — 2026-09-10

Rechecked [Varney–Morris, Corollary 6.1, Proposition 3.1, and Question 2](https://arxiv.org/html/2209.00449): exponent $`1/3`$ is realized and realizable exponents are closed under addition. The all-exponents assertion remains open. Author and marginal-growth-exponent searches found no complete finite-family construction or obstruction.
