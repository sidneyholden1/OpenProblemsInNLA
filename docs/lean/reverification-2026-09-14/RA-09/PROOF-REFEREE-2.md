# RA-09 — independent proof referee 2

**PASS — proof source, full frozen-target fidelity and independent local export consumer.** No material blocking findings.

Reviewer: `/root/iv06_statement_referee_2`, an independent AI agent, 2026-09-14. This review applies the local Tau Ceti adaptation in `docs/lean/REVIEW.md` across correctness, fidelity, degeneracies, computation reduction, API reuse and attribution. It is not an official Tau Ceti review. The two statement reviews were approved before this campaign's proof inspection. No mathematical source or metadata was edited by this referee.

The reviewed implementation is the preserved published snapshot `deb549fa9ddd6b119e6c59016f268237e645dfa2`, deliberately not the observed current upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. This is an independent reverification of George Stepaniants's existing AI-assisted formalization, not a claim of new authorship. Source mathematical credit is Matthew J. Colbrook, with the credits and Apache-2.0 notices retained. Canonical/full informal sources were read in the hash-bound statement review and remain unchanged at the frozen gate.

## Proof inspection and target coverage

All seventeen exports are traced through the sixteen-module active closure: Frobenius semantics/invariance; existence and semantics of actual ordered PSD spectral data; true finite-spectrum CFC and both truncation tails; the trace-deficit reduction; scalar consequences and branch certificates; the ordered scalar inequality; actual harmonic/overlap constraints and error expansions; zero-column, positive-tail and zero-tail closures; and the original universal affirmative conclusion. The theorem accepts every allowed eigenbasis, including repeated and zero eigenvalues. Ordered data is proved to exist for every PSD matrix, eliminating a vacuous custom-predicate interpretation. Frobenius squared is bridged to the genuine rectangular Frobenius norm, entry squares, trace and faithful zero. CFC uniqueness establishes the finite spectral formula for arbitrary selected bases and arbitrary functions on the finite spectrum.

The matrix premise is the original difference of squared norms. The trace-deficit identity proves it implies the residual bound using nonnegative trace of a product of PSD factors; it does not assert that the product is PSD or assume commutation. Actual orthogonal overlaps supply nonnegative weights, full column sums and bounded selected row sums. From Ahat≤A, each positive selected eigenvalue gives diagonal minus rank-one PSD order. Testing the zero diagonal entries proves zero support; testing v_i/a_i then gives the harmonic bound with all zero denominators justified by support. No invertibility assumption is inserted.

Concavity, monotonicity and nonnegativity yield the scalar ratio and threshold inequalities on their full unbounded domain, retaining f(0). Exact sum-of-squares factorization and three exhaustive branches prove the normalized inequality; positive normalization factors justify every cancellation. Averaging consumes the internally proved scalar/harmonic constraints. Selected zero columns retain their actual f(0) contribution. In the positive-tail branch f(tau)=0 is handled separately, showing all relevant nonnegative-spectrum function values vanish. In the zero-tail branch the original premise forces A=truncation(Ahat)=Ahat, and both errors are exactly (n−k)f(0)^2 for any selected null-space basis. The final proof combines excess and tail bounds with ε≥0, without assuming the transfer conclusion.

This is pure exact algebra, finite spectral theory and order. LeanCert supplies kernel trust audits; no numerical interval certificate is represented as part of this unbounded proof. Reuse of Mathlib and locally adapted RA-08 spectral-CFC/orthogonal APIs is explicitly credited, including source hashes and the original Mathlib authors. The OrderedExistence header's historical word 'counterexample' is a nonblocking documentation typo: the declarations and final result are affirmative. The original concave ordered transfer claim is fully covered; the source's broader subhomogeneous class, unordered variant and sharpness discussions are not newly claimed as exports.

## Fresh evidence and limitations

I independently inspected the entire active local dependency closure (16 files, 1932 lines), excluding duplicated historical snapshots, and compared every active file byte-for-byte with the preserved Git source. Every file in `statement-gate.json` was rehashed unchanged. The coordinator's fresh `lake build Solution` receipt records exit 0 and its retained log hash matches; this full build was run by the coordinator, not by this referee. I then ran my own fresh import consumer using the pinned macOS aarch64 Lean 4.33.1 runtime. It queries the actual type, prints transitive axioms and executes `#assert_trust kernel` for every one of the 17 comparator exports below. Consumer exit is 0; every export has exactly `propext`, `Classical.choice`, `Quot.sound`, with no holes, native reduction axioms or custom axioms. The actual printed types were compared with the approved Challenge signatures and source route. These checks do not replace isolated Linux Comparator statement equality or its sandbox/rejection controls; that remains a separate gate, and no historical Linux PASS is substituted here.

The relevant actual Mathlib definitions and semantics (PSD/MatrixOrder, CFC, norms, spectrum, finite indices and rank where applicable) were inspected in this review and the linked statement review. CFC square-root uniqueness requires the supplied positive square identity; real powers require the supplied nonnegative matrix and nonzero positive indices. For projects using numerical point certificates, LeanCert's checked dyadic theorem derives domain validity and enclosure soundness before strict comparison; the printed Boolean evidence is kernel reduction, not a numerical oracle. This dependency inspection is targeted semantic review, not line-by-line reauditing all of Mathlib or LeanCert. Trust closure and the later Comparator provide separate mechanical coverage.

### Export inventory

- `NLA.RA09.frobenius_semantics` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.frobenius_orthogonal_invariance` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.orderedSpectral_exists` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.orderedSpectral_semantics` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.functionalCalculus_spectral` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.truncation_semantics` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.trace_deficit_reduction` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.admissible_scalar_consequences` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.scalar_branch_certificates` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.ordered_scalar_certificate` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.harmonic_constraint` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.overlap_semantics` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.overlap_error_expansions` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.zero_column_average` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.positive_tail_transfer` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.zero_tail_closure` — actual type queried, standard-three axiom closure, kernel trust PASS.
- `NLA.RA09.concaveFrobeniusTransferConjecture` — actual type queried, standard-three axiom closure, kernel trust PASS.

### Exact source binding

`referee-2-active-inputs.json` SHA-256: `af3fa4783ed0124f81b20b3b455d51f53f8c1f8cc5c3cc0e9267d63ca4aa40d6`. This manifest contains the exact active file paths, byte sizes, line counts and all individual SHA-256 values listed below. `referee-2-proof-checks.json` binds the consumer scripts/logs, fresh coordinator receipt/log, frozen gate and any numerical/row evidence by hash.

| Active module | SHA-256 |
| --- | --- |
| `Solution` | `fc80b094cc7c7cb519e5f812066a87e29e8283cd8f9858ef6f3d04c9f5e2bbbb` |
| `NLA.RA09.Proof` | `1661afe661293f8b19e83714b6bc25a076ce10109875d79e9c118f9291e565bd` |
| `NLA.RA09.Transfer` | `45eac6374a1c836b89e903f218a45c9f3857e3f502528cdb02fb64a8367c6292` |
| `NLA.RA09.OverlapOrder` | `be16577398f0dfbedcd41d5fa22b105f961dffccffe2aa8eda633f5ead72923c` |
| `NLA.RA09.Overlap` | `759490c0b1a3a17eff13a683fae049474913ed2eec03f5dfa1e9c6722e06c173` |
| `NLA.RA09.Spectral` | `5a5cb2bb37b3c78f6e794420b9b54d7c97a94ad3824d7acdef61f17988969c45` |
| `NLA.RA09.Frobenius` | `f2d038d3d2f5195074ab5acc973771aaf57782d9ce9271c6fbc7132f8178c6ad` |
| `NLA.RA09.Definitions` | `2a9b0d9d536bc2620fbe3814ed95640caeae8a49e8b13a9e2136b469ba09ece9` |
| `NLA.RA09.SpectralCFC` | `b80049d98243a1cd19cac41ac28775f1e0f07ebb626963131f2e79ed257ab89d` |
| `NLA.RA09.OrderedExistence` | `beca9c7b9ca9c4b4b467acbbbe13acd3e25507c4653a71ab9a480494726a1631` |
| `NLA.RA09.Harmonic` | `629f355ef949d3f11acbba443fe1ba8a77d7ac89fb10e76f223ef5a47e7be91e` |
| `NLA.RA09.Averaging` | `1893a4f432261ead1efd291564ac1b3ba9a1be5cb59c74d755e01a9c5a5b2eb9` |
| `NLA.RA09.Scalar` | `be27edbd0f42e83fb825095bae65c48c8d90e8d1614ed90871abace1f55b6f17` |
| `NLA.RA09.TailScale` | `83b9619cadb1f02b19d38b3efce0cb0217a3c288796d492157a0bee629899729` |
| `NLA.RA09.ZeroColumn` | `c5a21c431bc1118466097e9e761c9c95e113162c69379b397c8e76ec21038c00` |
| `NLA.RA09.ZeroTail` | `45ccfc67b7c59ce13d38d2822c69c36bd36519a9516798ca9d02074cb5e61dae` |
