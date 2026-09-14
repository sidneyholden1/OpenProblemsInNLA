# MF-16 — independent statement referee 2

**PASS — approved statement boundary.** No blocking fidelity, vacuity or numerical-data finding. Proof and actual Linux verification remain separate future gates for this campaign.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md`, the local Tau Ceti adaptation, covering complete target fidelity, mathematical meaning, degeneracies, numerical scope, computation reduction, reuse and attribution. This is not official Tau Ceti endorsement or human peer review. I read the full retained canonical page, complete informal source(s), exact numerical plan, actual Definitions and Challenge, comparator configuration, project guide and formalization metadata. I did not inspect active Proof/Solution bodies. Definitions' finite-index/well-formedness proofs are part of the reviewed boundary.

The source is the existing authored snapshot `deb549fa9ddd6b119e6c59016f268237e645dfa2`, preserved from earlier branch ancestry. The observed upstream main is the older `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`; this review does not call the source current main or newly authored. This approval is bound to the complete canonical target at the preserved snapshot; it does not assert byte equality with the older main or adopt its formatting. Existing historical statement-stage notices and old published verification claims remain historical; they do not establish this campaign's proof or Linux gate. Project metadata was checked for target scope and attribution, not as evidence that a new proof run passed.

## Full target and certificate fidelity

The full target quantifies every finite ordinary two-letter list equal to its reversal and containing X, every complex Hermitian positive definite B,P of order two, and exactly one complex Hermitian positive definite solution. evalWord is the actual written-order List.prod of matrices. There is no real-only, diagonal, commuting or fixed-word restriction in the conjecture. The witness has16letters,14X and2B. Two distinct genuine complex positive definite solutions for this single admissible word suffice to refute the entire universal assertion; the source's degree theorem, third solution and exponent-family threshold are explicitly excluded.

All nine signatures are meaningful obligations: word semantics; source positive-definite data and exact determinants; actual twelfth-power reduction; bidirectional polynomial/word-entry equivalence; actual Krawczyk acceptance and whole-box bound; unique real root inside the box; recovery of a distinct full complex matrix solution; counterexample; full negation. The original B,P,X0 are unchanged. The independent exact product gives X0 B X0^12 B X0=P, det B=1, det X0=3 and det P=3^14. The trace-polynomial coefficients agree with the determinant-three Cayley–Hamilton recurrence. The polynomial AST has only constants, three in-range variables, add/mul/neg, and imposes xz−y²=3 as an equation, not an assumed parametrization with a potentially invalid denominator.

I inspected the actual LeanCert FinBoxMem, evalFin/SystemZero, intervalJacobian, preconditionedJacobian, infinity row-bound, point image enclosure and krawczykCheck definitions, plus the actual krawczykCheck_sound theorem. The checker requires supported AD, center containment, nonzero actual preconditioner determinant, strict contraction below1 and strict self-map inclusion. Its soundness yields an actual unique real zero in the complete closed box; no approximate root is assumed. The entire specified radius10^-7 box is used. I independently reconstructed the exact rational forward interval AD and obtained contraction0.0264384004893…<27/1000 and inclusion margin9.7317056722…×10^-8>radius/2. A separate Definitions-only Lean #eval returned true and exactly the same rational determinant, radius and contraction. These are diagnostics, not kernel proof certificates; later proof review must inspect the actual Boolean equality proof and its material use.

The matrix-recovery obligations close every escape hatch: x>3 ensures a positive leading minor and separation from X0; determinant3 plus that minor gives genuine complex positive definiteness after the entrywise ofReal map; the ordinary palindrome proves symmetry; determinant multiplicativity gives3^14; the two known entries and P11>0 determine the final diagonal entry. root_to_matrix explicitly requires all matrix entries equal, so the reduced two-entry system is not the final target. Local uniqueness inside the root box is kept distinct from global word uniqueness, which is disproved. Mathlib PosDef means Hermitian and positive quadratic form on every nonzero complex vector. The optimized one-box polynomial route is faithful and avoids the source's much smaller two-dimensional boxes and degree argument. Colbrook's mathematical credit, Stepaniants's formalization credit and original Hillar–Johnson/Armstrong–Hillar attribution are preserved.

## Independent checks and remaining obligations

The independent rational/integer reconstruction is in `referee-2-numerical-checks.json`. Its generator `/private/tmp/nla-fourth-five/referee2_numerics.py` was written by this reviewer from the displayed definitions, rather than relying on a saved PASS. These diagnostics check data and feasibility only; they are not proofs of the universal statements. MF-16's #eval, where applicable, imports Definitions only and is explicitly a diagnostic. The actual numerical statements and all necessary bridges are satisfactory before proof inspection.

The coordinator's fresh pinned macOS `lake build Challenge` passed with exactly 9 deliberate placeholder warnings, and I checked its exit-0 receipt and matching log SHA-256. That build is honestly attributed to the coordinator, not this reviewer; placeholders prove no mathematics. All 9 declarations match the exact comparator inventory and there are no definition-name exceptions. Permitted final axioms are only the standard three. The historical manifest's zero proof-hole count excludes its separate Challenge placeholders and is not independently verified at this phase.

The imported semantics inspected are hash-bound below and in the JSON. Familiar Mathlib finite sums, matrix products, real norms, spectrum/positive-definite or finite-count APIs are used with concrete mathematical definitions. Existing reviewed projects from the preceding campaign provide workflow and exact-matrix/counting examples; none of their results is added as an assumption here. Later independent proof review must check the full active dependency closure, material use of LeanCert and all export axioms; actual isolated Linux Comparator must check statement identity and kernel/sandbox rejection controls. No source, metadata or permanent problem ID was changed by this referee.

## Exact reviewed sources

| Source | SHA-256 |
| --- | --- |
| `matrix-functions-and-stability/MF-16/README.md` | `b69bf5038340ff27e10ed0c629a76cc1182eea72aaaf73f4aec881ecc1c84ac1` |
| `matrix-functions-and-stability/MF-16/lean/README.md` | `b972fb58ae6bb3025b331ad4c312ca695a687bfc1662c59e4205a7becd8a8df8` |
| `matrix-functions-and-stability/MF-16/lean/NUMERICAL_TARGETS.md` | `6d6ea0481cb33c0ff69675e008956920be1744ef6cebdafaeac73f9c87601689` |
| `matrix-functions-and-stability/MF-16/lean/NLA/MF16/Definitions.lean` | `5b8e0a7e11657c6d90dc956664f12f5afefdf8ab556517ae199ab339d99d604e` |
| `matrix-functions-and-stability/MF-16/lean/Challenge.lean` | `538b03b014015da03f9929fd520adfb978de96b3fa1b4fe3d995bb94e3dccf0f` |
| `matrix-functions-and-stability/MF-16/lean/comparator.json` | `c571ce8622b8ff95aa2a8a29ec186a68e3464e9431dae2a5b03db74236b8c088` |
| `matrix-functions-and-stability/MF-16/lean/formalization.yaml` | `e652e0885dc62acd60004a46ab4b187eeeee9b26e0f4cab0bf6714387397ec29` |
| `matrix-functions-and-stability/MF-16/lean/lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `matrix-functions-and-stability/MF-16/lean/lake-manifest.json` | `a0d0298e414637111ddfcd231f97a616e56d39c0c0c32a2c82c99c8f48b766a9` |
| `matrix-functions-and-stability/MF-16/lean/lakefile.toml` | `3fbcec68e929d4b9a570eead7946767f3a26d3f82d0efabdbf9bfdf45dc13ed6` |
| `docs/lean/REVIEW.md` | `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553` |
| `references/colbrook-matrix-functions-2026-09-11/manuscripts/MF-16.tex` | `d6de9df3384c8705fc5c3cac1aded04ff5c25931ef00b155edbd042e384f8c34` |

## Relevant imported semantics

| Dependency file | SHA-256 |
| --- | --- |
| `Mathlib/LinearAlgebra/Matrix/PosDef.lean` | `09290b5923e167fcf959df64d00b039c7b99c4b236755728219bf5b5feaac24a` |
| `LeanCert/Engine/RootFinding/Krawczyk.lean` | `8df9943a4e8d185164bbb86e93892f97f0596d2fcba88e48f5ea068628b7f283` |
| `LeanCert/Engine/Optimization/Gradient.lean` | `7e07c88940bfa0761bcd2a65de06733b90a3db079273118b268b0e6860335704` |

Machine report SHA-256: `7bb89e7162304b01f70bc0110ecd0dc76886e230874eba103aa2d4ebe9b343a6`. Its source/diagnostic/build hashes bind this approval to the exact bytes reviewed.
