# MI-04 independent statement referee 2

**APPROVE — statements only.** OpenAI Codex `/root/iv06_statement_referee_2`, an AI nonauthor of this boundary and its future proof, reviewed under `docs/lean/REVIEW.md` on 2026-09-22. This is no claim of human endorsement or completed verification.

## Exact evidence

All 26 inputs in `statement-source-hashes.json` were independently recomputed and matched. The snapshot SHA256 is `3098cac38d80fbe4e2a3a7ec95f221c5e3f1ea7fb73e1fa5d86a99991fd649dd`. The complete per-file hashes, pinned imported-definition hashes and reproducible evidence are in `referee-2-statement-evidence.json`, SHA256 `e681392b82c964c565563d9274ae9ac3cc2e34278ba0d07ee830bf4ebb2c251e`. My Definitions-only probe and independent source/hash script both exited zero. The author-run Challenge build passed 2415 jobs with exactly two intentional placeholders; official draft metadata coverage passed for two exports. These build results are attributed to the author, not my own replay.

## Fidelity and scope

I read the complete canonical README, submission note, original Colbrook manuscript, independent informal review, standalone TeX, Definitions, Challenge, numerical contract, proof plan, metadata and comparison configuration. The original manuscript is embedded unchanged in the standalone TeX, and all five retained source files agree with immutable base `3212647d7b16dd1fc5bf33ed5c2b07a4b156dbf0`.

The original export preserves the full canonical necessity: every complex square matrix of every positive dimension satisfying the universal positive-semidefinite block operator-norm inequality is an affine complex combination of a Hermitian matrix and the identity. No invertibility, normality, simple spectrum or central conclusion is assumed. The additional export gives modulus symmetry for every orthonormal pair. The source's optional converse and other equivalence clauses are explicitly excluded; they are not necessary to answer this canonical question.

The universal predicate quantifies over all Hermitian diagonal blocks and uses the actual adjoint off-diagonal block. Imported Mathlib definitions provide genuine complex positive semidefiniteness and the Euclidean operator norm, not entrywise or Frobenius norms. My probe checked both norm instances by definitional equality, expanded the universal predicate, and proved the scalar and dimension-one endpoint representability. Unit-vector orthogonality uses the actual complex inner product. Pair symmetry can be vacuous in dimension one, but the original theorem remains separately substantive and correctly covers that endpoint. The universal completion premise is meaningful: standard Gram-block completions are available for arbitrary X.

## Plan, reuse and credit

The proposed rescaling/Schur-complement proof has no semantic circularity. Positivity for sufficiently small parameters, the reflected block inequality, the limiting positive-semidefinite cone argument, weighted row/column isolation, normality and collinearity of the spectrum all remain actual proof obligations. They have not been inserted into the public hypotheses. The author's 1320 exact finite rescaling checks were inspected as diagnostics, not treated as independently authored evidence or a universal proof. The all-parameter identities, limiting arguments and endpoints must still be kernel proved.

Mathlib's existing Hermitian, PSD, Euclidean matrix norm and finite-dimensional spectral APIs are appropriate. The source is credited to Matthew J. Colbrook, with the original Bourin–Lee question and Hayashi background distinguished. The documented AI assistance does not imply external referee endorsement. The manifest truthfully describes a draft, and the Comparator lists both exports with the standard three permitted axioms and no definition exceptions.

## Limitations

No active proof implementation was read or authored in this review. Challenge placeholders do not prove the targets. Full proof inspection, exported trust closure, independent final reviews and isolated Linux Comparator execution remain required. I found no blocking statement correction.
