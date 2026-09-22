# RA-03 independent proof referee 1 — 2026-09-14

PASS — complete independent mathematical/source proof review and inspected fresh local execution evidence. No blocking correctness, fidelity, scope, computation or attribution finding.

This is an independent AI-agent review under `docs/lean/REVIEW.md`, applying the relevant adapted Tau Ceti angles, not official Tau Ceti or external human peer review. Both independent statement approvals and the coordinator's frozen gate preceded active proof inspection. Authored source is preserved from `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not observed older current upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate revision is `ad84edf4a36673eef141c12bface0802188ef540`. No new authored proof is claimed.

## Mathematical correctness and full frozen scope

All three active modules and four wrappers were read. The explicit entry sum is proved equal to the actual squared Frobenius norm using the correctly scoped nested-L2 matrix norm. Its nonnegativity and zero-iff-zero-matrix property justify the nonzero-residual normalization denominator. The zero branch is handled separately; summing over Option and product labels gives exact one-step mass one.

Full history mass nonnegativity and normalization are proved inductively with the actual first-label/tail equivalence Fin.consEquiv. The same equivalence yields an exact conditional-expectation recurrence for the genuinely defined history residual and mass, without any independence assertion. The nonzero-entry update branch is fixed before evaluation. All four witness entry probabilities and full squared residual errors are calculated from the actual update; the none label's zero mass is removed explicitly. The recurrence then proves the true one-step expectation 18/5.

The spectral bridge identifies the actual Euclidean adjoint composition with the true Gram matrix, and then proves its actual characteristic polynomial. Mathlib's sort_roots_charpoly_eq_eigenvalues acts on the complete root multiset and supplies the genuinely ordered eigenvalues 9,1, retaining multiplicity and dimension. Its actual singular-values API gives square roots 3,1 and the true tail one. No candidate spectrum is assumed or substituted for the target's singular-value definition.

The material scalar comparison 2<18/5 is rewritten through those actual expectation and tail equalities. The full universal conjecture is contradicted with all dimension and rank conditions discharged at n=m=2,k=1. The four public statements exactly match Challenge. Generic finite-law induction and a two-root characteristic polynomial keep Lean computation small; no all-history enumeration in arbitrary dimension or floating spectral approximation is used. The shared source's sharper all-rank/limiting/correlation and Cholesky results remain outside the exports. Colbrook's mathematical proof and Stepaniants's authored formalization remain credited.

## Exact evidence, trust and execution limits

I independently read all 3 active project modules, including definitions and wrappers, and mapped every registered export to its material proof chain. All active bytes match the preserved source and the statement gate, and all gate files remain unchanged. A comment-aware active-source scan found no sorry, admit, custom axiom, native_decide, unsafe or implemented_by. Challenge's deliberate placeholders are outside the active import closure. All 4 public exports have actual kernel trust assertions.

The coordinator's fresh macOS aarch64 `lake build Solution` completed with exit 0; I inspected its successful log and checked its recorded digest. Referee 2's independent fresh all-export consumer exited 0; I inspected the printed types and actual axiom closures. Both fresh logs report only propext, Classical.choice and Quot.sound for every selected export. These executions belong to the coordinator and referee 2, not an additional rebuild by this referee. Historical PASS records are not substituted for fresh evidence.

Actual material numerical route inspected: The printed strict_scalar_gap body uses Mathlib.Meta.NormNum.isNNRat_lt_true for 2 < 18/5 with exact rational arithmetic ending in Eq.refl true. This is a kernel-checked nonnegative rational comparison, not a dyadic interval checker. The source-level consumers are described above, and exact execution receipts and term-log hashes are attached in the evidence JSON. Earlier independent rational diagnostics are retained as supplemental checks, not as mathematical assumptions or universal proofs.

The full active import closure with exact paths/hashes, frozen boundary hashes, all exports and actual axiom lists, fresh execution provenance and evidence digests are in [referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `beef897be97030cc67e464cff29ff6d83621be4dfe8b38c55bea350852c1d88a`. No authored source, metadata or frozen statement attachment was changed by this reviewer.

Fresh Linux Comparator identity, default-kernel replay, sandbox/rejection controls and original artifact integrity remain separate operational gates. This proof review does not claim those Linux gates have passed and does not replace their audit.
