# MI-03 independent statement referee 2

- Phase/date: pre-proof mathematical statement review, 2026-09-14.
- Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_2`, assigned to MI-03. Not the implementer, a human referee, or the official Tau Ceti service.
- Source base: `9777c86853b40206f70438c92a47a7dec9bc66ae`.
- Mathlib revision: `0df444a360eaa60ab8c11dca51a86af692955474`.
- Verdict: **APPROVE** the final statement bytes below. No substantive mathematical correction required. One minor example-attribution wording issue was resolved before final hashing.

## Complete source and scope

I read the complete canonical README, complete standalone solution.tex, complete original-proofs/MI-03.tex, numerical targets, Definitions, and Challenge. I independently verified canonical source bytes against the immutable base commit and every listed source/statement hash against the statement-source-hashes manifest.

The original question asks for the infimum of all nonnegative dimension-independent admissible additive constants, for every odd k≥3. The boundary quantifies over every natural dimension n≥1, every k-tuple of complex square matrices, and every contraction in that tuple. No Hermitian, commuting, invertible, real-only or nonzero-summand restriction is introduced. Singular and zero matrices remain allowed. `oddSharpConstantConjecture` retains precisely the odd-k original question. Proving the stronger source formula for all k≥2 supplies every required odd case. Excluding k=0,1 from the public sharpness/value theorems is appropriate and does not remove any original case.

`upper_bound` asserts full admissibility of k/4, including nonnegativity and the all-dimensional inequality. `sharpness` requires actual complex dimension-two contractions realizing the displayed matrix gap, rather than merely an assumed scalar lower bound. `sharp_constant` separately advertises nonemptiness and lower boundedness of the exact admissible set alongside its true infimum value. `odd_sharp_constant` requires the whole original conjecture. These signatures do not assume their conclusions, hide a lower-bound theorem inside a definition, or weaken the target to a finite list of summand counts.

The optional source claim about Hermitian 3×3 extremizers is explicitly excluded and is not encoded by the four signatures. The dimension-two export does not claim the extra rank-one or exact-norm-one properties of the proposed source witnesses; only actual contraction and exact-gap claims are advertised. This is sufficient and faithful to the original target.

## Actual norm, modulus, order and infimum

Both Definitions and Challenge explicitly open `Matrix.Norms.L2Operator`. I inspected the imported Matrix C*-algebra implementation: its scoped norm is induced by the continuous linear map between Euclidean spaces, and `l2_opNorm_def`/`cstar_norm_def` identify it with that operator norm. `toEuclideanCLM` acts by actual matrix-vector multiplication. Thus the contraction bound is the spectral/Euclidean operator norm intended by the source, not the default entry norm or Frobenius norm. The complex domain and the ≤1 endpoint are correct.

`modulus` is literally `CFC.abs A`. I inspected `CFC.abs`, which is `CFC.sqrt (star A * A)`, and the actual matrix star instance, which is conjugate transpose. I also inspected the nonnegative functional-calculus square root, its nonnegativity and its square identity on nonnegative inputs. The Gram matrix AᴴA is nonnegative for every A, including singular matrices, so the default behavior of CFC.sqrt away from its predicate cannot replace the desired modulus. No symmetry assumption on A is needed.

The opened `MatrixOrder` instance defines X≤Y as `(Y-X).PosSemidef`, as confirmed by the actual imported preorder/partial-order declarations. The order is not entrywise. The expression `c • (1 : Matrix ...)` uses a real scalar times the matrix identity, exactly cI, and the signs/order of the desired inequality match the source. `sharpGap` has real diagonal entries k/4 and -3k/4 coerced into complex entries; real division is explicit and cannot truncate.

`bestConstant k` is literally real `sInf {c | admissible k c}`. The set contains only nonnegative reals by the first conjunct of admissibility. The upper-bound theorem gives a concrete member at every k≥2, and the sharp-constant theorem explicitly requires nonemptiness and `BddBelow` before advertising the value. The standard conditional-infimum API is appropriate. The implementation must use these facts and the witness-derived universal lower bound so that no empty-set or unbounded-set default determines the answer. The signatures themselves correctly expose the necessary gates.

## Independent analytic and numerical-target check

There is no approximate numerical calculation in the proposed proof. For any k≥2, the exact root-of-unity phases have unit modulus and zero sum. The proposed vector v_j=(1/2,√3 ω^j/2) has squared norm 1/4+3/4=1. Consequently e₁v_jᴴ is a contraction and its Gram square root is the rank-one projection v_jv_jᴴ. Summing zero phases gives ΣA_j=diag(k/2,0), while summing their projection entries gives Σ|A_j|=diag(k/4,3k/4). Since k≥2, the diagonal sum is positive semidefinite and its modulus is itself. The difference is exactly sharpGap k. Evaluation at e₁ in any purported universal inequality forces c≥k/4. These identities work at k=2 and every odd k≥3; no even-only cancellation has been substituted for the zero-sum phase identity.

For the universal upper bound, the displayed positive decomposition expands correctly: the pairwise-difference Gram sum equals kΣA_jᴴA_j-(ΣA_j)ᴴ(ΣA_j), canceling the corresponding squared moduli; the remaining square gives the k²I/4-kR terms. Each modulus is a positive contraction, so |A_j|-|A_j|² is positive semidefinite. The square of the self-adjoint R-kI/2 is positive semidefinite. This does not require commuting summands. The equivalent vector Cauchy–Schwarz route is also valid. The implementation must prove these PSD/norm bridges and the arbitrary-k phase identities; numerical experiments cannot replace those universal facts.

## Reuse, credit and resolved documentation detail

I inspected the MI-29 proof-independent matrix modulus/order/CFC example and the relevant pinned Mathlib implementations above. Reusing those mathematical APIs avoids replacing operator order/norm with superficially similar operations. Exact algebra and roots of unity suffice; no interval subdivision or spectral search is appropriate. LeanCert kernel-trust auditing is an honest planned use for this algebraic proof, and should not be described as numerical interval certification unless such a certificate is actually used.

The source argument is attributed to Matthew J. Colbrook and the original question/known upper bound to Bourin and Lee. Sidney Holden's formalization credit and OpenAI Codex assistance are separate. I do not independently authenticate ownership, affiliations, priority, or author endorsement. The canonical/source material discloses AI assistance and distinguishes agent review from human peer review and formal certification.

Resolved minor documentation finding: the initial examples paragraph incorrectly described IE-23 as supplying both genuine-infimum and supremum patterns. I requested narrowing that description to the actual genuine-supremum pattern. The final NUMERICAL_TARGETS now says exactly that; its final SHA-256 is `6141b4786e29b2cfd4e6ee538df1f173ea2c4bf52f6972173ff460022fdd8b0b`. No mathematical definition or theorem signature changed.

## Mechanical evidence and limitations

I inspected `verification/statement-build.log`: Definitions and Challenge build successfully (3029 jobs), with exactly four deliberate Challenge sorry warnings. I did not independently rerun this build. No proof implementation existed for this assignment; none was reviewed or written. I ran no final axiom audit, numerical LeanCert certificate, or Comparator. Two pre-proof statement approvals do not establish mathematics. The subsequent proof must supply the all-dimensional upper bound, true operator-norm contractions, arbitrary-k exact sharpness, valid infimum bridge, foundational-only exported axiom closure, independent final proof reviews, and isolated Comparator/default-kernel replay before promotion.

## SHA-256 of reviewed sources and evidence

- `../README.md`: `fc504918a1f2ca1d83bc0e3b68ff4864d349ad215ff50116e9bfab2776378ba3`
- `../solution.tex`: `bd7a553bdcb0cd76543960b299f952a30e0f5829192cc89c869ffe1676454703`
- `../../../references/colbrook-matrix-2026-09-11/original-proofs/MI-03.tex`: `2d2d0ac01e22de1c6d63471c0965b1c17362d5eda23d53cbf397ab4932be32b3`
- `NLA/MI03/Definitions.lean`: `14688d721143401624b2ccb0db66f1c417d03128b2f998ba63c22a71e49305bf`
- `Challenge.lean`: `eeb7b72d202166be496afc3fb0ca416dfdce3a3d5e8f86c58a44ea1cabcd4bb3`
- `NUMERICAL_TARGETS.md`: `6141b4786e29b2cfd4e6ee538df1f173ea2c4bf52f6972173ff460022fdd8b0b`
- `reviews/statement-source-hashes.json`: `512744db871684903b86fc781c4749febc1f1d3ca42200e9b26d05bf0dc54ed1`
- `verification/statement-build.log`: `7b269d5fb8b331067cf8a54096c3b48f1a9da1a08b536236b31ab3742efe4c8b`
- `.lake/packages/mathlib/Mathlib/Analysis/CStarAlgebra/Matrix.lean`: `79518c9e51c4d0cf4083ab69a9ac7a2817305b48db1fe6f25ae1d678e12ce223`
- `.lake/packages/mathlib/Mathlib/Analysis/Matrix/Order.lean`: `eb786ba4435f1955c504da52de2beae76647d814922266c8aac8f082bbc3e2da`
- `.lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Abs.lean`: `660c178d7405446d3ec489aa0554c65bb104ce95d58ae5134beba961f37e6932`
- `.lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Rpow/Basic.lean`: `5c87ec96e95be9c21e52857acc4892f9a6b7e69d7358f8d6fbbef93b0d249ef7`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/ConjTranspose.lean`: `10ace10899567db7c2ccd38c0e89e3bdca2261494975a42d3b1a5535c9e3b1b6`
- `.lake/packages/mathlib/Mathlib/Order/ConditionallyCompleteLattice/Basic.lean`: `4e4c9abe9993f2334c389d6cb4b75b31b44bb66bb87b65a95b3abac2dbd9fcc8`
