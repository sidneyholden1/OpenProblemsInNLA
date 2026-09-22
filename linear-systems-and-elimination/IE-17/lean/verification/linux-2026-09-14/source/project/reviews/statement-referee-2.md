# IE-17 independent statement referee 2

- Phase/date: pre-proof statement and exact-certificate review, 2026-09-14.
- Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_2`, assigned to IE-17; not a human referee or official Tau Ceti service.
- Immutable source base: `9777c86853b40206f70438c92a47a7dec9bc66ae`.
- Verdict: **PASS / APPROVE** the statement bytes below. No blocking or substantive statement correction requested. Mathematical proof implementation and isolated verification remain outstanding.

## Complete canonical target and scope

I read the complete canonical README and entire supplied manuscript, including both general certificates, exact iterates, approximation, rational completion, dense variant, and source/priority qualifications. I compared the canonical/source bytes with the immutable base commit and checked all entries of statement-source-hashes.json against the actual files. I also read Definitions, Challenge, numerical targets and the complete numerical precheck script/data.

The canonical target consists of two separate monotonicity assertions counted together. The final Challenge export correctly requires `¬monotonicError backwardError ∧ ¬monotonicError approxError`, not merely failure of their conjunction or failure of normal-residual monotonicity. Both concrete increases are independently required. The underlying matrices and vectors are real; perturbations affect A alone and keep b fixed. The spectral/operator norm is the stated canonical norm; no Frobenius or jointly perturbed-right-hand-side formulation is substituted.

## Exact LSMR, indices and termination

`krylovSpace` is the real span of exactly (AᵀA)^j Aᵀb for j=0,…,k-1, using actual matrix powers and multiplication. `isLSMRIterate` requires membership, least normal-residual Euclidean norm over the entire Krylov space, and least Euclidean length among equal-residual minimizers. These are the canonical equivalent exact-arithmetic conditions starting from zero, with no damping. They are not just orthogonality conditions assumed to imply optimality without a bridge.

`monotonicError` compares successive indices k and k+1 with k≥1, both vectors nonzero, and the first normal residual nonzero. It therefore concerns a transition before exact termination while allowing the next vector to be the terminal solution. Allowing natural zero dimensions adds no spurious counterexample because the required nonzero iterates cannot exist in a zero-dimensional domain. The concrete iterates theorem explicitly verifies full column rank through injectivity of the actual matrix map, both variational iterates, both nonzero vectors and both nonzero normal residuals. With this full-column-rank witness, the normal-residual objective is strictly convex and its Krylov minimizer unique, so the minimum-length condition is mathematically legitimate rather than an extra unsupported numerical claim.

## Genuine norms, optimization and projection

I inspected the imported `PiLp` norm instance: for p=2 it is the square root of the sum of squared real coordinate magnitudes. Thus `vnorm` via `WithLp.toLp 2` is genuine Euclidean norm, including on the sum-indexed stacked vector, rather than the default sup norm of a function. I also inspected the rectangular `Matrix.Norms.L2Operator` norm construction, induced from continuous linear maps between Euclidean spaces. Both boundary and Challenge open that scope, so perturbation norms are actual spectral norms even for rectangular E.

`feasible` is literally (A+E)ᵀ((A+E)x-b)=0, with unchanged b. `backwardError` is the actual real infimum of norms of every feasible E. Feasibility is always nonempty (E=-A) and all such norms are nonnegative. The Challenge additionally demands a feasible minimizer attaining each witness infimum, preserving the canonical minimum rather than replacing it by an unachieved numerical lower envelope. Finite-dimensional compactness of bounded closed norm sublevels and closedness of the polynomial feasible set supply a legitimate attainment route. Actual proof bodies must establish the required infimum/attainment bridges; these are not axioms of the custom definition. At an exact least-squares solution E=0 is feasible and nonnegativity gives error zero, consistent with the canonical convention.

`stacked` uses the actual `Matrix.fromRows` construction, which I inspected as Sum.elim on rows, to form K=[A;ηI] with η=||r||₂/||x||₂. `Sum.elim r 0` is exactly [r;0]. `leftPseudo` uses the genuine square-matrix inverse `(KᵀK)⁻¹Kᵀ`, whose imported inverse instance is determinant inverse times adjugate, not entrywise reciprocal. The four `moorePenrose` equalities are precisely KPK=K, PKP=P, symmetry of KP, and symmetry of PK over the real field.

The full-column-rank formula does not silently restrict the original universal approximation claim: whenever the universal comparison evaluates a nonzero nonterminal iterate, its residual is nonzero, η>0, and the stacked positive identity block makes K full column rank regardless of A's rank. At termination `approxError` explicitly returns zero; nonzero iterates exclude division by zero in other universal cases. The concrete approximation export further verifies all four Moore–Penrose identities at both witnesses, as well as the two exact squared values and their strict ordering. The proof must connect those rational values to the actual projected norm, not simply rename a convenient rational expression as the approximation.

## Independent exact witness checks

I independently used Python Fraction arithmetic, separate from executing the author's precheck, to check both listed Krylov representations; orthogonality of g-Hx₁ to Hg and of g-Hx₂ to both Hg and H²g; both nonzero normal residuals and vectors; and the residual fourth entry equal to one. A=diag(1,6,5) with one zero row is injective as claimed. The independent exact projection-formula calculation `Σ (Aᵀr)i²/(||x||² Hii+||r||²)` matches both enormous displayed rational approximation values, and they obey the stated 503/500 and 1007/1000 separation cuts. This confirms the planned numerical identities but does not itself prove the projection-formula bridge in Lean.

For the listed 4×3 rational upper perturbation E, I independently checked the exact perturbed normal equations at x₁. I reconstructed (1979/2000)I-EᵀE and verified its equality to the supplied L diag(D) Lᵀ with each rational D entry positive. This is a valid finite positive-definiteness certificate and a genuine spectral-norm route once formally connected to the operator norm.

For x₂, I independently reconstructed C,D from the displayed witness and checked every entry of `(5/6)C+(1/6)D-(99/100)I = K/2407881992100`. The stated positive weights give exactly the four stated positive weighted diagonal-dominance slacks. This supports an exact positivity proof through a positive diagonal scaling and a sum-of-squares decomposition, without requiring large determinant expansion. Weighted row inequalities alone must not be treated as ordinary unweighted diagonal dominance in the implementation.

The source's lower certificate handles both zero and nonzero new residuals. The numerical targets preserve that split and forbid division by a zero residual norm. Their exported lower bound is deliberately nonstrict, sqrt(99/100)≤μ(x₂), which is sufficient together with μ(x₁)≤sqrt(1979/2000) and the strict gap between those constants. This avoids unjustifiably promoting pointwise strict lower bounds to a strict infimum bound. The final exported strict increase remains fully sufficient to refute the original question. All of these auxiliary rational checks are mathematical prechecks, not Lean proofs.

## Reuse, credit, evidence and remaining obligations

Existing Mathlib Euclidean/operator norm, matrix inverse, block matrix and finite-dimensional optimization APIs are appropriate. Exact rational LDL and weighted positivity reduce computation responsibly; no approximate eigenvalue search or rounded recurrence can stand in for a universal certificate. LeanCert is to remain kernel-trust only, with any actual point arithmetic honestly distinguished from external prechecks.

The boundary credits Colbrook's submitted mathematical counterexample, Fong–Saunders' original questions, and Sidney Holden's formalization with OpenAI Codex assistance separately. Canonical/source materials preserve AI reconstruction and priority qualifications, and do not claim external human peer review or formal certification. I make no independent authorship, affiliation, ownership, priority or endorsement authentication.

I inspected `verification/statement-build.log`: Definitions and Challenge build successfully (2711 jobs), with exactly four deliberate Challenge sorry warnings. I did not independently rerun that build. No proof implementation was reviewed or written. Separate final proof reviews must cover the actual minimum-length/Krylov bridge, feasible-set attainment, spectral upper/lower bounds including both residual cases, four Moore–Penrose identities and projected-formula derivation, both strict increases, and their separate universal negations. Exported axiom audit and isolated Comparator/default-kernel replay remain mandatory before promotion. Statement approval alone establishes none of these Lean proofs.

## SHA-256

- `../README.md`: `53cba6429e84e1c8e055e10e5b7093f03ee0d1a94c8bf57f30ed150ae4cc08dc`
- `../../../references/colbrook-recovered-2026-09-11/manuscripts/IE-17.tex`: `d0e446f7b9ee5669c1beece9ca91a89387b2f8e340c19bca8254f556386efbcd`
- `NLA/IE17/Definitions.lean`: `eda180881ac84c75c75735bc4e8525bdf326862bed550890efe6381a14f4c90b`
- `Challenge.lean`: `8c5aa2240fa18627857e190591374dd50066f2962aed5fab0c6591b3eec1537a`
- `NUMERICAL_TARGETS.md`: `767f706cbf630848334c82a5de73798ad0a6f5a11d16af4e3ac95e8c07dca516`
- `verification/numerical_precheck.py`: `051008c0a0121031bd803d183a10ecf8c6ac5737aeff21e29b0173b445278161`
- `verification/numerical-precheck.json`: `de8a23f41e40e30e56d1c26d82dc9acde3d3e4e9185f7a7f8e5eb6279af5ccf1`
- `reviews/statement-source-hashes.json`: `873a57d68a88f2aa582dd1e62805682f237a11c26c86b321f874d06b8b535a99`
- `verification/statement-build.log`: `10702b6b1d27730e07228a50a74b30cd8c6bafcea55b22a249e0d6dcbcc4aeb1`
- `.lake/packages/mathlib/Mathlib/Analysis/Normed/Lp/PiLp.lean`: `660f3ad7077490c9a8eae924e18731c400282b8dccf80bfec1c6b02fe11ee25f`
- `.lake/packages/mathlib/Mathlib/Analysis/CStarAlgebra/Matrix.lean`: `79518c9e51c4d0cf4083ab69a9ac7a2817305b48db1fe6f25ae1d678e12ce223`
- `.lake/packages/mathlib/Mathlib/Data/Matrix/ColumnRowPartitioned.lean`: `4ca773885c89f50549414ec87f2925342008b8cb1ed193adf04be368d40fddfc`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/NonsingularInverse.lean`: `1ee785b6ebd213ad2ed971bf3c804afee8cc6ce52be69e63572b4cf1bdb5e880`
