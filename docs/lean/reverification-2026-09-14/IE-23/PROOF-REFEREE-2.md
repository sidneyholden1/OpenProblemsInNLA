# IE-23 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `4e07fd953ec0d53915af22cc0a30c821c207e3af` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with Dokmanić–Gribonval credited for the example. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee. 

## Actual proof and full target

The eight exports cover the full original uniqueness implication, refuted at m=2,n=3,p=4. Norms.lean first proves denominator positivity for every nonzero complex input, nonempty and bounded ratio sets, the true real supremum's IsLUB property and all-input bounds, including the zero vector. No boundedness or proposed optimizer is assumed. Matrices.lean checks both Gram inverse products, uses Mathlib's actual matrix inverse theorem, derives full row rank from AX=I and proves the Moore–Penrose formula equals B. Both competing inverses and their distinct entries are checked.

FourthPower.lean derives actual fourth powers of the real-rpow lp norm, Euclidean squared norms and the sharp two-coordinate bound from the nonnegative square (|u|²−|v|²)². Actions.lean expands arbitrary complex real and imaginary parts, establishing B's contraction identity, X's isometry and the action of every complex competing right inverse on z=(1,−1). Root signs and nonzero denominators are proved; the bound is attained by z for both B and X. Minimizers.lean then uses genuine csSup bounds to prove equal induced norms 2^(1/4), global minimality over every right inverse, and an attained IsLeast, before contradicting the unrestricted conjecture. All Solution wrappers match their Challenge statements.

The computation is finite exact algebra with one fourth-power SOS and one norming vector, avoiding interval subdivision and an unnecessary all-p optimizer classification. LeanCert provides kernel trust audits only; there is no claimed numerical interval certificate. Mathlib's Euclidean norm, real powers, conditionally complete supremum, actual inverse and rank APIs are reused directly. Mathematical credit is Matthew J. Colbrook with Dokmanić–Gribonval's example attribution retained. Scope does not extend to all-p formulas, endpoints, smallest dimension or a classification of all minimizers.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (8 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt, success log and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 8 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear in those closures. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All active project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.IE23.inducedNorm_semantics` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IE23.witness_matrix_identities` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IE23.fourth_power_norm_control` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IE23.witness_action_identities` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IE23.witness_attainment` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IE23.witness_norms` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IE23.witness_global_minimizers` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.IE23.not_rightInverseUniqueConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `linear-systems-and-elimination/IE-23/lean/Solution.lean` | `ce642354744645994d4462dff367595ba441781d19ed57a2dd99fe2303e5c671` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Actions.lean` | `950fe455fba3a7af6e927c369ecfd4bf4cf8d68d230b1fab775d185fdc42c451` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Definitions.lean` | `1af986f21059b5b9862decf09366d3ea8dba0c965a5b8550b8d9a0fcc41af33f` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/FourthPower.lean` | `bd0f3a858a5f12cec417f8b2be9bcce63fac4abde60b085fcf113aa192daafc6` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Matrices.lean` | `c7d97a3b225a7abdf39da15f6eb13caf2af171a4316bfa238782b0c430f37906` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Minimizers.lean` | `9dcb508619e2a15c44f94687bbaf7f179c27d7e323e360f4535bea5641e82597` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Norms.lean` | `2a3886e0db7f5ad8e2c0039bdfaf0e05d9f524c587973fc101de2200fda200d4` |
| `linear-systems-and-elimination/IE-23/lean/NLA/IE23/Proof.lean` | `2224a18d89621ef254e3a606b8e711e1576e1bb4e312365a9b4b4706eddc9ca6` |

Machine proof-checks SHA-256: `ea311f3b167df5e6e7b6395cd3a54c4aa774e4a0195d56b3064131c1cc4d38ff`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
