# IE-19 — independent statement referee 2

**PASS — approved statement boundary.** No blocking fidelity, vacuity or numerical-data finding. Proof and actual Linux verification remain separate future gates for this campaign.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md`, the local Tau Ceti adaptation, covering complete target fidelity, mathematical meaning, degeneracies, numerical scope, computation reduction, reuse and attribution. This is not official Tau Ceti endorsement or human peer review. I read the full retained canonical page, complete informal source(s), exact numerical plan, actual Definitions and Challenge, comparator configuration, project guide and formalization metadata. I did not inspect active Proof/Solution bodies. Definitions' finite-index/well-formedness proofs are part of the reviewed boundary.

The source is the existing authored snapshot `deb549fa9ddd6b119e6c59016f268237e645dfa2`, preserved from earlier branch ancestry. The observed upstream main is the older `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`; this review does not call the source current main or newly authored. This approval is bound to the complete canonical target at the preserved snapshot; it does not assert byte equality with the older main or adopt its formatting. Existing historical statement-stage notices and old published verification claims remain historical; they do not establish this campaign's proof or Linux gate. Project metadata was checked for target scope and attribution, not as evidence that a new proof run passed.

## Full target and certificate fidelity

The universal target retains n≥3,m>0,α≥(n−2)m and every real symmetric J with strictly positive entries bounded entrywise by αI+m11ᵀ and weak diagonal dominance. The parameter arithmetic is real, including n−2, and no strict-dominance, invertibility or Loewner-order premise is added. SharpConjecture includes both the full inequality and equality iff J is the comparison matrix. Refuting its inequality at one admissible instance refutes the whole original yes/no statement; the final two negations state exactly that.

rowSumNorm is the actual finite maximum of sums of real scalar nnnorms, coerced from NNReal; scalar norm equals absolute value. For positive n this is the canonical maximum absolute row-sum norm, not Mathlib's default entrywise matrix norm. Matrix inversion is Mathlib's genuine adjugate/determinant inverse and totalizes singular matrices to0. The counterexample explicitly requires IsUnit det for both J and S, eliminating that totalization artifact. There is no assumed candidate inverse in the theorem hypothesis.

I independently checked all nine entry bounds, symmetry and all three weak dominance inequalities for n=3,α=m=1. The rational matrices K,T satisfy both-sided JK=KJ=I and ST=TS=I. Exact determinants are27/4 and4. Every absolute row sum of K is7/9 and every row sum of T is5/4, so their actual finite maxima are those values, with strict gap17/36. The parameter bound and displayed comparison expression at this instance are exact. The three exports require genuine inverses, both unit determinants, the actual norms, the strict violation and the two full universal negations.

The complete source was read, including its sharp infimum1/(α+m), nonattainment and stronger-order exclusions. Those extra analytic results are not claimed by this formalization. Exact finite matrix algebra and one minimal LeanCert scalar inequality are appropriate; no numerical inverse, approximate eigenvalues or intervals are needed for the matrix data. Actual nonsingularity and the all-row maximum remain later proof obligations. Mathematical authorship is Colbrook's; formalization is Stepaniants's; Hillar–Lin–Wibisono's original conjecture credit remains intact.

## Independent checks and remaining obligations

The independent rational/integer reconstruction is in `referee-2-numerical-checks.json`. Its generator `/private/tmp/nla-fourth-five/referee2_numerics.py` was written by this reviewer from the displayed definitions, rather than relying on a saved PASS. These diagnostics check data and feasibility only; they are not proofs of the universal statements. MF-16's #eval, where applicable, imports Definitions only and is explicitly a diagnostic. The actual numerical statements and all necessary bridges are satisfactory before proof inspection.

The coordinator's fresh pinned macOS `lake build Challenge` passed with exactly 3 deliberate placeholder warnings, and I checked its exit-0 receipt and matching log SHA-256. That build is honestly attributed to the coordinator, not this reviewer; placeholders prove no mathematics. All 3 declarations match the exact comparator inventory and there are no definition-name exceptions. Permitted final axioms are only the standard three. The historical manifest's zero proof-hole count excludes its separate Challenge placeholders and is not independently verified at this phase.

The imported semantics inspected are hash-bound below and in the JSON. Familiar Mathlib finite sums, matrix products, real norms, spectrum/positive-definite or finite-count APIs are used with concrete mathematical definitions. Existing reviewed projects from the preceding campaign provide workflow and exact-matrix/counting examples; none of their results is added as an assumption here. Later independent proof review must check the full active dependency closure, material use of LeanCert and all export axioms; actual isolated Linux Comparator must check statement identity and kernel/sandbox rejection controls. No source, metadata or permanent problem ID was changed by this referee.

## Exact reviewed sources

| Source | SHA-256 |
| --- | --- |
| `linear-systems-and-elimination/IE-19/README.md` | `e665e2d1f11510a9f62d4ffd8c6547cd43aeb09576286b7e7ff22f8cdc61697d` |
| `linear-systems-and-elimination/IE-19/lean/README.md` | `d7388e96f98ea7ad6d3b00a6f9f43310d93c679c5d803dead8d967096cb2cd3d` |
| `linear-systems-and-elimination/IE-19/lean/NUMERICAL_TARGETS.md` | `71bab6295627b5d68e63a41bfae8a5e82ce11900d334846636f85cf454814c24` |
| `linear-systems-and-elimination/IE-19/lean/NLA/IE19/Definitions.lean` | `32dc631cd600154948963a875559cd610d974764fc77f13ab242a573c6dd22b3` |
| `linear-systems-and-elimination/IE-19/lean/Challenge.lean` | `c79e602bde37c5395eda1376635054776c72c1d803737e1dbfe0a963899627bb` |
| `linear-systems-and-elimination/IE-19/lean/comparator.json` | `6b02baa6e01466ddde5188c32c90c1063d2ed5163f852b37f0ae776795eec27d` |
| `linear-systems-and-elimination/IE-19/lean/formalization.yaml` | `bd55b7d5ef2b850578dd143bd757a168b2e4b0143ff74be16af991fe777ab433` |
| `linear-systems-and-elimination/IE-19/lean/lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `linear-systems-and-elimination/IE-19/lean/lake-manifest.json` | `0b2982e346ad245431120cb2eeafa466c9336f1e8bf11525312c0982cb840cb3` |
| `linear-systems-and-elimination/IE-19/lean/lakefile.toml` | `10d0c9c9dc8b8ac29e372807b94ca53b644aa5c032e6c4b7eb32c90736be66ef` |
| `docs/lean/REVIEW.md` | `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553` |
| `references/colbrook-recovered-2026-09-11/manuscripts/IE-19.tex` | `4c50113b3ca261779be36a0058e6b79cb594225098268cd8cc815e6b87b905a4` |

## Relevant imported semantics

| Dependency file | SHA-256 |
| --- | --- |
| `Mathlib/LinearAlgebra/Matrix/NonsingularInverse.lean` | `1ee785b6ebd213ad2ed971bf3c804afee8cc6ce52be69e63572b4cf1bdb5e880` |
| `Mathlib/Data/Finset/Lattice/Fold.lean` | `79b80dd5aa12886d31c582ab00585627dc4e7f1d7607c7b707484f38d95ce2f4` |
| `Mathlib/Analysis/Normed/Group/Real.lean` | `eaae958600a11f6a363c1aaf0f5d9d2f85f27a277eb26b6cbfe16e6462922cd4` |

Machine report SHA-256: `31109435e0cb968945580f5ce603e84d71ad32812b4be2a9188847630f263b66`. Its source/diagnostic/build hashes bind this approval to the exact bytes reviewed.
