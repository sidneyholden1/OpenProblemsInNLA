# MI-19 independent proof referee 1 — 2026-09-14

PASS — complete independent mathematical/source proof review and inspected fresh local execution evidence. No blocking correctness, fidelity, scope, computation or attribution finding.

This is an independent AI-agent review under `docs/lean/REVIEW.md`, applying the relevant adapted Tau Ceti angles, not official Tau Ceti or external human peer review. Both independent statement approvals and the coordinator's frozen gate preceded active proof inspection. Authored source is preserved from `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not observed older current upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate revision is `6f4c39feaa5ae494168dcc55af250b2acf126a02`. No new authored proof is claimed.

## Mathematical correctness and full frozen scope

The three-module active closure is complete. The actual complex Gram multiplication is proved entrywise, and Mathlib's genuine conjugate-transpose Gram theorem supplies complex PSD and Hermitian symmetry. Finset.univ_perm_fin_succ and the proved decomposeFin equivalence enumerate every permutation; a separately proved six-pair identity reduces the full-order inversion count. The restricted calculation filters the actual setwise-preservation predicate before evaluating terms. It neither assumes an enumeration table nor changes the inversion ordering.

Both actual sums are computed exactly: 335001935775/16384 and 167502585675/8192. Their reality and difference −3235575/16384 are proved by algebra. The scalar strict-gap certificate is explicitly consumed through Complex.real_lt_real, the actual difference identity and sub_neg; the strict comparison is not complex incomparability. All admissibility obligations are discharged in the assembled counterexample, and the entire SubsetConjecture is instantiated at n=4 with the allowed q and proper interior singleton. Both public wrappers preserve the frozen signatures exactly.

The computation is appropriately reduced to 24 permutations, six possible inversion pairs, finite Gram arithmetic and one scalar comparison. No spectral approximation, q-interval coverage or external enumeration axiom is used. The source's rank, all-q public identities and positive-definite perturbation extension remain excluded. Colbrook's mathematical work, Stepaniants's formalization, and existing dependency/workflow credits remain intact.

## Exact evidence, trust and execution limits

I independently read all 3 active project modules, including definitions and wrappers, and mapped every registered export to its material proof chain. All active bytes match the preserved source and the statement gate, and all gate files remain unchanged. A comment-aware active-source scan found no sorry, admit, custom axiom, native_decide, unsafe or implemented_by. Challenge's deliberate placeholders are outside the active import closure. All 2 public exports have actual kernel trust assertions.

The coordinator's fresh macOS aarch64 `lake build Solution` completed with exit 0; I inspected its successful log and checked its recorded digest. Referee 2's independent fresh all-export consumer exited 0; I inspected the printed types and actual axiom closures. Both fresh logs report only propext, Classical.choice and Quot.sound for every selected export. These executions belong to the coordinator and referee 2, not an additional rebuild by this referee. Historical PASS records are not substituted for fresh evidence.

Actual material numerical route inspected: The printed strict_scalar_gap body uses Mathlib.Meta.NormNum.isRat_lt_true and exact rational arithmetic ending in Eq.refl true. This is a kernel-checked signed rational comparison, not a dyadic interval checker. The source-level consumers are described above, and exact execution receipts and term-log hashes are attached in the evidence JSON. Earlier independent rational diagnostics are retained as supplemental checks, not as mathematical assumptions or universal proofs.

The full active import closure with exact paths/hashes, frozen boundary hashes, all exports and actual axiom lists, fresh execution provenance and evidence digests are in [referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `7fc3a0f9ead432b1a59db172a53f30652f263e112047449e56f5477863eb0189`. No authored source, metadata or frozen statement attachment was changed by this reviewer.

Fresh Linux Comparator identity, default-kernel replay, sandbox/rejection controls and original artifact integrity remain separate operational gates. This proof review does not claim those Linux gates have passed and does not replace their audit.
