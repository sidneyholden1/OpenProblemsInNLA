# MI-03 Lean formalization

Local proof complete. Two independent statement approvals were frozen at
`1546c3bf` before implementation. Solution compiles and all four exports pass
LeanCert kernel-trust and standard-axiom audits. Independent final proof reviews
and actual isolated Linux Comparator verification remain pending.
The canonical status remains Solved.

The target is the complete sharp additive triangle constant for all odd k≥3;
the planned proof establishes k/4 for all k≥2 and genuine nonempty bounded
infima. Norms use the actual Euclidean operator norm, modulus is the positive
square root of AᴴA, and order is positive-semidefinite matrix order.

Mathematical proof: Matthew J. Colbrook. Original question and known upper
bound: Bourin and Lee. Formalization: Sidney Holden with OpenAI Codex assistance.
See NUMERICAL_TARGETS.md and the independent statement reviews. The optional
Hermitian extremizer assertion is outside this formalization.

Local compilation shares a pinned dependency cache. Authoritative verification
requires a fresh isolated Linux Comparator run, kernel replay and rejection
controls, as documented in tools/lean/HARNESS.md. No external human review,
source-author endorsement or priority claim is asserted.
