# IE-18 — independent statement referee 2

**PASS — approved statement boundary.** No blocking fidelity, vacuity or numerical-data finding. Proof and actual Linux verification remain separate future gates for this campaign.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md`, the local Tau Ceti adaptation, covering complete target fidelity, mathematical meaning, degeneracies, numerical scope, computation reduction, reuse and attribution. This is not official Tau Ceti endorsement or human peer review. I read the full retained canonical page, complete informal source(s), exact numerical plan, actual Definitions and Challenge, comparator configuration, project guide and formalization metadata. I did not inspect active Proof/Solution bodies. Definitions' finite-index/well-formedness proofs are part of the reviewed boundary.

The source is the existing authored snapshot `deb549fa9ddd6b119e6c59016f268237e645dfa2`, preserved from earlier branch ancestry. The observed upstream main is the older `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`; this review does not call the source current main or newly authored. This approval is bound to the complete canonical target at the preserved snapshot; it does not assert byte equality with the older main or adopt its formatting. Existing historical statement-stage notices and old published verification claims remain historical; they do not establish this campaign's proof or Linux gate. Project metadata was checked for target scope and attribution, not as evidence that a new proof run passed.

## Full target and certificate fidelity

The conjecture retains every n≥2, nonzero real symmetric matrix M and the genuine condition1∉spectrum ℝ M. IsHermitian over ℝ is symmetry. Its actual Mathlib eigenvalue list is obtained from an orthonormal eigenbasis and retains multiplicities; the pair maximum ranges over distinct indices, not distinct scalar values. A finite NNReal supremum of squared scalar nnnorms is exactly the nonnegative pairwise real-square maximum. At n≥2 there are actual pairs. Real division's zero denominator convention matches the canonical value0. No stronger positive-definite or diagonal restriction is inserted into the universal assertion.

The residual map explicitly handles0and otherwise uses the actual dot product with(I−M)v divided by the sum of squared coordinates of(I−M)v. Two compositions are four original Anderson steps. Euclidean norm is explicitly sqrt(sum coordinate²), avoiding Pi's supremum norm. Exclusion of eigenvalue1 ensures the nonzero-domain denominator is nonzero in the original setting; the concrete certificate separately forces both actual denominators positive. amplificationSet includes every actual nonzero-vector ratio. IsGreatest means attainment plus an upper bound on the entire set, expressing the original maximum without an empty/unbounded real-supremum default. The counterexample supplies an actual member exceeding that purported greatest value, so attainment subtleties cannot drive the failure.

Independent exact arithmetic recovered both denominators61/50 and1381/93025, coefficients90/61 and3140/1381, vectors(−2,8,15)/61 and(289,−756,1125)/84241, and the squared ratio1920682/21289638243. All six ordered pair values were checked; their maximum is1/121. The pair expression is already squared in the proposed UNSQUARED norm factor: the correct squared comparison is with1/14641, and1920682·14641=28120705162>21289638243. The signature requires the genuine strict unsquared amplification inequality, which must be derived using nonnegative squares and a positive initial norm. No approximate square root is needed.

The three exports cover exact actual recurrence data, all witness admissibility/spectrum/maximum/strict-violation facts, and negation of the full canonical identity. Positivity of M and I−M is an additional conclusion about this witness, not a universal assumption. The source's stronger parameter-family unbounded underestimation, second example and separate asymptotic convergence question are outside scope. Mathlib spectral/finite-max APIs and exact rational algebra are suitable; the eventual LeanCert scalar certificate must be consumed after these bridges. Colbrook and Stepaniants retain mathematical and formalization credit.

## Independent checks and remaining obligations

The independent rational/integer reconstruction is in `referee-2-numerical-checks.json`. Its generator `/private/tmp/nla-fourth-five/referee2_numerics.py` was written by this reviewer from the displayed definitions, rather than relying on a saved PASS. These diagnostics check data and feasibility only; they are not proofs of the universal statements. MF-16's #eval, where applicable, imports Definitions only and is explicitly a diagnostic. The actual numerical statements and all necessary bridges are satisfactory before proof inspection.

The coordinator's fresh pinned macOS `lake build Challenge` passed with exactly 3 deliberate placeholder warnings, and I checked its exit-0 receipt and matching log SHA-256. That build is honestly attributed to the coordinator, not this reviewer; placeholders prove no mathematics. All 3 declarations match the exact comparator inventory and there are no definition-name exceptions. Permitted final axioms are only the standard three. The historical manifest's zero proof-hole count excludes its separate Challenge placeholders and is not independently verified at this phase.

The imported semantics inspected are hash-bound below and in the JSON. Familiar Mathlib finite sums, matrix products, real norms, spectrum/positive-definite or finite-count APIs are used with concrete mathematical definitions. Existing reviewed projects from the preceding campaign provide workflow and exact-matrix/counting examples; none of their results is added as an assumption here. Later independent proof review must check the full active dependency closure, material use of LeanCert and all export axioms; actual isolated Linux Comparator must check statement identity and kernel/sandbox rejection controls. No source, metadata or permanent problem ID was changed by this referee.

## Exact reviewed sources

| Source | SHA-256 |
| --- | --- |
| `linear-systems-and-elimination/IE-18/README.md` | `682354cc164216c838aac0124770f13d0921078f17ca797b76358c85054bf10b` |
| `linear-systems-and-elimination/IE-18/lean/README.md` | `021b9154449803940827856318907a3096a02441df09c12a12c456c90cc8ce58` |
| `linear-systems-and-elimination/IE-18/lean/NUMERICAL_TARGETS.md` | `318f34ec1f88f111a83c1a6c869735ac2cc5640b5bdb34f89201e97607e9e890` |
| `linear-systems-and-elimination/IE-18/lean/NLA/IE18/Definitions.lean` | `dc32a03d0ab95a1b3f41f864f90d30d56c3dd041330015caa059e253ff47b28d` |
| `linear-systems-and-elimination/IE-18/lean/Challenge.lean` | `97ad7cf8e2c3077d4cc52f587c9702627f06c8d915005804f044fd60c66ffd59` |
| `linear-systems-and-elimination/IE-18/lean/comparator.json` | `7fd64ea1eb36dd9d29ae5888b0aeeb39fb96bd4bc12db7712cb6347098fcc1b6` |
| `linear-systems-and-elimination/IE-18/lean/formalization.yaml` | `a9bdf9f78bf428a92ba6f6a89bee4b30df95a004e75d77b9694e3ee9dba60ff6` |
| `linear-systems-and-elimination/IE-18/lean/lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `linear-systems-and-elimination/IE-18/lean/lake-manifest.json` | `b8ca3cb45073b21d3747c31a676c509b33f3c20623db200fe82ff682af5b2075` |
| `linear-systems-and-elimination/IE-18/lean/lakefile.toml` | `c17f59db14314e81e508eebcddb2517175071360bf305fe963054bfb1a00f557` |
| `docs/lean/REVIEW.md` | `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553` |
| `references/colbrook-recovered-2026-09-11/manuscripts/IE-18.tex` | `f7ebc6b6ebed015e24dfae48b0ed525fe67c99530a35ba66bed7d6ba44aa6b36` |

## Relevant imported semantics

| Dependency file | SHA-256 |
| --- | --- |
| `Mathlib/Analysis/Matrix/Spectrum.lean` | `1ad47effa0a5fbc373ebb6cf52a6b85a66b25d3c5a86394f3dd5932ffbfc3afe` |
| `Mathlib/Order/Bounds/Defs.lean` | `e5a38e3cf5b12a87a53bbd64d4d458bacb2f707aa75e1b3dca1c33014aa23c2d` |
| `Mathlib/Data/Finset/Lattice/Fold.lean` | `79b80dd5aa12886d31c582ab00585627dc4e7f1d7607c7b707484f38d95ce2f4` |
| `Mathlib/Analysis/Normed/Group/Real.lean` | `eaae958600a11f6a363c1aaf0f5d9d2f85f27a277eb26b6cbfe16e6462922cd4` |

Machine report SHA-256: `53879cc198b28a05e92cfb36059d19f75fe43eec13295d71965da3db5ed2b2ab`. Its source/diagnostic/build hashes bind this approval to the exact bytes reviewed.
