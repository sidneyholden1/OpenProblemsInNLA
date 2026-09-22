# MI-08 independent final referee 2

- Phase/date: final proof review, 2026-09-14.
- Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of implementation; not human review or official Tau Ceti service.
- Verdict: **PASS for the stated partial scope and local proof review**, bound to these exact hashes. No blocking finding. Adaptive equivalence and the all-dimension optimum are excluded.
- Actual isolated Linux Comparator/default-kernel replay and rejection controls remain pending. This report does not claim that gate passed or authorize canonical promotion.
- Protocol: `docs/lean/REVIEW.md`; correctness, fidelity, degeneracy, optimization, reuse and attribution covered. Usage checks during review showed 26% remaining, above the requested stop threshold.

## Immutable scope and source

I read all of Correspondence, Designs, Proof and Solution, the actual boundary and current README/manifest, alongside the complete canonical README, solution.md and solution.tex inspected in the preceding statement review. All 17 proof-source snapshot hashes match. All three mathematical boundary files match frozen `607a5e4a`; the three complete canonical sources match base `9777c86853b40206f70438c92a47a7dec9bc66ae`. Preserved statement README and manifest match their earlier reviewed hashes. No source or metadata was edited.

The result remains explicitly partial: fixed-list sign-design correspondence for all positive dimensions and row counts; rank/divisibility obstructions; the explicit order-twelve certificate; and least feasible fixed length twelve for every dimension 9–12. The source's stronger adaptive comparison is not exported, and no all-dimension optimum or complete resolution of MI-08 is asserted. The original all-real-X quantifier and fixed list outside it remain unchanged.

## Fixed lists and integer signs

`conjugate_unit` establishes the actual entry formula for U Eab Uᵀ using Matrix.single. `factors_diagonal` applies the fixed averaging identity to Ejj and reads coordinate (i,i), i≠j. The real reciprocal 1/q is nonzero because FixedPinching explicitly requires q>0. The resulting sum of real squares is zero. I inspected Mathlib's sum_mul_self_eq_zero_iff: it uses nonnegativity of every square and forces every summand's underlying entry to zero. Thus every factor is proved diagonal; diagonality is not an assumed admissibility restriction.

`factor_signs` reads the diagonal coordinate of actual UᵀU=I. The proved off-diagonal zeros collapse its sum to one diagonal square; the real equation x²=1 gives exactly ±1. `fixed_to_design` chooses the matching integer sign and proves its real cast equals the original diagonal entry. Applying the universal identity to Eij for every ordered pair (including nonsymmetric units when i≠j) gives the actual column Gram sum. Exact casts transport it to the integer matrix equation HᵀH=qI. No real-to-integer rounding, modular equality or extra restriction on U occurs.

`design_to_fixed` constructs one list of real diagonal matrices from the integer signs, proves actual orthogonality, and proves the average for an arbitrary real matrix X entry by entry. The entire matrix, not just its symmetric part, is quantified. It uses the exact cast Gram identity and a proved nonzero q before cancellation. The positive-dimension premise of the exported equivalence is unused because the helpers are stronger; retaining it matches the frozen canonical scope and is harmless. q=0 is excluded wherever averaging requires division, so no zero-denominator escape exists.

## Rank, rectangular divisibility and explicit certificate

The rank proof operates directly over ℤ. I inspected Matrix.rank, rank_smul_of_mem_nonZeroDivisors, rank_mul_le_left and rank_le_width. Rank is the finite rank of the actual image module; scaling by a non-zero-divisor preserves it via an injective module map. Since q>0 gives q≠0 in the integral domain ℤ, qI has rank d, and rank(HᵀH)≤rank(Hᵀ)≤q. The strong rank condition required by the inequalities holds over ℤ. This resolves an unnecessarily restrictive suggestion in my statement report to cast to a field: no field cast is needed, and the code does not mistakenly treat ℤ as a field. The actual general ring API proves the desired bound. For d=0 the conclusion remains valid.

For d≥3, three distinct columns exist and the proof reads all three off-diagonal Gram equations. It adapts Mathlib's Hadamard divisibility calculation to rectangular columns: each (1+ba)(1+ca) is divisible by four for integer signs; summing its expansion gives q. This needs no square completion or row orthogonality. The adaptation and Dennj Osele attribution are explicit in the file and manifest. I compared it with the actual imported proof.

`twelve_integer_certificate` unfolds the genuine sign and Gram predicates on the exact Paley matrix and uses `decide +kernel`. The ordinary kernel checks the entire finite integer certificate. The prior independent exact diagnostic verified the actual natural-number subtraction/modulo formula, source residues, and Gram restrictions; it remains supporting evidence only. `restrict_design` proves the column Gram identity for any injective column map and preserves every sign. Fin.castLE supplies that injection for every d≤12.

## Actual least feasible length

`finite_minimums` obtains the restricted design and turns it into an actual length-twelve list satisfying FixedPinching. It therefore proves membership of 12 in the genuine feasible-length set. For every arbitrary feasible q, it extracts the integer design, obtains q≥d and 4∣q, and concludes q≥12 using d≥9. This quantifies all possible competing lists and lengths. Nonemptiness and IsLeast are explicit; the infimum equality follows from actual leastness via IsLeast.csInf_eq, not an empty-set convention. The entire interval 9≤d≤12 is covered, including endpoints.

## Independent replay, trust and remaining limits

I independently elaborated Correspondence, Designs, Proof and Solution with pinned Lean4.33.1 and the existing dependency cache. All four exit codes were zero; no warnings appear in `verification/final-referee-2-elaboration.log`. I separately wrote and ran `verification/FinalReferee2Audit.lean`, exit zero. All four public exports have exactly `[propext, Classical.choice, Quot.sound]` as transitive axiom closure, excluding sorry, custom axioms and native-compiler trust.

The independent audit traverses the actual hadamard_twelve term and finds LeanCert.Validity.verify_strict_upper_bound_dyadic_checked plus expression evaluation/constant constructors. Thus the retained 0<12 check uses an actual LeanCert certificate. This is a modest positive-row-count obligation, not a numerical search or oracle. Kernel trust is explicit, and all four Solution trust assertions pass. Challenge's four deliberate placeholders remain in a separate environment and are not imported by Solution. I also inspected the implementer's 3584-job build log and axiom evidence; they agree with the independent results.

The proof uses matrix units, exact casts, general rank APIs, a small integer divisibility argument and one finite certificate, without interval subdivision. Its decomposition is clear and avoids importing irrelevant adaptive machinery. Metadata truthfully labels partial scope, local success, pending final/operational gates, AI assistance and source nonendorsement. Colbrook's mathematical partial result, Bourin–Lee's question, Holden's formalization and the reused Mathlib proof are distinguished. Apache-2.0 is retained.

This is a local replay using a shared pinned cache, not a fresh isolated Linux run. I did not run the actual Comparator/rejection controls or independently rerun the official schema validator. I did not authenticate priority, affiliation, ownership or source endorsement, or reprove all imported library mathematics. No human-review or full-resolution claim follows from this report. Mathematical approval is specific to the hashes below; later wrapper updates do not alter that boundary.

## SHA-256

- `NLA/MI08/Definitions.lean`: `3d239b1379ea53cead7b54a06ed8ae92e2d191420f45a39b5466dcd6380c3965`
- `Challenge.lean`: `7ef811f91e89621f606400fb76756068f941c30f94ac4d9135bb6111d115413e`
- `NUMERICAL_TARGETS.md`: `c8bf9ab6782e2bec826664fe69cd09a523e495cedadbee64ada5f4eca6d25832`
- `NLA/MI08/Correspondence.lean`: `3bf9263dcc6726a08b4cfd31aa9386c872c38ba58cb607de184ee78a8e143741`
- `NLA/MI08/Designs.lean`: `a3d875b90fee6e891d9a1af914ac1d2a60002a28aca3f8f6aa325e2ff5742a5f`
- `NLA/MI08/Proof.lean`: `b78a5e6dc64f679329fa5fbb05ece206d161f503578d4b50b72a8ebd23f156e7`
- `Solution.lean`: `bf8b01921469343f9a3acd5f2fe875e9530de4c69024af8b0fd2b409fd401950`
- `comparator.json`: `18928dd61159e774c47a220a825f4666881e2a89fa825514bd800a91463bf465`
- `lakefile.toml`: `0ba5280ec9dd388e19ebb4b09e1257f4f8851b72da6ed8a3432a647eed9720b4`
- `lake-manifest.json`: `84d8f7719040dade88e1d169389aa9a9b937686ce5782ec5063d8cc0fa726c08`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- `formalization.yaml`: `5772fa9a218b656e5a20483b6ff0172b6c4a5c7f742e2f39162823082d8fe7b3`
- `README.md`: `6cf0b930926a7fab68bef677494a6764c8ca797f338e673fb3ff8167261af564`
- `LICENSE`: `cfc7749b96f63bd31c3c42b5c471bf756814053e847c10f3eb003417bc523d30`
- `verification/final-build.log`: `c17c819aedabeb1abaeecd3694c5c2b4e1cac5443879933eccefcff0a5154aa3`
- `verification/AxiomAudit.lean`: `b1ab427ee49ed7941c6fcdcee8f872cc2f70bf7e281772d136cd1f9c8e198c32`
- `verification/axioms.log`: `1dcbbca3ec0905bb7404494e4f06f9edec7bad84454ce396f0cd64c301be74a3`
- `../README.md`: `814804db20ca8a73366cced2a5de00f8f01261f13d05d5bae1eaa1a1124289e2`
- `../solution.md`: `854a282d60852a4a15a91bcc8a2889d69a1268124faca6cbd92d40e4e547cd99`
- `../solution.tex`: `c15abfde319610c212c0e021531fd7a89640fb39fb39ef1c112c0cd64827f404`
- `reviews/statement-review-snapshot/README.md`: `1a55dbd03860837653a88abe2d3d017ecf0537d6b885315704cb2066687166c0`
- `reviews/statement-review-snapshot/formalization.yaml`: `5a5e7b8ddc58f8eba0ddfbe8a865f65089503de2edc9e04ddc6d02c51f3264ac`
- `reviews/proof-source-hashes.json`: `ea72bd40f46e812b2f242e107dfed6cbfdc1c212ff81160454e2aa11d1a7119f`
- `verification/final-referee-2-source-check.json`: `48d5a45a875770face62948607e796288086cfe0152eb780390c92cd2fbecf9f`
- `verification/final-referee-2-elaboration.log`: `c6f4acb3acf6f9a7ec5765913a146d298a41b3a710c512ff0e9ddec231259ca5`
- `verification/FinalReferee2Audit.lean`: `52c068305a14b08648fa5239ae66a298ba0318832c9329c70fbf46e063c46a8f`
- `verification/final-referee-2-axioms-and-cuts.log`: `18a5c3487232c5ef059184da4f93e1e19c31c12b8b682004aaf436c7428089ad`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/Rank.lean`: `67b4fa7bee02c1806f29562718bfb34c0e1f40af5ec6a91ef91cc33610657491`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/HadamardMatrix.lean`: `b04b0656bc502d39b1c7d238afe6152428778f59411a7ef9753c81565b231c31`
- `.lake/packages/mathlib/Mathlib/Algebra/Order/BigOperators/Ring/Finset.lean`: `c89a7463df5acd6485e64d14b958daaedf6b857aad2808a4ead0570b52220568`
