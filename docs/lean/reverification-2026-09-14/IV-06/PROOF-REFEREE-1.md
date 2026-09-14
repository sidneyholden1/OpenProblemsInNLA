# IV-06 independent proof referee 1 — 2026-09-14

PASS — complete local mathematical proof review of all 8 frozen exports, with no blocking finding. Linux Comparator and operational acceptance are separate gates.

This independent AI-agent review applies the relevant Tau Ceti adaptations in `docs/lean/REVIEW.md`: target fidelity, full scope, correctness, edge cases, proof trust, economical computation, actual library semantics, reuse and attribution. It is not official Tau Ceti endorsement or human peer review. Proof inspection began only after both statement approvals and the coordinator's frozen statement gate.

## Source and mathematical audit

I read every active project module in the table below and all Solution wrappers, independently of the other referee. All active bytes match preserved source `deb549fa9ddd6b119e6c59016f268237e645dfa2`, candidate `05dda9e7ac6c222910d7553694ff4b4551aaa2a6` and the statement gate. The source is deliberately not observed older main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. The original canonical mathematics agrees with that older main, with rendering differences only. The earlier statement review's complete canonical/informal-source and library audit is bound in the evidence and remains unchanged. This reverification does not newly author an existing proof.

The eight exports connect the entire original interval matrix family to genuine eigenvalues and actual connected components. The generic eigenvalue/determinant equivalence uses the actual nonzero kernel-vector theorem for λI−A. The empty-dimensional extension has no artificial eigenvalue. The family equivalence derives all seven fixed entries from equal bounds and leaves the other two independent. The generic determinant identity is exact for every a,b,λ.

All four allowed rational eigenpairs are checked, with explicit nonzero vectors, including λ=0. The affine separator calculation proves both bounds for every matrix in the closed box at −1,1,12. Its upper bounds are all at most −18, and the material numerical_separator_margin gives their strict negativity. Therefore each separator is excluded by the actual determinant/eigenvalue equivalence; no grid or sampled-spectrum conclusion is used.

The generic connected-component lemma uses equality in Mathlib's actual ConnectedComponents quotient, the preconnected component's continuous image in ℝ and IsPreconnected.Icc_subset. All six ordered pairs of the four witnesses are separated by an excluded point. This gives an explicit injection Fin 4 into the genuine component quotient, followed by Cardinal.mk_le_of_injective. An infinite component set cannot collapse to zero. Thus 4≤componentCard, hence 3<componentCard, contradicts the dimension-three instance of the complete universal target.

The proof consumes all required numerical and topology bridges with no finite-component, diagonalizability or compactness premise. My independent determinant, corner and six-pair diagnostics match its exact data. Computation is minimized to finite affine arithmetic and one scalar certificate. Exactly four components, endpoint descriptions, determinant-range surjectivity and a sharp general replacement bound remain excluded. Colbrook retains mathematical credit and Hladík–Daney–Tsigaridas the original question credit.

## Fresh execution, trust and evidence

I inspected the coordinator's fresh macOS aarch64 `lake build Solution` receipt and entire log: exit 0, 2918 jobs. I also read referee 2's fresh consumer script, receipt, all printed export types and all axiom closures: exit 0. Every export depends exactly on `propext`, `Classical.choice`, `Quot.sound`. These are their executions, not independent builds by me. I independently checked their script/log hashes, matched the entire Comparator export list and audited the source-to-target paths. No historical PASS is used as fresh execution evidence.

Actual printed term uses LeanCert.Validity.verify_strict_upper_bound_dyadic_checked for -18 < 0, expression neg(const 18) and upper bound 0 on [0,0], precision -53 and depth 10. The separately printed _proof_1_7 is of_decide_eq_true (id (Eq.refl true)). Cast normalization uses exact NormNum where needed; it does not replace the checked dyadic certificate.

The relevant pinned Mathlib APIs were read directly; additional CFC, localization, formal-smoothness and polynomial-evaluation APIs are hash-bound where used. Whole library hashes identify the inspected declarations and their proofs; this does not claim every dependency line was read. The comment-aware active-source scan found no holes, custom axioms, native_decide, unsafe or implemented_by. Challenge is outside the active import closure. All frozen boundary and statement-attachment hashes were rechecked.

[referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `43b0fc37016188e85e43649d745e4c1d26336ed1114da116de95259573d4cb61`, records the exact active closure, boundary files, additional API hashes, permitted axiom lists and fresh build/consumer/certificate attachments. The independent exact diagnostics from the statement stage remain supplementary, not substitutes for the checked proof. George Stepaniants retains original formalization authorship, Caltech affiliation and AI-assistance disclosure. Source mathematical and library credits are preserved.

No authored proof, metadata, canonical target or frozen statement evidence was modified. This PASS approves the reviewed mathematical implementation and local proof trust. It does not certify the separate Linux sandbox, rejection controls, Comparator identity replay or publication; those require their own actual retained evidence.

## Exact active source hashes

| Source | SHA-256 |
|---|---|
| `intervals-and-absolute-value-equations/IV-06/lean/Solution.lean` | `b4b9ab44b95accb5f4a0b677d417937cc0ca9ae6c9f08409b2c178ef0d8f699d` |
| `intervals-and-absolute-value-equations/IV-06/lean/NLA/IV06/Proof.lean` | `600311e699fecc178f921e8233a9c14d50774db5980ea63560040e578d896333` |
| `intervals-and-absolute-value-equations/IV-06/lean/NLA/IV06/Definitions.lean` | `283a31f8e9d100347e5403b8e5688feebd13968d865d487b4962eaa1f861b195` |
