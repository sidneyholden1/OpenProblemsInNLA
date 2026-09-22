# PF-02 exact statement plan — before proof implementation

This is a statements-only draft of the complete negative answer to PF-02. Its mathematical source is Matthew J. Colbrook, *An orientation obstruction to connectedness of minimal positive semidefinite factorization orbits*, Theorem 1. The original question is due to Fawzi–Gouveia–Parrilo–Robinson–Thomas. Codex prepared this draft for independent review; no proof or formal-verification success is claimed.

The canonical README and the complete source manuscript were read, including the optional all-size and positive-perturbation arguments. The worktree base is `32f1f799219fbcaf4c66bfaa4edb8a0c591e79e9`; exact source hashes are in `verification/source-provenance.json` and `verification/statement-source-hashes.json`. The earlier feasibility screen read `deb549fa9ddd6b119e6c59016f268237e645dfa2`; the two relevant source files are compared byte-for-byte before this draft is frozen. Historical source review claims are not evidence of a new Lean result.

## Full scope and definitions

The conjecture retains every integer k≥3, p,q≥1, entrywise nonnegative real M, actual ordinary rank k(k+1)/2 and actual minimal positive PSD factor size k. Factorizations include every row and column family of real symmetric positive semidefinite k×k matrices with actual trace(A_i B_j)=M_ij. Their topology is the subspace topology inherited from finite products of real matrix spaces; it is the Euclidean topology of the original question.

`feasibleSizes` contains every positive natural size admitting such a factorization, and `psdRank` is its actual natural sInf. A separate generic contract requires the feasible set to be nonempty and its infimum to be an attained least member for every nonnegative M in the canonical dimensions. A diagonal factorization in size q supplies nonemptiness. Thus no default empty-infimum value substitutes for minimal rank.

`Congruent F G` quantifies over every unit S in the actual real k×k matrix ring and requires both transformations G.A_i=Sᵀ F.A_i S and G.B_j=S⁻¹ F.B_j S⁻ᵀ. No restriction to orthogonal, positive-determinant, or orientation-preserving matrices is imposed. `OrbitSpace` is Mathlib's `Quot` with its coinduced quotient topology. The generic quotient contract requires that this relation is an equivalence and that two classes agree iff there is an actual displayed congruence; it also requires the class map to be a genuine quotient map. This prevents additional identifications being hidden in the use of a generated-relation quotient.

The final target is the negation of the full connectedness conjecture. The explicit k=3,p=q=6 instance suffices. The stronger source constructions for every odd/even factor size, nonquantitative positive perturbations, component counts and classification are excluded. This is a complete universal negation, not a claim that every admissible M has disconnected quotient.

## Exact finite quantities to prove

Use the displayed integer matrix `witnessM` and six positive definite factors from the source. The second factor family changes only the (0,1) and (1,0) entries of factor index 3 from +1 to −1. Both row and column factor families undergo this change. Their full trace Gram matrices must equal `witnessM` entry by entry.

All entries of `witnessM` are strictly positive. Its actual determinant is 8192 and rank is 6. In coordinate order (X00,X11,X22,X01,X02,X12), the row-coordinate determinants of the two factor families are +32 and −32. The trace metric is diag(1,1,1,2,2,2); the factor two is essential because both off-diagonal matrix entries contribute to the trace.

The leading principal minors of factors 0,…,5 are respectively (4,8,16), (2,8,16), (2,4,16), (2,3,6), (2,4,6), (2,4,6). Reflection preserves this list. These finite quantities provide positivity diagnostics; the exported requirement is actual Mathlib positive definiteness, and actual PSD factorization membership, not just a list of positive numbers.

Minimality must prove `IsLeast (feasibleSizes witnessM) 3` and `psdRank witnessM=3`. The supplied size-three factors give membership. To exclude positive sizes below three, the general flattening bound rank(M)≤k² is sufficient: k≤2 implies k²≤4<6. There is no need to formalize the stronger all-k symmetric dimension bound k(k+1)/2 merely to prove this instance.

## Required generic bridges and topology

For arbitrary symmetric families A_i,B_j in order three, prove their actual trace-pairing matrix equals U_A G U_Bᵀ. Applying it to every actual witness factorization and using det(M)≠0 forces det(U_A)≠0. The factorization space is not restricted in advance by an orientation hypothesis.

For an arbitrary real 3×3 S, including singular S, define the 6×6 matrix C_S by the actual congruence images of the six symmetric coordinate basis matrices. Prove both U_(SᵀAS)=U_A C_S and det(C_S)=det(S)^4. This is a fixed polynomial identity in all nine entries of S. When S is a unit, det(S)≠0 and its fourth power is positive, including when det(S)<0. This avoids proving the source's general-dimensional identity by polynomial density.

The real-valued sign function is +1 when det(U_A)>0 and −1 otherwise. Prove it is continuous on the entire factorization subtype using the proved nonvanishing, and that it is invariant under every allowed congruence. Descend it to a continuous function on the actual quotient and prove its range is exactly {−1,+1}, using both concrete factorizations. The final contract requires a nonempty quotient and failure of `IsPreconnected univ`, stronger than failure of connectedness caused merely by emptiness. A continuous image of a preconnected space in ℝ cannot contain −1 and +1 while excluding zero. The quotient counterexample then contradicts the full conjecture.

## Computation, library reuse and trust plan

Use exact finite ring arithmetic and matrix determinant identities; avoid intervals over matrix entries, eigenvalue approximation, and topological reasoning by numerical sampling. Author-side `verification/precheck.py` independently reconstructs both Gram matrices, all listed principal minors and determinants, and coefficientwise checks det(C_S)=det(S)^4 in nine polynomial variables. The degree-12 polynomial has 120 nonzero terms. Its cached-minor determinant computation keeps this diagnostic small. This diagnostic establishes no Lean theorem or universal topology fact; its exact output is `verification/precheck.json`.

Pinned Mathlib semantics inspected include real `Matrix.PosSemidef`, actual `Matrix.rank`, `Quot`'s coinduced topology, `Topology.isQuotientMap_quot_mk` and `continuous_quot_lift`. Existing IV-06 supplies an example of passing from a genuine connectedness predicate to an interval obstruction; RA-20 supplies an example of retaining actual subtype/cardinality semantics and exact source bridges. No theorem from those NLA projects is assumed. LeanCert's explicit kernel trust auditing will check final exports. Pure exact algebra needs no artificial interval certificate; if a numerical point certificate is later used, its actual kernel term and material consumption must be inspected.

## Gate status

There are nine deliberate Challenge placeholders and no proof or Solution implementation. The fresh pinned Lean 4.33.1 macOS aarch64 `lake build Challenge` succeeds (2397 jobs) with exactly those nine warnings. An initial failed typecheck for the unqualified `IsQuotientMap` name is retained as `verification/statement-build-initial.log`; the corrected declaration uses `Topology.IsQuotientMap`. Well-formedness and exact author diagnostics do not replace two independent statement approvals. The drafting agent cannot count as an independent referee of this boundary. Proof development, two final reviews, all-export axioms, actual Linux Comparator/default-kernel replay and rejection/sandbox controls remain subsequent gates.
