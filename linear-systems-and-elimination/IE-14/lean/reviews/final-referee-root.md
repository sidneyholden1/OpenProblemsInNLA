# IE-14 independent final proof review

**APPROVE — complete original target; no unresolved material finding.**

Reviewer: OpenAI Codex coordinator `/root`, an AI nonauthor of IE-14 statements and mathematical proof implementation. Date: 2026-09-22. This is the repository's adaptation of Tau Ceti standards, not an endorsement or external human peer review.

I read the complete canonical target and attributed source manuscript, the complete informal source review, frozen numerical contract, definitions and four Challenge signatures; then all ten active proof/definition/export files and the final metadata/configuration. I independently recomputed every one of the25 final snapshot hashes and all16 pre-proof statement hashes, using preserved original README/YAML bytes for the two later status updates. The full statement gate has two independent approvals before proof implementation. No mathematical contract was changed afterward.

## Fidelity and proof correctness

The theorem covers every n≥4, every nonsingular complex matrix supported on the ordinary tridiagonal bands plus the two nonzero corners in its original order, and every actual maximal-modulus column pivot path. Weak pivot inequalities retain ties. Actual row swaps and trailing Schur complements define the states. All stage/entry maxima, the initial normalization, the attained greatest member and the nonempty bounded real supremum are genuine Mathlib objects. No front invariant, desired bound, realness, normalization, determinant or pivot legality is inserted as a public hypothesis beyond the original target.

The upper proof derives untouched future nonfinal rows directly from their original structural zeros: these rows have zero earlier multipliers and cannot be selected as nonzero pivots. This proves that each early pivot occupies the current, next or last position. The proof controls the actual current front positions, rather than silently identifying them with original row labels. The three swap cases in `front_update` derive individual and sum envelopes from complex triangle inequalities and the actual column-maximal multiplier bound.

The last column's zero arrivals give Fibonacci recurrences, with the explicit extra unit at the last fresh arrival; the final scalar is bounded by the final pair sum. Ordinary columns have at most two relevant arrivals and are bounded by two. The penultimate column uses a somewhat looser recurrence than the manuscript, still rigorously below the global sharp constant. The all-entry wrapper separately covers padded zeros, the last scalar, both front positions and untouched future entries. The smallest n=4 and empty middle-column ranges are included without a negative Fibonacci index. Positive initial maximum follows from a required nonzero corner.

The witness is the source's literal rational lower/upper product with its original row assignment. `WitnessInput` proves every forbidden entry vanishes, both corners are exactly1 and−1, the initial maximum is1, and the determinant is nonzero by a genuine row equivalence and nonzero triangular factors. The exceptional second and final columns are computed separately. `WitnessPath` proves by induction that every actual padded Schur state equals a truncated LU residual under the derived current-position factor row. The residual identities use triangularity and nonzero diagonals to justify every cancellation. The chosen current pivots are maximal in modulus because all lower-factor entries have modulus at most1; all stages, including the final pivot, are proved legal. The permutation defines the input, never an extra allowed initial operation. The final scalar is exactly F_(n+1)+1.

`Proof` combines the full upper bound with that actual stage entry to establish equality, actual growth-set membership and domination, and Mathlib `IsGreatest.csSup_eq`. There is no conditional central lemma left undischarged in the four exports. My earlier finite all-tie diagnostics are useful transcription checks only, not the universal argument.

## Independent mechanical evidence

I ran the separate `verification/RootFinalConsumer.lean` directly against the compiled final Solution. It elaborates the exact original-form upper theorem, rational attainment, genuine greatest element and real supremum, with F_(n+1)+1 written explicitly. It passed with exit0. Its own four LeanCert kernel trust assertions passed and all four transitive axiom listings contain exactly propext, Classical.choice and Quot.sound. The companion JSON hashes the consumer and raw log.

I inspected the actual successful `verification/solution-build-final.log` (3086 jobs) and separate author axiom log. Earlier failed development logs remain historical evidence and are not treated as successful runs. The active proof closure contains no proof placeholders, custom axioms, native_decide or unsafe proof shortcuts. Challenge's four deliberate statement placeholders are isolated from Solution. Comparator exports exactly the four required results, permits only the standard three axioms and has no replaceable definitions. The actual isolated Linux Comparator has not yet run; this report does not claim that future gate passed.

## Quality, reuse and attribution

Exact finite algebra and recurrence envelopes avoid unnecessary interval evaluation and dimension enumeration. LeanCert is used for actual kernel trust checks, not decorative numeric certificates. The proof separates actual GEPP semantics, quantitative bounds, witness input and witness path; it reuses Mathlib's norm, finite supremum, Fibonacci, triangular determinant, row equivalence and conditional-completeness APIs. IE-15's state-layout inspiration is credited without importing its different real rook-pivot result. Minor tactic lint suggestions do not affect meaning or trust and are not blockers.

The mathematical attribution to Matthew J. Colbrook/Cambridge, Higham's original question, source reconstruction/AI disclosure, Sidney Holden's AI-assisted formalization and licenses are preserved. Metadata truthfully reports local completion and pending independent/Linux acceptance. No novelty, source-author endorsement or external human review is claimed.

## Reviewed identity and limits

This approval is specific to `reviews/proof-source-hashes.json` SHA256 **01160ab473019fa5939a9fdeba4bb9a1aac5c35da4ad478f1c1058dde5f9d40c**. Every bound file is copied into the companion evidence receipt. A second independent final review, actual Linux/default-kernel and isolation/rejection controls, and publication checks remain separate gates. This report authorizes proceeding to those gates; it is not itself a Linux or publication certificate.
