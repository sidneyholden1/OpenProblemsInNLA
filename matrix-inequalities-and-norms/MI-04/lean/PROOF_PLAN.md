# MI-04: full-target feasibility and replacement for eigenvalue perturbation

Planning only, 2026-09-22. A statement-only project has been created; no Lean target proof has been implemented. This note is an independent reconstruction of a possible formal proof route, not a checked theorem or a statement approval.

## Exact scope and credit

For every positive finite dimension n and every complex n-by-n matrix X, assume that for every pair of Hermitian matrices A,B, positivity of the actual block matrix [[A,X],[X*,B]] implies its actual spectral L2 operator norm is at most the spectral L2 operator norm of A+B. Conclude that X=alpha K+beta I for some Hermitian K and complex alpha,beta. No invertibility, simple eigenvalue, distinct singular value, real-entry, or normality assumption belongs in the boundary.

This is the complete canonical question. Colbrook's source proves additional equivalences, a numerical-range characterization and the converse. Those optional stronger results need not be exports, and must not be advertised as formally proved unless implemented. The mathematical source remains Matthew J. Colbrook; the PSD rescaling below is a proposed formal-proof adaptation of his weighted row/column comparison step. It should not be attributed verbatim to the source.

The complete canonical README, solution.md, solution.tex, original MI-04.tex and independent informal review were read. Source paths and exact hashes are in verification/source-provenance.json.

## Recommended replacement for the simple-eigenvalue perturbation step

Use scalar-sum PSD reflection, a polynomial matrix family and a positive-definite gap. This needs no continuously chosen eigenvectors, extremal eigenvalue derivatives, Taylor expansion, or asymptotic remainder estimate.

1. **Preservation.** The universal property passes from X to rX for r>0 by applying it to A/r,B/r and multiplying the resulting inequality by r. It passes to X* by swapping the two blocks, and to U*XU for unitary U by simultaneous block conjugation. These are genuine norm-invariant changes of coordinates, not extra hypotheses.

2. **Reflection.** Suppose P=[[D,Y],[Y*,E]] is PSD and D+E=2I, where Y has the universal property. Then norm(P)<=2, so P<=2I in the actual PSD order. Thus 2I-P is PSD. Swap the two blocks and change the sign of one block to conclude that [[D,Y*],[Y,E]] is PSD. This is the only use of the universal norm hypothesis in the limiting comparison.

3. **Fix one coordinate i.** Choose positive real weights e_j<2 for j!=i and put e_i=2. Let d_j=2-e_j for j!=i. For real t and positive real s, set

   D_t=diag(t^2 at i; d_j elsewhere), E_t=diag(2-t^2 at i; e_j elsewhere),
   P_t=[[D_t,t*s*X],[t*s*X*,E_t]].

   For t!=0, rescale coordinate i of the first block by 1/t. The resulting Q_t has upper diagonal 1 at i and d_j elsewhere, lower diagonal E_t, and off-diagonal block B_t whose i-th row is s times the i-th row of X and whose other rows are t*s times their rows of X. **Define Q_t by these entries, including t=0**, so continuity is polynomial and never relies on extending the singular inverse 1/t continuously. For t>0, P_t is the congruence of Q_t by diag(top scaling t at i,1 elsewhere; bottom I).

4. **Arrow criterion at zero.** Let R=sum_j norm(X_ij)^2/e_j. The bottom block E_0 is positive definite. Its Schur complement in Q_0 is exactly diag(1-s^2 R at i; d_j elsewhere). Therefore s^2 R<1 implies Q_0 positive definite. A convenient existing-API proof is: Schur complement gives PSD; the block determinant formula gives a nonzero determinant since all diagonal factors are positive; PSD plus nonzero determinant gives positive definiteness. Conversely, positivity of Q_0 implies 1-s^2 R>=0 by the same Schur complement and its i-th diagonal entry.

5. **No missing openness theorem is required.** For positive-definite Hermitian Q_0, CFC gives eta>0 with eta I<=Q_0. Continuity gives norm(Q_t-Q_0)<eta for t sufficiently close to zero. Since Q_t-Q_0 is Hermitian, the standard CStar order bound -(norm(Q_t-Q_0)) I<=Q_t-Q_0 implies Q_t>=0 (indeed it remains strictly positive). This proves the needed neighborhood statement explicitly from existing order/norm APIs. There is no assumption that arbitrary complex perturbations stay Hermitian: Hermiticity of this concrete Q_t is proved for every real t.

6. **Apply reflection for t>0.** Congruence makes P_t PSD. Its diagonal sum is exactly 2I, and t*s>0, so step 2 applies to the property of t*s*X. After inverse congruence the reflected Q'_t is PSD. Its entrywise limit is the arrow matrix constructed from X* instead of X. The PSD cone is closed, so Q'_0 is PSD. Its Schur complement yields s^2 C<=1, where C=sum_j norm(X_ji)^2/e_j.

7. **Threshold comparison, including zeros.** R,C are nonnegative. If C>R, let s=sqrt(2/(R+C)); the denominator is positive, s>0, s^2 R<1 and s^2 C>1, a contradiction. Therefore C<=R. Repeat for X* (whose universal property follows in step 1) to get R=C. This treats R=0 without division by R.

8. **Only two rational weight configurations per pair are needed.** For i!=j use first e_i=2 and all other e_k=1, then change just e_j to 1/2. Subtract the two weighted equalities. The result is norm(X_ij)^2=norm(X_ji)^2, hence equality of norms. No variable interval optimization or search is needed. For arbitrary orthonormal u,v, extend the pair to an orthonormal basis and apply this result to the unitarily transformed X.

## Geometry after pair symmetry

The source's normality argument sums the squared pair equalities in an orthonormal basis containing a prescribed unit vector. This yields norm(Xv)=norm(X*v), hence normality. A global normal eigenbasis is not required: for three distinct spectral values select three unit eigenvectors, use normality to get orthogonality, and apply the source's explicit cubic-root-of-unity pair. The resulting exact identity forces every spectral triple to be collinear. Handle spectra with one or two values separately, without imposing distinctness on the input matrix. A real-line spectrum characterization through continuous functional calculus then makes alpha^{-1}(X-beta I) self-adjoint. This geometry route is being independently investigated by the coordinator and has not been Lean-checked here.

## Inspected pinned library bridges

Paths below are relative to the pinned mathlib checkout; exact file hashes are retained in verification/source-provenance.json.

- `Analysis/CStarAlgebra/Matrix.lean`: actual `Matrix.Norms.L2Operator` scope and matrix CStar norm, not the default entrywise norm.
- `Analysis/Matrix/Order.lean`: `Matrix.nonneg_iff_posSemidef`, `Matrix.le_iff`, `Matrix.PosSemidef.posDef_iff_det_ne_zero`, `Matrix.isStrictlyPositive_iff_posDef`.
- `Analysis/CStarAlgebra/ContinuousFunctionalCalculus/Order.lean`: `CStarAlgebra.norm_le_iff_le_algebraMap`, `IsSelfAdjoint.neg_algebraMap_norm_le_self`, `CFC.exists_pos_algebraMap_le_iff`, `CStarAlgebra.isClosed_nonneg` and its `OrderClosedTopology` instance. The gap lemma's code correctly uses strictly positive spectrum despite its imprecise docstring word 'nonnegative'.
- `LinearAlgebra/Matrix/PosDef.lean`: `Matrix.PosDef.fromBlocks₂₂` is a PSD Schur-complement equivalence requiring a positive-definite invertible bottom block; positive definiteness of the whole block must be established separately. `PosSemidef.conjTranspose_mul_mul_same` and unit congruence equivalences supply the transports.
- `LinearAlgebra/Matrix/SchurComplement.lean`: `Matrix.det_fromBlocks₂₂` uses `invOf`; an explicit invertibility instance converts this to the nonsingular inverse used in the Schur-complement lemma.
- `Topology/Instances/Matrix.lean`: `continuous_matrix`, continuous conjugate transpose/matrix products and `Continuous.matrix_fromBlocks`.
- `Analysis/InnerProductSpace/PiL2.lean`: `Orthonormal.exists_orthonormalBasis_extension` and `..._of_card_eq` for extending an actual two-vector orthonormal family.
- `Analysis/InnerProductSpace/Adjoint.lean`: `isStarNormal_iff_norm_eq_adjoint`, `IsStarNormal.ker_adjoint_eq_ker`.
- `LinearAlgebra/Eigenspace/Basic.lean`: finite-dimensional `Module.End.hasEigenvalue_iff_mem_spectrum`, including eigenvalue zero.
- `Analysis/CStarAlgebra/Unitary/Maps.lean`: unitary left/right multiplication isometries, ultimately using `CStarRing.norm_coe_unitary_mul` and `norm_mul_coe_unitary`.

## Feasibility judgement and concrete missing work

**Mathematically feasible for the full canonical necessity, with a concrete perturbation-free route. Not yet a Lean implementation estimate or acceptance.** The main new code is (i) block norm/congruence transport with the correct L2 instances, (ii) exact arrow Schur/determinant identities, (iii) the Hermitian gap/PSD limit lemma, (iv) pair-to-normal and spectral-triple/CFC geometry. None is an unproved source theorem permitted as an input to the final target. Bookkeeping around finite coordinate sets, block indices and complex real casts remains substantial. Repeated/zero spectral values and n=1 must be explicit cases.

Recommended eventual exports: universal property implies orthonormal-pair modulus symmetry; pair symmetry implies normality/essential Hermiticity (as useful independent structural lemmas); and the full canonical implication. The final theorem must discharge every bridge internally. LeanCert should audit the final exports' kernel trust; no numerical interval certificate is intrinsically needed for this exact algebra/continuity proof. Any optional scalar root-of-unity inequalities should use exact identities or genuinely consumed kernel certificates, not decorative checker calls.
