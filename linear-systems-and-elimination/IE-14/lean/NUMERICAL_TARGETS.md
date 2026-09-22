# IE-14 numerical statements before proof

Source: the complete canonical IE-14 README and Matthew J. Colbrook's attributed
`references/colbrook-recovered-2026-09-11/manuscripts/IE-14.tex`, including its
review and AI-assistance disclosure. The source proves all sizes, not merely its
finite numerical examples. Formalization: Sidney Holden with OpenAI Codex assistance.

## Fixed mathematical boundary

For every integer n≥4, inputs are complex n×n matrices in their original ordering.
The only allowed nonzeros satisfy |i−j|≤1 or are the two cyclic corners; both
corners must be nonzero, and the actual determinant must be nonzero. No realness,
symmetry, diagonal dominance, preselected pivot order, or normalization is imposed
on the universal theorem.

`schurStep` performs only the allowed active row swap and the literal complex
Schur update at the current column. `isPath` requires a nonzero pivot whose modulus
is greatest in the entire active column. Equality is allowed, so every permitted
tie choice is included. Eliminated rows/columns are padded by zero; all other
entries are the actual trailing Schur complement. `S 0=A` disallows preliminary
reordering. No column swaps occur. The last pivot is also required nonzero.

`entryMax` is a finite maximum of complex moduli. `growth` is the finite maximum
over all entries of all n active stages, divided by the original maximum. The
proof must establish the denominator is positive from the input assumptions.
`cyclicGrowths` ranges over every such input and every allowed path. Its real
supremum is not a maximum by definition: nonemptiness, boundedness and attainment
are separate proof obligations.

With F₀=0,F₁=1, define B(n)=F_(n+1)+1. The four exact exports are:

1. Every allowed complex input and every allowed path have growth ≤B(n).
2. The explicit rational matrix embedded in ℂ belongs to the same input class,
   has initial maximum1, admits the literal candidate pivot path, and has growth
   exactly B(n).
3. B(n) is a genuine greatest member of the entire growth set.
4. The growth set is nonempty and bounded above, and its actual real sSup is B(n).

The first values are n=4,5,6,7,8: B(n)=6,9,14,22,35. No positive size n≥4 is
excluded; the two small column-history ranges may be empty at n=4.

## Exact rational witness and actual pivot schedule

All factor entries are rational. L has unit diagonal and −1 on its first two
subdiagonals. U has nonfinal diagonal1 except U₁₁=1/2 (zero-based), additionally
U₀₁=1/2, zero other nonfinal off-diagonals, and final column
U_(i,n−1)=F_(i+2) for i<n−1, U_(n−1,n−1)=F_(n+1)+1.

Let C=LU. Original row0 is C₀; original row n−1 is C₁; original row i for
1≤i<n−1 is C_(i+1). This defines the input, not a preliminary elimination
operation. Candidate pivot positions are r₀=0 and r_k=n−1 for k≥1, with every
candidate state computed by `schurStep`. Thus selected original row labels are
0,n−1,1,2,...,n−2. The theorem must prove every such pivot maximal and nonzero.

Required witness facts: all forbidden entries vanish; corners are1 and−1;
initial maximum1; det≠0; each active pivot column in factor labels is
L_(i,k) U_(k,k); and the final scalar is F_(n+1)+1. The actual recurrence,
not an assumed LU-elimination bridge, connects these facts to growth.

## Planned computation reduction (not assumptions)

Track surviving rows by original labels. Before each of the first n−2
eliminations there are two old surviving front rows and one newly arriving
original row; later rows remain unchanged because their prior pivot columns
are zero. This invariant must be derived from sparsity and legal nonzero pivots.
It is absent from every public hypothesis.

For a target column, a fresh zero and old sorted modulus bounds a≥b give new
bounds (a+b,a). A fresh value bounded by c gives survivor-sum bound
 a+b+c+max(a,b,c).
These follow from the complex triangle inequality and pivot multiplier norm≤1.
Use equivalent maximum/sum invariants if they avoid sorting operations.

The last column begins with old pair(1,1), has n−3 zero-fresh updates, and then
one fresh entry≤1. Its final survivor sum is
 2F_(n−1)+F_(n−2)+1=F_(n+1)+1.
Middle columns have bound2. The next-to-last column starts(1,0), has n−4
zero-fresh updates, then two nonzero-fresh updates; its bound F_(n−1)+1 is
below B(n). Every earlier active entry is covered, not just the final pivot.
Unnormalized inputs retain their initial entry maximum by homogeneity or by
carrying that factor through every inequality; normalization cannot be assumed.

All computation is exact rational/complex algebra and finite Fibonacci
recurrences. LeanCert will check the kernel trust of completed theorems. No
artificial interval certificate is required. Rational finite-size scripts are
transcription diagnostics, not evidence for universal upper bounds or all sizes.

## Reuse and exclusions

IE-15's padded-state layout is useful, but its real rook-pivot semantics are not
reused as a theorem: IE-14 uses complex column-only partial pivoting. Existing
Mathlib finite maxima, complex norms, matrix determinant/inverse, permutations,
and Fibonacci APIs will be preferred over new abstractions. The actual Lean4
Comparator must compare all four Solution exports to this frozen Challenge.

Excluded: other pivot rules, deterministic tie-breaking, forbidden preliminary
permutations, growth of stored L multipliers, and claims for n<4. None is part of
the canonical target. The full canonical claim is retained without an unproved
front invariant, scalar growth bound, or witness admissibility premise.
