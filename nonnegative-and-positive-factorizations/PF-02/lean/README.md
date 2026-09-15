# PF-02 Lean formalization

This project proves the complete negative answer to the [retained PF-02 question](../README.md). The explicit positive integer matrix has ordinary rank six and minimal real PSD factor size three. Its entire factorization space, modulo every invertible real congruence with the specified quotient topology, is disconnected.

The mathematical argument is Matthew J. Colbrook's Theorem 1 in [the complete source](../../../references/colbrook-factorization-2026-09-11/manuscripts/PF-02_disconnected_orbits.tex). Sidney Holden prepared this formalization with OpenAI Codex assistance. Original source attribution and licenses are retained. The optional all-size constructions in the manuscript are unnecessary for the universal negation and are not claimed here.

## Statement and proof boundary

The [numerical plan](NUMERICAL_TARGETS.md), [definitions](NLA/PF02/Definitions.lean), and [Challenge](Challenge.lean) were approved by two independent AI statement referees and frozen in commit `c342dad3` before proof implementation. [The freeze receipt](verification/statement-freeze.json) binds the exact bytes and approvals. Challenge's nine intentional placeholders establish no theorem and are never imported by Solution.

[Solution](Solution.lean) exports all nine reviewed declarations. The proof is divided into [exact matrix certificates](NLA/PF02/Numeric.lean), [general rank and quotient foundations](NLA/PF02/StructuralBase.lean), and [the full orientation obstruction](NLA/PF02/Structural.lean). The sign function is defined on every actual factorization, descends through the genuine quotient topology, and takes both signs. No orientation or nonsingularity assumption is added to the factorization space.

## Computation and trust

Exact integer determinant certificates are transported to the actual real matrices. A ring proof establishes the congruence determinant identity for all nine real matrix entries. Positivity is proved by sums of squares; there is no numerical eigenvalue approximation or interval sampling. Minimality uses the sufficient rank bound `rank M ≤ k²` to exclude sizes one and two.

Every export has `#assert_trust kernel` and a printed transitive axiom audit. [The local receipt](verification/local-proof.json) records successful compilation, unchanged frozen statements, and only `propext`, `Classical.choice`, and `Quot.sound`. These checks use pinned Lean 4.33.1, Mathlib, and LeanCert. They are local macOS checks, not a substitute for isolated Linux verification.

## Reproduction and current status

From this directory, run `lake build Challenge Solution`. The shared Linux runner is `tools/lean/verify.sh`, used by the repository's pinned GitHub workflow. [Comparator configuration](comparator.json) covers all nine exports, permits only the three standard axioms, and has no replaceable definition entries. [formalization.yaml](formalization.yaml) records authorship, scope, sources and actual verification status.

Both independent final code reviews passed. A fresh isolated Linux Comparator/default-kernel run, including rejection and sandbox controls, is still required before publication as Lean verified. The canonical problem status remains unchanged at this stage. AI-agent reviews are not human peer review or endorsement by Tau Ceti or the mathematical source author.
