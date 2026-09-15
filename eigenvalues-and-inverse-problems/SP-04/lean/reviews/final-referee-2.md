# SP-04 independent final referee 2

**Phase:** final mathematical code review. **Verdict: PASS for the reviewed local proof bytes**, subject to the separate actual Linux Comparator/default-kernel and publication gates. Reviewer `/root/sp04_final_referee_2` is a fresh AI agent and a nonauthor of both SP-04 statements and implementation. This is the repository adaptation of Tau Ceti review, not human peer review, an official Tau Ceti review, or source-author endorsement.

## Fidelity and scope

I read the repository review protocol and Lean README, the complete preserved canonical SP-04 README and both complete source solution.md and solution.tex, NUMERICAL_TARGETS, Definitions, Challenge, Solution, all six implementation modules, project README and metadata/configuration. The mathematical source remains Matthew J. Colbrook's argument; formalization credit is Sidney Holden with AI assistance. Exact source bytes match the recorded Git revision. All frozen statement/configuration and both statement-report hashes still match. The frozen numerical plan's draft language is historical and explained by current project documentation.

The original negative answer is preserved. Feasible means absolute determinant one, allowing both signs. Stationary is the original real matrix equation; UniqueLeast compares every real stationary pair, and Nearest compares the explicit squared Frobenius objective over all feasible matrices. Squaring preserves the order of the nonnegative Frobenius norm. The construction proves actual existence and uniqueness, not a conditional bad candidate. All multiplier endpoints and the full strict singular-parameter region are retained. The generic negation is against every nonzero polynomial in all nine entries at dimension three and thus contradicts the conjecture quantified over every dimension at least two. No diagonal-only exceptional sample or supplied key theorem replaces the original target.

## Mathematical proof and computation

MatrixReduction derives both reverse/transposed stationary identities using actual invertibility from feasibility. Distinct positive diagonal entries make the two off-diagonal equations nonsingular. It consequently reduces every stationary matrix, with no assumed diagonal restriction.

Scalar covers c=0 and both exact positive ranges split at 2/5, with small-root product margins (3/10)(44/25)^2<1 and (2/5)(3/2)^2<1. It proves negative-root identities, strict product monotonicity and IVT existence at the exact endpoint 13/25. All eight root-sign patterns are compared. The bounded-multiplier identification proves global least absolute multiplier and equality-case uniqueness without requiring an unnecessary asymptotic analysis of every other root branch. The selected negative entry has strictly positive magnitude, and flipping it supplies an actual feasible matrix of smaller distance.

MatrixOrbit proves determinant, stationary-equation and objective invariance, using a genuine inverse transform to transport uniqueness over all stationary matrices. TopologyProof uses six independent skew entries and three diagonal entries. The matrix exponential stays orthogonal, its actual strict derivative is proved by composition, and the derivative's three two-by-two off-diagonal blocks are nonsingular by distinct positive squared parameters. Surjectivity in the full finite-dimensional matrix space yields the neighborhood statement by the inverse function theorem. The orthogonal homeomorphism extends this to every point of the family. The rational example proves nonemptiness. This is openness in all nine real entries.

PolynomialProof uses analyticity of the actual coordinate evaluation polynomial and the identity theorem on the connected real matrix space. Arbitrary coordinate assignments are recovered as matrices, so MvPolynomial.funext implies that a polynomial vanishing on the whole space is zero. Thus every nonzero polynomial misses some counterexample, including all proper real algebraic exceptions. I inspected the relevant pinned Mathlib analytic identity/evaluation API and LeanCert point-inequality configuration. The reuse of matrix exponential, inverse function and analytic identity APIs is appropriate and avoids new unproved spectral assumptions. Module separation and names expose the main bridges; no substantive API, attribution or proof-quality correction is needed.

LeanCert is materially used: my actual proof-value dependency traversal of the final negation visits 51,060 declarations and finds both rational margin declarations, all-matrix reduction, eight-pattern comparison, derivative/injectivity, open-family proof and analytic identity. Both margin proof bodies reference LeanCert.Validity.verify_strict_upper_bound_dyadic_checked, with kernel decision certificates. Scalar sets kernel trust before both invocations. These are consumed certificates, not decorative imports or unused results.

## Independent mechanical evidence and limitations

I independently ran `lake build Solution`: exit 0, 8799 jobs. This is a local build with cached dependencies/modules replayed where Lake found them current, not a cold Linux rebuild. I separately re-elaborated Solution with `lake env lean Solution.lean`: exit 0, all nine kernel trust assertions and printed axiom closures containing exactly propext, Classical.choice, Quot.sound. The independent source-signature comparison passes for all nine declarations; comparator.json registers exactly those targets, allows only the three standard axioms, and has no definition exceptions. No proof module imports Challenge, and there are no proof holes or added axioms in the implementation. Challenge's deliberate placeholders are outside the solution environment.

The dependency probe initially reached all required material declarations but failed while printing an opaque certificate body; its retained initial log is diagnostic, not acceptance evidence. Enabling allowOpaque in that review-only probe produced exit 0 and the full certificate/dependency evidence. No mathematical source was edited. The build includes nonmaterial linter/deprecation warnings and is not described as warning-free.

My audit script, evidence JSON, build/elaboration logs, successful dependency probe and its initial diagnostic log are retained under verification/final-referee-2-*. I did not run or certify the isolated Linux sandbox, Comparator, raw-kernel replay, negative controls, remote CI, PDFs or publication updates. Those remain distinct gates. No novelty search, external human review or source-author endorsement is claimed.

## Exact reviewed bytes (SHA-256)

- `NLA/SP04/Definitions.lean`: `54a1ab62f1e32e1913ee87600a98fb1f942f4acf6e55f777b6be3cb25b3825d5`
- `NLA/SP04/MatrixOrbit.lean`: `87466976c00277df848be716749f838166ffdee1ffc9c8129a8d459fdb4829ae`
- `NLA/SP04/MatrixProof.lean`: `fc388ff5c1f86cc08346b3a8c4452e6a3ca3b27cf0645ad4d4126f501d57f01b`
- `NLA/SP04/MatrixReduction.lean`: `c9a1b2cc4435a701ed9f593cd56ad1a6f85c570e0f36dffaaff663a2ad545211`
- `NLA/SP04/PolynomialProof.lean`: `633b1f923bd5c7ee95f239510f6babbb0b0dd1cff49f29dec44a0347da2ab9d3`
- `NLA/SP04/Scalar.lean`: `40168bb227aa6f027186917b65f099ca8e0540de81fc9f7139f9a4bd844e7460`
- `NLA/SP04/TopologyProof.lean`: `92f356340475f05d7b99d631097acc5273bc8c155aa438bde551e867a91bccb8`
- `Solution.lean`: `79ca08076b83585023c8e354000b7c336733d98a0d141254d1fd046791e8a39c`
- `Challenge.lean`: `99e61e62c3ea8e5911e7765850735515cca4f896c3593001215dd703585c0506`
- `NUMERICAL_TARGETS.md`: `6a32b2cc5d14e9f062e5ec09bac8471f91eb269054b9a0241d590c47b1649a63`
- `formalization.yaml`: `4de3af168689911596e4552db33b7b1869f5db7ca9bd7228b299b8669376887e`
- `comparator.json`: `583cad865ecdc647f71544a4cdd62dd8473fb436242240c56e89ba9f00ddf6f9`
- `lakefile.toml`: `752b51f88c9dfcc5a21ca5008fcad5d615779c55f41d210ecb5806cf5ce73e0d`
- `lake-manifest.json`: `0b777416633b6ab6cecb4b739da1148251ec285a20225da94da6f72b56bddcab`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- `SOURCE_PROVENANCE.json`: `bf48973ee63563d93e1f4a8d575422d3e4e603703ea4fc4be20f7ad5828cca9e`
- `README.md`: `2453dac3b79c3fb462e8aa0d1af0dce43cb773d0dea69a93666f0ecb5f8008d4`

Source files:

- `eigenvalues-and-inverse-problems/SP-04/README.md`: `2dfa12b2eee5e312bbd45d023d8fa33e1c40e2d598f6538e651d6df519ae38ca`
- `eigenvalues-and-inverse-problems/SP-04/solution.md`: `d7a9e5a9d0fa0bb43e45a3d5c37b6e52d86373cbf4391980d0c1c54ff2ebc45c`
- `eigenvalues-and-inverse-problems/SP-04/solution.tex`: `4709776d1b91f8eefc4521495057cbc0451f897c7232ee7c838214f7627da481`

Successful independent evidence logs:

- `verification/final-referee-2-build.log`: `ca8ca98baefd923f4ebdf024c2cc4a9cb4d66b8d403f1a8fe2b8475816a2af2f`
- `verification/final-referee-2-elaboration.log`: `11ab91adc886b88743923cde76a0a39af79630836a2f07fa8358de6017179c4a`
- `verification/final-referee-2-dependencies.log`: `2ae445a0766813060fcbe889f26c7de5ccf311948b30930b2b5dcc885b33c337`
