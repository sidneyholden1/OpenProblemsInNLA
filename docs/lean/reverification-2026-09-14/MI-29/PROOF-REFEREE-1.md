# MI-29 independent proof referee 1 — 2026-09-14

PASS — complete independent mathematical/source proof review and inspected fresh local execution evidence. No blocking correctness, fidelity, scope, computation or attribution finding.

This is an independent AI-agent review under `docs/lean/REVIEW.md`, applying the relevant adapted Tau Ceti angles, not official Tau Ceti or external human peer review. Both independent statement approvals and the coordinator's frozen gate preceded active proof inspection. Authored source is preserved from `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not observed older current upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate revision is `312c879a41904f9b4c6f127546e032a74b3c971f`. No new authored proof is claimed.

## Mathematical correctness and full frozen scope

All three active modules were read. The generic spectral-power bridge is exactly CFC.rpow_natCast, including exponent zero. The genuine CFC.abs nonnegativity and abs_sq theorem give the all-matrix modulus identity and its eighth-power reduction via (|X|²)^4. No pointwise matrix power or unproved modulus replacement enters the proof.

The generic positive-real comparison uses a stronger valid route than necessary: A^k is positive definite for every real k when A is positive definite, and the other CFC power is PSD. Their sum is positive definite, so det_pos plus Complex.pos_iff proves both determinant statements. The unused original B/invertibility/nonnegative-exponent binders do not restrict or trivialize the claim; the public theorem retains them. Original admissible inputs still have the intended spectral semantics established in the statement review.

The witness diagonal positivity, Hermitian symmetry, det B=−1/125, actual matrix-ring unit and both failures of semidefiniteness are all proved. The Gram reductions explicitly derive (AB)ᴴAB=BA²B and (BA)ᴴBA=AB²A, preserving the alignment of the products. Every named finite Gram, square and final matrix certificate is verified against actual operations before it is used. Repeated squaring then feeds the genuine three-dimensional determinant formula and produces both exact values and the positive right-minus-left gap.

The scalar certificate is materially consumed in witness_strict_violation through the actual complex gap and its zero imaginary part. All counterexample conclusions are assembled, and the full conjecture is instantiated at n=3,k=6,p=8 with every hypothesis discharged. The five wrappers preserve the frozen scope. Only exact finite products/determinants and one scalar point are computed. No singular-inverse artifact, numerical square root or parameter-domain search is present. Singular-input, known k=2 and positive-B variants remain excluded; Colbrook's mathematical and Stepaniants's formalization credits are preserved.

## Exact evidence, trust and execution limits

I independently read all 3 active project modules, including definitions and wrappers, and mapped every registered export to its material proof chain. All active bytes match the preserved source and the statement gate, and all gate files remain unchanged. A comment-aware active-source scan found no sorry, admit, custom axiom, native_decide, unsafe or implemented_by. Challenge's deliberate placeholders are outside the active import closure. All 5 public exports have actual kernel trust assertions.

The coordinator's fresh macOS aarch64 `lake build Solution` completed with exit 0; I inspected its successful log and checked its recorded digest. Referee 2's independent fresh all-export consumer exited 0; I inspected the printed types and actual axiom closures. Both fresh logs report only propext, Classical.choice and Quot.sound for every selected export. These executions belong to the coordinator and referee 2, not an additional rebuild by this referee. Historical PASS records are not substituted for fresh evidence.

Actual material numerical route inspected: The printed positive scalar gap body uses LeanCert.Validity.verify_strict_upper_bound_dyadic_checked on the constant 0 over [0,0], upper bound 21036678407451/156250000000000, precision -53 and depth 10. The separately printed _proof_1_7 is of_decide_eq_true (id (Eq.refl true)); exact cast congruence supplies the target real inequality. The source-level consumers are described above, and exact execution receipts and term-log hashes are attached in the evidence JSON. Earlier independent rational diagnostics are retained as supplemental checks, not as mathematical assumptions or universal proofs.

The full active import closure with exact paths/hashes, frozen boundary hashes, all exports and actual axiom lists, fresh execution provenance and evidence digests are in [referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `6a63dfa3f3aa6b1b42dcdc57d8ce94d9a153b3a998ed7628debc1bbc0d29b2e3`. No authored source, metadata or frozen statement attachment was changed by this reviewer.

Fresh Linux Comparator identity, default-kernel replay, sandbox/rejection controls and original artifact integrity remain separate operational gates. This proof review does not claim those Linux gates have passed and does not replace their audit.
