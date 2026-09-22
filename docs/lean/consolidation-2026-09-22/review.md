# Independent consolidation review — 22 September 2026

**Verdict: PASS for the reviewed consolidation, subject to combined-tree CI.** No blocking source, scope, attribution or link finding remains. This approves integration of existing verified work; it does not claim 35 new mathematical results or a new execution of every proof.

Reviewer: OpenAI Codex agent `/root/iv06_statement_referee_1`. I performed the read-only inventory/evidence audit and reviewed the coordinator's imports separately. I contributed to some historical formalizations (PF-02, SP-04 and IE-04), so this is an independent consolidation review, not a replacement nonauthor proof review of those projects. Their separate historical nonauthor final reviews remain retained.

## Exact imports and scope

I independently compared each staged canonical project subtree, evidence directory and required reference bundle with its exact published Git commit, then checked that its working-tree bytes match the index. All 35 comparisons pass. `review-evidence.json` records every exact source commit and path. This includes complete original targets for 34 IDs and the explicitly restricted fixed-list result for MI-08. MI-08 remains **Partially resolved**: adaptive comparison and the general all-dimension optimum are not claimed formalized. IE-15 has no imported Solution or status promotion.

The append-only registry is byte-identical to main `587bd896f0e1006f4a4b7f38555e3a523ef85176`: all 217 IDs and canonical paths remain. Canonical original targets, source credits and historical notices are preserved exactly as in their reviewed publication subtrees. IE-16 and NR-03 validly move beyond main's older partial status because their later complete negative counterexamples are included, with the necessary `references/holden-ie16-2026-09-12` and `references/holden-nr03-2026-09-13` source bundles and distinct mathematical/formalization credit. IE-18, IE-19 and MI-19 already had identical canonical pages and active Lean proofs on main; their only project delta is the neutral reverification notice plus separate audit evidence.

No whole historical branch base was merged. That matters because the reverification branches otherwise bring roughly 22,000 unrelated file changes. The 19,106-file import is instead confined to the selected project/source/evidence paths, including their substantial historical nested evidence. Exact preservation keeps the original artifacts and reviewed-byte claims meaningful. Shared Lean verification tooling, workflows and dependency trust policy are unchanged.

## Evidence audit

Before import, I recomputed all 25 reverification branches' accepted referee/evidence hashes, checked original ZIP hashes and actual Linux control-log hashes/exit statuses/required markers, and confirmed tested-to-published whole-project identity. For the ten original publication branches I checked original ZIP SHA-256 and CRC, actual Comparator/default-kernel/sandbox/rejection logs, permitted standard axioms, and tested active Lean hashes. Fresh GitHub API queries confirmed successful exact-publication-head Lean and permanent-ID workflows for those ten branches. The complete immutable proof/publication identities and URLs are in `inventory.json`.

This is retained-evidence verification, not a duplicate full Lean rebuild. Historic Linux receipts establish the per-project proof claims; combined-tree CI is separately required before the integration is considered complete. The consolidation README accurately distinguishes those gates. No custom axiom or definition-replacement allowance was introduced. Source and formalization authorship—including Stepaniants, Holden, Colbrook and Shao where applicable—remains in the exact imported pages/manifests.

## Links, PDF reproduction and catalogs

The local relative-link scan covered 257 canonical pages, project guides and evidence front-page documents, with **zero missing targets**. Missing source bundles identified during the inventory stage are now present. Immutable external proof-run links remain unchanged; this scan does not assert that every historical external website remains reachable.

I reviewed the renderer diff. It includes only the publication-specific KE-05 original-statement and references breaks, IV-03/IV-06 original-statement breaks with IV-03's references adjustment, and FR-12's references break. The unrelated old-base TR-08 removal and IE-12 addition were excluded. The PDFs and TeX sources are copied byte-for-byte from reviewed publication subtrees; no new PDF rendering or visual-review claim is made here.

The regenerated catalogs contain all 217 IDs and agree with the canonical status counts: **36 Lean verified, 55 Solved, 69 Partially resolved and 57 Open**. The 34 full imported targets overlap three already-verified main targets, explaining the total. RESOLVED's new section explicitly distinguishes complete targets from MI-08 and treats older narratives as dated history. No unrelated status promotion was found.

## Final gate and reproducibility

`review-evidence.json` binds the exact inventory, import receipt, consolidation README, current catalogs, RESOLVED, registry and renderer. Source hashes are additionally bound by each preserved publication commit. The coordinator's required metadata/ID/unit tests and combined CI are separate execution gates; I have not represented the initial system-Python missing-PyYAML attempt as a pass. The environment-corrected tests and CI must pass before final completion. No proof, canonical page or metadata was edited by this reviewer.
