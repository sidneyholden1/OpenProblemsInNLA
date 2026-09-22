# IS-02 Lean verification

Mathematical counterexample: Matthew J. Colbrook, University of Cambridge.
Original conjecture: Bassam Mourad and Hassan Abbas. Formalization: Sidney Holden,
Center for Computational Biology, Flatiron Institute, Simons Foundation, with
OpenAI Codex assistance.

The four targets cover the complete negative resolution at order four:
actual admissibility and characteristic polynomial, uniqueness against every
isospectral symmetric stochastic competitor, exclusion from the complete
extreme-point segment locus, and negation of the original universal statement.
See NUMERICAL_TARGETS.md for the exact boundary and computation reductions.

Status: complete local Lean 4.33.1 kernel build passes (3582 jobs), with
all four exports carrying only the three standard axioms. Both independent
frozen-statement reviews passed before implementation. Both independent final proof reviews also PASS, including separate proof
replays and all-export axiom audits. Actual isolated Linux verification remains
pending. Reviewed proof revision: `4beade02`.

The proof uses exact characteristic-polynomial identities in six real variables,
a pruned exhaustive support proof, and elementary algebra to identify all six
permutation copies. Actual extreme-point and closed-segment definitions yield
the exclusion. No graph or spectral property of a competing input is assumed.
LeanCert runs in kernel mode for the retained strict positive-trace obligation;
all exports are audited using LeanCert trust checks. No interval subdivision.

The pinned official v0.4 formalization manifest and Comparator configuration
advertise all four targets with no replaceable definition holes. Reviewed
statement metadata is preserved in reviews/statement-review-snapshot.
Actual isolated Linux Comparator/default-kernel verification with rejection
controls is required before promotion. The exact final-reviewed README and
manifest are retained in reviews/proof-review-snapshot; original proof hashes
remain reproducible through that snapshot.
Toolchain and dependencies are pinned; local builds share a pinned cache.
Shared workflow provenance: tools/lean/NOTICE.md. Canonical status is unchanged.
