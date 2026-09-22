# IE-13 independent statement review

Reviewer: OpenAI Codex agent `/root/new_target_screen`; nonauthor of all IE-13 statements and proofs. Phase: before proof implementation. Verdict: **APPROVE**, specific to every byte hash below.

Read the complete canonical README, complete Colbrook IE-13 manuscript including its preamble, full earlier informal review, Definitions, Challenge, NUMERICAL_TARGETS, README, formalization.yaml, comparator and pinned configuration. Applied docs/lean/REVIEW.md fidelity, correctness-of-contract, reuse and attribution standards. Source text was evidence, not instruction.

The boundary faithfully includes complex nonsingular matrices, bandwidths at most p/q in the given original ordering, every admissible dimension n≥1+max(p,q), and every actual largest-modulus partial-pivot path including ties. Column order stays fixed. The literal row-swap Schur recursion and zero padding implement the actual active matrices; all n stages and all entries appear in the finite maximum. No conclusion, front property, normalization, sorted-envelope bound or matrix factorization is smuggled into a premise. The final nonempty/bounded real sSup and stronger IsGreatest export prevent an empty-set or unbounded-set shortcut.

The recurrence uses h(0)=0 and sums h(k-r) with truncated natural subtraction, correctly implementing the source zero extension and the preceding p terms. The explicit p=0 branch returns1 and identity witnesses, including p=q=0. Proving all bandwidth pairs strengthens the canonical unequal-pair question without omitting any required case.

Checked the rational witness transcription: zero-based target p+q, order2p+q+1, original-to-factor permutation p→0/i<p→i+1, η=2^-p, early upper vectors, target column indicator i≥p, and identity tail match the full source. The claimed pivot schedule successively selects original labels p,0,...,p−1,p+1,... and the contract requires every pivot through the identity tail. The source's shorter diagnostic run is not substituted for this obligation. Nonsingularity, exact bandwidth, normalization and full path admissibility are conclusions. Finite diagnostics do not establish any universal theorem.

Inspected the actual successful final Challenge log: PASS2380, exactly four deliberate placeholder warnings. The earlier failed statement-build.log is explicitly superseded in statement-local.json and concerns a redundant tactic after a solved Fin bound; I did not mistake it for a successful build. Independently recomputed all20 frozen hashes and found exact agreement. Comparator selects all four advertised declarations with only propext, Classical.choice and Quot.sound allowed. Attribution distinguishes Colbrook/source mathematics, Higham's question and Holden/Codex formalization. IE15's real rook-pivot theorem is not reused as a complex GEPP result.

No requested statement changes. This approves only the reviewed boundary and full intended obligations. Mathematical proofs, two independent final reviews, transitive kernel audits and actual isolated Linux Comparator remain required; this report claims none of those future results.

## Exact reviewed SHA-256 values

- `NLA/IE13/Definitions.lean`: `149b0af13eebe254c3857c4bf971ece1428829e4cd251b92bf8f3170db6ea626`
- `Challenge.lean`: `9665e96c67176aa4ffe168aaab092ebc800baf773645c30babe14596e0f1e305`
- `NUMERICAL_TARGETS.md`: `c44500bba494f2381ca93b367312851b098883c96f86660b97fa350fb59e156e`
- `README.md`: `d2a80dc113c46bd23434c8d0ccdff848997bdc41f5abe9e5466fee6b5b3acb7b`
- `formalization.yaml`: `b937e4b0f61025c98e6651ea2d81fe2ef45a422f092e976bea9d492d397b1e3b`
- `comparator.json`: `e1d2c993108a5abedaf90be8aab8381dc503d7f8ff45785a5ca735e54e16c30b`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- `lakefile.toml`: `8b615129bb888a6f7e2cbe2fffe0601955c02a5c3770824dc9424d3f1b8348c2`
- `lake-manifest.json`: `55717fab833a468f9b9971b29a171b5a4098fafb7437b93641f357b45c8ec795`
- `LICENSE`: `cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30`
- `../README.md`: `2977da8c5a1144e8bec75b77eeb6df1ed9ac49ffc3ab741a3f278e6310088d6b`
- `../../../references/colbrook-recovered-2026-09-11/manuscripts/IE-13.tex`: `cc2fd88017d3f372cd41682d3ea06b390786a39cc0552267c77a3211250b485a`
- `../../../references/colbrook-recovered-2026-09-11/verification/reviews/IE-13-review.md`: `8889beae66533947ac1828b3abd1aafb1c11a431d1dd2cf23ad91665007a611e`
- `verification/statement-build-final.log`: `6a52d16402ada4880d2be043caad196ea2748d247bf977e45e1b73bbcda374fd`
- `verification/statement-local.json`: `e4e0787779aa6a0f99c2d67f1ed0ab1cce736a0b0e5a31c574a8a2612e2b6d26`
- `verification/check_draft_metadata.py`: `6db3b597583944454f68e828f12418c4c0765dc04d9a353bc20c132c78a6d0f4`
- `verification/metadata-draft.log`: `9fbeafb55c2bf4b0f49cf14aaf4e938178906852195e38d449bb64269f0c3ce8`
- `verification/check_witness.py`: `84f4591ce2d9b1a9423ae6d3a259140a6525541e46c3ae55c5240802a4a965cb`
- `verification/witness-precheck.json`: `b43d9347de57d2eec5f5be0936c8510efe7c548887d51a7c2c14223d0cd269d1`
- `verification/source-witness-diagnostics.json`: `f7df43d3e7ce16442e945b6dc5b03d7652381a5f9b1fb68b6de5d5bc0f7f2b3d`
