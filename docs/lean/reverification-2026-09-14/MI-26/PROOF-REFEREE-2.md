# MI-26 — independent proof referee 2

**PASS — proof source, full frozen-target fidelity and independent local export consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, an independent AI agent, 2026-09-14. This review applies the local Tau Ceti adaptation in `docs/lean/REVIEW.md` across correctness, fidelity, degeneracies, computation reduction, API reuse and attribution. It is not an official Tau Ceti review. The two statement reviews were approved before this campaign's proof inspection. No mathematical source or metadata was edited by this referee.

The reviewed implementation is the preserved published snapshot `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not the observed current upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. This is an independent reverification of George Stepaniants's existing AI-assisted formalization, not a claim of new authorship. Source mathematical credit is Matthew J. Colbrook, with the credits and Apache-2.0 notices retained. Canonical/full informal sources were read in the hash-bound statement review and remain unchanged at the frozen gate.

## Proof inspection and target coverage

The seven exports establish the exact admissible-function predicate, genuine spectral CFC and extension independence, quadratic CFC, explicit witness data, the all-unitary counterexample and original universal negation. Concavity is proved for x−x² by the exact nonnegative Jensen gap θ(1−θ)(x−y)² on the full nonnegative half-line. No monotonicity or nonnegative-output condition is silently added to this problem's admissible class. The CFC bridge uses the real spectrum of the Hermitian matrix and derives independence from values below zero using PSD eigenvalue nonnegativity; no custom spectral substitute remains unbridged.

Both rank-one rational projection matrices are PSD by actual Gram factors. Exact multiplication proves the projections' squares and their zero quadratic-function values. Thus arbitrary unitary conjugates on the right remain zero. An explicit nonzero vector gives the actual complex quadratic form 6/5 on the left; this contradicts the PSD order needed for domination. LeanCert's materially used point certificate is 0<6/5, with checked dyadic validity at [0,0], precision −53/depth 10. The exported consumer prints the actual theorem and the separate checker inspection prints its Boolean equality proof as of_decide_eq_true (id (Eq.refl true)). The exact projection reduction is substantially smaller than numerical matrix interval evaluation.

The proof covers the original function class and all complex unitary choices, including the noncommuting witness pair. It does not address the different problem obtained by additionally requiring the concave function to be nonnegative. The CFC composition/subtraction/power APIs and true PSD quadratic form test are applied with their actual hypotheses.

## Fresh evidence and limitations

I independently inspected the entire active local dependency closure (3 files, 360 lines), excluding duplicated historical snapshots, and compared every active file byte-for-byte with the preserved Git source. Every file in `statement-gate.json` was rehashed unchanged. The coordinator's fresh `lake build Solution` receipt records exit 0 and its retained log hash matches; this full build was run by the coordinator, not by this referee. I then ran my own fresh import consumer using the pinned macOS aarch64 Lean 4.33.1 runtime. It queries the actual type, prints transitive axioms and executes `#assert_trust kernel` for every one of the 7 comparator exports below. Consumer exit is 0; every export has exactly `propext`, `Classical.choice`, `Quot.sound`, with no holes, native reduction axioms or custom axioms. The actual printed types were compared with the approved Challenge signatures and source route. These checks do not replace isolated Linux Comparator statement equality or its sandbox/rejection controls; that remains a separate gate, and no historical Linux PASS is substituted here.

The relevant actual Mathlib definitions and semantics (PSD/MatrixOrder, CFC, norms, spectrum, finite indices and rank where applicable) were inspected in this review and the linked statement review. CFC square-root uniqueness requires the supplied positive square identity; real powers require the supplied nonnegative matrix and nonzero positive indices. For projects using numerical point certificates, LeanCert's checked dyadic theorem derives domain validity and enclosure soundness before strict comparison; the printed Boolean evidence is kernel reduction, not a numerical oracle. This dependency inspection is targeted semantic review, not line-by-line reauditing all of Mathlib or LeanCert. Trust closure and the later Comparator provide separate mechanical coverage.

### Export inventory

- `NLA.MI26.admissibleFunction_iff` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI26.functionalCalculus_eq_spectral` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI26.functionalCalculus_congr_nonneg` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI26.quadratic_cfc` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI26.witness_data` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI26.counterexample` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI26.not_subadditivityConjecture` — actual type queried, standard-three axiom closure, kernel trust PASS.

### Exact source binding

`referee-2-active-inputs.json` SHA-256: `dfde7d8dbd22d2c83ad1e53eeb9601752eb164c810293ed9c0f501e0baa32b86`. This manifest contains the exact active file paths, byte sizes, line counts and all individual SHA-256 values listed below. `referee-2-proof-checks.json` binds the consumer scripts/logs, fresh coordinator receipt/log, frozen gate and any numerical/row evidence by hash.

| Active module | SHA-256 |
| --- | --- |
| `Solution` | `a79aa8df0b6b7501dcb6d264fc8a9a21ac0710aa05ed65bff3b244ba97fe6da1` |
| `NLA.MI26.Proof` | `94dd1dde3f1b12002380ae4730ea6396a955f7cbe69a34dde101e7a035fae0af` |
| `NLA.MI26.Definitions` | `821cb1b2a29f7382a1f36bd6b506bc6b249b9da0b61837702658173814995f63` |
