# MI-22 — independent proof referee 2

**PASS — full frozen-target fidelity, proof-source audit and fresh independent local consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, independent AI agent, 2026-09-14. I applied `docs/lean/REVIEW.md` across source fidelity, mathematical correctness, degeneracies, computation reduction, library reuse and attribution. This is the local Tau Ceti adaptation, not official Tau Ceti endorsement or human peer review. Both independent statement approvals preceded this campaign's proof inspection.

This is reverification of George Stepaniants's existing AI-assisted formalization at preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored work or the observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate `c08c30f050524f79ef2cdbb001babcd0e93876ba` preserves the reviewed mathematical bytes. Mathematical credit remains Matthew J. Colbrook, with the original problem and referenced authors credited in the canonical source. Author affiliation and Apache-2.0 notices are retained. No source, metadata or permanent ID was changed by this referee. 

## Actual proof and full target

The eight exports preserve the full complex positive-definite all-dimension weighted singular-value log-majorization target. FunctionalCalculus.lean proves positive powers, invertible congruences and the actual spectral-decomposition formula for every real exponent. SingularValues.lean uses the genuine sorted eigenvalues of the Euclidean adjoint composition to prove first singular value = L2 operator norm, with nonnegativity, ordering and zero tail proved separately. The actual n≥1 hypothesis prevents a missing first value. Norms.lean explicitly selects the L2 matrix norm, proves its equality with toEuclideanCLM, its Gram-square identity, trace/Frobenius bound, coordinate action bound and Hermitian eighth-power norm identity.

Witness.lean verifies positive diagonal pivots, a determinant-one LDL factor and the exact rational factorization of T. It proves A=D² and B=DT⁸D positive definite, then derives the principal powers by CFC.rpow_rpow and inverse identities. Crucially witnessRoot is the actual B^(1/8), with root^8=B and B^(7/8)root=B; it is not an assumed or approximate root. Multiplying the actual left product by this root gives the exact rational N. ExactData.lean verifies all generated rational tables by kernel norm_num, with the T²,T⁴,T⁸ chain, then proves trace(B)<4⁸, a unit-vector test value >44000, and ||AB||_F²<10500². These imply ||root||<4, ||left||>11000 and ||AB||<10500 without calculating a spectral enclosure.

The material numerical_separation term really invokes LeanCert.Validity.verify_strict_upper_bound_dyadic_checked for 10500<11000 on the singleton [0,0], precision −53 and depth 10. Its separately printed Boolean checker proof is of_decide_eq_true (id (Eq.refl true)); the soundness theorem checks expression domain and enclosure before concluding the real inequality. It is consumed by the strict first-singular-value reversal and final universal negation. The counterexample defeats the k=1 prefix, so it need not separately falsify the determinant/full-product clause.

This is the disclosed rational adaptation of Colbrook's method, using T obtained from rounded source root data and B=DT⁸D. It does not claim to certify the original integer B or the original 10900/10200 estimates. Neighboring MI23/MI29 organization is acknowledged and re-proved locally, not imported as an unexplained premise. No all-parameter classification is advertised.

## Independent evidence and limits

I read the complete active local mathematical dependency closure and every Solution wrapper (8 Lean modules), excluding duplicated historical snapshots. The canonical/full informal sources, numerical targets and genuine definitions were read in the frozen statement review. Every frozen gate file was rehashed unchanged, and every active module was compared byte-for-byte with both the immutable candidate and preserved authored base. The exact paths, byte sizes and hashes are retained in `referee-2-active-inputs.json`.

The coordinator's fresh pinned macOS `lake build Solution` passed; I checked its exit-0 receipt, success log and matching log hash. I then independently ran a fresh `lake env lean` consumer importing the actual Solution, querying all 8 exported types, printing every transitive axiom closure and executing `#assert_trust kernel` on each export. That independent consumer returned exit 0. Every export has exactly `propext`, `Classical.choice`, `Quot.sound`; no sorry, native reduction or custom axioms appear in those closures. Actual printed types and the Solution proof routes agree with the approved Challenge boundary. Numerical terms and their actual checker evidence were inspected separately where used. Generator scripts are retained in this audit directory for reproducibility. A separate fresh environment-dependency probe confirms a value-dependency path from the exported universal negation to the material scalar theorem. Its initial diagnostic had a missing Lean Name annotation (exit 1); the original script/log/receipt are retained, and the corrected diagnostic returned exit 0. This was an external inspection-script error, not a project proof error; all export consumers passed on their first run.

The imported Mathlib and LeanCert inspection is a targeted review of the actual semantic APIs and material soundness route, not a line-by-line reproof of every library dependency. All active project proof bodies were read; the standard-axiom consumer supplies separate transitive trust coverage. This report does not establish isolated Linux Comparator identity, default-kernel execution or rejection/sandbox controls. Those require the separate actual operational audit; no historical success is substituted.

## Exports

- `NLA.MI22.singular_values_semantics` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI22.spectral_power_semantics` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI22.euclidean_norm_bounds` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI22.witness_rational_data` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI22.witness_principal_powers` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI22.witness_operator_gap` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI22.counterexample` — type queried; standard-three axioms; kernel trust PASS.
- `NLA.MI22.not_weightedLogMajorizationConjecture` — type queried; standard-three axioms; kernel trust PASS.

## Exact active source hashes

| Source | SHA-256 |
| --- | --- |
| `matrix-inequalities-and-norms/MI-22/lean/Solution.lean` | `6b37f8df6544f93df123dc746db24c3b3ccd4c6a3e318732ef09946d639e556c` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/Definitions.lean` | `3a9398c2da3be1c71fd59de483042153cae1af55226f4b61ca9d7bd977ffd8f8` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/ExactData.lean` | `9ca45e5514696f97481169d2c2ac2f4dafd7a1d572a71a0f74e648783c9b1873` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/FunctionalCalculus.lean` | `6141b8c119733278b6834d04a91a7b2ba5d35530c229fbc269b4189eed15e62d` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/Norms.lean` | `1c83c4e72f57ee06fc74ef0265e5b3947ed9af8dececd52b8809fcb919f9835f` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/Proof.lean` | `9d5140c36dd23c4d726e1f2855cfe4ade18999f868c2df7e7f784eab2bc08c9c` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/SingularValues.lean` | `c942fff572f2dc939348499e0b515d93d25abe11b5d589e76af5577d98bc542f` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/Witness.lean` | `378a5be902ff4cd0a59555de93b3315da9a49c72f69250d9294860d110ca1ff9` |

Machine proof-checks SHA-256: `edfba3272129d7965b773eacfb1db2949d2e0ecfc6aa19b8c13e9cf1c0236694`. That report binds the gate, source manifest, fresh consumer scripts/receipts/logs, numerical evidence and coordinator build by exact hashes.
