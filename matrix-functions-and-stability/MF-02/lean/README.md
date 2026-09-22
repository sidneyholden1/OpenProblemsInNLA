# MF-02 Lean verification project

The full original uniform constant-factor stage bound covers every multiplication
budget m≥0 and every real gap 0<δ<1. Source exposition: George Stepaniants,
Caltech. The optimized cubic is credited to Chen and Chow, and the prior uniform
asymptotic order to Cheon, Kim and Kim. Formalization: Sidney Holden with OpenAI
Codex assistance. No novelty or source-author endorsement is claimed. Apache-2.0.

The definitions use actual polynomial register histories with all free real
linear combinations and reuse, and actual cubic-composition coefficient lists.
All approximation errors are actual real suprema/infima, with explicit
nonempty/bounded obligations. Each fixed polynomial error is attained. The least
stage is proved feasible and minimal, so conditional-infimum fallback cannot
establish the result. No approximation theorem is a final hypothesis.

Two independent hash-bound statement approvals preceded implementation; see
reviews/statement-gate.json. Definitions, Challenge, numerical contracts,
Comparator configuration and dependency pins remain unchanged. The original
reviewed README and metadata are preserved in reviews/statement-review-snapshot.

Proof modules derive register degree bounds by span induction; compact interval
error attainment; the degree obstruction by odd-part symmetrization, contracting
the even square and applying pinned exterior Chebyshev extremality; exact cubic
critical-point and gap-ratio inequalities; genuine two-product register programs;
constructive error squaring; strict improvement of real infima; and the uniform
stage bounds including budgets zero and one. Solution discharges the polynomial
DegreeBound used as an internal assembly interface with the proved theorem.

LeanCert supplies kernel trust assertions for all seven exports. Exact
polynomial algebra, order and existing Chebyshev extremality avoid interval
subdivision. See NUMERICAL_TARGETS.md for the frozen contracts and verification
for build receipts. The independent Challenge retains seven intentional holes;
the completed Solution must have none.

Acceptance, 2026-09-22: complete local Solution PASS3023; all seven LeanCert
kernel assertions and transitive axiom audits use exactly propext,
Classical.choice, Quot.sound. Both independent nonauthor final reviews pass:
[agent2](reviews/final-referee-agent2.md) and
[new-target referee](reviews/final-referee-2.md).
[Fresh isolated Linux Comparator/default-kernel acceptance](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/35693827256)
checks all seven exports and actual rejection/isolation controls at immutable
proof revision 9aba1c7fed69ad95023b217a28cb486a7b9983ef. [Retained source-bound evidence](../../../docs/lean/verification-2026-09-22/MF-02/README.md)
includes original archive digest and every tracked input hash. The operational
artifact audit is by a proof author and is separate from both independent
mathematical reviews. Reviewed documentation is preserved under
reviews/proof-review-snapshot. AI assistance is disclosed; no external human
peer review or source-author endorsement is claimed.

Shared verification provenance is in tools/lean/NOTICE.md. Existing IE-15 project
organization and kernel audit layout and pinned Mathlib APIs supplied examples.
