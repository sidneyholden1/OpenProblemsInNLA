# IE-23 Lean formalization

This project formalizes a complete negative answer to [IE-23](../README.md).
For the source's exact complex 2×3 matrix, the Moore–Penrose inverse and a
distinct right inverse both have induced 4-to-2 norm 2^(1/4). The exponent 4
belongs to the original finite range p>2, so one example negates the full
universal uniqueness claim.

Mathematical argument: Matthew J. Colbrook. The source credits the smallest
matrix to Dokmanić and Gribonval's spectral-norm example. Formalization:
Sidney Holden, with OpenAI Codex assistance. The source's stronger all-p
formula and complete minimizer classification are outside this formalization.

The proof uses actual conjugate transpose and matrix inverse, all nonzero
complex test vectors, and actual real suprema. It proves nonempty bounded ratio
sets and positive denominators, derives the universal quartic norm bound, and
attains it at (1,-1). Exact algebra suffices throughout. LeanCert audits kernel
trust; no numerical subdivision or interval computation is required.

Statements were frozen at `881f8871` after two independent AI statement reviews
and successful type-checking. Local proof compilation and kernel-trust checks
have passed. Both independent final proof reviews and all three exported axiom audits
passed. Actual isolated Linux Comparator checks are pending. The canonical status remains Solved.

See [NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md), [formalization.yaml](formalization.yaml),
[reviews](reviews/) and [verification](verification/). No external human peer
review, source-author endorsement or historical-priority claim is made.
