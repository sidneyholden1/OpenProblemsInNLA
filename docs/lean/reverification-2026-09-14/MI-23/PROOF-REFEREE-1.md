# MI-23 independent proof referee 1 — 2026-09-14

PASS — complete local mathematical proof review of all 8 frozen exports, with no blocking finding. Linux Comparator and operational acceptance are separate gates.

This independent AI-agent review applies the relevant Tau Ceti adaptations in `docs/lean/REVIEW.md`: target fidelity, full scope, correctness, edge cases, proof trust, economical computation, actual library semantics, reuse and attribution. It is not official Tau Ceti endorsement or human peer review. Proof inspection began only after both statement approvals and the coordinator's frozen statement gate.

## Source and mathematical audit

I read every active project module in the table below and all Solution wrappers, independently of the other referee. All active bytes match preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, candidate `8595b5406fc21df98924ce1b5ec486f5ea67f00c` and the statement gate. The source is deliberately not observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. The original canonical mathematics agrees with that older main, with rendering differences only. The earlier statement review's complete canonical/informal-source and library audit is bound in the evidence and remains unchanged. This reverification does not newly author an existing proof.

The eight exports cover the corrected eigenvalue target, not its earlier singular-value version. FunctionalCalculus proves positive definiteness of real powers and both means for arbitrary real exponents. An explicit invertible similarity and charpoly_mul_comm transfer all characteristic roots of a positive-definite product to a positive-definite matrix. The full root multiset, length n, decreasing order, positivity and determinant product are established. Taking real parts is consequently justified; multiplicities are not discarded.

Witness proves the exact LDL and principal-power identities for Colbrook's D,T construction, including T⁸, the two means G,H and actual products G²H²,A²B². Arithmetic checks each addition-chain table, the actual (0,2) entry 1260589125202/9, the complete Frobenius sum and their rational squared gap. These agree with my fresh independent exact diagnostics.

SpectralNorm proves the largest root of X²Y² equals ‖XY‖² by charpoly equality with YX²Y=(XY)ᴴ(XY), positivity and the genuine L2 matrix norm. The positive-dimension condition excludes the empty-list default. NormBounds proves the coordinate bound using a genuine unit basis vector and the Frobenius bound through the entire Gram trace. The material scalar_gap_positive certificate makes the norm-square comparison strict; the proved spectral bridge yields the actual largest-root reversal.

Proof derives the length-three first-prefix failure and instantiates the full original parameter domain at r=s=1,p=2,t=1/8. It does not add a normalized or restricted input hypothesis. The broader positive-power helpers are useful genuine theorems, not assumptions replacing the target. All-parameter failure, valid-region classification and the earlier singular-value conjecture remain excluded. Exact powers eliminate eigenvalue/root enclosures; Colbrook's mathematical authorship and the acknowledged campaign API reuse remain intact.

## Fresh execution, trust and evidence

I inspected the coordinator's fresh macOS aarch64 `lake build Solution` receipt and entire log: exit 0, 3152 jobs. I also read referee 2's fresh consumer script, receipt, all printed export types and all axiom closures: exit 0. Every export depends exactly on `propext`, `Classical.choice`, `Quot.sound`. These are their executions, not independent builds by me. I independently checked their script/log hashes, matched the entire Comparator export list and audited the source-to-target paths. No historical PASS is used as fresh execution evidence.

Actual printed term uses LeanCert.Validity.verify_strict_upper_bound_dyadic_checked for 0 < 99434824489435745411095588895/107495424, constant expression 0 and that rational upper bound on [0,0], precision -53 and depth 10. The separately printed _proof_1_7 is of_decide_eq_true (id (Eq.refl true)). Cast normalization uses exact NormNum where needed; it does not replace the checked dyadic certificate.

The relevant pinned Mathlib APIs were read directly; additional CFC, localization, formal-smoothness and polynomial-evaluation APIs are hash-bound where used. Whole library hashes identify the inspected declarations and their proofs; this does not claim every dependency line was read. The comment-aware active-source scan found no holes, custom axioms, native_decide, unsafe or implemented_by. Challenge is outside the active import closure. All frozen boundary and statement-attachment hashes were rechecked.

[referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `753700446fde07208c0233ca65a4557f34635f61091e7bb8856119d64849415a`, records the exact active closure, boundary files, additional API hashes, permitted axiom lists and fresh build/consumer/certificate attachments. The independent exact diagnostics from the statement stage remain supplementary, not substitutes for the checked proof. George Stepaniants retains original formalization authorship, Caltech affiliation and AI-assistance disclosure. Source mathematical and library credits are preserved.

No authored proof, metadata, canonical target or frozen statement evidence was modified. This PASS approves the reviewed mathematical implementation and local proof trust. It does not certify the separate Linux sandbox, rejection controls, Comparator identity replay or publication; those require their own actual retained evidence.

## Exact active source hashes

| Source | SHA-256 |
|---|---|
| `matrix-inequalities-and-norms/MI-23/lean/Solution.lean` | `575f2fd27922d2725d93ada823bfeb4da70407d7fd9c31fb7cf1753a5fdbd243` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/Proof.lean` | `a82ba18b834453491e4d7bb50de23c08555b92bb70e573551d11e714a404984a` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/Arithmetic.lean` | `d5895f0636fa3aa3887721c610ee9f526cc35a6838e1d4ad7e7ba7f0548af3d9` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/NormBounds.lean` | `1fd4f9d91818470bfee7e3bb164baaaf120b80ee088ff827134be0e2ac867ad3` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/SpectralNorm.lean` | `af43452f42fde8c361d3ab21c4bcf9839f355b7c06f905dbc56c1eb591c6c5a3` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/FunctionalCalculus.lean` | `5603fb214d01f327ba297af151e278ed8f8310368272c59180dd52ebd87839a1` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/Definitions.lean` | `1ca2386528fc7ff944f84088842f62c5f33a38f14cde7ee8127972be29696def` |
| `matrix-inequalities-and-norms/MI-23/lean/NLA/MI23/Witness.lean` | `4d7d79b742e614712d5ecc052c04df135cde6b6548ec7cb19f6cfbae0ef987b7` |
