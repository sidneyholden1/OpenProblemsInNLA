# MI-04: exact contracts fixed before proof

This is a symbolic, all-dimensional problem; there is no sampled numerical target or finite interval grid. The two Challenge exports quantify over every natural n>=1 and every complex n-by-n X. `UniversalBlockNorm X` is the literal condition for all Hermitian A,B and the actual PSD matrix `Matrix.fromBlocks A X X.conjTranspose B`. Both norms use `Matrix.Norms.L2Operator`, the induced Euclidean operator norm. `PairModulusSymmetry` uses genuine unit Euclidean vectors u,v with complex inner product zero, and the actual matrix continuous-linear-map action. `EssentiallyHermitian` is exactly an existential Hermitian K and arbitrary complex alpha,beta with X=alpha K+beta I.

1. `universal_pair_symmetry`: the universal condition implies the off-diagonal pair modulus equality for every orthonormal pair.
2. `original_target`: the universal condition implies the complete canonical essentially-Hermitian conclusion. No invertibility, distinct spectrum, dimension bound beyond n>=1, real-entry restriction or source theorem is a premise.

The intermediate pair condition is vacuous in dimension one, but the original conclusion is still separately proved there. Alpha=0 is allowed, so scalar matrices are included. The canonical implication is the advertised target. The source's optional converse, four-way equivalence and numerical-range formulation are excluded from the formal claim.

## Exact algebra to establish internally

The complete proposed route is in PROOF_PLAN.md. It is an adaptation of Colbrook's proof, not his original perturbation argument copied verbatim. All analytic and algebraic bridges below are proof obligations, never hypotheses of the final exports.

- UniversalBlockNorm is preserved under positive real scaling, conjugate transpose and unitary similarity.
- Scalar-sum PSD reflection: if D+E=2I and [[D,Y],[Y*,E]]>=0, the norm property gives the same PSD completion with Y replaced by Y*.
- Fix coordinate i, weights e_i=2 and 0<e_j<2 for j!=i, d_j=2-e_j. The polynomial family Q_t has upper diagonal (1 at i; d_j elsewhere), lower diagonal (2-t^2 at i; e_j elsewhere), and cross-block rows s*X_i and t*s*X_j elsewhere. Its congruence by top coordinate scaling t equals [[diag(t^2,d),t*sX],[t*sX*,diag(2-t^2,e)]]. The diagonal sum is exactly 2I.
- At t=0 the Schur complement is diag(1-s^2*R at i; d_j elsewhere), with R=sum_j ||X_ij||^2/e_j. For s^2 R<1 it is positive definite. A positive gap and continuity make Q_t PSD for small t>0; reflection and closed PSD cone give s^2 C<=1, C=sum_j ||X_ji||^2/e_j.
- If C>R>=0, set s=sqrt(2/(R+C)). Then s>0 and s^2 R<1<s^2 C. This handles zero R without division by R. Repeating for X* gives R=C.
- Two exact rational weight configurations suffice for any i!=j: e_i=2 and e_k=1 for k!=i, followed by changing just e_j to 1/2. Subtraction isolates ||X_ij||^2=||X_ji||^2. Arbitrary orthonormal pairs follow by actual unitary basis extension.
- Sum pair equalities to prove normality. Use three distinct spectral values and the source's orthonormal Fourier pair to prove collinearity, with separate singleton/two-value cases. A real-line spectrum/CFC characterization then gives the actual Hermitian affine representation. No normal eigenbasis or eigenvalue differentiability theorem is assumed.

## Optimization, trust and evidence

Use exact finite sums, block identities and general positivity/continuity. There is no mathematical need for an interval oracle here. LeanCert is pinned and will check the permitted kernel trust of final exports; an exact scalar checker should only be added if its result is consumed. Separate Challenge and Solution will be compared by the unchanged repository Linux Comparator, including negative and isolation controls. Only two deliberate Challenge placeholders exist at this stage; no Solution proof is present.

The author diagnostic in verification/rescaling_diagnostic.py checks exact rational complex matrix identities on a bounded collection, including dimension one and zero rows. It is a finite implementation diagnostic, not the all-dimensional proof. verification/DefinitionsProbe.lean explicitly checks the actual L2 norm bridges and the scalar conclusion case. Two independent nonauthor statement approvals are required before proof work.

Credit: source mathematics Matthew J. Colbrook; original question Bourin–Lee, with Hayashi background. Formalization Sidney Holden with OpenAI Codex assistance. Mathlib, LeanCert and Comparator retain their existing credit. AI-agent checks are not external human review or source-author endorsement.
