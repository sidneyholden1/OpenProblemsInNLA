# MI-21 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `e43421af3d19dac5fc2cb6304affba66e7ddae24` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee.

## Actual proof and full target

All three exports connect the actual CFC geometric means to the actual Euclidean operator norm and full all-unitarily-invariant-norm conjecture. Operator norm admissibility is proved using Mathlib's CStarRing unitary multiplication invariance, norm axioms and actual matrix norm instance. Every input is complex positive definite through diagonal positivity and invertible Hermitian conjugation; both sums are exactly identity. CFC inverse powers use strict positivity and the actual rpow inverse laws. The Riccati bridge proves the candidate is positive semidefinite, transforms its square to the inner CFC argument and invokes CFC.sqrt_unique. Thus no arbitrary square root or surrogate geometric mean is assumed.

Both inverse identities and ordered Riccati products are independently verified entry by entry. The proof's second numerator is S*N*S, using the same positive meanScale as the first. This equals (5/3) times the statement diagnostic's second numerator D+(3/5)E, and the shared scale is (25/9) times that diagnostic's second scale. Consequently N^2/h is unchanged; the separate exact rescaling diagnostic is retained. The actual input square roots and both squared means give the rational witnessL. A nonzero actual Euclidean eigenvector with eigenvalue 1351000/1350907 supplies a lower bound on the true operator norm using le_opNorm and cancellation of its strictly positive norm. The right matrix is identity for every real p, in particular every allowed positive p. Instantiating the general conjecture at p=1, two dimensions and two summands yields its full negation, without restricting the universal target to those parameters.

The material eigenvalue gap uses an actual LeanCert strict-upper dyadic verifier at [0,0], precision -53 and depth 10. Its separately printed Boolean auxiliary proof reduces to of_decide_eq_true (id (Eq.refl true)). The verifier's actual soundness implementation checks domain validity and bounds the evaluated expression by the enclosure before comparison. Exact Riccati scaling cancels the only scalar square root; no numerical eigenvalue approximation, interval matrix square root or assumed covariance is used.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (3 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 3 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.MI21.operatorNorm_isUnitaryInvariant` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI21.counterexample` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI21.not_geometricMeanNormConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `matrix-inequalities-and-norms/MI-21/lean/Solution.lean` | `a30f8dfd1103b6ba1f1aca927e7ef4a92b6fa8ae70658463cdea649378ae1a50` |
| `matrix-inequalities-and-norms/MI-21/lean/NLA/MI21/Definitions.lean` | `18ebd6d65063b6e970d76b60aab6a8a8bc595189e9b8e188895030d2172f1055` |
| `matrix-inequalities-and-norms/MI-21/lean/NLA/MI21/Proof.lean` | `7db067a9cc73e3cda027e2e01d664e4b12bf5af84e8f6b3bb10d9bd4de30e9bc` |

Machine proof-checks SHA-256: `f002d5507952d8b4f6f90a1d43d5aa0163af679c3214d77b2a35776ec578d8b5`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
