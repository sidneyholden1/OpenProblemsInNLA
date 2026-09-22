# MF-12 complete contracts before proof

Canonical target and complete Colbrook manuscript `arbitrary_growth_exponents.tex`
were read at base 736845bc. Mathematical authorship: Matthew J. Colbrook,
University of Cambridge; projection-reset and tensor-product antecedents retain
Varney–Morris credit. No priority or human-review endorsement is claimed.

The final target is every real γ≥0, one positive dimension and one fixed finite
nonempty real matrix family, chosen before every word length k≥1. The maximal
product norm must lie between c k^γ and C k^γ with 0<c≤C, at every length, and
the actual nth-root limit must equal one. A subsequence bound, varying matrices,
a family-dependent exponent or rational-only γ does not suffice.

1. `wordProduct` is the actual matrix product of the complete finite word.
List order reverses the source's labels, immaterial since all words range
freely. Matrix norms use Mathlib's actual Euclidean L2 operator-norm scope,
not default entrywise or maximum-row norms.
2. `productNorms` ranges over all length-k words in the actual family;
`maximalProductNorm` is its genuine real supremum. `RealizesExponent` requires
that this supremum is an attained greatest element for every positive k, so
nonempty/bounded defaults cannot establish the result. It also requires the
actual root-limit assertion, not an assumed abstract joint spectral radius.
3. With λ=1/4, the literal 6×6 `seed μ` and `reset` matrices and literal 2×6 U,
6×2 V must satisfy U A^q V=[[1-q λ^q,q μ^q],[0,1]] for every q≥0 and μ∈ℝ.
The same matrices obey UV=I and reset=VU; these must be proved, not assumed.
4. For every 0<α<1 set μ=4^(α-1), so 1/4<μ<1. Prove full `RealizesExponent`
for the fixed pair {seed μ,reset}. For arbitrary reset gaps q_i, the compressed
triangular product uses ell_q=q4^(-q), b_q=q μ^q=q^α ell_q^(1-α).
The telescoping budget sum ell_i w_i≤1 and finite Hölder inequality prove
all-word upper growth. A=q-independent seed has bounded powers.
5. For every positive length n≥4 choose q=Nat.log 4 n, k=n/(q+1), remainder
r=n-k(q+1). The word A^r(P A^q)^k has exactly length n. Prove k ell_q≥1/4,
then 1-(1-ell_q)^k≥1/5, for example by the exact Bernoulli bound ku/(1+ku).
Its first coordinate yields a constant multiple of n^α. Lengths1,2,3 are
covered by A^n and its unit eigenvector. No floating-point search or finite
word enumeration substitutes for the universal bounds.
6. Integer γ=m uses the actual (m+1)-dimensional Jordan block I+N and zero.
For noninteger γ=m+α tensor both fractional generators with that same Jordan
block. Prove every resulting word is the tensor of the corresponding base
word and J^n, and prove polynomial upper/lower bounds in the actual operator
norm. Dimension-dependent norm equivalence is allowed in the proof constants;
it may not replace the norm in the final target. Handle γ=0 explicitly.
7. Derive actual nth-root convergence to1 from the positive two-sided polynomial
bounds, and prove finiteness/nonemptiness/maximal attainment for the constructed
pair. `arbitrary_pair` is stronger than the canonical finite-family target;
`original_target` supplies exactly that target, without any extra hypotheses.

The requested four exports are compressed_powers, fractional_growth,
arbitrary_pair, original_target. Rational-entry refinements, optimal dimensions,
optimal constants and convergence of growth/k^γ are outside the formal claims.
Two independent statement approvals and a successful typecheck precede proof.
Two nonauthor final reviews, all-export LeanCert kernel checks, actual isolated
Linux Comparator/default-kernel and rejection controls precede promotion.
Exact algebra and finite Hölder should replace unnecessary interval subdivision.
