# MI-22 independent proof referee 1 — 2026-09-14

PASS — complete local mathematical proof review of all 8 frozen exports, with no blocking finding. Linux Comparator and operational acceptance are separate gates.

This independent AI-agent review applies the relevant Tau Ceti adaptations in `docs/lean/REVIEW.md`: target fidelity, full scope, correctness, edge cases, proof trust, economical computation, actual library semantics, reuse and attribution. It is not official Tau Ceti endorsement or human peer review. Proof inspection began only after both statement approvals and the coordinator's frozen statement gate.

## Source and mathematical audit

I read every active project module in the table below and all Solution wrappers, independently of the other referee. All active bytes match preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, candidate `c08c30f050524f79ef2cdbb001babcd0e93876ba` and the statement gate. The source is deliberately not observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. The original canonical mathematics agrees with that older main, with rendering differences only. The earlier statement review's complete canonical/informal-source and library audit is bound in the evidence and remains unchanged. This reverification does not newly author an existing proof.

The eight exports include complete singular-value semantics, arbitrary-real principal-power semantics, genuine norm bounds, exact witness data, actual root identities, the norm gap and full log-majorization negation. FunctionalCalculus uses positive-definite CFC powers and congruence with an invertible positive matrix; negative powers are handled through actual inverse products. SingularValues proves equality of the first actual adjoint-composition singular value and the Euclidean operator norm by its square, nonnegativity and the antitone Hermitian spectrum. Every multiplicity and zero extension is retained.

Witness proves the disclosed LDL factors and pivots, hence complex positive definiteness; A=D² and B=DT⁸D are the actual matrices. ExactData checks every rational certificate by finite kernel arithmetic with a T²,T⁴,T⁸ addition chain. The test vector has genuine norm one, the entire AB Frobenius sum is bounded, and the selected Nv coordinate exceeds 44000. This agrees with my independent Fraction reconstruction.

The root remains Y=B^(1/8). Its positivity, Y⁸=B and B^(7/8)Y=B follow from the actual CFC composition/addition laws. No factor is improperly commuted. The exact identity LY=N and the trace/eighth-power argument give ‖Y‖<4. A coordinate action bound and genuine submultiplicativity then force ‖L‖>11000; the Gram trace/Frobenius bound gives ‖AB‖<10500. The material numerical_separation certificate connects these strict estimates. The actual first singular-value reversal refutes the mandatory prefix at k=1,n=3, and the admissible t=1/8 instance negates the whole conjecture.

This is the explicitly disclosed rational adaptation of Colbrook's method, not his original printed integer B. That original B, its root-error theorem and 10900/10200 thresholds are not formal exports. The numerical root-enclosure work is avoided by exact powers and a single scalar certificate. Source reuse from MI23/MI29 is acknowledged; no neighboring NLA theorem is imported.

## Fresh execution, trust and evidence

I inspected the coordinator's fresh macOS aarch64 `lake build Solution` receipt and entire log: exit 0, 3163 jobs. I also read referee 2's fresh consumer script, receipt, all printed export types and all axiom closures: exit 0. Every export depends exactly on `propext`, `Classical.choice`, `Quot.sound`. These are their executions, not independent builds by me. I independently checked their script/log hashes, matched the entire Comparator export list and audited the source-to-target paths. No historical PASS is used as fresh execution evidence.

Actual printed term uses LeanCert.Validity.verify_strict_upper_bound_dyadic_checked for 10500 < 11000, constant expression 10500 and upper bound 11000 on [0,0], precision -53 and depth 10. The separately printed _proof_1_7 is of_decide_eq_true (id (Eq.refl true)). Cast normalization uses exact NormNum where needed; it does not replace the checked dyadic certificate.

The relevant pinned Mathlib APIs were read directly; additional CFC, localization, formal-smoothness and polynomial-evaluation APIs are hash-bound where used. Whole library hashes identify the inspected declarations and their proofs; this does not claim every dependency line was read. The comment-aware active-source scan found no holes, custom axioms, native_decide, unsafe or implemented_by. Challenge is outside the active import closure. All frozen boundary and statement-attachment hashes were rechecked.

[referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `49a59a230cfd8d840a589baf44677197e229ca68d0399f612a404498a24c658f`, records the exact active closure, boundary files, additional API hashes, permitted axiom lists and fresh build/consumer/certificate attachments. The independent exact diagnostics from the statement stage remain supplementary, not substitutes for the checked proof. George Stepaniants retains original formalization authorship, Caltech affiliation and AI-assistance disclosure. Source mathematical and library credits are preserved.

No authored proof, metadata, canonical target or frozen statement evidence was modified. This PASS approves the reviewed mathematical implementation and local proof trust. It does not certify the separate Linux sandbox, rejection controls, Comparator identity replay or publication; those require their own actual retained evidence.

## Exact active source hashes

| Source | SHA-256 |
|---|---|
| `matrix-inequalities-and-norms/MI-22/lean/Solution.lean` | `6b37f8df6544f93df123dc746db24c3b3ccd4c6a3e318732ef09946d639e556c` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/Proof.lean` | `9d5140c36dd23c4d726e1f2855cfe4ade18999f868c2df7e7f784eab2bc08c9c` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/SingularValues.lean` | `c942fff572f2dc939348499e0b515d93d25abe11b5d589e76af5577d98bc542f` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/Norms.lean` | `1c83c4e72f57ee06fc74ef0265e5b3947ed9af8dececd52b8809fcb919f9835f` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/FunctionalCalculus.lean` | `6141b8c119733278b6834d04a91a7b2ba5d35530c229fbc269b4189eed15e62d` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/Definitions.lean` | `3a9398c2da3be1c71fd59de483042153cae1af55226f4b61ca9d7bd977ffd8f8` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/ExactData.lean` | `9ca45e5514696f97481169d2c2ac2f4dafd7a1d572a71a0f74e648783c9b1873` |
| `matrix-inequalities-and-norms/MI-22/lean/NLA/MI22/Witness.lean` | `378a5be902ff4cd0a59555de93b3315da9a49c72f69250d9294860d110ca1ff9` |
