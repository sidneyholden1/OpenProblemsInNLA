# MI-07 — independent proof referee 2

**PASS — proof source, full frozen-target fidelity and independent local export consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, an independent AI agent, 2026-09-14. This review applies the local Tau Ceti adaptation in `docs/lean/REVIEW.md` across correctness, fidelity, degeneracies, computation reduction, API reuse and attribution. It is not an official Tau Ceti review. The two statement reviews were approved before this campaign's proof inspection. No mathematical source or metadata was edited by this referee.

The reviewed implementation is the preserved published snapshot `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not the observed current upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. This is an independent reverification of George Stepaniants's existing AI-assisted formalization, not a claim of new authorship. Source mathematical credit is Matthew J. Colbrook, with the credits and Apache-2.0 notices retained. Canonical/full informal sources were read in the hash-bound statement review and remain unchanged at the frozen gate.

## Proof inspection and target coverage

The seven exports cover the actual modulus/square-root bridge, identification of maximalModulus from genuine convergence, equivalence with spectral/operator-norm convergence, the witness moduli, all three witness root limits, the all-unitary counterexample, and the original triangle-conjecture negation. The FunctionalCalculus module proves positive-exponent powers of projections from their actual {0,1} spectrum, real scalar power multiplication on PSD matrices, and convergence of powers of a positive definite matrix to the identity. The latter uses positive actual eigenvalues and a fixed unitary eigenbasis; it does not assume a guessed limit or invertibility of a singular projection. The reciprocal indices are r+1, so no zero denominator/exponent ambiguity occurs. Actual sequence convergence is supplied before limUnder_eq is used; the explicit norm bridge uses the intended L2 operator norm, not an arbitrary entrywise norm.

The exact root sequences and positive-definite spanning sum give the genuine three limits. Trace cyclicity and the full unitary identities imply every proposed right side has trace 11/6 while the left side has trace 13/6, hence a gap −1/3 in the PSD difference. LeanCert materially supplies 0<1/3 through a checked dyadic singleton [0,0] certificate at precision −53/depth 10. Its actual auxiliary checker is printed and is of_decide_eq_true (id (Eq.refl true)); no native oracle is used. The proof treats arbitrary complex unitary pairs. It resolves the original negative target, without asserting that no other constant can work or general convergence of arbitrary unrelated sequences.

Mathlib reuse is appropriate: CFC.rpow_eq_cfc_real, finite-spectrum functional calculus, continuousAt_const_rpow for strictly positive eigenvalues, pow_rpow_inv_natCast with the explicit nonzero index, and PSD plus nonzero determinant implying positive definiteness. The short dedicated CFC helpers express meaningful reusable facts rather than restating the counterexample as assumptions.

## Fresh evidence and limitations

I independently inspected the entire active local dependency closure (4 files, 590 lines), excluding duplicated historical snapshots, and compared every active file byte-for-byte with the preserved Git source. Every file in `statement-gate.json` was rehashed unchanged. The coordinator's fresh `lake build Solution` receipt records exit 0 and its retained log hash matches; this full build was run by the coordinator, not by this referee. I then ran my own fresh import consumer using the pinned macOS aarch64 Lean 4.33.1 runtime. It queries the actual type, prints transitive axioms and executes `#assert_trust kernel` for every one of the 7 comparator exports below. Consumer exit is 0; every export has exactly `propext`, `Classical.choice`, `Quot.sound`, with no holes, native reduction axioms or custom axioms. The actual printed types were compared with the approved Challenge signatures and source route. These checks do not replace isolated Linux Comparator statement equality or its sandbox/rejection controls; that remains a separate gate, and no historical Linux PASS is substituted here.

The relevant actual Mathlib definitions and semantics (PSD/MatrixOrder, CFC, norms, spectrum, finite indices and rank where applicable) were inspected in this review and the linked statement review. CFC square-root uniqueness requires the supplied positive square identity; real powers require the supplied nonnegative matrix and nonzero positive indices. For projects using numerical point certificates, LeanCert's checked dyadic theorem derives domain validity and enclosure soundness before strict comparison; the printed Boolean evidence is kernel reduction, not a numerical oracle. This dependency inspection is targeted semantic review, not line-by-line reauditing all of Mathlib or LeanCert. Trust closure and the later Comparator provide separate mechanical coverage.

### Export inventory

- `NLA.MI07.modulus_eq_sqrt` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI07.maximalModulus_eq_of_tendsto` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI07.root_limit_iff_spectralNorm` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI07.witness_moduli` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI07.witness_root_limits` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI07.counterexample` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI07.not_triangleConjecture` — actual type queried, standard-three axiom closure, kernel trust PASS.

### Exact source binding

`referee-2-active-inputs.json` SHA-256: `cd37c4b2add73f91bc745448d7e0cf805feef12312b2d8c4963d930d06658521`. This manifest contains the exact active file paths, byte sizes, line counts and all individual SHA-256 values listed below. `referee-2-proof-checks.json` binds the consumer scripts/logs, fresh coordinator receipt/log, frozen gate and any numerical/row evidence by hash.

| Active module | SHA-256 |
| --- | --- |
| `Solution` | `e460594ac018c8a1e966d88012b07c4ada8743957a414cbdfff8b790d54c07ee` |
| `NLA.MI07.Proof` | `55f400e703994c3967a245495f6ad1ebc1999133cfd748185c81ef263178d8a3` |
| `NLA.MI07.Definitions` | `369e99eaf3df8a8bbfb214973129ab71fbc95445ba9d176e91d52bca3bc46bc5` |
| `NLA.MI07.FunctionalCalculus` | `0963940bbed1818e7b8240129de01e832660f045dbfcabf578fb11d99949553a` |
