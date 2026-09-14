# IE-17 independent proof referee 2

- Phase/date: final mathematical source review and independent local replay, 2026-09-14.
- Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_2`, not the implementer, a human referee, or official Tau Ceti service.
- Statement freeze: `0986a8479d7f2c74560f456b20a7db98bc83de9b`. Definitions, Challenge and NUMERICAL_TARGETS are unchanged against that revision.
- Verdict: **PASS / APPROVE** at the exact hashes below. No substantive mathematical defect found. Actual isolated Linux Comparator remains a separate pending gate; canonical promotion is not approved on local evidence alone.

## Full source, fidelity and exports

I read all 108 lines of Certificates, 252 lines of Proof, 111 lines of Approximation, and Solution, against the approved boundary and the full canonical/source argument previously reviewed in `statement-referee-2.md`. I also read the current README, formalization.yaml, Comparator config and final-build/axiom evidence, and checked every entry of proof-source-hashes.json against its actual bytes.

The implementation proves both original negative claims separately, preserving fixed b, real exact arithmetic, zero-start undamped variational LSMR with minimum-length ties, genuine rectangular spectral perturbation norm, and the actual projected-residual approximation. The final result is a conjunction of two negations, each independently contradicted by its corresponding strict increase at the same successive nonzero, nonterminal iterates. No normal-residual proxy, Frobenius norm, sampled optimization value, or weakened conjunction replaces the original target. The minimum-error lower bound is deliberately nonstrict at sqrt(99/100), as approved; this suffices for the strict first-to-second increase without claiming the source's stronger strict lower endpoint.

All four public signatures match the frozen Challenge. The import chain is Solution → Approximation → Proof → Certificates → Definitions; Challenge's placeholders are absent from that dependency chain. The Comparator config lists exactly those four public names, no definition holes, and only the three foundational axioms.

## Attainment and actual LSMR iterates

`backward_attained` is a real attainment theorem for every finite real matrix dimension, not an assumed optimization oracle. The feasible perturbation set is nonempty using E=-A and is closed as the zero set of the continuous polynomial normal-equation map. I inspected `IsClosed.exists_infDist_eq_dist`: in a proper metric space it intersects the closed set with a bounded closed ball and applies compact attainment. The actual finite-dimensional real normed-space properness instance applies here. `Metric.isGLB_infDist` identifies distance-from-zero values with their greatest lower bound, and the proof explicitly identifies those values with the exact set of feasible spectral norms defining backwardError. The nonempty set is supplied again to the conditional-infimum equality. Thus neither empty-set defaults nor an unachieved infimum is substituted for the canonical minimum.

`krylov_one` and `krylov_two` derive complete scalar coefficient representations of the actual Krylov spaces using the imported span-range finite-linear-combination equivalence. The exact residual-gap identities hold for every point in each space and equal the candidate's squared normal-residual norm plus three nonnegative weighted coordinate squares. `iterate_of_gap` therefore proves global residual minimization, not just stationary equations. Equal objective norm forces each coordinate difference to zero, proving uniqueness and hence the minimum-Euclidean-length tie requirement. The concrete coefficients give the source x₁,x₂. `witness_injective` proves full column rank, and explicit coordinate checks prove both iterates and both normal residuals nonzero, discharging the original transition/termination conditions.

The local norm lemmas explicitly use EuclideanSpace.real_norm_sq_eq and the true matrix L2 operator bound, whose imported definitions I inspected. They do not use the default sup norm of coordinate functions. Squared norm inequalities supply nonnegativity before using algebraic order reasoning.

## Upper spectral certificate and arbitrary-feasible lower bound

Certificates contains the exact rational 4×3 upper perturbation, whose feasibility is checked directly against the unchanged b. `upper_ldl` checks every entry of κI-EᵀE=L diag(D)Lᵀ, with κ=1979/2000. Positive rational D entries give PSD by congruence. Crucially, `upper_norm_sq` then proves a bound for the actual rectangular operator norm: it applies the PSD quadratic form to every Euclidean input, identifies squared dot products with Euclidean squared norms, and invokes `ContinuousLinearMap.opNorm_le_bound`. It does not infer a spectral bound from an entrywise norm or an unproved eigenvalue estimate.

The lower K is verified by an exact weighted sum-of-squares identity. Each coefficient is positive; the mixed signs reproduce the off-diagonal entries. `lower_form` proves the exact rational bridge between that quadratic form and the source's C,D expression. This converts the weighted diagonal-dominance investigation into a kernel-checked identity rather than assuming a diagonal-dominance theorem with incorrect scaling. The large source determinants are unnecessary.

`lower_feasible_sq` quantifies over every feasible real 4×3 E. It defines the actual perturbed residual v=r-Ex₂ and derives its perturbed normal equations. In the v=0 branch it uses Ex₂=r and the true operator bound, together with an exact rational comparison, to get ||E||²≥99/100. No residual normalization occurs in this branch.

In the v≠0 branch, it explicitly proves ||v||²>0. Feasibility gives Aᵀv=-Eᵀv and vᵀb=||v||². Those identities yield the exact D-form identity without unit normalization. The actual operator inequalities for Eᵀv and Ex₂, including equality of transpose and original operator norms, bound both C and D contributions. Division by ||x₂||² is justified by strict positivity, and the final cancellation of ||v||² occurs only in the nonzero branch. Thus no feasible perturbation case is omitted. Attainment then transfers the every-feasible-E bound to the genuine backward-error minimum. Combining this with the explicit upper perturbation and the strict rational square-root gap gives the claimed increase.

## Actual projector, Moore–Penrose identities and LeanCert

The approximation implementation starts from the original stacked matrix and projected vector, not from a renamed rational expression. For arbitrary real t it computes the Gram matrix of scaledStack t as diag(1+t²,36+t²,25+t²); all diagonal entries are proved nonzero. The explicit reciprocal diagonal is proved a true right inverse, and `Matrix.inv_eq_right_inv` identifies the genuine matrix inverse in leftPseudo. `stack_penrose` proves all four Moore–Penrose identities, including symmetry of both products. These are exported at each actual iterate.

`projector_norm_sq` expands the full seven-coordinate projected vector, uses the sum-indexed Euclidean norm, and proves the three-term rational expression with all denominator nonzero facts. `approximate_formula` substitutes t=||r||/||x||, proves ||x||²>0, and uses the nonterminal hypothesis to select the original nonzero branch of approxError. It therefore connects the exact rational formula to the specified approximation rather than assuming the formula. Exact residual and iterate calculations produce the two advertised enormous rational squared values. `approximation_nonneg` permits the final passage from squared strict ordering to error strict ordering.

The two scalar cuts are proved by LeanCert's kernel-only interval_decide on closed rational inequalities, with no subdivisions. My independent audit walks the actual approximation proof expression's used constants: it contains `LeanCert.Validity.verify_strict_upper_bound_dyadic_checked`. This confirms actual LeanCert certificate use, not merely an unused import or compiler-trust evaluation. Transitive exported axiom audit below confirms no native or custom trust. The small source-derived point inequalities and the rational/SOS reductions appropriately minimize computation.

## Independent local checks

I independently re-elaborated Certificates.lean, Proof.lean, Approximation.lean, and Solution.lean with pinned Lean 4.33.1. All four exited 0, including their kernel trust assertions. `verification/referee-2-elaboration.log` records each module and exit status. The only warnings are the same two deprecated Set membership names generated by the imported LeanCert point tactic; they do not affect semantics or trust.

A separate independent audit imports Solution and prints all four public transitive axiom closures. Every export depends exactly on `[propext, Classical.choice, Quot.sound]`. It also inspects actual LeanCert dependencies as described above. Source is retained in `verification/Referee2Audit.lean`, output in `verification/referee-2-axioms-and-cuts.log`; the run exited 0. The author's final-build log independently records successful Solution compilation with 3677 jobs. I have not inferred a Linux Comparator pass from any of these local checks.

## Reuse, documentation and limitations

The proof reuses Mathlib's closed-set distance attainment and finite-dimensional properness, Euclidean operator norms, finite spans, PSD congruence, matrix inverse uniqueness, and block matrix algebra. The helper separation is clear: numerical certificates, variational/optimization argument, and actual projector derivation. Exact rational LDL and weighted SOS avoid unnecessary spectral calculations; direct gap identities avoid a simulated recurrence. The final argument is mathematically complete at the advertised scope.

Headers, README and manifest distinguish Colbrook's submitted mathematics, Fong–Saunders' original questions, and Sidney Holden's formalization with OpenAI Codex assistance. They preserve AI reconstruction and priority qualifications, state the spectral-only scope, identify actual LeanCert point usage, and conservatively label final reviews and isolated Linux verification pending. No external human review, source-author endorsement, or novelty is claimed. I do not authenticate ownership, names, affiliations or priority. Metadata-only pending statuses may be updated after actual gates pass without changing the mathematical source; changed proof bytes require renewed review.

This is independent AI mathematical/source review with local elaboration and exported-axiom inspection, not an independent audit of the full Lean/OS kernel or all transitive Mathlib/LeanCert code. I inspected the relevant used APIs, not every dependency. Actual isolated Linux Comparator, its default-kernel replay/rejection controls and operational provenance audit remain pending, so the canonical status must not be promoted on this report alone. No proof code was modified by this reviewer.

## SHA-256

- `NLA/IE17/Definitions.lean`: `eda180881ac84c75c75735bc4e8525bdf326862bed550890efe6381a14f4c90b`
- `NLA/IE17/Certificates.lean`: `a5788f6a4bcdba325f3f35e7ef379f66aeef05f85b72a77d5a42532d2a0cc49d`
- `NLA/IE17/Proof.lean`: `324546012fd97f17309ef200ef9507a7f8f05567f692ff0f23f86cb7d3ffbc48`
- `NLA/IE17/Approximation.lean`: `fc00a9edd478153d9369f1546572a12f830a8621fce2ca421bf2b3fb89ed4b82`
- `Challenge.lean`: `8c5aa2240fa18627857e190591374dd50066f2962aed5fab0c6591b3eec1537a`
- `Solution.lean`: `84551059f5a2eb78a918de92c6be4eef0a261e7f6854c4423210646ff3ed4d0a`
- `NUMERICAL_TARGETS.md`: `767f706cbf630848334c82a5de73798ad0a6f5a11d16af4e3ac95e8c07dca516`
- `README.md`: `d4bc3f990c33c07280caad981a45eb981d3f71ea578f538e84613c460ea2dc60`
- `formalization.yaml`: `56e705ab47e4d4e9431482c435256537dbfa556c376d4815ac798ad58ba14264`
- `comparator.json`: `4be90034e97c30a2f3de0fb10e7cf2dc78eff13a3f9b2724e6419890b90ed72a`
- `reviews/proof-source-hashes.json`: `be30af8973860d55918359c4d538d244521e6315adf75e5d0b7fdeca3116358f`
- `verification/final-build.log`: `3824b32e87985ad76958cd45f285ef81894121da5be4bd787b35ebd99c26f809`
- `verification/referee-2-elaboration.log`: `36d67289db1205cd2e4f148f4e3d4590634279e3d2f47cf3ff96b813ebdaa366`
- `verification/referee-2-axioms-and-cuts.log`: `2073b5f636ccbc7b6a7b85eda4d5108e3097a069bef48464ca83b998f5ab63fd`
- `verification/Referee2Audit.lean`: `f054ddbb32514856f743e6b822b668cc51250e5379ff895d565b5582da45d338`
- `.lake/packages/mathlib/Mathlib/Topology/MetricSpace/HausdorffDistance.lean`: `c60ba18220f965f572da23238039c5c5a3ed98817e61d0f6632279fc6daa931b`
- `.lake/packages/mathlib/Mathlib/Analysis/Normed/Module/FiniteDimension.lean`: `2598904c7b6a33ad86537d15464c45d476dea56dd035e3d8237dab5027f47e5e`
- `.lake/packages/mathlib/Mathlib/Analysis/CStarAlgebra/Matrix.lean`: `79518c9e51c4d0cf4083ab69a9ac7a2817305b48db1fe6f25ae1d678e12ce223`
- `.lake/packages/mathlib/Mathlib/Analysis/InnerProductSpace/PiL2.lean`: `1f9827b2db67213c725a2dcc3fec52a87772966d1fbd3fc6857a019dbd7a6053`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Finsupp/LinearCombination.lean`: `f8e79ad4a35781c09b7de25fcf491f1d17306cb50a7446d985cabedfc09f20da`
- `.lake/packages/LeanCert/LeanCert/Tactic/Verification.lean`: `2c576708b528acdde17796b0b715b83079f9cad377182dbd87c248323ff0a58c`
- `.lake/packages/LeanCert/LeanCert/Validity/DyadicBounds.lean`: `6f1cdbc11f32e425ef5e9f4a22966d64ff0d11614ec9453ed7dde498e31a7c47`
