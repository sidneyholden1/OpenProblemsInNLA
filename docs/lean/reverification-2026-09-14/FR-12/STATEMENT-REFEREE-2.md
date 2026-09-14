# FR-12 — independent statement referee 2

**PASS — approved statement boundary.** No blocking fidelity, vacuity or numerical-data finding. Proof and actual Linux verification remain separate future gates for this campaign.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md`, the local Tau Ceti adaptation, covering complete target fidelity, mathematical meaning, degeneracies, numerical scope, computation reduction, reuse and attribution. This is not official Tau Ceti endorsement or human peer review. I read the full retained canonical page, complete informal source(s), exact numerical plan, actual Definitions and Challenge, comparator configuration, project guide and formalization metadata. I did not inspect active Proof/Solution bodies. Definitions' finite-index/well-formedness proofs are part of the reviewed boundary.

The source is the existing authored snapshot `deb549fa9ddd6b119e6c59016f268237e645dfa2`, preserved from earlier branch ancestry. The observed upstream main is the older `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`; this review does not call the source current main or newly authored. FR-12 has no canonical page at the observed older main, so no cross-revision target identity is claimed. Existing historical statement-stage notices and old published verification claims remain historical; they do not establish this campaign's proof or Linux gate. Project metadata was checked for target scope and attribution, not as evidence that a new proof run passed.

## Full target and certificate fidelity

The full original target is the existence of a single arbitrary positive real C bounding the count at every positive multiple of four. hadamardCount is Nat.card of exactly the real sign-matrix subtype with the actual Gram identity; labels are never quotiented or normalized. Nat.card would totalize an infinite type to zero, so counting_semantics explicitly requires finiteness in every dimension and the actual Mathlib IsHadamard equivalence at positive dimension. Mathlib's predicate includes unitary entries and both Gram identities. Over the reals the entry condition is precisely ±1, and the reverse Gram identity follows from positive n and the nonsingular one-sided identity. There is no assumed finite family cardinality or existence at unsupported orders.

The actual block/reindex construction keeps the top A,B rows and permutes the lower paired rows by a genuine permutation. Top rows recover A,B; equality of first halves and distinctness of positive-order Hadamard rows recover the permutation. This gives m!, not the source's stronger all-perfect-matching (2m−1)!! factor. That restriction concerns only the injected family, not the objects counted or the universal target. Both canonical and formal metadata explicitly exclude the stronger recurrence. The seven signatures cover semantics, injection, cardinal recurrence, power-of-two nonemptiness, the exact all-k lower bound, strict counterexamples for every positive real C and full universal negation. Natural K=k+2 eliminates truncated subtraction while retaining precisely 2^K(K−1)(K−2)/8. The inner power is natural and the outer power is real; Real.log n / Real.log2 is genuine base-two logarithm. All exhibited dimensions are positive multiples of four.

I independently enumerated the complete labeled order1/2 sign-matrix sets and the restricted map: H(1)=2, H(2)=8, with4/128 distinct outputs from4/128 triples. These are construction output counts, not claims that H(2)=4 or H(4)=128. They are only finite diagnostics; universal injectivity, finiteness, exponential induction and an actual Archimedean choice must be proved later. Exact symbolic cardinality/factorial/log APIs are appropriate; a decorative interval certificate is unnecessary. The full original negative result is covered, not Hadamard existence at every admissible order or a matching upper bound. George Stepaniants is credited for both the mathematical construction and formalization; Ferber–Jain–Zhao keep the conjecture and prior upper-bound credit.

## Independent checks and remaining obligations

The independent rational/integer reconstruction is in `referee-2-numerical-checks.json`. Its generator `/private/tmp/nla-fourth-five/referee2_numerics.py` was written by this reviewer from the displayed definitions, rather than relying on a saved PASS. These diagnostics check data and feasibility only; they are not proofs of the universal statements. MF-16's #eval, where applicable, imports Definitions only and is explicitly a diagnostic. The actual numerical statements and all necessary bridges are satisfactory before proof inspection.

The coordinator's fresh pinned macOS `lake build Challenge` passed with exactly 7 deliberate placeholder warnings, and I checked its exit-0 receipt and matching log SHA-256. That build is honestly attributed to the coordinator, not this reviewer; placeholders prove no mathematics. All 7 declarations match the exact comparator inventory and there are no definition-name exceptions. Permitted final axioms are only the standard three. The historical manifest's zero proof-hole count excludes its separate Challenge placeholders and is not independently verified at this phase.

The imported semantics inspected are hash-bound below and in the JSON. Familiar Mathlib finite sums, matrix products, real norms, spectrum/positive-definite or finite-count APIs are used with concrete mathematical definitions. Existing reviewed projects from the preceding campaign provide workflow and exact-matrix/counting examples; none of their results is added as an assumption here. Later independent proof review must check the full active dependency closure, material use of LeanCert and all export axioms; actual isolated Linux Comparator must check statement identity and kernel/sandbox rejection controls. No source, metadata or permanent problem ID was changed by this referee.

## Exact reviewed sources

| Source | SHA-256 |
| --- | --- |
| `frames-and-matrix-designs/FR-12/README.md` | `db0a3714e6ba316e9c24a43f56a61fb36b068fe40f279a15d0415bc85279d1fc` |
| `frames-and-matrix-designs/FR-12/lean/README.md` | `6698734f06f6b658edf4fc21048c9d127b14466dfb8784aa893da5c53a0e171d` |
| `frames-and-matrix-designs/FR-12/lean/NUMERICAL_TARGETS.md` | `bedc45de378f2e7429e7214f572f466e9c806abb7f02ab9921aa50f6368c9da0` |
| `frames-and-matrix-designs/FR-12/lean/NLA/FR12/Definitions.lean` | `0c074289e7ee518876a36caf33f1b66a286ca46e7e520c083d07b9133779bf9c` |
| `frames-and-matrix-designs/FR-12/lean/Challenge.lean` | `b7610d4a0b7416737dc9fdb3cbc24f7c154fe27bfd6b25986b7ed7b80dee28a7` |
| `frames-and-matrix-designs/FR-12/lean/comparator.json` | `03d4d4ef6190299ee767f9c677c40d23bda8576ae35a6628fa022a0a679c1581` |
| `frames-and-matrix-designs/FR-12/lean/formalization.yaml` | `76a17a4b58803dfd17384b5c6e45075b36c8cc3eda3cc79d71ec8cb4862d63f8` |
| `frames-and-matrix-designs/FR-12/lean/lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `frames-and-matrix-designs/FR-12/lean/lake-manifest.json` | `ef45e8c3dc558df93024d94b81f42ace998ddfacc8b7948905a4b90c548742cb` |
| `frames-and-matrix-designs/FR-12/lean/lakefile.toml` | `b64736762c8980abbc71aa5a7dc5f34e502ec228cdb9773673d85662d8d318c7` |
| `docs/lean/REVIEW.md` | `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553` |
| `frames-and-matrix-designs/FR-12/solution.md` | `60ffef5d41d8986df21d25bc539f8761c86a5d64c43bb1012f110ed9917e4d59` |
| `frames-and-matrix-designs/FR-12/solution.tex` | `700b2190651608a68c1449c065f318902180d1cc634e8845ea51d3ee5a57c163` |

## Relevant imported semantics

| Dependency file | SHA-256 |
| --- | --- |
| `Mathlib/LinearAlgebra/Matrix/HadamardMatrix.lean` | `b04b0656bc502d39b1c7d238afe6152428778f59411a7ef9753c81565b231c31` |
| `Mathlib/SetTheory/Cardinal/Finite.lean` | `b113177c5ed00662c73a8f3b04002b399c19f0d008920e52c1a6b6c7f16713bf` |

Machine report SHA-256: `a152c17310a4483fba764b68deeba3f871c46fff0f6a86fa2ec9aeab4ef51147`. Its source/diagnostic/build hashes bind this approval to the exact bytes reviewed.
