# TR-15 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `26d7d0ac7fd14d3f8d527977db3b50c948a77f39` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee.

## Actual proof and full target

All seven exports preserve the complete common-generator Hankel tensor and full real H-eigenpair semantics. The lower contraction reindexes every ordered pair through an actual finite equivalence and computes all components for arbitrary real vectors. The upper contraction proves every tuple except the all-one tuple contributes zero, rather than assuming a selected tensor slice is the whole contraction. Its nonzero vector is checked by a coordinate. Strict positivity of the first lower contraction follows from its sum of squares and the nonzero-vector condition; every real lower eigenpair must consequently have positive eigenvalue even when its first vector coordinate is zero.

Nonvacuity is proved separately by continuity and the genuine intermediate-value theorem on [0,1]; strict endpoint signs yield an interior root and every coordinate of the resulting eigenpair is verified. The actual negative upper eigenpair materially includes negative_eigenvalue_certificate. Its printed term applies verify_strict_upper_bound_dyadic_checked at singleton [0,0], precision -53, depth 10; the separately printed Boolean checker proof is `of_decide_eq_true (id (Eq.refl true))`. The verifier checks domain validity and enclosure soundness before strict comparison. Full admissibility is supplied and the counterexample directly instantiates the original universal inheritance statement. No vacuous lower-eigenpair premise, tensor normalization, numerical root approximation or eigenvalue enumeration is used. Even-order inheritance and stronger Hankel-matrix positivity statements are outside scope.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (3 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 7 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.TR15.lower_contractions` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.TR15.upper_contraction` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.TR15.lower_eigenvalues_pos` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.TR15.lower_eigenpair_exists` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.TR15.upper_negative_eigenpair` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.TR15.counterexample` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.TR15.not_inheritanceConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `tensor-computations/TR-15/lean/Solution.lean` | `dc31d2a6a1ef891bbdc9b6781a7a250c6751d539b7cd95c4a59d08638a8faeb1` |
| `tensor-computations/TR-15/lean/NLA/TR15/Definitions.lean` | `63b8767fd19148b269f6e4041d464f0de5dc64cac82e1448fee43115bed55379` |
| `tensor-computations/TR-15/lean/NLA/TR15/Proof.lean` | `795f3b1305dfae77fe71ec1927b7d72e9d913a2ffd0475879880f33e55c959be` |

Machine proof-checks SHA-256: `7a0e514e4f42be8930531e5d35bc31576fc1fd2c79f64ccb72fa751667517d7f`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
