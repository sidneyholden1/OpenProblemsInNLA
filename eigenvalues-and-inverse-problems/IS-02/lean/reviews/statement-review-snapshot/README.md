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

Status: statement preparation only. The exact symbolic precheck is supporting
evidence, not a proof. Two independent statement approvals must precede proof
implementation. The pinned official v0.4 formalization manifest and Comparator
configuration advertise four targets with no replaceable definition holes.

Full kernel proof, all-export axiom audits, two independent final reviews and
actual isolated Linux Comparator/default-kernel verification with rejection
controls are required before canonical promotion. Toolchain and dependencies
are pinned; local builds share a pinned cache. Shared workflow provenance:
tools/lean/NOTICE.md. Canonical problem status remains unchanged.
