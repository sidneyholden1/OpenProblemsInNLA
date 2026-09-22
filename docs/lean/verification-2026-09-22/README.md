# Lean verification campaign — 22 September 2026

Completed publication milestone, 06:27 UTC: three new complete original targets
are accepted and merged, after statement-first independent reviews, complete
proofs, two independent nonauthor final reviews, LeanCert kernel trust checks,
actual isolated Linux Comparator/default-kernel acceptance and rejection and
sandbox controls. Each project includes official-schema formalization.yaml.

| New full target | Proof exports | Proof evidence | Main merge |
|---|---:|---|---|
| IE-15 | 4 | [Acceptance](IE-15/README.md) | 736845bc |
| SP-05 | 4 | [Acceptance](SP-05/README.md) | c42692a1 |
| MF-02 | 7 | [Acceptance](MF-02/README.md) | 0793f46d |

The [separate consolidation](../consolidation-2026-09-22/README.md) imported
35 historical projects: 34 complete targets and MI-08's explicitly bounded
partial result. Its fresh combined-tree run checked 284 exports and 17,159
tracked input hashes. Those historical projects are not counted as new proofs
in the table above.

At main0793f46d, all 217 original IDs and canonical paths remain unchanged:
39 Lean verified, 52 Solved awaiting full formal verification, 69 Partially
resolved and 57 Open. MF-12 is ongoing and is not counted as complete in this
milestone.

Original ZIPs, GitHub digest metadata, exact source hashes and all checks are
retained separately for proof-head, publication-head and integration runs.
Canceled duplicate/new-branch checks are explicitly distinguished from the
successful required runs; no canceled run is used as acceptance evidence.
Mathematical and formalization attribution remains in each project. AI-agent
review is not external human peer review or source-author endorsement.
