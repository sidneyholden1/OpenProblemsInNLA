# IV-06 frozen numerical and mathematical targets

Source revision: `9777c86853b40206f70438c92a47a7dec9bc66ae`.
Read the complete canonical `../README.md` and Matthew J. Colbrook's complete
`../../../references/colbrook-intervals-2026-09-11/manuscripts/IV-06.tex`.
The latter supplies the mathematical proof; formalization is by Sidney Holden
with OpenAI Codex assistance. Original conjecture: Hladík, Daney and Tsigaridas.

The full original target quantifies over every natural dimension n ≥ 1 and all
real lower and upper matrices L ≤ U entrywise. Every entry varies independently
in a closed interval; singleton intervals are allowed. A real eigenvalue is a
real t with an actual nonzero real vector v satisfying A v = t v for some
admissible A. There are no symmetry, invertibility or diagonalizability assumptions.
Count actual nonempty connected components in the usual real topology using
Mathlib's connectedComponentIn and Set.encard (extended natural cardinality).
The theorem negates the universal bound by producing ≥ 4 components in dimension 3.

## Exact certificate

A(a,b) has rows (25,a,b), (1,-1,0), (1,0,1).
The domains are -166 ≤ a ≤ -16 and 9 ≤ b ≤ 159, independently.
The four included eigenvalues and their witnesses are:

| t | a | b | v |
|---|---|---|---|
| -3 | -21 | 154 | (-4,2,1) |
| 0 | -16 | 9 | (-1,-1,1) |
| 3 | -146 | 29 | (4,1,2) |
| 25 | -91 | 84 | (312,12,13) |

Each vector is nonzero and each pair satisfies the domain bounds.
At t = -1, 1, 12 the exact characteristic-determinant ranges are respectively
[-332,-32], [-318,-18], [-3750,-150]. Only strict exclusion of zero is required.
One can eliminate the eigenvector equations directly instead of expanding the
determinant: at t=-1 or 1 its first coordinate vanishes and the bounds force
the other coordinates to vanish; at t=12, the last two equations give
v0=13 v1=11 v2, and the first yields (1859 + 11a + 13b)v1 = 0. The lower bounds
a ≥ -166 and b ≥ 9 make this coefficient at least 150, forcing v=0.

The separators lie strictly between consecutive included points:
-3 < -1 < 0 < 1 < 3 < 12 < 25. A preconnected subset of ℝ contains the
interval between each two of its points. Thus four witness points give four
distinct nonempty connected components. This topological bridge is a required
proof, not a hypothesis or an assumed consequence of a numerical computation.

## Computation policy and exports

Use exact integer/rational algebra for the eigenpairs, elimination and finite
cardinality bridge. No spectral search, subdivision or approximate eigenvalue
is needed. LeanCert is pinned and any use must be kernel trust; an auxiliary
strict rational separator margin may use a point certificate. Do not replace
these exact arguments by an artificial multidimensional interval computation.

Challenge exports included_points, excluded_separators, counterexample, and
not_componentBoundConjecture. All definitions and signatures must type-check
and receive two independent statement approvals before proof bodies are written.
No claim to identify all component endpoints or the exact component count is made.
