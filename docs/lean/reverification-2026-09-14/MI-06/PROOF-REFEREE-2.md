# MI-06 — independent proof referee 2

**PASS — proof source, full frozen-target fidelity and independent local export consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, an independent AI agent, 2026-09-14. This review applies the local Tau Ceti adaptation in `docs/lean/REVIEW.md` across correctness, fidelity, degeneracies, computation reduction, API reuse and attribution. It is not an official Tau Ceti review. The two statement reviews were approved before this campaign's proof inspection. No mathematical source or metadata was edited by this referee.

The reviewed implementation is the preserved published snapshot `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not the observed current upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. This is an independent reverification of George Stepaniants's existing AI-assisted formalization, not a claim of new authorship. Source mathematical credit is Matthew J. Colbrook, with the credits and Apache-2.0 notices retained. Canonical/full informal sources were read in the hash-bound statement review and remain unchanged at the frozen gate.

## Proof inspection and target coverage

The six exports cover the genuine modulus/CFC square-root bridge; six exact witness moduli; a nonzero vector orthogonal to any two complex vectors; the all-unitary quadratic bounds; the fixed witness counterexample; and negation of the original sqrt(2) domination conjecture. The selected rational 3×3 matrices are not a diagonal-only proxy. The kernel dimension argument applies to arbitrary two vectors, even dependent or zero vectors: a complex linear map from dimension three to two cannot be injective. Its nonzero kernel vector has strictly positive squared norm. Positive Gram decompositions and exact square identities establish all CFC square roots. Actual unitary conjugation preserves the identity and transforms the two rank-one directions. On the common orthogonal vector the two upper bounds are each 1/8 times its squared norm; the sum's lower bound is 3/8 times that norm. The strict scalar gap therefore contradicts PSD order for every complex unitary pair.

The material LeanCert step is the exact point inequality 2<9/4, used through Real.sqrt to obtain sqrt(2)<3/2. The final numerical inspection prints both the private theorem and its Boolean checker proof; it uses checked dyadic validity at the singleton interval [0,0], precision −53, depth 10. No large interval search or numerical square root is required. Initial diagnostic attempts to access Lean's private numeric namespace failed, and one attempt encountered an opaque imported declaration; all those logs are retained as failed inspection attempts, not proof failures or acceptance evidence. The successful final inspection independently re-elaborates an exact byte-for-byte copy of the active Proof.lean outside the tested project, with only a diagnostic appendix, then accesses the actual newly elaborated theorem bodies. This bypasses imported private-body opacity without changing any tested source. The independent final export consumer is separate and passes.

Mathlib's CFC.sqrt_unique explicitly requires a nonnegative candidate and a square identity, both supplied. The finite-dimensional argument, quadratic form identities and genuine MatrixOrder bridge eliminate norm-instance and vacuity escape hatches. Full negative target at the specified constant is proved; no claim concerning every possible replacement constant is made.

## Fresh evidence and limitations

I independently inspected the entire active local dependency closure (3 files, 671 lines), excluding duplicated historical snapshots, and compared every active file byte-for-byte with the preserved Git source. Every file in `statement-gate.json` was rehashed unchanged. The coordinator's fresh `lake build Solution` receipt records exit 0 and its retained log hash matches; this full build was run by the coordinator, not by this referee. I then ran my own fresh import consumer using the pinned macOS aarch64 Lean 4.33.1 runtime. It queries the actual type, prints transitive axioms and executes `#assert_trust kernel` for every one of the 6 comparator exports below. Consumer exit is 0; every export has exactly `propext`, `Classical.choice`, `Quot.sound`, with no holes, native reduction axioms or custom axioms. The actual printed types were compared with the approved Challenge signatures and source route. These checks do not replace isolated Linux Comparator statement equality or its sandbox/rejection controls; that remains a separate gate, and no historical Linux PASS is substituted here.

The relevant actual Mathlib definitions and semantics (PSD/MatrixOrder, CFC, norms, spectrum, finite indices and rank where applicable) were inspected in this review and the linked statement review. CFC square-root uniqueness requires the supplied positive square identity; real powers require the supplied nonnegative matrix and nonzero positive indices. For projects using numerical point certificates, LeanCert's checked dyadic theorem derives domain validity and enclosure soundness before strict comparison; the printed Boolean evidence is kernel reduction, not a numerical oracle. This dependency inspection is targeted semantic review, not line-by-line reauditing all of Mathlib or LeanCert. Trust closure and the later Comparator provide separate mechanical coverage.

### Export inventory

- `NLA.MI06.modulus_eq_sqrt` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI06.witness_moduli` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI06.two_vector_orthogonal` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI06.witness_quadratic_bounds` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI06.counterexample` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.MI06.not_dominationConjecture` — actual type queried, standard-three axiom closure, kernel trust PASS.

### Exact source binding

`referee-2-active-inputs.json` SHA-256: `16539394af312a9481e41eb57dc3348c0ee48f5d15f17f96ee91f5959cb91b11`. This manifest contains the exact active file paths, byte sizes, line counts and all individual SHA-256 values listed below. `referee-2-proof-checks.json` binds the consumer scripts/logs, fresh coordinator receipt/log, frozen gate and any numerical/row evidence by hash.

| Active module | SHA-256 |
| --- | --- |
| `Solution` | `389fac775519a84b79b68811e141df5f466e9818469efca889c550e3110b806a` |
| `NLA.MI06.Proof` | `3c1fdf9ba68e850d26d1307ce6ac2a1e9a1037aba5645bda10aa68e7c3d44145` |
| `NLA.MI06.Definitions` | `a89c6604d36aec8ae3428df7663a2dbb6f2f923b13ca5f7746aaf4f424cb29d2` |
