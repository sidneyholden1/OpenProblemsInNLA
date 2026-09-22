# MI-23 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `8595b5406fc21df98924ce1b5ec486f5ea67f00c` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee. 

## Actual proof and full target

All eight exports preserve the corrected eigenvalue formulation of the original conjecture, including arbitrary complex positive-definite matrices, both r,s parameter regions, p≥1 and t∈[0,1]. FunctionalCalculus.lean proves positivity of actual CFC powers and means, and derives a two-sided square-root inverse plus similarity of XY to a positive Hermitian congruence. Actual characteristic-polynomial root multisets are shown to be real, positive, complete with length n, sorted and determinant-product preserving. SpectralNorm.lean proves the maximum-root semantics, so List.getD's fallback cannot produce the counterexample. It then proves the genuine identity lambda_max(X²Y²)=||XY||₂² through characteristic-polynomial cyclicity, positive congruence and the adjoint Gram identity; eigenvalues are never defined as operator norms.

Witness.lean certifies D and T positive definite by exact LDL, and proves B=DT⁸D, G=DTD, H=DT⁷D and the actual principal 1/8 and 7/8 mean identities by CFC. Arithmetic.lean verifies repeated-squaring tables and the exact GH entry and AB Frobenius square; the independently recomputed difference is 99434824489435745411095588895/107495424. NormBounds.lean proves entry≤operator norm using a unit coordinate vector and the Frobenius bound from the actual Gram trace. Thus the positive rational gap proves a strict squared operator-norm reversal, then a strict first-eigenvalue and k=1 prefix reversal. Both eigenvalue list lengths are proved before the prefix contradiction. The witness r=s=1,p=2,t=1/8 is admissible and refutes the full universal statement.

The material scalar_gap_positive term uses LeanCert's checked dyadic upper-bound theorem on the constant zero against that positive rational, on [0,0] with precision −53/depth 10. The actual auxiliary Boolean proof separately prints as of_decide_eq_true (id (Eq.refl true)). Exact casts are handled by ordinary NormNum terms; no native computation or numerical eigenvalue guess enters the proof. This is a reduced exact point computation, not a broad spectral interval search. The mean/congruence patterns acknowledge MI29/MI21 and use pinned Mathlib; Colbrook retains the mathematical credit. The proof does not settle the remaining valid parameter subregions or alter the corrected original eigenvalue target.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (8 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt, success log and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 8 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear in those closures. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility. A separate fresh environment-dependency probe confirms a value-dependency path from the exported universal negation to the material scalar theorem. Its initial diagnostic had a missing Lean Name annotation (exit 1); the original script/log/receipt are retained, and the corrected diagnostic returned exit 0. This was an external inspection-script error, not a project proof error; all export consumers passed on their first run.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All active project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.MI23.positive_powers_and_means` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI23.product_eigenvalue_semantics` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI23.squared_product_largest` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI23.operator_norm_bounds` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI23.witness_data` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI23.witness_squared_gap` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI23.counterexample` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI23.not_generalizedGeometricMeanConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `matrix-inequalities-and-norms/MI-23/lean/Solution.lean` | `575f2fd27922d2725d93ada823bfeb4da70407d7fd9c31fb7cf1753a5fdbd243` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/Arithmetic.lean` | `d5895f0636fa3aa3887721c610ee9f526cc35a6838e1d4ad7e7ba7f0548af3d9` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/Definitions.lean` | `1ca2386528fc7ff944f84088842f62c5f33a38f14cde7ee8127972be29696def` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/FunctionalCalculus.lean` | `5603fb214d01f327ba297af151e278ed8f8310368272c59180dd52ebd87839a1` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/NormBounds.lean` | `1fd4f9d91818470bfee7e3bb164baaaf120b80ee088ff827134be0e2ac867ad3` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/Proof.lean` | `a82ba18b834453491e4d7bb50de23c08555b92bb70e573551d11e714a404984a` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/SpectralNorm.lean` | `af43452f42fde8c361d3ab21c4bcf9839f355b7c06f905dbc56c1eb591c6c5a3` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/Witness.lean` | `4d7d79b742e614712d5ecc052c04df135cde6b6548ec7cb19f6cfbae0ef987b7` |

Machine proof-checks SHA-256: `3a6aee8badf724e92ef3fedca4a0cc30181198b0a56624265450bcae39987fe5`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
