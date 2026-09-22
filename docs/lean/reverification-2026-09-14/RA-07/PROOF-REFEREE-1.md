# RA-07 independent proof referee 1 — 2026-09-14

PASS — complete independent mathematical/source proof review and inspected fresh local execution evidence. No blocking correctness, fidelity, scope, computation or attribution finding.

This is an independent AI-agent review under `docs/lean/REVIEW.md`, applying the relevant adapted Tau Ceti angles, not official Tau Ceti or external human peer review. Both independent statement approvals and the coordinator's frozen gate preceded active proof inspection. Authored source is preserved from `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not observed older current upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate revision is `6a8aee632957b5a4fbc254d6bc12841ea658dcfe`. No new authored proof is claimed.

## Mathematical correctness and full frozen scope

All six active modules were read. Algebra proves elementary values directly from actual powersetCard sums, including nonempty admissible-cardinality sets and positivity of every product. It expands the actual generating product via Finset.prod_one_add, not an assumed coefficient list, and the derivative coefficient theorem supplies j! e_j. Factorial cancellation in error_as_derivative_ratio uses an explicitly nonzero factorial; it is valid even when later numerators vanish.

Roots proves each original linear factor has degree one, the genuine product degree n and the actual derivative degree n−d. Positive value at zero follows from the positive elementary coefficient and factorial. The original complex roots are forced onto the strictly negative real ray by the actual vanishing product. That ray is proved convex, and Gauss–Lucas is applied only when the preceding derivative has positive degree. The induction covers d=n by applying it to degree one before reaching the constant derivative, rather than invoking a nonconstant theorem on a constant.

Complex splitting is descended to genuine real Splits because every actual complex root lies in the real embedding's range. Splits.eq_prod_roots and natDegree_eq_card_roots then use the full multiset, converted to a finite list with each multiplicity retained. Each μ=−1/r is strictly positive; the exact factor identity X−r=(−r)(1+μX) and evaluation at zero recover the actual normalization constant. The generic factorization lemma also remains correct for zero or constant polynomials; the exported derivative theorem independently proves its positive nonzero scale. No root-count or generic-position assumption enters.

Sums proves the first three derivative formulas by actual finite-product differentiation. A symmetric zero-diagonal double-sum lemma establishes exactly twice the strict-upper-half sum, giving both pair identities without double counting. The denominator is strictly positive because indices 0 and 1 exist and their product is positive. Repeated/equal inputs correctly permit a zero numerator.

Proof shifts actual derivative ratios using the obtained nonzero scale and exact derivative-iteration equality. The chosen derivative order j−1 and factor count n−(j−1)≥2 are proved by arithmetic; the three original ratios become indices 0,1,2 of the factored polynomial. Field cancellation uses proved nonzero denominator factors, and exact algebra produces 2*pairGap/denominator. The final quotient sign proves the entire ConvexityConjecture, including the degree-two upper endpoint and n=3 case. All six wrappers match Challenge. LeanCert supplies actual kernel trust auditing only; no numerical certificate is invented. Strict monotonicity, extra index-one and sampling/application claims remain excluded. Colbrook's mathematics and Stepaniants's formalization credit are preserved.

## Exact evidence, trust and execution limits

I independently read all 6 active project modules, including definitions and wrappers, and mapped every registered export to its material proof chain. All active bytes match the preserved source and the statement gate, and all gate files remain unchanged. A comment-aware active-source scan found no sorry, admit, custom axiom, native_decide, unsafe or implemented_by. Challenge's deliberate placeholders are outside the active import closure. All 6 public exports have actual kernel trust assertions.

The coordinator's fresh macOS aarch64 `lake build Solution` completed with exit 0; I inspected its successful log and checked its recorded digest. Referee 2's independent fresh all-export consumer exited 0; I inspected the printed types and actual axiom closures. Both fresh logs report only propext, Classical.choice and Quot.sound for every selected export. These executions belong to the coordinator and referee 2, not an additional rebuild by this referee. Historical PASS records are not substituted for fresh evidence.

Actual material numerical route inspected: Kernel trust auditing only; no numerical theorem. The source-level consumers are described above, and exact execution receipts and term-log hashes are attached in the evidence JSON. Earlier independent rational diagnostics are retained as supplemental checks, not as mathematical assumptions or universal proofs.

The full active import closure with exact paths/hashes, frozen boundary hashes, all exports and actual axiom lists, fresh execution provenance and evidence digests are in [referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `f2a882d2b86b70f97d4738b726d3d2dfa7a86a311d17d443ebb1fcd40c5aacc3`. No authored source, metadata or frozen statement attachment was changed by this reviewer.

Fresh Linux Comparator identity, default-kernel replay, sandbox/rejection controls and original artifact integrity remain separate operational gates. This proof review does not claim those Linux gates have passed and does not replace their audit.
