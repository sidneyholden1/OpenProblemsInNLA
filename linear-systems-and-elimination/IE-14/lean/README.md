# IE-14 Lean verification

The complete accepted proof establishes the sharp growth factor F_(n+1)+1 for
every order n≥4. It covers arbitrary complex nonsingular cyclic tridiagonal
inputs with both corners nonzero, every permitted GEPP tie, and every active
Schur entry in the original ordering. The explicit rational family attains
the bound through the literal row-swap elimination path. Nonemptiness,
boundedness, the greatest element and the genuine real supremum are proved.

**Accepted proof, 2026-09-22:** the complete local Solution builds (3,086 jobs).
All four LeanCert kernel assertions and transitive axiom audits pass using only
`propext`, `Classical.choice`, and `Quot.sound`. Both independent nonauthor final
reviews pass: [root](reviews/final-referee-root.md) and
[referee 1](reviews/final-referee-1.md).
[Isolated Linux Comparator/default-kernel acceptance](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/35700510972)
checks all four frozen statements plus actual rejection and isolation controls
at immutable proof revision `9a0117aa8ed40a73b285772b3b1c13864782e95d`. The coordinator, a nonauthor of the
mathematical proof, audited original ZIP/API digests and all tracked source
hashes; [retained evidence](../../../docs/lean/verification-2026-09-22/IE-14/README.md).
The active proof contains no placeholders. Four intentional placeholders remain
only in the trusted Challenge, which Solution does not import. Reviewed proof
metadata is preserved under `reviews/proof-review-snapshot`; original statement
metadata remains under `reviews/statement-original`.

## Proof structure

- `Base.lean` supplies finite entry maxima and actual growth bounds.
- `Front.lean` derives the two-row front and untouched future rows from actual
  complex GEPP and the original sparsity pattern.
- `PairBounds.lean` and `ColumnBounds.lean` control every column history using
  complex norm inequalities and Fibonacci recurrences; `Upper.lean` assembles
  the full all-path upper bound.
- `WitnessInput.lean` proves the rational input's exact pattern, both nonzero
  corners, determinant and initial maximum.
- `WitnessPath.lean` proves the actual swapped Schur states equal truncated
  LU residual sums, every pivot is legal, and the final pivot is F_(n+1)+1.
- `Proof.lean` combines attainment with the upper bound and derives the sharp
  supremum. `Solution.lean` exports the four frozen Challenge statements.

No desired front property, scalar bound, normalization, factorization or pivot
admissibility is assumed in a public theorem. Finite rational diagnostics are
transcription checks only; the Lean proofs quantify over every required order.
The method uses exact finite algebra, avoiding unnecessary interval computation.

## Evidence and reproduction

Run `lake build Solution` with the pinned toolchain and dependencies. The actual
local build is recorded in `verification/solution-build-final.log`. The author's
separate witness audit and exact diagnostics are retained under `verification/`.
The two pre-proof nonauthor approvals and original statement hashes remain in
`reviews/`; `reviews/statement-original/` preserves the approved README and
formalization.yaml before this status update. Mathematical statement bytes and
pinned configuration are unchanged. The root-level shared Lean workflow provides
the required isolated Linux Comparator and rejection controls.

See [NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md) for exact contracts and the
source-to-formalization plan. All four results are listed in formalization.yaml
and comparator.json. The mathematical reviews and accepted proof-run evidence
are retained separately from subsequent publication checks.

## Attribution

Mathematics is attributed in the complete manuscript to Matthew J. Colbrook,
Cambridge; its substantial AI assistance and reconstruction disclosures remain.
Higham retains original-problem credit. Formalization: Sidney Holden with OpenAI
Codex assistance. Apache-2.0. No novelty, external human review or source-author
endorsement is claimed. The complete source and earlier informal review are under
`references/colbrook-recovered-2026-09-11` at the repository root.

IE-15's padded-state proof layout was studied and adapted. Its real rook-pivoting
bound is not used as a complex GEPP result. Mathlib, LeanCert, Comparator and
formalization.yaml retain their licenses and credit; shared workflow attribution
is recorded in `tools/lean/NOTICE.md`.
