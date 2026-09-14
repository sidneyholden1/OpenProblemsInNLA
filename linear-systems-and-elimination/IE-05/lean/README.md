# IE-05 Lean verification

Mathematical counterexample: George Stepaniants, California Institute of
Technology. Original conjecture: John Peca-Medlin. Formalization: Sidney Holden,
Center for Computational Biology, Flatiron Institute, Simons Foundation, with
OpenAI Codex assistance.

The statement boundary covers the complete original universal extremizer
equality through the exact order-eight counterexample. It requires actual
positive-diagonal QR factors, actual GEPP row swaps and Schur recurrences, the
first-available tie rule for the displayed paths, and the genuine growth
supremum over every orthogonal input and admissible tie path.

Status: statements elaborate (2380 jobs), exact integer/Fraction prechecks pass;
both independent statement reviews passed. No proof body or completed verification
is claimed. See `NUMERICAL_TARGETS.md` for scope and computation reductions.

`formalization.yaml` follows the pinned official v0.4 schema. Comparator selects
all four targets, no definition holes, only the three standard Lean axioms.
Two independent final reviews and actual isolated Linux Comparator/default
kernel replay with rejection controls are required before canonical promotion.
Shared workflow provenance is in `tools/lean/NOTICE.md`.
