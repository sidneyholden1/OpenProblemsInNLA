# IE-14 Lean statement boundary

Mathematics attributed in the complete source to Matthew J. Colbrook, Cambridge;
the source's substantial AI assistance and reconstruction disclosures are retained.
Higham retains the original problem and tridiagonal comparison credit.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0.
No novelty, external human review or source-author endorsement is claimed.

Scope is the complete canonical target: every complex cyclic tridiagonal input
of every order n≥4, both corners nonzero, actual nonsingularity, original ordering,
every allowed GEPP pivot tie, and every active Schur entry. The actual growth
supremum is F_(n+1)+1 and is attained by the explicit rational family.

Status: four deliberate Challenge placeholders. Two independent statement
approvals are required before proof implementation. Complete local proof,
independent final reviews and actual isolated Linux Comparator checks remain
pending. Canonical status, target, permanent ID and path are unchanged.

See [NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md) for the exact contracts and
planned computation reductions. The complete manuscript and source review are
under `references/colbrook-recovered-2026-09-11` at the repository root.
IE-15's padded-state layout was studied; its real rook-pivot hypotheses are
incompatible and are not substituted for the present complex GEPP definition.
Shared workflow credit remains in `tools/lean/NOTICE.md`.
