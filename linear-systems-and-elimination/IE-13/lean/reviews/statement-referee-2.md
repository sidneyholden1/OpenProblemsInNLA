# IE-13 independent statement review

**APPROVE — exact full-target boundary, no blocking finding.**

Phase: before proof. Reviewer: OpenAI Codex agent `/root/iv06_statement_referee_2`, an AI nonauthor of this IE-13 boundary and future IE-13 proof. Date: 2026-09-22. This adapts the repository's Tau Ceti review protocol; no external human review or endorsement is claimed.

I read the complete canonical README, complete attributed IE-13 manuscript including preamble and status qualifications, complete informal review, all Definitions and four Challenge signatures, numerical targets, project documentation, manifest, Comparator configuration, pins, and the retained statement-build and finite-check material. All twenty frozen hashes were independently recomputed. Source base is `85490781eb0ca01c4545ded776117d7cb4cf9f52`.

## Fidelity, semantics and nonvacuity

The canonical unequal-bandwidth problem is retained and strengthened to every natural p,q, including p=q and both zero. The dimension lower bound remains n≥1+max(p,q). `IsBanded` imposes exactly the original at-most lower/upper bandwidth restrictions on arbitrary complex entries and actual determinant nonzero. No realness, exact bandwidth, normalization, front invariant, diagonal condition or derived bound is a premise.

`schurStep` uses the current row permutation at pivot k, leaves columns fixed, divides by the actual selected pivot and zero-pads eliminated rows/columns. `isPath` forces the original state, nonzero pivots at all n stages, each selected row active, and maximal complex modulus over the entire active column with weak inequalities retaining ties. Its final recurrence stops after the last used state; unconstrained later states never enter growth. This represents every canonical shrinking Schur path by padding and conversely. Required growth is every active entry at every stage, not just U or pivots. Stored multipliers are correctly excluded. Positive dimension and nonsingularity preclude a zero normalization denominator; the proof must establish that fact.

The pinned complex norm is sqrt(normSq), and Finset.sup is an actual finite supremum fold with bottom zero for nonnegative moduli. `bandGrowths` existentially ranges over all admissible dimensions, inputs and paths. Mathlib's genuine `IsGreatest` contains membership as well as universal domination. `original_target` additionally states nonemptiness and boundedness of the actual real set before identifying its genuine sSup; there is no empty-set escape or custom substitute for the supremum.

The zero-extended recurrence is transcribed correctly: natural subtraction reaching zero uses h₀=0, so the previous-p sum agrees at all early indices. The explicit p=0 branch gives1. The witness has fixed order2p+q+1 and exact rational entries embedded into ℂ; its original-row assignment matches the source. Its candidate pivot positions realize original labels p,0,…,p−1,p+1,… without an extra preliminary permutation. The full-path attainment conclusion includes the identity tail and all nonzero/maximal pivots, a useful strengthening of the manuscript's finite initial-stage diagnostics. For p=0 it is the identity with identity pivots. No assertion about this candidate is hidden in a definition or premise.

## Independent checks and proof feasibility

My separately reconstructed exact rational script checks30 pairs p=0…4,q=0…5, every forbidden structural zero, initial maximum1, the entire prescribed Schur path, every nonzero maximal pivot, nonsingularity via elimination, and exact recurrence growth. These are transcription/nonvacuity checks, not a universal proof. The author/coordinator's larger checks were read as corroboration only. My own Lean Definitions consumer passed with actual modulus, finite-supremum and greatest-element interfaces, a kernel-reduced recurrence example, p=0 branch and padding identity. An initial probe used a wrong unqualified API name and reduction tactic; its failed log is retained and the corrected probe passed. The coordinator's Challenge build PASS2380 with exactly four intentional placeholders was inspected; I did not duplicate that complete build.

The source's sorted-front argument requires an actual row-label/untouched-row invariant, monotonicity under sorting and fresh insertion, and the p-component envelope; all remain proof obligations. The scalar estimate is not a disguised theorem hypothesis. Exact sums, recurrences and complex triangle inequalities are appropriate and avoid artificial interval computation. LeanCert is truthfully planned as a kernel trust audit here. Mathlib finite supremum, determinant, permutation and conditional-completeness APIs are reused; IE-14's complex padded definitions are explicitly credited, without importing an unproved result. Comparator lists all four exports and only the standard three permitted axioms.

Mathematical attribution to Matthew J. Colbrook, original-problem credit to Higham, the source's reconstruction/substantial-AI disclosure, Sidney Holden's formalization credit and Apache licensing are preserved. Documentation correctly describes statements only and pending proof/final review/Linux. Optional closed forms are not separately promised; all required unequal pairs, zero bandwidths, complex inputs and tie paths remain included.

## Limits and exact identity

This approval authorizes proof work only. Four Challenge placeholders prove no mathematics; no active Proof/Solution body has been inspected or authored in this review. Final independent proof reviews, kernel axiom closure and the actual isolated Linux Comparator remain required. The accompanying `referee-2-statement-evidence.json` binds this exact snapshot, imported semantics and every independent script/log.

| Frozen file | SHA-256 |
|---|---|
| `NLA/IE13/Definitions.lean` | `149b0af13eebe254c3857c4bf971ece1428829e4cd251b92bf8f3170db6ea626` |
| `Challenge.lean` | `9665e96c67176aa4ffe168aaab092ebc800baf773645c30babe14596e0f1e305` |
| `NUMERICAL_TARGETS.md` | `c44500bba494f2381ca93b367312851b098883c96f86660b97fa350fb59e156e` |
| `README.md` | `d2a80dc113c46bd23434c8d0ccdff848997bdc41f5abe9e5466fee6b5b3acb7b` |
| `formalization.yaml` | `b937e4b0f61025c98e6651ea2d81fe2ef45a422f092e976bea9d492d397b1e3b` |
| `comparator.json` | `e1d2c993108a5abedaf90be8aab8381dc503d7f8ff45785a5ca735e54e16c30b` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `lakefile.toml` | `8b615129bb888a6f7e2cbe2fffe0601955c02a5c3770824dc9424d3f1b8348c2` |
| `lake-manifest.json` | `55717fab833a468f9b9971b29a171b5a4098fafb7437b93641f357b45c8ec795` |
| `LICENSE` | `cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30` |
| `../README.md` | `2977da8c5a1144e8bec75b77eeb6df1ed9ac49ffc3ab741a3f278e6310088d6b` |
| `../../../references/colbrook-recovered-2026-09-11/manuscripts/IE-13.tex` | `cc2fd88017d3f372cd41682d3ea06b390786a39cc0552267c77a3211250b485a` |
| `../../../references/colbrook-recovered-2026-09-11/verification/reviews/IE-13-review.md` | `8889beae66533947ac1828b3abd1aafb1c11a431d1dd2cf23ad91665007a611e` |
| `verification/statement-build-final.log` | `6a52d16402ada4880d2be043caad196ea2748d247bf977e45e1b73bbcda374fd` |
| `verification/statement-local.json` | `e4e0787779aa6a0f99c2d67f1ed0ab1cce736a0b0e5a31c574a8a2612e2b6d26` |
| `verification/check_draft_metadata.py` | `6db3b597583944454f68e828f12418c4c0765dc04d9a353bc20c132c78a6d0f4` |
| `verification/metadata-draft.log` | `9fbeafb55c2bf4b0f49cf14aaf4e938178906852195e38d449bb64269f0c3ce8` |
| `verification/check_witness.py` | `84f4591ce2d9b1a9423ae6d3a259140a6525541e46c3ae55c5240802a4a965cb` |
| `verification/witness-precheck.json` | `b43d9347de57d2eec5f5be0936c8510efe7c548887d51a7c2c14223d0cd269d1` |
| `verification/source-witness-diagnostics.json` | `f7df43d3e7ce16442e945b6dc5b03d7652381a5f9b1fb68b6de5d5bc0f7f2b3d` |
