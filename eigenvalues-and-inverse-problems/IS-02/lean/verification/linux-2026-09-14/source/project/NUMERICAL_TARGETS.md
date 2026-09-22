# IS-02: frozen mathematical targets before proof

Mathematical counterexample: Matthew J. Colbrook, University of Cambridge.
Original conjecture: Bassam Mourad and Hassan Abbas, Conjecture 5.1, p. 10 of
arXiv:1310.1273v1. Formalization: Sidney Holden, Flatiron Institute, with Codex.

The complete retained README and solution.md at base
9777c86853b40206f70438c92a47a7dec9bc66ae are the target and proof sources.
The primary preprint's definitions on pp. 1–2 and conjecture on p. 10 were
also inspected on 14 September 2026. Its positive-trace necessary condition
matches the canonical target. No novelty or source-author endorsement is claimed.

## Four public targets

1. The exact source matrix A = diag([[0,1],[1,0]], [[1/2,1/2],[1/2,1/2]])
   is a real symmetric nonnegative stochastic matrix. Its actual characteristic
   polynomial is X(X−1)^2(X+1); its trace is exactly one and strictly positive.
2. Every real symmetric nonnegative stochastic B with this characteristic
   polynomial is A with a simultaneous permutation of rows and columns.
   This is the full spectral-uniqueness quantifier, with multiplicities.
3. The source endpoints diag(S,I₂), diag(S,S) are distinct admissible matrices
   and have A as their midpoint. A is not an actual extreme point of the full
   polytope and belongs to none of the actual closed segments in the proposed
   locus. The vertices are Mathlib extremePoints, not permutation matrices.
4. The original universal necessary condition, over every n ≥ 4, is false.
   Order four suffices; no classification at other dimensions is advertised.

## Computation reduction and proof design

All witness entries are rational; no floating-point eigenvalues, spectral
intervals, or approximate graph arguments are required. Use LeanCert in kernel
mode for the retained scalar positivity obligation and export trust checks.

For an arbitrary competing order-four input, write the six nonnegative
upper-triangle entries as a,b,c,d,e,f. Row sums fix the diagonal. Exact symbolic
prechecking shows p′(1) = 4T, where p is the actual characteristic polynomial
and T is the sum of the sixteen spanning-tree products. Equal characteristic
polynomials give T = 0. Nonnegativity forces every tree product to vanish.
Among the 64 edge supports, 38 contain a spanning tree, 23 have an isolated
vertex, and only 3 are disjoint pairs with no isolated vertex. The support
partition is a proof plan, not an assumption added to spectral uniqueness.

An isolated vertex contributes diagonal entry one. The trace-one condition and
nonnegative remaining diagonals force the other three diagonals to zero; their
row sums then force every remaining edge to 1/2. This would give nonzero
determinant, contradicting the zero constant coefficient. Thus only two
pairs remain. Their two diagonal parameters t,s satisfy t+s=1/2. Determinant
zero then forces {t,s}={0,1/2}, exactly the source witness up to permutation.
The proof will establish these algebraic implications in Lean, not trust the
external symbolic precheck. No library graph connectivity or Perron theorem
is needed for this finite instance.

For the locus, the source midpoint excludes extreme-point status. The zero
(0,0) entry forces a segment from I to an admissible vertex to end at that
vertex; the zero (0,2) entry does the same for segments from C. In [I,C],
the zero (0,2) entry forces I, which differs from A. All parameters include
both endpoints, and all vertices of the polytope are quantified.

## Mechanical and review gates

Definitions use actual Matrix.charpoly, Matrix.trace, submatrix reindexing by
Equiv.Perm, Mathlib real segment, and Set.extremePoints. The positive-dimension
assumption precedes uses of C_n's denominator. Nothing relies on its value
at n=1. No custom conclusion is assumed in an admissibility predicate.

Before implementation: elaborate all statements and obtain two independent
hash-specific source/statement approvals. After implementation: all four
exports must have no proof holes, only standard3 axioms, two independent final
reviews, and actual isolated Linux Comparator/default-kernel replay with the
repository rejection controls. Canonical status remains unchanged until then.
