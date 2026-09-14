# IV-06 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `05dda9e7ac6c222910d7553694ff4b4551aaa2a6` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee. 

## Actual proof and full target

The eight exports cover the full independent-entry interval-box conjecture for real matrices. The generic eigenvector/determinant bridge uses Mathlib's actual exists_mulVec_eq_zero_iff, valid even in dimension zero, and does not assume an eigenvalue exists. The family equivalence proves that the two free parameters describe the entire original interval box, recovering every fixed entry, followed by an unrestricted exact determinant polynomial. Four explicit nonzero real eigenvectors establish admitted values −3,0,3,25 for admissible family members.

Every matrix in the full box is excluded at separators −1,1,12 using exact affine determinant bounds. The weakest upper margin −18<0 is an actual LeanCert checked dyadic point certificate, on [0,0] at precision −53/depth 10. Its auxiliary Boolean proof is kernel of_decide_eq_true (id (Eq.refl true)); it is used for all separator negativity and hence the exported component count and universal negation. The proof avoids interval subdivision by eliminating the matrix determinant exactly first.

The topology bridge uses the real subtype's actual connected components, maps a preconnected component continuously into R and applies IsPreconnected.Icc_subset. An exact finite ordering proof supplies a separator between every pair of the four included values. This gives an injective Fin 4 map into ConnectedComponents and the genuine cardinal lower bound ≥4, without a finiteness/closedness assumption or Nat.card convention. The three-dimensional instance then refutes the complete all-dimension conjecture. All wrappers match the frozen Challenge. Colbrook retains the mathematical credit and Mathlib's connectedness/cardinal/determinant APIs are reused directly. This proves at least four components, not exactly four, exact interval endpoints, full eigenvalue ranges or a replacement general bound.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (3 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt, success log and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 8 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear in those closures. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility. A separate fresh environment-dependency probe confirms a value-dependency path from the exported universal negation to the material scalar theorem. Its initial diagnostic had a missing Lean Name annotation (exit 1); the original script/log/receipt are retained, and the corrected diagnostic returned exit 0. This was an external inspection-script error, not a project proof error; all export consumers passed on their first run.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All active project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.IV06.eigenvalue_determinant_semantics` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IV06.family_and_determinant_semantics` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IV06.witness_eigenpairs` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IV06.witness_separators` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IV06.connected_component_intervals` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IV06.four_components` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IV06.counterexample` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IV06.not_componentBoundConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `intervals-and-absolute-value-equations/IV-06/lean/Solution.lean` | `b4b9ab44b95accb5f4a0b677d417937cc0ca9ae6c9f08409b2c178ef0d8f699d` |
| `intervals-and-absolute-value-equations/IV-06/lean/NLA/IV06/Definitions.lean` | `283a31f8e9d100347e5403b8e5688feebd13968d865d487b4962eaa1f861b195` |
| `intervals-and-absolute-value-equations/IV-06/lean/NLA/IV06/Proof.lean` | `600311e699fecc178f921e8233a9c14d50774db5980ea63560040e578d896333` |

Machine proof-checks SHA-256: `998f3b21b8e1fb6a62c5acc3a306809f7a684d37135385b06a1de28545876b09`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
