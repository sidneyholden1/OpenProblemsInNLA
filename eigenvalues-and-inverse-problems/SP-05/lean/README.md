# SP-05 Lean verification project

Mathematical resolution: Matthew J. Colbrook, University of Cambridge, as
attributed in the complete canonical source. Original conjecture: N.
Kalantarova and L. Tunçel. Formalization: Sidney Holden with OpenAI Codex
assistance. Apache-2.0.

The four exports prove the full original inequality for every dimension at
least two and every real symmetric positive-definite pair A,B. A nonzero real
PSD eigenmatrix attains the global Jordan–Kronecker minimum. Both commutation
sectors use the actual Kronecker Rayleigh quotient; their genuine real infima
are nonempty, bounded below and attained. No commutativity, rank or simple
spectrum restriction is imposed.

Local status, 2026-09-22: complete Solution build PASS (3532 jobs). All four
LeanCert `#assert_trust kernel` checks pass; each transitive axiom closure is
exactly `propext`, `Classical.choice`, and `Quot.sound`. Two independent
nonauthor final reviews and actual isolated Linux Comparator/default-kernel
verification are pending. The canonical page is not promoted by this local
result. These are AI-assisted checks, not external human peer review or
source-author endorsement.

Two independent statement approvals preceded implementation. The
[statement gate](reviews/statement-gate.json) binds all reviewed inputs;
Challenge, Definitions, numerical contracts, Comparator configuration and
dependency pins remain unchanged. The original reviewed README and metadata
are preserved under `reviews/statement-review-snapshot`.

The proof derives PSD preservation of the actual inverse from a spectral
negative-eigenpair contradiction and an invertible congruence. It then proves
a Hermitian top eigenmatrix exists, uses CFC positive and negative parts to
obtain a PSD one, and transports its reciprocal eigenvalue to the global
minimum. Realification preserves positivity and nonzeroness. Compact sphere
minimization proves the sector infima are attained, and exact vectorization
and trace identities assemble the original comparison. LeanCert supplies
kernel trust audits; these exact spectral arguments need no interval search.

Proof modules are under `NLA/SP05`: `Geometry`, `InversePositive`,
`InverseOperator`, `SpectralMaximum`, `ConeEigen`, `ComplexMinimum`,
`Realification`, `Minimum`, `SectorMinima`, and `Comparison`. The independent
Challenge and Solution each expose the same four statements. See
[NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md) for the frozen contracts and
[local build](verification/solution-build-2.log) for the actual kernel result.

The preserved source is the complete SP-05 README and solution.md at base
83a1a140. Existing MI-03 spectral/CFC proofs and MI-29 kernel-audit layout
provide examples; no result from either is assumed. Shared workflow and
dependency credit are in `tools/lean/NOTICE.md`. The exact coordinate script
under `verification` is a supporting diagnostic, not a trusted proof oracle.
