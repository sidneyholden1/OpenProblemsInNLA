# MI-07 independent proof referee 1 — 2026-09-14

PASS — independent mathematical/source proof review. No blocking source or scope finding.

This is a Tau Ceti–adapted AI review under `docs/lean/REVIEW.md`, not official Tau Ceti review or human peer review. Both new statement approvals and the frozen gate preceded this proof audit. The reviewed implementation is the existing George Stepaniants AI-assisted formalization; this campaign makes no new-authorship or novelty claim. Source base `deb549fa9ddd6b119e6c59016f268237e645dfa2` was deliberately preserved and is not the latest observed upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. Candidate commit: `dacf46260eaf39c833da5c0a3207c0349166459a`.

## Correctness and full scope

The seven exports cover the genuine modulus identity, identification of a maximal modulus from an actual limit, equivalence with convergence in the actual L2 operator norm, all six witness moduli, all three root-sequence limits, the all-unitary counterexample, and the full negation of `TriangleConjecture`.

`FunctionalCalculus` proves the needed CFC operations on actual spectra. A PSD projection has spectrum in {0,1}; its rpow identity requires q>0. Scalar homogeneity requires a nonnegative scalar. Convergence of positive-definite matrix powers to the identity follows from strictly positive actual Hermitian eigenvalues, scalar continuity, and finite spectral reconstruction; no invalid zero-eigenvalue limit is used. The witness sum's matrix R is genuinely positive definite (PSD plus nonzero determinant). Reciprocal positive integer exponents tend to zero. Exact CFC root-sequence formulas therefore prove limits P, (5/12)I and (13/12)I before `limUnder_eq` is invoked. The limit selector is not treated as evidence of convergence.

Cyclicity of genuine complex matrix trace and both unitary identities give left trace 13/6, right trace 11/6 and difference -1/3 for every pair of complex unitaries. PSD implies nonnegative real trace, contradicting the material LeanCert kernel point `0<1/3`. The original constant-one question is negated without an added convergence assumption. The source's stronger no-finite-C statement and convergence for every unrelated input are excluded. Exact projection algebra and a single rational point replace numerical matrix limits or spectral approximation.

## Evidence and execution limits

The coordinator’s fresh macOS aarch64 `lake build Solution` completed with exit code 0; I checked its recorded log digest and successful completion. This is the coordinator’s execution, not my own rebuild. I independently read referee 2’s fresh consumer output for all exports: each reported only propext, Classical.choice and Quot.sound (ignoring universe annotations). I inspected the printed point proof: it invokes LeanCert.Validity.verify_strict_upper_bound_dyadic_checked with of_decide_eq_true kernel evidence, and source inspection tracks that point into the final contradiction.

The active import closure contains 4 project modules and 7 public Comparator declarations. I independently checked every active file byte against both the preserved source commit and statement gate, and every frozen gate file remains unchanged. A comment-aware scan found no sorry, admit, custom axiom, native_decide, unsafe or implemented_by in active source. Intentional Challenge placeholders are outside the Solution import graph. All configured exports have actual theorem declarations and public kernel trust commands. Historical snapshots and historical PASS records are not substituted for the active closure or fresh execution.

Exact file-by-file active-source hashes, all export names, boundary/configuration hashes, source/execution provenance and evidence digests are in [referee-1-proof-evidence.json](referee-1-proof-evidence.json), SHA-256 `227f9fe2199612b5ff62630bd30f220494336c3b0e93d988f0ef1af34e01cfc0`. The separately hash-bound statement report records the complete canonical/informal-source review and actual Mathlib semantic definitions already inspected. No authored source or metadata was changed by this referee.

Actual Linux Comparator acceptance, sandbox/rejection controls and original artifact integrity are separate later operational gates. This report does not claim that those gates have run or passed.
