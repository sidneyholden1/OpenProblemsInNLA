# IE-19 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `82aee43d2dd0b1ef201134ed8d066b62b7fca890` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee.

## Actual proof and full target

The three exports give the admissible order-three counterexample with genuine inverses and nonsingularity, then negate both the original inequality and its equality-characterized sharpening. Entrywise bounds, real symmetry and all weak diagonal-dominance conditions are proved for the actual witness. Exact full matrix multiplication proves a right inverse for each matrix. Mathlib's actual isUnit_det_of_right_inverse and inv_eq_right_inv then establish nonsingularity and identify the totalized matrix inverse with those candidates. There is no assumed inverse or singular-case escape.

Every row's absolute scalar norm sum is computed exactly; Finset.sup_const with the explicit nonempty finite index set proves the actual finite maximum is 7/9 for the witness inverse and 5/4 for the comparison inverse. The comparison formula evaluates to 5/4 under parameters satisfying all source constraints. The strict gap then refutes the original universal inequality, which in turn refutes the conjunction with equality characterization. The source's additional sharp infimum/nonattainment theory is not claimed.

The material scalar gap uses `leancert (trust := kernel)`, but its actual printed proof is a Mathlib NormNum exact rational comparison and reflexive integer check, not an interval or dyadic verifier term. Kernel trust audits cover every export. Exact finite multiplication, all-row constant sums and the tiny rational inequality are appropriate reductions; approximate matrix inversion and larger numerical intervals are unnecessary.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (3 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 3 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.IE19.counterexample` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IE19.not_lowerBoundConjecture` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IE19.not_sharpConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `linear-systems-and-elimination/IE-19/lean/Solution.lean` | `72fa6092d37c32eb453af0ba83974cc541cb15730080c96dfbaa9226a6f6f658` |
| `linear-systems-and-elimination/IE-19/lean/NLA/IE19/Definitions.lean` | `32dc631cd600154948963a875559cd610d974764fc77f13ab242a573c6dd22b3` |
| `linear-systems-and-elimination/IE-19/lean/NLA/IE19/Proof.lean` | `06a534c417911f7db8aca8310699c3862eaf535f8b34ec20b5551218c20a5460` |

Machine proof-checks SHA-256: `362b75dfd7893bd12335056ce01d5333911e53eadb573c74d91fef599c8e9fc1`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
