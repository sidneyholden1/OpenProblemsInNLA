# IE-13 full numerical statements before proof

The complete canonical target and Matthew J. Colbrook's attributed manuscript
`references/colbrook-recovered-2026-09-11/manuscripts/IE-13.tex` are the source,
including its full informal review and substantial AI-assistance disclosure.
Higham retains original-problem credit. Formalization: Sidney Holden with
OpenAI Codex assistance. Source base: `85490781eb0ca01c4545ded776117d7cb4cf9f52`.

## Exact public scope

The canonical question asks all unequal lower/upper bandwidth pairs p,q≥0.
We prove the stronger statement for **all** p,q≥0, including equal pairs and
both zero. For every order n≥1+max(p,q), inputs are arbitrary nonsingular complex
n×n matrices with bandwidths **at most** p and q in their original ordering:
A(i,j)=0 whenever j+p<i or i+q<j. There is no realness, exact-bandwidth,
symmetry, diagonal-dominance or normalization assumption.

`isPath` is literal complex GEPP. At stage k its pivot position r(k)≥k is
nonzero and maximal in modulus over the entire active column, with ≤ allowing
all ties. Only this row is swapped with k; no column swap or preliminary
permutation occurs. `S 0=A`, and each next state is the exact trailing Schur
complement. Eliminated rows and columns are padded with zero. The last pivot
is also nonzero. Unused states after the last stage do not enter growth.

`entryMax` is the finite maximum of complex entry moduli. `growth` is the
maximum over every entry at every one of the n stages, divided by entryMax A.
Actual nonsingularity and positive order imply the denominator is positive;
this must be proved, not assumed or replaced by normalization. The padded
maximum equals the genuine active-matrix maximum because eliminated entries
are zero. Stored eliminated multipliers are not part of the growth measure.

`bandGrowths p q` quantifies over **all admissible dimensions**, all such
matrices and all such paths. Its `sSup` is the genuine real supremum;
nonemptiness, boundedness and exact attainment are explicit obligations.

## Sharp constants and four exports

Define the natural sequence h(p,0)=0 and, for t≥0,

    h(p,t+1) = 1 + sum_{r=0}^{p-1} h(p,t-r),

where natural subtraction truncates to zero. This exactly implements the
source's h_t=0 for t≤0, h_t=1+sum_{r=1}^p h_(t-r) for t>0.
Set B(p,q)=1 if p=0, and B(p,q)=h(p,p+q) otherwise.
Examples: B(0,q)=1; B(1,q)=q+1; B(2,0..3)=2,4,7,12;
B(3,0..2)=4,8,15. No power with a negative exponent appears in the contract.

1. `upper_bound`: every admissible dimension, complex input and actual path
   has growth≤B(p,q).
2. `rational_attainment`: the explicit rational input below has admissible
   order, the required bandwidth/nonsingularity, initial maximum1, the literal
   candidate legal pivot path, and actual growth exactly B(p,q).
3. `sharp_maximum`: B(p,q) is a genuine greatest member of the entire
   dimension-varying growth set.
4. `original_target`: that set is nonempty and bounded above, and its actual
   real supremum equals B(p,q).

No sorted-front invariant, envelope bound, determinant, pivot admissibility,
normalization or desired recurrence estimate is hidden in a public premise.

## Literal rational attaining family and full pivot path

Set n=2p+q+1, target column index t=p+q (all indices here zero-based).
When p=0 use the identity matrix of order q+1 and identity pivot positions.
For p>0 let η=1/2^p and let L₀ have unit diagonal and −1 on the first p
subdiagonals. For each column k<t, define the upper-supported vector

- u₀=1 if k≤p;
- uᵢ=2^(i−1) for 1≤i≤k≤p;
- uₖ=1 if k≥p+1;
- all other entries zero.

Map original row p to factor row0, original row i<p to factor row i+1,
and original row i>p to factor row i. Earlier input columns are η times
L₀u in this row assignment. The target column has ones precisely in original
rows i≥p. Later columns are literal identity columns. All entries are rational
and are embedded into ℂ without approximation.

This row assignment defines the original input, not a preliminary allowed
operation. Candidate current-position pivots are r(k)=p for k≤p and r(k)=k
for k>p. They select original labels p,0,1,...,p−1,p+1,... . `witnessStates`
is obtained by the actual complex `schurStep` recursion, including the target
column and the entire identity tail. The theorem must establish legality of
**every** pivot, not merely the first t pivots checked in some source diagnostics.

Required facts include all forbidden structural zeros, maximum1, genuine
determinant nonzero, active pivot-column maximality/nonzero, the target stage
entry h(p,p+q), and full growth equality. Root's exact source diagnostics test
all 70 pairs 0≤p≤6,0≤q≤9 and the full candidate path; they are transcription
checks, not universal proofs. The p=0 identity branch is explicit.

## Computation reduction and proof obligations

Derive the front from actual original row labels and lower bandwidth:
untouched future labels i≥k+p have had zero earlier multipliers and cannot
have been chosen as nonzero earlier pivots. There are at most p old survivors
and one new row; missing rows near the bottom may be padded by zeros.

For sorted target magnitudes y₁≥...≥y_(p+1)≥0, deleting any pivot row and
updating with multipliers of modulus≤1 gives sorted survivors bounded by
(y₁+y₂,...,y₁+y_(p+1)). This is an envelope, not an assertion that GEPP picks
the largest target-column entry. Sorting, fresh insertion and the componentwise
comparison must all be justified. Starting from p zeros and appending units,
the canonical state after t≥1 updates has i-th component
1+sum_{r=1}^{p-i+1}h(p,t-r), with largest component h(p,t).

Let L=p+q with p≥1. For a zero-based target column j≥L the old target
entries vanish until stage j−L, and exactly L updates precede elimination
of column j. For j<L, initial old entries are bounded by the state after
one imaginary update, and at most j further updates give h(p,j+1)≤h(p,L).
Fresh/untouched and removed pivot-row entries must also be covered. These
estimates must apply to every active entry of every actual path, carrying the
initial entry maximum throughout or proving an exact scaling bridge.
When p=0 all inputs are upper triangular and actual GEPP multipliers vanish.

All computations are exact algebra, complex norm inequalities and finite
natural recurrences. LeanCert will audit the completed proofs' kernel trust;
no artificial interval certificate is needed. Use Mathlib finite maxima,
permutations, sums and matrix APIs. IE-14's proof-independent complex padded
layout is reused with attribution, but no cross-project proof import or
unproved IE-14 result is permitted. All four final exports must pass actual
Lean4 Comparator statement identity and isolated Linux kernel replay.

## Exclusions

Optional closed formulas for special bandwidths and the equal-bandwidth
historical expression are not separate advertised results. Equal bandwidths
are nevertheless included by the stronger recurrence theorem. Other pivot
rules, imposed deterministic tie conventions, preliminary reorderings and
claims about stored L multipliers are outside the canonical target. No
required unequal pair, zero bandwidth, complex input, dimension or tie path
is excluded.
