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

Status: the full local Lean 4.33.1 build passes (3581 jobs); all four exports
pass kernel trust checks with only the three standard axioms. Exact prechecks
and both independent frozen-statement and final proof reviews passed. Actual
isolated Linux Comparator verification remains pending.
See `NUMERICAL_TARGETS.md` for scope and computation reductions.

The proof factors all square roots by column, checks integer Gram/QR/LU
certificates in Lean’s kernel, and bounds only the entries needed for a strict
growth gap. Two rational point inequalities use LeanCert with kernel trust.
A general GEPP growth bound proves the actual supremum bounded; the explicit
orthogonal witness proves nonemptiness. No numerical oracle is assumed.

`formalization.yaml` follows the pinned official v0.4 schema. Comparator selects
all four targets, no definition holes, only the three standard Lean axioms.
Both independent final reviews are retained in `reviews/`; their exact reviewed
README and manifest are preserved in `reviews/proof-review-snapshot`. Actual
isolated Linux Comparator/default-kernel replay with rejection controls is
required before canonical promotion.
Shared workflow provenance is in `tools/lean/NOTICE.md`.
