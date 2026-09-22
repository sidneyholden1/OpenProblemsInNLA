# RA-03 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `ad84edf4a36673eef141c12bface0802188ef540` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee.

## Actual proof and full target

All four exports refer to the actual sequential randomized cross-pivot process and squared Frobenius error. The norm bridge unfolds the explicitly scoped Frobenius instance, proving the coordinate sum equals the actual squared norm, including zero-size cases. Every pivot mass is nonnegative, the absorbing none label has total mass exactly when A=0, and the full label sum is one. History normalization is an induction over the actual changing residual matrix using Fin.consEquiv, not an independence assumption. Zero pivots carry zero mass, while the zero-matrix state is normalized and absorbed. The generic normalization theorem covers all dimensions and history lengths.

The witness has four nonzero entries. Every actual cross update and each mass/error is computed, giving expectation 18/5. Its true adjoint-self Euclidean linear map is related to the matrix Gram product; the characteristic polynomial is (X-9)(X-1). Mathlib's sort_roots_charpoly_eq_eigenvalues theorem is applied with full root multiplicity and actual decreasing order, then the genuine singularValues definition gives 3,1 and tail square 1. Thus the counterexample is not conditional on an invented singular-value list. The strict gap against 2^1*1 refutes the complete universal squared-error assertion. Stronger constants and unsquared-error results from the source are outside this claim.

The material strict_scalar_gap uses leancert's NormNum rational-comparison route and a reflexively checked integer inequality, as the actual printed term confirms. It is not an interval certificate. The exact order-two example and one-step expectation minimize computation while the probability law is proved generically.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (3 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 4 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.RA03.frobeniusSq_eq_norm_sq` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA03.process_isProbability` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA03.counterexample` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.RA03.not_squaredErrorConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `randomized-and-low-rank-approximation/RA-03/lean/Solution.lean` | `08e83996051e2c443a6a5153e8fb6e30ebf69bd4f44f86cddda837bbc0baf86e` |
| `randomized-and-low-rank-approximation/RA-03/lean/NLA/RA03/Definitions.lean` | `de6509ef6b4a41db3e01fce7b77af4c7c338dbd61f8f135e956602d3b8b0980f` |
| `randomized-and-low-rank-approximation/RA-03/lean/NLA/RA03/Proof.lean` | `b98c702906e163805ae83809cf750eca650f365a815034a665e2ebd7bd96746a` |

Machine proof-checks SHA-256: `b9e24d70c20180f8f41152d5eb1e26b40bea75ba24045e21bd01f9c456c0fb54`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
