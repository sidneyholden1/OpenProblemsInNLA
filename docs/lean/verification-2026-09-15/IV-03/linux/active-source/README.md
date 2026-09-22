# IV-03 Lean formalization

This project formalizes the complete retained IV-03 target: for every positive matrix dimension and every ordered pair of real entrywise interval endpoints, the n-squared negative-sign vertex tests characterize the entire interval consisting of inverse M-matrices. It also proves the equivalent two-sign criterion, the exact vertex formula, and vertex admissibility. No interval regularity or nonsingularity hypothesis is added.

Mathematical argument: Matthew J. Colbrook, as recorded in the [canonical page](../README.md) and full manuscript. Formalization: Sidney Holden, with OpenAI Codex assistance.

## Statement boundary and proof

Two independent statement reviews preceded implementation. [The statement freeze](statement-freeze.json) and [numerical plan](NUMERICAL_TARGETS.md) record the precise boundary. Challenge's deliberate placeholders are reference statements and are never imported by Solution.

[Proof notes](PROOF_NOTES.md) explain the full-dimensional induction. The proof derives inverse-M principal and Schur closure, complementary inverse identities, adjugate signs without assuming the matrix invertible, and determinant positivity from proper principal minors and those signs. Hybrid interval matrices and a resolvent comparison transfer the vertex information to every interval member. Explicit one- and two-dimensional arguments establish the induction bases. Exact symbolic arguments avoid interval subdivision or large finite computations.

## Verification status

All four [Solution](Solution.lean) exports compile in the normal 8,804-job build and pass LeanCert kernel trust assertions with only `propext`, `Classical.choice`, and `Quot.sound`. [The local receipt](verification/local-proof.json) records exact source and log hashes. Both independent final reviews passed and are retained in [reviews](reviews/); fresh isolated Linux Comparator/default-kernel verification remains required before publication as Lean verified.

[Comparator](comparator.json) selects all four targets with no definition exceptions. [formalization.yaml](formalization.yaml) records scope and attribution. AI-agent reviews apply the repository's Tau Ceti adaptation; they are not external human peer review or official Tau Ceti endorsement.
