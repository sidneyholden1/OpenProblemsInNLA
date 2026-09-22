# SP-04 independent statement referee 1

Phase: statements only, before implementation. Reviewer: `/root/iv06_statement_referee_1`, an independent AI agent who did not author this boundary. **APPROVE / PASS for the exact bytes below.** This is the repository's Tau Ceti-inspired review adaptation, not human peer review, Tau Ceti endorsement, or proof verification.

I read the entire canonical README and both complete informal solution formats, all definitions, all nine Challenge signatures, numerical plan, metadata, provenance and supplied statement typecheck evidence. I did not inspect or implement proof bodies. The mathematical source is Matthew J. Colbrook's manuscript at preserved commit `deb549fa9ddd6b119e6c59016f268237e645dfa2`; formalization authorship remains Sidney Holden with AI assistance. No novelty or source-author endorsement is inferred.

## Fidelity and full scope

- `Feasible` is the actual real determinant condition `|det X| = 1`, including both determinant signs. `Stationary` additionally requires the actual equation `Xᵀ(U−X)=cI`; it is not a diagonal or root-pattern surrogate.
- `UniqueLeast` supplies an actual stationary pair, compares its absolute multiplier with every real stationary pair, and makes equality imply equality of both matrix and multiplier. `Nearest` compares the explicit sum of all nine squared entries with every feasible matrix. Order of these nonnegative squared Frobenius distances is equivalent to order of Frobenius distances; no different matrix norm is selected by an instance.
- The strict parameter interval is nonempty and gives positive, ordered, distinct singular values. Positive-multiplier exclusion includes both endpoints, including zero. Selected-product division uses the source's positive quadratic root; denominator positivity remains a proof obligation, not a hidden assumption.
- `diagonal_stationary_reduction` quantifies over arbitrary stationary matrices and must prove their diagonality. `diagonal_unique_failure` includes all root-sign patterns through `UniqueLeast`; the separate bounded-root existence theorem alone would not establish this. No supplied classification hypothesis displaces the hard part of the source.
- `counterexampleFamily` includes all left/right real orthogonal transforms of every diagonal datum in the interval. Its nonempty-and-open export uses the actual product topology on the full nine-entry real matrix space, not the diagonal subspace. Orthogonal covariance and openness are obligations, not assumed facts.
- The polynomial export quantifies over every nonzero polynomial in all nine entries and requires an actual family member outside its zero locus. Over the infinite field of reals, a nonzero polynomial is not the zero polynomial function. Every proper real algebraic exceptional set is contained in such a zero locus. The all-dimension conjecture permits a separate polynomial in each dimension, and its negation follows from the full dimension-three export; this preserves algebraic genericity rather than replacing it by one special matrix.
- Conditioning the rule on a unique least pair matches the canonical permission to restrict to the unique-choice locus. The counterexample conclusions prove that a unique pair exists, so the negative result is not vacuous. Finiteness of the entire stationary set is not silently assumed or claimed as an additional formal result.

The nine exports collectively cover the original negative target. Exclusions are accurate: no result is asserted for determinant +1 only, no general stationary-set finiteness theorem is exported, and the illustrative decimals and identity-matrix comparison are not claimed as the universal proof.

## Independent evidence and API checks

I independently ran the attached rational diagnostic script. It checks the nonempty rational parameter witness, radicand lower bound 393/400, the square-root-difference slope margin below 2, the exact uniform small-root product bound 29172/31250 < 1, and the negative-root endpoint margins. Rational square-root enclosures independently bracket the sample selected root between 4974/10000 and 4975/10000, and the sample identity distance is exactly 1710107/1000000. These finite diagnostics are not proofs of universal root classification, matrix covariance, or openness.

I read pinned Mathlib's actual determinant definition (alternating multilinear determinant/Leibniz formula), matrix topology instance (the ordinary nested product of real topologies), multivariate polynomial evaluation (evaluation of every coefficient/monomial under the nine coordinates), and `MvPolynomial.continuous_eval`. These meanings match the contract. The planned exact square-root-difference bounds avoid unnecessary differentiation or interval subdivision; LeanCert may certify rational margins while ordinary proofs must connect them to all stationary matrices and the generic conclusion. Importing all Mathlib is broad but does not alter semantics; narrowing imports later is a maintenance improvement, not a blocking statement defect.

The supplied author-run scratch typecheck receipt reports exit 0 under Lean 4.33.1 and Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`; its log contains exactly nine deliberate `sorry` warnings and success at 8708 jobs. I inspected that log and independently recomputed equality of all four receipt file hashes with current files. I did not run that build myself or treat placeholders as proofs. Source-provenance hashes also match the three source files read. Current wrapper/project pins are separately hashed below.

## Verdict and remaining gates

No blocking statement-fidelity, quantifier, endpoint, norm, topology, attribution or vacuity issue found. **Approve the exact statement boundary for freeze and proof work.** This approval does not certify implementation feasibility on a particular time budget. All nine proofs, trust/axiom inspection, two final proof reviews, metadata completion and actual sandboxed Linux Comparator remain separate gates. The present draft metadata correctly says these are pending.

## Exact SHA-256 hashes read

- `../README.md`: `2dfa12b2eee5e312bbd45d023d8fa33e1c40e2d598f6538e651d6df519ae38ca`
- `../solution.md`: `d7a9e5a9d0fa0bb43e45a3d5c37b6e52d86373cbf4391980d0c1c54ff2ebc45c`
- `../solution.tex`: `4709776d1b91f8eefc4521495057cbc0451f897c7232ee7c838214f7627da481`
- `NUMERICAL_TARGETS.md`: `6a32b2cc5d14e9f062e5ec09bac8471f91eb269054b9a0241d590c47b1649a63`
- `NLA/SP04/Definitions.lean`: `54a1ab62f1e32e1913ee87600a98fb1f942f4acf6e55f777b6be3cb25b3825d5`
- `Challenge.lean`: `99e61e62c3ea8e5911e7765850735515cca4f896c3593001215dd703585c0506`
- `formalization.yaml`: `6dfcccab9a7d516194f871f80a306a707230faf6dbb3a29fd4f69fe20ca600df`
- `SOURCE_PROVENANCE.json`: `bf48973ee63563d93e1f4a8d575422d3e4e603703ea4fc4be20f7ad5828cca9e`
- `verification/statement-typecheck.json`: `4a7ca98a484640507bda93981dd9ff05a05c513b2ee4aab48fdb745679e30466`
- `verification/statement-typecheck.log`: `66856fc2551ccbf152179f11799aeab6f8c2fc20d3d5bd1162b5c5ba714a1e06`
- `../../../docs/lean/REVIEW.md`: `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- `lakefile.toml`: `752b51f88c9dfcc5a21ca5008fcad5d615779c55f41d210ecb5806cf5ce73e0d`
- `.lake/packages/mathlib/Mathlib/Topology/Instances/Matrix.lean`: `f1177b96ad3853e806edfa9a26ee036db98e03c1c361179b7cdf60213d157734`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/Determinant/Basic.lean`: `37646a248748fd65e37c20a21b4a20fea11539d4312aae4f277e4faef8ed2b87`
- `.lake/packages/mathlib/Mathlib/Algebra/MvPolynomial/Eval.lean`: `4df972e1914f2292171801920bbf014a3a2e56a679520edaf4403ef3638f3007`
- `.lake/packages/mathlib/Mathlib/Topology/Algebra/MvPolynomial.lean`: `85ac5d20944ed63164f486576a0a346cf471412a5b77e56fbfbe209b591cb093`
- `reviews/statement-referee-1-diagnostic.py`: `ee4b1ff89af85a141172f3f428bf28cdde235740f69e042a2034634c19f06216`
- `reviews/statement-referee-1-diagnostic.log`: `08c45f47c1d503853521d2480d5246b34df3f8093a8c6dd07e0a96e81e60137d`
- `reviews/statement-referee-1-evidence.json`: `4c36bda55c5ebd7b09e78142fd994e8cbaef90ff2df31f880508bfd1378dc5ca`
