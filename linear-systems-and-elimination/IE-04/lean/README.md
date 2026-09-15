# IE-04 local formalization

All twelve complete-target declarations pass the pinned local Lean build and
LeanCert kernel trust checks. The formalization proves the full negative answer
to the uniform exponential smoothed GEPP tail conjecture using George
Stepaniants's complete proof. Independent final code reviews and the actual
isolated Linux Comparator remain pending. No canonical publication status has
been changed on the strength of this local result.

The result uses every actual largest-magnitude pivot schedule, true finite entry
maxima and their attained supremum, the Euclidean operator norm, and the entire
independent standard-Gaussian matrix law. It covers arbitrary deterministic
centers in the probability-null singularity and tie lemmas. An all-dimensional
identity-centered counterexample violates every proposed pair of constants.
The source's additional zero-centered result is not advertised.

See [PROOF_NOTES.md](PROOF_NOTES.md) for the actual proof bridges and computation
reduction, [NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md) for the frozen contract,
and [formalization.yaml](formalization.yaml) for exact export coverage and
source attribution. The material LeanCert exp(-2)>1/8 certificate is retained
through the final negation; its actual kernel Boolean and dependency path are
recorded in the numerical audit logs under `verification/`.

Reproduce with the pinned Lean toolchain and dependencies using `lake build
Solution`, then `lake env lean verification/ExportAudit.lean`. Local build and
all-axiom receipts are stored in `verification/local-proof.json`. The twelve
intentional Challenge placeholders establish no mathematics; Solution does not
import Challenge. The independently reviewed draft README and metadata remain
in `reviews/statement-review-snapshot/`.

Mathematical argument: George Stepaniants, Caltech. Original conjecture:
Spielman and Teng. Formalization: Sidney Holden with AI assistance. This is not
human peer review, official Tau Ceti endorsement, or source-author endorsement.
Original source pages and permanent problem IDs remain unchanged.

Both independent nonauthor final source reviews now pass; their evidence-packaging follow-up is resolved in [the exact final code gate](verification/final-code-gate.json). Fresh isolated Linux verification remains pending.
