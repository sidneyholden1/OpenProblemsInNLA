# IE-05 mathematical and numerical boundary before proof

Mathematical counterexample: George Stepaniants, Department of Computing and
Mathematical Sciences, California Institute of Technology. Original conjecture:
John Peca-Medlin. Formalization: Sidney Holden, Center for Computational Biology,
Flatiron Institute, Simons Foundation, with OpenAI Codex assistance.

## Complete target and source

Canonical `linear-systems-and-elimination/IE-05/README.md` and the complete
`solution.md` at base `9777c86853b40206f70438c92a47a7dec9bc66ae`.
The original conjecture says that for every n≥2, the orthogonal QR factor of the
unit lower triangular matrix with all strict-lower entries -1 maximizes actual
GEPP element growth over all orthogonal matrices and all admissible tie paths.
The specified candidate uses first available row in ties. A single n=8
counterexample refutes this full universal statement; no true supremum value
or asymptotic leading constant is advertised.

`positiveQR` gives exactly the defining relations QᵀQ=I, QR=L, R upper triangular
and strictly positive diagonal. Quantifying over factors satisfying these
relations expresses the canonical positive-diagonal QR convention. It does not
substitute the no-exchange LU factorization for QR. Both explicit pairs must
be shown to satisfy these relations, not merely to be orthogonal matrices.

## Actual pivoting and extrema definitions

States are full n×n matrices padded by zeros outside their active trailing
submatrix. State 0 is the actual input. At stage k, choose p≥k with nonzero
pivot attaining the largest absolute entry of the active first column. Swap
current rows k,p, then form the exact trailing Schur complement. Earlier rows
and columns are zeroed; future recurrence is imposed only while k+1<n.
`isPath` allows every admissible tie choice. `isFirstPath` additionally picks
the smallest current row index among maximizers; it is used for the specified
candidate and the displayed no-exchange counterexample. No column pivoting or
preliminary reordering is permitted. Values of states at indices ≥n do not
enter the recurrence, maxima or growth.

`entryMax` is the genuine largest absolute matrix entry, implemented as a
finite supremum of nonnegative real absolute values. `growth` is the largest
entry magnitude across every state divided by this input maximum. It is not
spectral, Frobenius, or merely a final-pivot ratio by definition. The finite
suprema are zero on an empty index type; all witnesses have n=8.

`orthogonalGrowths n` contains actual growth factors of every real orthogonal
matrix and all admissible GEPP paths. The conjecture uses the genuine real
sSup of this set. The exported witness theorem explicitly requires the n=8 set
to be nonempty and bounded above, forbidding an empty/unbounded sSup default.
Every admissible path with n≥1 has positive input maximum because its first
pivot is nonzero. The elementary stage bound max(S[k+1])≤2 max(S[k]) gives a
finite universal growth bound (2^n is sufficient), without assuming orthogonality.

## Frozen exact matrices and QR certificates

The full source integer H,H0,T,T0 and positive squared column lengths D,D0 are
encoded in Definitions and independently regenerated in the Fraction precheck.
No rounded square roots occur. For each example Qij=Hij/sqrt(Dj).

Candidate D0=(8,248,3286,36146,349184,2796544,2,5462).
Counterexample D=(8,16,240,47640,472430,3644970,16148136,5272).
Ltilde differs from L8 only at zero-based entry (7,1), which is zero.

Prove HᵀH=diag(D) and H0ᵀH0=diag(D0), then actual QᵀQ=I. Define R=QᵀL
(or QᵀLtilde); prove QR=L, upper triangularity and positive diagonal. The
integer products HᵀL and H0ᵀL8 are upper triangular with positive diagonal,
so the QR check needs no explicit matrix-inverse formula or numerical QR.

The source LU identities H=Ltilde T and H0=L8 T0 have positive T diagonals.
The stated active formula S[k]ij=Σell≥k L[i,ell]T[ell,j]/sqrt(Dj), for i,j≥k,
must be proved to obey the actual Schur recurrence and pivot conditions.
Its first-column ratios equal the corresponding strict-lower entries (-1 or
0), so the first available row is k at every stage. Both exported paths use
p(k)=k. These identities establish the path; they are not assumptions hidden
inside `isPath`.

## Minimal growth separation targets

Only the bounds needed to refute optimality are advertised:

- growth(Q8) ≤ sqrt(17948132/2601);
- growth(Qtilde) ≥ 5272/63;
- growth(Q8) < growth(Qtilde) ≤ sSup(orthogonalGrowths 8).

The source proves exact values, but these one-sided bounds already settle the
full conjecture. This deliberately reduces computations without changing the
mathematical target. Do not claim formalization of the exact source stage table.

For the candidate, all active squared entries are ≤5462. The largest integer
active numerator in each column is (1,13,51,169,511,1365,1,5462); comparison with
D0 proves the bound. Its input entry (2,2) has magnitude 51/sqrt(3286), giving
the needed input-maximum lower bound. For the counterexample, every input
squared entry is ≤3969/5272; its final active pivot has magnitude sqrt(5272).
These give the two desired growth bounds without finding every counterexample
stage maximum or every candidate input maximizer.

The exact rational separator 167/2 lies strictly between the two growth bounds:

17948132/2601 < (167/2)^2 < (5272/63)^2.

Use LeanCert's kernel point prover for these cuts if useful. All roots have
strictly positive integer radicands. Factor out common positive column roots
before pivot comparisons and Schur arithmetic; never subdivide root intervals
or repeat irrational computations entry by entry.

## Review and trust gates

`verification/numerical_precheck.py` uses only exact integers/Fractions to check
both QR products, all pivots, all Schur recurrences and exact growth values.
It is diagnostic preparation, not Lean evidence. Existing IV-06/IE-17 kernel
point inequalities and IE-19 finite nonnegative-real sup norm definitions were
studied. The shared pinned Mathlib and LeanCert setup is reused; those projects'
mathematical results are not assumed. Shared Comparator workflow provenance is
in tools/lean/NOTICE.md.

Two independent Tau Ceti-style statement approvals must precede proof bodies.
Two independent final proof reviews, exported axiom closures, real isolated
Linux Comparator/default-kernel replay and rejection controls are required
before canonical status promotion. No definition holes; only propext,
Classical.choice and Quot.sound. Original problem ID/path/target remain fixed.
