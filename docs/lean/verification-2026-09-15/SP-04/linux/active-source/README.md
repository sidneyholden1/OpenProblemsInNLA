# SP-04 Lean formalization

This project proves the complete negative answer to the [retained SP-04 question](../README.md). A nonempty open set in the full space of real three-by-three matrices has a unique least absolute stationary multiplier whose feasible matrix is not nearest. Every nonzero polynomial fails to exclude all these counterexamples, refuting the algebraic-generic rule in the original question.

Mathematical argument: Matthew J. Colbrook, [complete source](../../../eigenvalues-and-inverse-problems/SP-04/solution.tex). Formalization: Sidney Holden, with OpenAI Codex assistance. No source-author endorsement or human peer review is asserted.

## Reviewed boundary

The [numerical plan](NUMERICAL_TARGETS.md), [definitions](NLA/SP04/Definitions.lean) and [Challenge](Challenge.lean) were approved by two independent statement referees before implementation and frozen at `03b0c979`. [Exact boundary and report hashes](verification/statement-freeze.json) remain unchanged. Challenge's nine deliberate placeholders establish no result and are never imported by Solution.

## Proof and computation

[Scalar](NLA/SP04/Scalar.lean) proves the full multiplier exclusion, selected negative root and all-eight-pattern uniqueness. Two exact rational point certificates use LeanCert kernel mode; splitting at c=2/5 gives simple root bounds and avoids square-root interval searches. The reviewed c and singular-value domains remain unchanged. A strict sign flip supplies an actual better feasible competitor.

[MatrixReduction](NLA/SP04/MatrixReduction.lean) derives diagonal stationary matrices from the original matrix equations; [MatrixOrbit](NLA/SP04/MatrixOrbit.lean) and [MatrixProof](NLA/SP04/MatrixProof.lean) transport all-stationary uniqueness and the actual squared Frobenius comparison under arbitrary orthogonal transformations.

[TopologyProof](NLA/SP04/TopologyProof.lean) uses six independent left/right skew directions and three diagonal directions. The derivative is invertible because the positive singular parameters are distinct. Matrix exponentials remain orthogonal, and the inverse function theorem proves openness in all nine real matrix entries. [PolynomialProof](NLA/SP04/PolynomialProof.lean) applies the analytic identity theorem on that full space to avoid every nonzero polynomial exception. No diagonal-locus or finite-sample genericity shortcut is used.

## Current verification status

[Solution](Solution.lean) independently exports all nine Challenge signatures. The local build passed 8799 jobs, all nine LeanCert kernel trust assertions and printed transitive axiom audits; only `propext`, `Classical.choice` and `Quot.sound` occur. [Local receipt](verification/local-proof.json). Historical failed development logs are diagnostics, not acceptance evidence; the final successful build supersedes them.

Independent final code reviews and a fresh isolated Linux Comparator/default-kernel run with actual rejection and sandbox controls remain pending. The canonical problem status is unchanged. [Comparator](comparator.json) covers all nine targets with no definition exceptions; [formalization.yaml](formalization.yaml) records scope, credit and current status. Run `lake build Challenge Solution`; authoritative Linux verification uses the shared `tools/lean/verify.sh` harness. AI-agent review is not external human peer review or official Tau Ceti endorsement.
