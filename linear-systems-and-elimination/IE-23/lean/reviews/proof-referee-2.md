# IE-23 independent proof referee 2

- Phase/date: final mathematical proof review, 2026-09-14.
- Reviewer: `/root/iv06_statement_referee_2`, independent OpenAI Codex AI agent assigned to IE-23, not the implementer, a human referee, or an official Tau Ceti service.
- Original source base: `9777c86853b40206f70438c92a47a7dec9bc66ae`. Statement freeze: `881f88715b89ff9b468ed8f9d1fbb96a31769c9a`; Definitions hash was checked against that commit. Working-tree implementation reviewed at the SHA-256 hashes below.
- Verdict: **APPROVE mathematical proof implementation**. No substantive mathematical defect found. README and manifest claims are also approved at the reviewed bytes; isolated Comparator remains a separate pending gate.

## Fidelity, hypotheses and actual mathematical objects

I reviewed all of Proof.lean and Solution.lean against the complete canonical target, full manuscript, Definitions, numerical targets, and approved Challenge reviewed in `statement-referee-2.md`. The full original complex, finite-real-p>2 uniqueness implication is negated by a legitimate dimension 2×3 example at p=4. No assertion of all-p equality, every minimizer, or minimum over every right inverse is smuggled into the formalization claim. Those stronger source results are unnecessary to refute the displayed universal implication.

The original complex domain remains intact throughout. `squared_norm_identity` is quantified over every complex two-vector and reduces complex squared norms to both real and imaginary coordinates via `Complex.sq_norm` and `Complex.normSq_apply`. It therefore proves the complex identity, not merely a real restriction. The norm definitions remain actual square roots, sums of complex magnitudes, real powers, and the actual supremum over all nonzero complex vectors.

## Algebra and inverse/rank bridge

The two right-inverse identities are checked entry by entry with exact rational complex arithmetic. `pseudoInverse_eq` proves `(A Aᴴ)G=I` for the explicit genuine inverse G=[[2/3,-1/3],[-1/3,2/3]], then invokes imported `Matrix.inv_eq_right_inv`. I inspected this imported theorem: it derives equality with the actual nonsingular matrix inverse from a right-inverse identity for square matrices. Thus the formal pseudoinverse equality does not exploit a default singular inverse or substitute entrywise reciprocal. The subsequent multiplication AᴴG=B is exact.

Surjectivity is proved constructively for an arbitrary complex codomain vector v: preimage Xv maps to v by AX=I and matrix-vector associativity. This is precisely the full-row-rank boundary. Distinctness is witnessed by entry (0,0), where X has zero and B has 1/3. The final implication is instantiated using these actual rank, right-inverse, and distinctness proofs.

## Global norm bounds, denominator and supremum gates

`euclidean_X` proves X preserves the two-coordinate Euclidean norm. `squared_norm_identity` proves ||By||₂²+|u+v|²/3=|u|²+|v|² for arbitrary complex u,v. Nonnegativity and the monotonicity of the genuine square root then give `euclidean_B_le_X`.

`quartic_sum_pos` extracts a nonzero coordinate from the nonzero vector and proves |u|⁴+|v|⁴>0, including cases with either coordinate zero. `pNorm_four_pos` uses actual positive-base real powers to prove the denominator strictly positive. All later division steps use this theorem. `pNorm_four` correctly specializes real exponent 4 to natural fourth powers.

`ratio_X_upper` reduces the inequality to its fourth power only after supplying nonnegativity of both sides and a nonzero exponent. I inspected `pow_le_pow_iff_left₀` and `Real.rpow_inv_natCast_pow`: the former gives the required implication on nonnegative reals and the latter recovers the radicand under the stated nonnegative-base and nonzero-exponent assumptions. `Real.sq_sqrt` is used only with an explicit nonnegative sum. The remaining inequality is the exact identity arising from (|u|²-|v|²)²≥0. This is an upper bound for every nonzero complex vector, not a numerical sample. `ratio_B_upper` follows by numerator domination and a nonnegative denominator.

At the explicit nonzero vector (1,-1), both matrices attain the desired ratio 2^(1/4). The B image is computed as (0,1,-1); the X image follows its general norm identity. `flat_ratio_value` uses real-power addition and sqrt=rpow with positive base 2, and division by a proven nonzero fourth root.

`norm_certificates_proved` extracts the universal ratio bounds from the actual ratio-set membership definition, derives nonemptiness from the attained member, and derives boundedness above from those universal bounds. Only then does it apply `csSup_le` and `le_csSup`. I inspected these imported supremum facts and their hypotheses. Consequently neither an empty-set nor an unbounded-set supremum default is used. Both norm equalities are genuine upper-bound-plus-attainment statements, and the public certificate includes the nonempty/bounded witnesses.

Finally `not_uniquenessConjecture_proved` instantiates the full original conjecture with m=2,n=3,p=4,A,X, rewrites the actual pseudoinverse and the two established norm values, and contradicts strict-order irreflexivity. No conclusion is embedded in an assumption or custom definition.

## Independent elaboration and transitive axioms

I independently ran `lake env lean NLA/IE23/Proof.lean` with the specified Lean 4.33.1 runtime; exit status was 0 and output empty. The output log is `verification/referee-2-proof-elaboration.log`. This independently re-elaborated the entire implementation, including its three `#assert_trust kernel` commands. I also inspected the author's successful proof and Solution build logs (2145 and 2147 jobs respectively).

A separate temporary file imported Solution and printed axioms for `NLA.IE23.witness_algebra`, `NLA.IE23.norm_certificates`, and `NLA.IE23.not_uniquenessConjecture`. This independent run exited 0; all three exports depend exactly on `[propext, Classical.choice, Quot.sound]`. Output is retained in `verification/referee-2-exported-axioms.log`. No sorry, custom, or compiler-trust axiom occurs transitively in the exports. The Solution source imports Proof, not the placeholder Challenge, and its three signatures match the reviewed Challenge statements. Isolated Comparator still supplies the separate mechanical statement-identity gate.

LeanCert is actually used here for its transitive kernel trust assertions. I inspected the imported assertion implementation, which calls `collectAxioms` and rejects sorry, custom axioms and native compiler trust for the kernel mode. This proof does not use interval arithmetic or a numerical LeanCert certificate, and must not be advertised as doing so. Pure exact algebra makes artificial interval work unnecessary; this usage follows the approved computation policy.

## Reuse, clarity, attribution and remaining gates

The proof uses existing Mathlib inverse uniqueness, complex norm-square expansion, real roots/powers, finite matrix arithmetic, and conditional supremum APIs. Local lemmas isolate denominator positivity, universal upper bounds, attainment, and inverse identities clearly. There is no reason to add interval subdivision or stronger abstract optimization machinery for this exact p=4 counterexample. The implementation is small enough to inspect completely, and its exported surface matches the actual refutation scope.

Mathematical source authorship and Sidney Holden's formalization with OpenAI Codex assistance are distinguished in the file header. Resolved minor attribution wording: the initial header said the matrix witness ‘originates in’ Dokmanić–Gribonval’s spectral-norm example. I suggested preserving the source’s qualification rather than implying independent priority authentication; the final header now says ‘The source attributes the matrix witness to’ that example. I reread this comment-only change after the independent elaboration; executable mathematical code is unchanged. Apache licensing is recorded and a project LICENSE is present; I have not authenticated ownership or author identities.

At initial inspection, README, formalization.yaml, and comparator.json were still being prepared. I subsequently read all three. The final reviewed metadata correctly limits the norm computation to p=4 while identifying the full original negation, states actual complex/pseudoinverse/supremum semantics and the ratio-set gates, identifies LeanCert use specifically as kernel-trust auditing, preserves source/example credits and AI assistance, and truthfully labels final reviews and isolated Linux Comparator pending. Reported foundational axioms and zero solution sorry counts agree with my independent check. Comparator config lists exactly the three public exports, the reviewed Challenge and Solution modules, an empty definition-hole list, and only the three foundational permitted axioms. I did not independently run the metadata schema validator or Comparator, and I do not authenticate the affiliation metadata. Status wording should be refreshed after the actual remaining gates pass.

This review is independent AI mathematical/source review with local elaboration and exported-axiom inspection, not a full audit of the Lean kernel or all transitive dependency implementations. The relevant used imported facts named above were inspected; the whole Mathlib dependency tree was not. Later mathematical changes require new hashes/review. Metadata-only status changes require checking their evidence but do not alter approval of unchanged proof bytes.

## SHA-256

- `NLA/IE23/Definitions.lean`: `2ee00cdcdd36e75c481798c1522f899520790dfbbaa9e1ad831acbea14a89e81`
- `NLA/IE23/Proof.lean`: `4fbbefca10f57a04bd3523c5a5354703e31a698dc889d0123d0db425abf9c690`
- `Solution.lean`: `c4e4c6fe4d34afe2ca368e38fb8705e6b08980bcd282cf06c813b10c9d3c43db`
- `Challenge.lean`: `145a96587f1d3026ef61af600254fd68f2a56a31d757905593a77829a80fb5e3`
- `NUMERICAL_TARGETS.md`: `448fc539461059b80ce656251ccd8bd2a96e492e9c1f4ad3e564a62211c478a5`
- `lake-manifest.json`: `52b144f9ffbaa26d0d21dd3b279e16eb102b720774ebe2d5a9e41170bab0d73f`
- `verification/proof-build.log`: `ad463cda722b5b5d296edb7df26c0c549fec921d6bf98299a6ca7280c3d96aa9`
- `verification/solution-build.log`: `f43709d5c793fc4a761db6e4f922add13d0a0af0ef6b29043fd6317cf0634062`
- `verification/referee-2-proof-elaboration.log`: `e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`
- `verification/referee-2-exported-axioms.log`: `36291365ba931bd465197fe1ddd2f1d43bbe9eef9a13448dbc938ecc1f72370c`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/NonsingularInverse.lean`: `1ee785b6ebd213ad2ed971bf3c804afee8cc6ce52be69e63572b4cf1bdb5e880`
- `.lake/packages/mathlib/Mathlib/Analysis/Complex/Norm.lean`: `815efa05d2282b0b234139eac16d614f1128d69e39cf02249df887934ccc9741`
- `.lake/packages/mathlib/Mathlib/Data/Complex/Basic.lean`: `e279bd6369e83ebf6716e17a8f38c81c812020753472cac5e7ae2a501790b760`
- `.lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Pow/Real.lean`: `1f4e64fc28a20f4e19291a94dafd68daa82588b46f6ee5b9203df373ba595fa3`
- `.lake/packages/mathlib/Mathlib/Analysis/Real/Sqrt.lean`: `d6055b85eb3279133dd76eead0e1306032314c2c42c99b431b07e6aad654da86`
- `.lake/packages/mathlib/Mathlib/Algebra/Order/GroupWithZero/Basic.lean`: `5ae904bb6c2caab184fbeb514e648544f96ad657860f307d43bbc2217ce535cb`
- `.lake/packages/mathlib/Mathlib/Order/ConditionallyCompleteLattice/Basic.lean`: `4e4c9abe9993f2334c389d6cb4b75b31b44bb66bb87b65a95b3abac2dbd9fcc8`
- `.lake/packages/LeanCert/LeanCert/Tactic/Verification.lean`: `2c576708b528acdde17796b0b715b83079f9cad377182dbd87c248323ff0a58c`
- `README.md`: `864ad2082bbc63c0ce4e361642c67e55fae7797eaf86b2d650cdd3c66b3d416f`
- `formalization.yaml`: `25e7ca4292c448da46f9ebd921c80a7a0a565ba43291c1e89d92ce7e54c279f9`
- `comparator.json`: `d81e1cbaa7c789b1bd33e2ddf1bcad9cd3219d807b5c4aacf1f147f46972d908`
