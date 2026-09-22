# PF-02 independent statement review — referee 2

- Phase: statement boundary, before proof implementation.
- Reviewer: `/root/new_target_screen`, independent OpenAI Codex AI agent.
- Independence: I did not author or modify PF-02 Definitions, Challenge or numerical targets. My separate SP-04 drafting does not contribute a PF-02 proof or statement.
- Protocol read: repository `docs/lean/REVIEW.md`, adapting Tau Ceti review; no Tau Ceti endorsement or human peer review is asserted.
- Verdict: **APPROVE** the exact bytes below for the statement gate.
- Date: 14 September 2026.

## Scope review and evidence

I read the canonical PF-02 README and the complete authored TeX manuscript, including both optional all-size extensions. I independently compared the two source files byte-for-byte with commit `deb549fa9ddd6b119e6c59016f268237e645dfa2`; both match. The working branch base is `32f1f799219fbcaf4c66bfaa4edb8a0c591e79e9`. Historical PASS labels in these sources were treated as evidence of neither this formalization nor its truth.

`ConnectedOrbitConjecture` retains real entrywise nonnegative matrices, all k≥3 and p,q≥1, the ordinary rank k(k+1)/2, actual minimal real PSD factor size, and connectedness of the full congruence quotient. A single fully proved k=3,p=q=6 counterexample negates the universal question; the optional all-size constructions are unnecessary. This is a complete original-target negation, not an isolated diagnostic claimed as a solution.

`IsPSDFactorization` requires actual Mathlib positive semidefiniteness and all trace products. `feasibleSizes` ranges over all positive sizes, and `psd_rank_semantics` explicitly requires nonemptiness and an attained least member. Thus the sInf convention is not silently exploiting an empty set. `witness_exact_data` includes positive definiteness, both genuine factorizations, determinant/rank values, and true minimality as conclusions. The generic rank≤k² bound suffices to exclude k≤2 because the witness rank is six; replacing the source's stronger symmetric-space bound by this weaker sufficient theorem is valid.

The quotient identifies all matrix-ring units, with exactly A↦SᵀAS and B↦S⁻¹BS⁻ᵀ. No determinant-sign or orthogonality restriction is imposed. `congruence_quotient_semantics` requires equivalence, class equality iff actual congruence, and the quotient-map property. I additionally inspected pinned Mathlib `Topology/Constructions.lean`: the `Quot` topology is explicitly coinduced by `Quot.mk`, with its quotient-map theorem. Finite-product real matrix/subtype topology is the canonical Euclidean subspace topology.

The exact matrix, six factors and reflected factor agree with the manuscript's zero-based translation. The trace metric counts symmetric off-diagonals twice, correctly. The two orientation determinants ±32 and det(M)=8192 are concrete conclusions. `trace_coordinate_bridge` quantifies over arbitrary symmetric factors; `congruence_coordinate_identity` quantifies over every real S, including singular matrices. Its fourth determinant power handles negative-determinant changes of basis. This fixed polynomial identity is a legitimate computation reduction that preserves the required group.

`orientation_invariant` requires nonzero row-coordinate determinant for every actual factorization, then continuity and invariance on the whole subtype. `quotient_orientation` requires an actual continuous descended function with range exactly {−1,+1}. Neither a restricted orientation component nor an assumed disconnectedness is hidden in the definitions. The final counterexample expressly requires a nonempty quotient and failure of preconnectedness, so emptiness or mere failure of path connectedness cannot discharge it.

I inspected `formalization.yaml`: source authorship is retained as Matthew J. Colbrook and new formalization credit is Sidney Holden; AI involvement and pending proof/review are explicit. I inspected `comparator.json`: all nine Challenge theorem names are selected, no definitions are selected as theorem substitutes, and the permitted axioms are exactly propext, Classical.choice and Quot.sound.

## Mechanical evidence actually inspected

The author statement-build log reports a successful pinned Lean 4.33.1 build, with exactly nine expected Challenge sorry warnings. Its receipt agrees with its SHA-256. After the manifest project-name correction to NLAPF02, I independently reran `lake build Challenge` against the current files. It exited zero and replayed Challenge, with the same nine expected warnings; this incremental replay is recorded in `verification/statement-referee-2-build.log`, not misrepresented as a clean rebuild. Dependency pins remain LeanCert 621a43d7cf21f87872392a01e874f2f1dbddc926 and Mathlib 0df444a360eaa60ab8c11dca51a86af692955474.

I inspected the author's `precheck.json` only as a diagnostic report. I did not independently execute its Python verifier or claim its PASS as a Lean proof. The analytic/topological contracts remain explicit future theorem obligations.

## Byte-specific approval

All SHA-256 values below were computed independently from current file bytes. The changed manifest project name does not alter mathematical signatures; its current digest is included.

| File relative to lean project | SHA-256 |
| --- | --- |
| `NLA/PF02/Definitions.lean` | `8ec6b4b58a99eb5e4554ebe7807619665c52deb83405083ba40b224a935b1f1d` |
| `Challenge.lean` | `1984dbc1415c91951df296f00011049c5ccc0a5baabe937cb8e107a411c51532` |
| `NUMERICAL_TARGETS.md` | `7ce9ec1ed32cf81c213cbba661c367f5528e536361fb6a2a715c5c36c72c5758` |
| `comparator.json` | `8b17ff697fb75d3d8ba82a8ce169ca895d2402148a353301ba683ffd7193ceb4` |
| `lakefile.toml` | `e9d31a3273307f6e5c4e1031f339b2de1d1980b3412ea2fa2982efdeb4270cb1` |
| `lake-manifest.json` | `19b43bd134b48c326c0977c6134db0c9a7da9fc89961d20cd303390ac7154eda` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `formalization.yaml` | `a1c4cd12a570c3d4b97a4aef7a640300169ff41569a256c12725dd343dfcd920` |
| `verification/source-provenance.json` | `3be2f3b7162fa2126f1363df34a6c0f4ec3ebe0fa0636218062cc69e7bdddd97` |
| `verification/statement-build.log` | `245ecb83e0d9871551620a796b3a650da7f562c3f21d35ca6548abe1599a3732` |
| `verification/statement-build.json` | `39210a8d6b8e3c4b2bece6faa9dc758581d7e1f992e0eeb69f1ca8573a1e6d2c` |
| `verification/statement-referee-2-build.log` | `b6b8a62bf021856171fdb452fce3b7a5267b31f2f58b2c020150bfd8042f90b1` |
| `verification/precheck.json` | `eeb92b61f36e88a4f8b61609b9ea6025e17c2d605c59f0ee884b516e36d091e2` |

| Canonical/source file relative to worktree | SHA-256 |
| --- | --- |
| `nonnegative-and-positive-factorizations/PF-02/README.md` | `4ef3bba41aca6e2a2c66a8a39e5974b54095b85fba0557c6353c253202aa26c7` |
| `references/colbrook-factorization-2026-09-11/manuscripts/PF-02_disconnected_orbits.tex` | `7e41f64f8495231b9cadd5296daa8fe44790039d3f6e25260cd04be258f3bf65` |

## Limitations and subsequent gates

No substantive statement changes are requested. This approval authorizes proof development against these signatures; it establishes no mathematical theorem. All nine Challenge declarations deliberately contain sorry. There is no inspected Solution implementation, no completed LeanCert export-axiom audit, no Linux Comparator/default-kernel replay, and no rejection/sandbox control run in this review. Two independent final-proof reviews and all mechanical gates remain necessary before any Lean-verified or publication-complete claim. Material statement/source changes invalidate this byte-specific approval until rereviewed.
