# FR-12 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `42818143f084791532e39ff56c13949bebd8d389` preserves the reviewed mathematical bytes. Mathematical credit remains George Stepaniants; Ferber–Jain–Zhao retain their conjecture/prior-bound credit. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee.

## Actual proof and full target

The seven exports are all connected to the original labeled-matrix target. Semantics encodes each real sign entry into Bool injectively, proving actual finiteness for every order (including zero); positive-order Gram semantics agree with Mathlib Hadamard matrices. Doubling computes all four block row inner products after an actual index equivalence. The two top blocks recover the input matrices; positive row norms and orthogonality make the rows injective, recovering the lower permutation. Thus the cardinal inequality counts actual subtype matrices with the genuine m! permutation factor. No quotienting, assumed injection or infinite-cardinality totalization remains.

Growth proves power-of-two nonemptiness from order one before using counts. Its factorial bound keeps the upper half through the actual Nat factorial theorem. Real-power multiplication and the explicit exponent identity prove the all-k lower bound, with natural/real casts and index shift preserved. Choosing a natural k>16C+2 supplies a strict exponent gap for every positive real C; log(2) is proved nonzero, and the selected dimension is proved positive and divisible by four. This refutes the full asymptotic bound. The stronger all-perfect-matching recurrence and a general Hadamard existence theorem are not claimed. The finite Boolean encoding, block arithmetic and scalar growth induction avoid expensive enumeration and numerical logarithm computation. LeanCert supplies explicit kernel trust audits only; there is no artificial interval certificate.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (6 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 7 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.FR12.counting_semantics` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.FR12.injective_doubling` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.FR12.factorial_doubling` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.FR12.power_two_nonempty` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.FR12.power_two_lower_bound` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.FR12.counterexample` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.FR12.not_countingConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `frames-and-matrix-designs/FR-12/lean/Solution.lean` | `c37bbf5bb1bab85816f6c343eb3ee7bbfdadec2f6ad4dc17d11348a041ab598a` |
| `frames-and-matrix-designs/FR-12/lean/NLA/FR12/Definitions.lean` | `0c074289e7ee518876a36caf33f1b66a286ca46e7e520c083d07b9133779bf9c` |
| `frames-and-matrix-designs/FR-12/lean/NLA/FR12/Doubling.lean` | `841cf24ebad19caf9fe6807a67079931b5bf2fafba01d19ca256bf4f393a081e` |
| `frames-and-matrix-designs/FR-12/lean/NLA/FR12/Growth.lean` | `654930878291656c7f08fb285019d0033bc4c3e5ceebfac625ce676ce228fbaf` |
| `frames-and-matrix-designs/FR-12/lean/NLA/FR12/Proof.lean` | `a75ef4a3567d641df84f7971c4d3f182b1ae73fb87cb70d474feda5c7af69df3` |
| `frames-and-matrix-designs/FR-12/lean/NLA/FR12/Semantics.lean` | `6cba3023ab9f319ac4622a81c4bb7b0cca34da96933fc8e0507f31f6671341e7` |

Machine proof-checks SHA-256: `e774566c561bb6a5cf94643b3cad0c9b0634a9418f63ba8324a0736ca6c9f165`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
