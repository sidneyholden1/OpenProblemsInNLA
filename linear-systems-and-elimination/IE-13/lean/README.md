# IE-13 Lean formalization

Mathematics attributed in the complete source to Matthew J. Colbrook, Cambridge;
substantial AI assistance and reconstruction disclosures are preserved. Higham
retains original-problem credit. Formalization: Sidney Holden with OpenAI Codex
assistance. Apache-2.0; no novelty, external human review or endorsement claimed.

The full dimension-independent complex GEPP growth target is proved for
all nonnegative bandwidth pairs, strengthening the original unequal-pair target.
Both zero-bandwidth cases, every admissible dimension, every allowed pivot tie,
and every intermediate entry are included. The sharp value is 1 for p=0 and
h(p,p+q) otherwise. A rational matrix of order 2p+q+1 attains the bound along its
actual full pivot path. The genuine real growth set is nonempty and bounded,
and its supremum is the stated sharp value.

**Accepted proof, 2026-09-22:** the complete local Solution builds (3,096 jobs).
All four LeanCert kernel assertions and transitive axiom audits pass using only
`propext`, `Classical.choice`, and `Quot.sound`. Both independent nonauthor final
reviews approve the exact frozen candidate: [referee 2](reviews/final-referee-2.md)
and [referee 3](reviews/final-referee-3.md).
[Isolated Linux Comparator/default-kernel acceptance](https://github.com/sidneyholden1/OpenProblemsInNLA/actions/runs/35703222111)
checks all four frozen statements with actual rejection and isolation controls
at immutable proof revision `e8acacba4964ae8c103e808174cc6630d9bd00a1`, attempt 1.
The coordinator is a **coauthor of the mathematical proof** and performed the
separate operational archive/API/input-hash audit; this is not an independent
mathematical review. [Retained evidence](../../../docs/lean/verification-2026-09-22/IE-13/README.md).
The active proof contains no placeholders. Four intentional placeholders remain
only in trusted Challenge, which Solution does not import. Reviewed proof
metadata is preserved under `reviews/proof-review-snapshot`; original statement
metadata remains under `reviews/statement-original`.

[NUMERICAL_TARGETS.md](NUMERICAL_TARGETS.md) records the frozen contracts and
exact rational witness. [UPPER_PROOF_NOTES.md](UPPER_PROOF_NOTES.md) explains
the subset-sum envelope that derives the bound from every literal Schur path.
The witness modules verify actual rational LU factors, nonzero maximal pivots,
row-label transport and the attaining entry. All computation is exact finite
algebra; no numerical interval search is necessary. LeanCert audits the actual
exported proof closures in kernel mode.

The source manuscript and full informal review are retained under
references/colbrook-recovered-2026-09-11 at repository root. IE-14 generic
entrywise and actual-path code was adapted with attribution; IE-15's earlier
padded-state layout was studied. There are no cross-project Lean imports.
Exact finite diagnostics are transcription checks only. Shared reproduction
workflow credit and licenses remain in tools/lean/NOTICE.md.

Reproduce locally with `lake build Solution`. Run the isolated Linux workflow
through the repository's [reproduction guide](../../../docs/lean/README.md).
Author execution receipts are in verification/local-proof-20260922.json;
original reviewed metadata is retained in reviews/statement-original.
