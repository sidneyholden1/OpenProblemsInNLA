# MI-26 independent proof referee 1 — 2026-09-14

PASS — independent mathematical/source proof review. No blocking source or scope finding.

This is a Tau Ceti–adapted AI review under `docs/lean/REVIEW.md`, not official Tau Ceti review or human peer review. Both new statement approvals and the frozen gate preceded this proof audit. The reviewed implementation is the existing George Stepaniants AI-assisted formalization; this campaign makes no new-authorship or novelty claim. Source base `deb549fa9ddd6b119e6c59016f268237e645dfa2` was deliberately preserved and is not the latest observed upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate commit: `0f21b8856978ca835ca8f7254f372d2b828c7baa`.

## Correctness and full scope

All seven exports are connected to the target: the admissible-function equivalence, genuine spectral CFC formula, independence of extension below zero, the quadratic CFC identity, complete witness data, failure for every complex unitary pair, and the full negation of `SubadditivityConjecture`.

The CFC bridges use the actual Hermitian spectral theorem and finite spectrum, so even the arbitrary function spectral formula is justified by continuity on a finite set. PSD eigenvalues give the half-line extension result. The polynomial bridge uses actual CFC subtraction, powers and identity rather than defining the matrix function to equal the desired polynomial. The concavity of f(x)=x-x² follows from its exact nonnegative Jensen gap on the whole allowed half-line; the source permits real-valued f, so no global nonnegativity condition has been silently imposed.

P and Q are genuine PSD rank-one projections (directions (1,0) and (3/5,4/5)). Exact finite multiplication establishes f(P)=f(Q)=0 and f(P+Q)=F. The nonzero vector has actual quadratic form 6/5 in F. Every proposed unitary right side is therefore zero, and PSD of -F would force -6/5≥0. LeanCert's explicit kernel point `0<6/5` participates in this contradiction. No optimization over unitaries or numerical eigensolver is needed. The stronger positive-definite variant and the different globally nonnegative function class are excluded.

## Evidence and execution limits

The coordinator’s fresh macOS aarch64 `lake build Solution` completed with exit code 0; I checked its recorded log digest and successful completion. This is the coordinator’s execution, not my own rebuild. I independently read referee 2’s fresh consumer output for all exports: each reported only propext, Classical.choice and Quot.sound (ignoring universe annotations). I inspected the printed point proof: it invokes LeanCert.Validity.verify_strict_upper_bound_dyadic_checked with of_decide_eq_true kernel evidence, and source inspection tracks that point into the final contradiction.

The active import closure contains 3 project modules and 7 public Comparator declarations. I independently checked every active file byte against both the preserved source commit and statement gate, and every frozen gate file matched at that check before publication edits. Later publication wrappers are outside this frozen proof-source comparison. A comment-aware scan found no sorry, admit, custom axiom, native_decide, unsafe or implemented_by in active source. Intentional Challenge placeholders are outside the Solution import graph. All configured exports have actual theorem declarations and public kernel trust commands. Historical snapshots and historical PASS records are not substituted for the active closure or fresh execution.

Exact file-by-file active-source hashes, all export names, boundary/configuration hashes, source/execution provenance and evidence digests are in [referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `670190369efb52bc9ec026f7b11316d4f6efe125821d21fc215486afb04d2255`. The separately hash-bound statement report records the complete canonical/informal-source review and actual Mathlib semantic definitions already inspected. No authored source or metadata was changed by this referee.

Actual Linux Comparator acceptance, sandbox/rejection controls and original artifact integrity are separate later operational gates. This report does not claim that those gates have run or passed.
