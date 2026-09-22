# MF-12 complete Lean verification

Source mathematics: Matthew J. Colbrook, University of Cambridge, with the
source's AI-assistance disclosure. Varney and Morris retain original-question,
projection-reset and tensor-product credit. Formalization: Sidney Holden with
OpenAI Codex assistance. Apache-2.0; no novelty or author endorsement claimed.

Scope: the complete canonical target, every real exponent γ≥0, one fixed
finite nonempty family in a fixed positive dimension, all switching words and
every positive length. Genuine attained maximal L2 operator norms have
positive two-sided polynomial bounds, and their actual nth-root limit is one.
Neither subsequences nor rational-exponent-only statements suffice.

Acceptance, 2026-09-22: complete local Solution build (3,110 jobs), four
LeanCert kernel assertions and exact transitive axiom audits using only
`propext`, `Classical.choice`, and `Quot.sound`. Two independent nonauthor
final reviews pass: [root](reviews/final-referee-root.md) and
[referee 1](reviews/final-referee-1.md).
[Isolated Linux Comparator/default-kernel acceptance](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/35696246513)
checks all four exports and actual rejection/isolation controls at immutable
proof revision `1231b92f2b0235559e5fe5162f6b76d21249ffd0`. The independent nonauthor operational audit
retains original archive/API digests and every tracked input hash in
[source-bound evidence](../../../docs/lean/verification-2026-09-22/MF-12/README.md).
The accepted run is attempt 2; the initial attempt was canceled at the user's
pause request and is not used as acceptance evidence. Reviewed metadata is
retained under `reviews/proof-review-snapshot`; statement-time wrappers remain
under `reviews/statement-review-snapshot`. The four intentional placeholders
are confined to the trusted Challenge, which Solution does not import.

Proof route: exact source compression, finite Hölder and telescoping bounds for
every reset word, logarithmic-gap witnesses padded to every positive length,
genuine finite maxima and the actual root limit. Repeated fixed 2×2 Jordan tensor
factors cover integer parts of arbitrary real exponents. Their larger dimensions
are permitted by the canonical target; no optimal-dimension claim is made.
Entrywise comparisons retain the actual L2 operator norm. LeanCert provides
kernel trust audits; this exact argument needs no interval certificate.

See NUMERICAL_TARGETS.md and verification/check_seed.py for full contracts and
exact rational supporting diagnostics. Diagnostics are not universal proofs.
The complete source at base736845bc is under
references/colbrook-jsr-growth-2026-09-11/manuscripts/arbitrary_growth_exponents.tex.
Shared workflow credit and licenses remain in tools/lean/NOTICE.md.
