# MI-29 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `312c879a41904f9b4c6f127546e032a74b3c971f` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee.

## Actual proof and full target

All five exports preserve actual complex CFC powers and absolute values. The natural-power bridge requires genuine PSD input. The modulus theorem uses CFC.abs_sq and actual conjugate-transpose products, reducing the eighth modulus power to the fourth Gram power. General comparison positivity is proved by adding a strictly positive spectral power of A to a PSD power, then using PosDef.det_pos and Complex.pos_iff; the two compared determinants are genuinely positive real quantities. The witness A is positive definite; B is Hermitian and invertible via its exact determinant -1/125, and opposite diagonal-sign witnesses prove both B and -B fail PSD. No singular or semidefinite degeneration is exploited.

Both Gram products, their squares and the final determinant matrices are finite certificates verified against actual multiplication and CFC reductions. The explicit left/right determinants and positive difference 21036678407451/156250000000000 agree with the independent rational diagnostic. The actual complex strict comparison then contradicts the original all-matrix/all-nonnegative-real-exponent inequality at k=6,p=8. Existence of other parameter regimes or classifications is not asserted.

The material scalar_gap_positive term uses LeanCert's actual strict-upper dyadic verifier on [0,0], precision -53/depth 10. Its printed auxiliary Boolean proof is of_decide_eq_true (id (Eq.refl true)); actual imported soundness checks domain validity and enclosure inclusion. Small entrywise square certificates and the Gram-power identity avoid expanding noncommutative eighth powers or computing a matrix square root numerically.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (3 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 5 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.MI29.spectralPower_natCast` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI29.modulus_power_eight` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI29.comparison_positive_real` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI29.counterexample` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI29.not_modulusDeterminantConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `matrix-inequalities-and-norms/MI-29/lean/Solution.lean` | `0cb66f4fc4d379f1f91699ba16b6feda93710798fe414fa09b242cd12076ce11` |
| `matrix-inequalities-and-norms/MI-29/lean/NLA/MI29/Definitions.lean` | `c73bfb1856b3e1059ce2ef1e35f8314cb339edcc38b89d28780d38b122ce1a16` |
| `matrix-inequalities-and-norms/MI-29/lean/NLA/MI29/Proof.lean` | `b683a2c0faebd595f7d9f2b0973a9955cf39443c924f7dfd05b3b60e16bdadf5` |

Machine proof-checks SHA-256: `f8a853cd7dfc331905dd8a75988236740beaf16a2ab3aff2802e52da153bd8e7`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
