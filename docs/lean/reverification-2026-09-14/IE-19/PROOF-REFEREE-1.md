# IE-19 independent proof referee 1 — 2026-09-14

PASS — complete mathematical/source proof review and fresh local execution evidence. No blocking correctness, full-scope or attribution finding.

This independent AI review applies `docs/lean/REVIEW.md` and the relevant adapted Tau Ceti angles; it is not official Tau Ceti or external human peer review. Both statement reviews and the coordinator's gate preceded this proof inspection. Existing authored source is preserved at `deb549fa9ddd6b119e6c59016f268237e645dfa2`; it is deliberately not the observed older upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate revision: `82aee43d2dd0b1ef201134ed8d066b62b7fca890`. The statement report retains the precise source provenance, including FR-12's absence at older main; no new proof authorship is claimed.

## Mathematical proof and frozen scope

I read all three active modules. The proof checks symmetry and all entrywise bounds explicitly and derives the actual erased-index dominance sums from the complete row sum and diagonal value. The conjecture remains weakly diagonally dominant and includes all original parameters; the chosen stricter witness does not change it.

The two rational candidate inverses are checked by actual finite matrix multiplication. Mathlib's isUnit_det_of_right_inverse establishes nonsingularity, and inv_eq_right_inv identifies each candidate with the actual matrix inverse. No totalized singular inverse or an assumed inverse formula enters the result. Every candidate inverse row has its exact NNReal absolute sum proved, and Finset.sup_const with nonempty Fin 3 establishes the full row maximum. These are the actual 7/9 and 5/4 inverse infinity norms, not estimates from one selected entry.

The displayed comparison expression is evaluated at n=3,α=m=1. The explicit-kernel LeanCert scalar point 7/9<5/4 is then materially used in `counterexample_proved`. All parameter and admissibility premises are discharged when the full lower-bound conjecture is instantiated. Projecting the inequality component of the full sharp conjecture yields its negation as well. The three public aliases exactly preserve the frozen contracts.

Exact finite matrix products and equal row sums keep computation small; no general inverse-bound theory, numerical inversion or interval subdivision is required. The manuscript's additional sharp-infimum and nonattainment result is excluded. Colbrook's mathematical counterexample, Stepaniants's formalization credit and original Hillar–Lin–Wibisono question attribution are preserved.

## Exact evidence and execution limits

I independently read all 3 active project modules, including definitions and public exports. The full import closure and every registered export were checked. All active bytes match both the preserved commit and the frozen statement gate, and all gate files matched during this review. A comment-aware executable-source scan found no sorry, admit, custom axiom, native_decide, unsafe or implemented_by. Intentional Challenge placeholders are outside the Solution import graph. All 3 public declarations have actual kernel trust commands.

The coordinator's fresh macOS aarch64 `lake build Solution` completed with exit code 0. I checked its successful log and recorded digest. Referee 2's separate fresh all-export consumer exited 0; I inspected every printed export type and axiom closure. Both fresh logs report only propext, Classical.choice and Quot.sound for all exports. These are their executions, not an additional rebuild by this reviewer. I inspected referee 2’s fresh numerical proof-term output as recorded in the evidence JSON, together with the source-level material dependency described above; that execution belongs to referee 2. The scalar body is Mathlib.Meta.NormNum.isNNRat_lt_true with exact rational arithmetic and Eq.refl true; although the source calls leancert with kernel trust, it does not use a dyadic interval theorem here. Prior diagnostics and historical PASS records are not substituted for current evidence.

All exact active source paths/hashes, boundary hashes, registered exports, actual axiom lists, fresh execution provenance and evidence digests are retained in [referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `4437c4f7df12bd176f7fdf49681ebf88443c34ad94499d0aa2b7707d62c3d05a`. My earlier exact diagnostic remains independently recorded but is not part of a Lean proof. No authored source, metadata or statement was edited by this reviewer.

Actual Linux Comparator statement identity, default-kernel replay, sandbox/rejection controls and original artifact integrity are separate operational gates. This proof report makes no claim that those fresh Linux gates have passed and does not replace their review.
