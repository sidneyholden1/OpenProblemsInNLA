# TR-15 — independent statement referee 2

**PASS — approved statement boundary.** No blocking fidelity, vacuity or numerical-data finding. Proof and actual Linux verification remain separate future gates for this campaign.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md`, the local Tau Ceti adaptation, covering complete target fidelity, mathematical meaning, degeneracies, numerical scope, computation reduction, reuse and attribution. This is not official Tau Ceti endorsement or human peer review. I read the full retained canonical page, complete informal source(s), exact numerical plan, actual Definitions and Challenge, comparator configuration, project guide and formalization metadata. I did not inspect active Proof/Solution bodies. Definitions' finite-index/well-formedness proofs are part of the reviewed boundary.

The source is the existing authored snapshot `deb549fa9ddd6b119e6c59016f268237e645dfa2`, preserved from earlier branch ancestry. The observed upstream main is the older `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`; this review does not call the source current main or newly authored. This approval is bound to the complete canonical target at the preserved snapshot; it does not assert byte equality with the older main or adopt its formatting. Existing historical statement-stage notices and old published verification claims remain historical; they do not establish this campaign's proof or Linux gate. Project metadata was checked for target scope and attribution, not as evidence that a new proof run passed.

## Full target and certificate fidelity

The original universal implication retains all odd m≥3, all q≥2,n≥2 and every finite real common generator. Actual lower order/dimension are m and q(n−1)+1; upper order/dimension are qm and n. generatorIndex is a bounded finite sum of zero-based coordinates; it agrees with the canonical one-based sum minus order. The lower Fin.cast identifies equal lengths and retains the same data, with no out-of-range default or reordered generator. The tensor is the full finite array. contraction sums every ordered (s−1)-tuple, with no factorial normalization, and IsHEigenpair uses nonzero real vectors, every component and ordinary signed-coordinate integer powers. The total order-zero definition is outside all admissible parameters.

Every real lower eigenpair is universally quantified in the strict-positivity export. HasNoNegativeHEigenvalues is the absence of a pair with negative real eigenvalue; it does not assert nonnegative entries or a positive associated Hankel matrix. The exact first contraction is a strictly positive sum of squares for every nonzero real vector, forcing its eigenvalue positive. I independently reconstructed all27lower entry contributions as exact monomial coefficients and both upper components over all32ordered tuples each. The upper vector(0,1) leaves only the all-one tuple, yielding(0,−1)=−1·(0^5,1^5). All original parameters are admissible.

The seven exports include every lower contraction, the actual upper contraction, universal lower positivity, unconditional lower-pair existence, the negative upper pair, the full admissible counterexample and universal negation. Nonvacuity is a separate required conclusion, not an extra conjecture premise: the actual continuous polynomial2t^4+2t^3+3t²−4t−1 has exact values−1 and2 at0and1, hence an interior root supplies the genuine pair(2+2t+2t²,(1,0,t)). All equations are checked, not just a selected component. No eigenvalue enumeration or numerical root isolation is needed. Finite-array/Finset APIs and the ordinary IVT are appropriate; LeanCert's eventual exact−1<0 point certificate must remain in the final negative-pair argument. The full odd-order target is refuted; the even-lower-order theorem and stronger associated-Hankel-PSD conditions are excluded. Source proof and formalization attribution remain Colbrook and Stepaniants respectively.

## Independent checks and remaining obligations

The independent rational/integer reconstruction is in `referee-2-numerical-checks.json`. Its generator `/private/tmp/nla-fourth-five/referee2_numerics.py` was written by this reviewer from the displayed definitions, rather than relying on a saved PASS. These diagnostics check data and feasibility only; they are not proofs of the universal statements. MF-16's #eval, where applicable, imports Definitions only and is explicitly a diagnostic. The actual numerical statements and all necessary bridges are satisfactory before proof inspection.

The coordinator's fresh pinned macOS `lake build Challenge` passed with exactly 7 deliberate placeholder warnings, and I checked its exit-0 receipt and matching log SHA-256. That build is honestly attributed to the coordinator, not this reviewer; placeholders prove no mathematics. All 7 declarations match the exact comparator inventory and there are no definition-name exceptions. Permitted final axioms are only the standard three. The historical manifest's zero proof-hole count excludes its separate Challenge placeholders and is not independently verified at this phase.

The imported semantics inspected are hash-bound below and in the JSON. Familiar Mathlib finite sums, matrix products, real norms, spectrum/positive-definite or finite-count APIs are used with concrete mathematical definitions. Existing reviewed projects from the preceding campaign provide workflow and exact-matrix/counting examples; none of their results is added as an assumption here. Later independent proof review must check the full active dependency closure, material use of LeanCert and all export axioms; actual isolated Linux Comparator must check statement identity and kernel/sandbox rejection controls. No source, metadata or permanent problem ID was changed by this referee.

## Exact reviewed sources

| Source | SHA-256 |
| --- | --- |
| `tensor-computations/TR-15/README.md` | `7979d193949dd8ef3545e55a1c9535bfdaaefac91f435b5066c23e83c4e4cf50` |
| `tensor-computations/TR-15/lean/README.md` | `b511d9919421320fc7221ffeec12f7afb64915dd7321b0f3c9f58a8a5db41bf2` |
| `tensor-computations/TR-15/lean/NUMERICAL_TARGETS.md` | `6851bb94fb8f6049980113b4df9a1346bd3ed9549f66dd74b2b1f6a5ee947cd6` |
| `tensor-computations/TR-15/lean/NLA/TR15/Definitions.lean` | `63b8767fd19148b269f6e4041d464f0de5dc64cac82e1448fee43115bed55379` |
| `tensor-computations/TR-15/lean/Challenge.lean` | `6778940f8f0f645fc6be0c57f1fb8f67791e0c67c896074651bca9cada491428` |
| `tensor-computations/TR-15/lean/comparator.json` | `80d0148e7ddf0a431d6833c3e464cf15424c94767394dd1a0fe93366c8bbb45f` |
| `tensor-computations/TR-15/lean/formalization.yaml` | `bb92a8ca1192e224b00d273d8ac658f9cac191336ee06f922ec73a0dbc6e93bb` |
| `tensor-computations/TR-15/lean/lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `tensor-computations/TR-15/lean/lake-manifest.json` | `8d71288432949937d6c64f1175c7a9c7c5389bc261d79dad512ba4c385e97127` |
| `tensor-computations/TR-15/lean/lakefile.toml` | `247a1ea746bb54d8adfb18fdce81669f85de63d5d9dfe8998eb255f54002181d` |
| `docs/lean/REVIEW.md` | `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553` |
| `references/colbrook-unclaimed-2026-09-11/manuscripts/TR-15.md` | `31aaf87084303a6de0ef380270c973719efa027c6131c76b27a02cb489a1fa74` |

## Relevant imported semantics

| Dependency file | SHA-256 |
| --- | --- |
| `Mathlib/Data/Fintype/BigOperators.lean` | `bfa35992c02f47d7c78a5425ea3c4eecba0ad54de1b5752db565b37de11148c0` |
| `Mathlib/Algebra/BigOperators/Fin.lean` | `4fe78cba9cdeac4eb8badbdd6359b055031900906fb94f3e51aba6d81451dbd5` |

Machine report SHA-256: `56f1bc8614b4593b9900cb0d8cf6721b4008a7a8797d5faeea4baa65331edcf3`. Its source/diagnostic/build hashes bind this approval to the exact bytes reviewed.
