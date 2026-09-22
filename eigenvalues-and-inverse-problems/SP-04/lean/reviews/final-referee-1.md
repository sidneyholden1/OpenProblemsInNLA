# SP-04 independent final code review — referee 1

Phase: final mathematical code and fidelity review. Reviewer: `/root/sp04_final_referee_1`, an independent OpenAI Codex AI agent and nonauthor of this project's statements and proof code. **APPROVE / PASS for the exact mathematical bytes listed below**, subject to the separately required fresh isolated Linux Comparator and publication checks. This is an AI-agent review under the repository's Tau Ceti adaptation, not external human peer review or an official Tau Ceti run or endorsement.

I read `docs/lean/README.md` and `REVIEW.md`, the entire canonical SP-04 README and complete Markdown and TeX informal solution, the frozen numerical plan, all definitions and nine Challenge signatures, every proof module and Solution, provenance, statement reviews, dependency configuration and active metadata. The source mathematical argument remains attributed to Matthew J. Colbrook, and this formalization to Sidney Holden with AI assistance.

## Fidelity and mathematical proof

The definitions faithfully retain real matrices, absolute determinant one (both signs), the original stationary matrix equation, all real stationary competitors, uniqueness of both the selected matrix and multiplier, and the explicit squared Frobenius objective over every feasible matrix. Its squared order is equivalent to Frobenius norm order. The negative conclusion supplies an actual unique least pair, so it cannot follow merely from an empty stationary set. A counterexample at dimension three suffices to negate the all-dimensions assertion. The genericity quantifier allows every nonzero polynomial in all nine entries, preserving the proper real algebraic exception meaning.

`MatrixReduction` obtains invertibility from feasibility, derives the reversed stationary equation by cancellation, and uses both transposed equations to force every off-diagonal entry to zero. Positive distinct parameters ensure unequal squares. This is a valid and simpler alternative to the source's Gram-matrix argument, with no assumption that competitors are diagonal.

`Scalar` covers the entire closed multiplier interval `[0,13/25]`, including zero. The split at `2/5` covers both cases without gaps. In the lower case each positive root is below `44/25` and either below `3/10` or above one; in the upper case each is below `3/2` and either below `2/5` or above one. The exact product margins are `5808/6250 < 1` and `9/10 < 1`. Both LeanCert point certificates are actually used to contradict the unit product. Thus the optimization does not shrink the frozen parameter domain. The source's square-root derivative estimate is unnecessary.

For negative multipliers the code proves denominator positivity, the explicit negative-root magnitude identity, strict monotonicity and continuity, and endpoint crossing. The IVT produces an actual root strictly inside `(0,13/25)`; strict monotonicity proves uniqueness. All eight root-sign patterns are covered. The bounded-multiplier identification excludes every competitor of equal or smaller absolute multiplier except the selected entries and multiplier. This avoids the source's unnecessary analysis of the eventual crossing time of every other pattern while proving the full conclusion. The sign-flipped competitor is feasible and has strictly smaller actual squared Frobenius distance.

`MatrixOrbit` proves determinant, stationary-equation and Frobenius invariance and the inverse transformation. The unique least comparison is transported using arbitrary stationary matrices on both sides. `MatrixProof` therefore proves failure for every member of the stated family.

`TopologyProof` genuinely works on the full space of real three-by-three matrices. The local map has three independent upper-triangle left-skew coordinates, three lower-triangle right-skew coordinates, and three diagonal coordinates. Its derivative is computed using the matrix exponential derivative at zero. Each off-diagonal two-by-two derivative block is nonsingular because the corresponding positive singular parameters have different squares, while the diagonal coordinates act identically. Finite dimensionality converts injectivity into surjectivity. The inverse-function neighborhood theorem then gives a full-dimensional neighborhood inside the family. Matrix exponentials of skew matrices are proved orthogonal, and orthogonal homeomorphisms carry those neighborhoods to every family point. The rational parameter witness proves nonemptiness. No SVD continuity or openness of the diagonal subspace is assumed.

`PolynomialProof` makes polynomial evaluation analytic in every matrix entry. If a polynomial vanished on the nonempty open family, the real analytic identity principle on the connected full matrix space would force it to vanish everywhere. Reassembling arbitrary nine-coordinate assignments as matrices and `MvPolynomial.funext` then force the polynomial itself to be zero. This is a complete bridge to arbitrary proper algebraic exceptions and the final generic negation.

## Trust, reuse, quality and limitations

I inspected the actual pinned Mathlib APIs for analytic evaluation of linear coordinates, the identity principle on a preconnected real normed space, and the surjective strict-derivative neighborhood theorem. Their hypotheses are discharged in the real finite-dimensional matrix space; no hidden connectedness, spectral, finite-sampling or exceptional-set assumption weakens the target. The proof uses existing determinant, trace, exponential, finite-dimensional linear algebra, IVT and analytic APIs instead of reimplementing their mathematics. Helper modules are focused by responsibility. Broad `Mathlib` imports and a few dense tactic lines are maintenance opportunities, not correctness defects.

I independently recomputed every active mathematical hash in `verification/local-proof.json`, every frozen boundary hash and both frozen statement-report hashes. All match. All nine Challenge and Solution signatures agree after whitespace normalization. The proof sources have no `sorry`, `admit`, custom `axiom`, `native_decide`, or Challenge import. The actual comparator configuration includes all nine targets, only the standard three axioms and an empty definition-exception list. My independent metadata schema/coverage validation passed for all nine declarations.

I independently ran `lake env lean Solution.lean`; exit zero and all nine kernel-trust assertions passed, with each printed transitive axiom set exactly `[propext, Classical.choice, Quot.sound]`. Evidence is retained in `verification/final-referee-1-reelaboration.log`. This is a local macOS check using the installed dependencies, not a fresh isolated Linux raw-kernel or Comparator replay.

I also ran the retained environment dependency-query script. It confirms that the final generic negation transitively retains both scalar margins, all-matrix reduction, scalar uniqueness, Frobenius invariance, derivative and injectivity, and the nonzero-polynomial open-set lemma. Each margin body directly calls `LeanCert.Validity.verify_strict_upper_bound_dyadic_checked` and contains ordinary kernel `of_decide_eq_true` proof data. The successful log is `verification/final-referee-1-dependencies.log`. An initial diagnostic used the default opaque-body accessor and stopped after the dependency checks; enabling `allowOpaque := true` fixed the query. That initial diagnostic log is retained and is not acceptance evidence.

The frozen numerical plan and source-provenance receipt retain their original statements-only wording as historical boundary artifacts. Active README and formalization metadata accurately supersede that stage and explain the proof-method deviations. I do not request rewriting frozen historical text. Metadata's final-review status should be advanced only after both independent reports exist; its Linux status must remain pending until an actual successful run is retained. No canonical status promotion is authorized by this report alone.

No mathematical blocker, vacuous hypothesis, definition replacement, domain restriction, wrong norm, determinant-sign omission, genericity shortcut, or attribution defect was found. Mechanical Linux verification and publication remain separate gates. I did not conduct a new literature search, establish novelty, inspect every Mathlib proof transitively by hand, or claim human/source-author endorsement.

I additionally re-elaborated each of the seven current `NLA/SP04/*.lean` source files independently with `lake env lean`; all seven exited zero. The retained `verification/final-referee-1-modules.log` records each invocation and exit. Only deprecation/style warnings occurred. I rechecked mathematical hashes after the sweep; no mathematical source changed during review. This sweep uses installed imported dependencies and does not replace the required fresh Linux replay.

## Exact reviewed SHA-256 hashes

- `NLA/SP04/Definitions.lean`: `54a1ab62f1e32e1913ee87600a98fb1f942f4acf6e55f777b6be3cb25b3825d5`
- `NLA/SP04/MatrixProof.lean`: `fc388ff5c1f86cc08346b3a8c4452e6a3ca3b27cf0645ad4d4126f501d57f01b`
- `NLA/SP04/PolynomialProof.lean`: `633b1f923bd5c7ee95f239510f6babbb0b0dd1cff49f29dec44a0347da2ab9d3`
- `NLA/SP04/Scalar.lean`: `40168bb227aa6f027186917b65f099ca8e0540de81fc9f7139f9a4bd844e7460`
- `NLA/SP04/TopologyProof.lean`: `92f356340475f05d7b99d631097acc5273bc8c155aa438bde551e867a91bccb8`
- `NLA/SP04/MatrixReduction.lean`: `c9a1b2cc4435a701ed9f593cd56ad1a6f85c570e0f36dffaaff663a2ad545211`
- `NLA/SP04/MatrixOrbit.lean`: `87466976c00277df848be716749f838166ffdee1ffc9c8129a8d459fdb4829ae`
- `Solution.lean`: `79ca08076b83585023c8e354000b7c336733d98a0d141254d1fd046791e8a39c`
- `Challenge.lean`: `99e61e62c3ea8e5911e7765850735515cca4f896c3593001215dd703585c0506`
- `comparator.json`: `583cad865ecdc647f71544a4cdd62dd8473fb436242240c56e89ba9f00ddf6f9`
- `lakefile.toml`: `752b51f88c9dfcc5a21ca5008fcad5d615779c55f41d210ecb5806cf5ce73e0d`
- `lake-manifest.json`: `0b777416633b6ab6cecb4b739da1148251ec285a20225da94da6f72b56bddcab`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- `NUMERICAL_TARGETS.md`: `6a32b2cc5d14e9f062e5ec09bac8471f91eb269054b9a0241d590c47b1649a63`
- `formalization.yaml`: `4de3af168689911596e4552db33b7b1869f5db7ca9bd7228b299b8669376887e`
- `README.md`: `2453dac3b79c3fb462e8aa0d1af0dce43cb773d0dea69a93666f0ecb5f8008d4`
- `SOURCE_PROVENANCE.json`: `bf48973ee63563d93e1f4a8d575422d3e4e603703ea4fc4be20f7ad5828cca9e`
- `../README.md`: `2dfa12b2eee5e312bbd45d023d8fa33e1c40e2d598f6538e651d6df519ae38ca`
- `../solution.md`: `d7a9e5a9d0fa0bb43e45a3d5c37b6e52d86373cbf4391980d0c1c54ff2ebc45c`
- `../solution.tex`: `4709776d1b91f8eefc4521495057cbc0451f897c7232ee7c838214f7627da481`
