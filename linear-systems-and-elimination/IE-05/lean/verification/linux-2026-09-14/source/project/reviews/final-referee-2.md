# IE-05 independent final referee 2

- Phase/date: final proof review, 2026-09-14.
- Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of implementation; not a human referee or official Tau Ceti service.
- Verdict: **PASS for mathematical fidelity and local proof review**, bound to the hashes below. No blocking finding. Actual isolated Linux Comparator/default-kernel replay and rejection controls remain pending; this report does not authorize canonical promotion or claim that operational gate passed.
- Protocol: `docs/lean/REVIEW.md`; covers correctness, full scope, degeneration, computational reduction, imported API use, clarity, and attribution.

## Immutable target and actual proof

I reread the complete canonical README and complete Stepaniants solution.md, the frozen Definitions/Challenge/numerical targets, and every implementation module (Bounds, IntegerCertificates, RealCertificates, Proof, Solution). I independently verified all 17 entries in proof-source-hashes.json, all three frozen boundary files against commit `3fd6665e`, and both canonical source files against `9777c86853b40206f70438c92a47a7dec9bc66ae`. All match. The earlier statement review found no required correction; its substantive obligations are discharged below.

The original all-dimensions extremizer equality, with real orthogonal matrices and all admissible partial-pivoting tie paths in the supremum, is negated by the legitimate order-eight witness. This is element growth, not an operator norm. The prescribed candidate is the positive-diagonal QR factor of lowerMatrix, under the first available row tie convention. Its factors and path exist by the two explicit certificate exports, so the negation does not exploit vacuous candidate premises. Exact source stage-table equalities, the value of the true supremum, and the separate asymptotic conjecture are intentionally outside the advertised formal scope. The one-sided growth bounds suffice to refute the complete original equality.

`IntegerCertificates` checks both integer Gram identities, upper triangularity and positive diagonal of HᵀL, positive D and T diagonals, initial states, every active pivot column and every actual recurrence. It uses `decide +kernel`, including split finite cases for expensive identities; these are checked proofs, not external numerical assumptions. The integer data and modified zero-based entry (7,1) match the source. The previously retained independent Fraction review checked all 408 active entries; that diagnostic evidence remains distinct from Lean proof evidence.

`RealCertificates.real_orthogonal` divides the exact Gram identities by strictly positive column square roots. `real_qr` sets R=QᵀL and uses square-matrix direct finiteness to obtain QQᵀ=I from QᵀQ=I, then proves QR=L, upper triangularity, and strictly positive diagonal. This is a genuine QR certificate; LU is used separately for the elimination states, not confused with QR. `root_pos` and `root_sq` establish the needed positivity before cancellation.

`realStates_cast` identifies the defined real states with exact integer active numerators divided by their column roots. `real_recurrence` proves the actual `schurStep` equation for every next state, using the integer recurrence and nonzero pivot/roots. It does not assume the path relation or merely rename the LU formula. `real_first_path` proves initial state, nonzero diagonal pivot, maximality in the complete active column, and every recurrence; the selected row k is the first available index, so all ties are correctly resolved. Earlier rows/columns are zero padded by the actual recurrence; states beyond index n never enter growth.

## Denominators, all ties, and genuine supremum

I inspected `Bounds.schur_entry_bound` especially for arbitrary swaps: the surviving row is old swap(k,p,i), including old row k when i=p. The proof establishes that this row still comes from the active region. Pivot maximality and a nonzero selected pivot bound the absolute multiplier by one; the triangle inequality gives twice the preceding maximum. Thus boundedness is proved for every admissible path, including swaps and all ties, although the two examples need no exchanges.

`path_input_pos` uses the actual first nonzero pivot and S[0]=A, so no totalized division-by-zero escape is possible. `path_stage_bound` inducts over every relevant state, and `path_growth_bound` divides only by that positive input maximum. Its deliberately loose bound 2^n is enough. The n=0 empty-index behavior is excluded by the lemma's positive-dimension premise and is irrelevant to the n≥2 conjecture and n=8 witness. Orthogonality also ensures these square inputs are nonsingular; the explicit path pivots are all certified nonzero.

I checked the actual Mathlib finite supremum implementation (fold of lattice maximum from bottom), finite supremum inequalities, and the conditional-supremum theorem. `entryMax` and `growth` are genuine maxima of nonnegative real magnitudes, over all rows/columns/stages. `growth_separation` proves an explicit member of orthogonalGrowths8 and a universal bound 2^8. It passes the proved BddAbove and witness membership to `le_csSup`, whose implementation derives IsLUB using nonemptiness and boundedness. No empty or unbounded real-sSup default supplies the conclusion.

The candidate proof bounds every active entry by sqrt5462 and obtains the needed denominator lower bound from its actual (2,2) entry 51/sqrt3286. The witness proof bounds every input entry by 63/sqrt5272 and obtains its numerator lower bound from the actual last pivot 5272/sqrt5272. Nonnegative square-root and absolute-value facts justify all squared comparisons; witness_input_pos justifies the final division inequality. Their directions give exactly the advertised upper and lower growth bounds. The rational separator produces a strict gap, which passes through the actual witness member into the genuine supremum. `counterexample` instantiates the original universal proposition at these already-proved candidate factors/path and contradicts that strict gap.

## Independent mechanical evidence and trust

I independently ran pinned Lean 4.33.1 via `lake env lean` on Bounds, IntegerCertificates, RealCertificates, Proof, and Solution; every exit code was zero. Evidence: `verification/final-referee-2-elaboration.log`. This replay uses the existing pinned local dependency cache; it is not a fresh isolated Linux build. The only warnings are one harmless tactic-style linter and two deprecated Set.mem_setOf expansions in the point tactic. No proof hole was reported.

I separately created and ran `verification/FinalReferee2Audit.lean`. All four exported declarations have exactly `[propext, Classical.choice, Quot.sound]` as their transitive axiom closures. No sorry, custom axiom, or native compiler axiom appears. The Solution import carries all four kernel trust assertions. The four Challenge placeholders are confined to the separate statement environment; Solution does not import Challenge.

The independent audit also traverses the actual `scalar_separation` proof term and finds `LeanCert.Validity.verify_strict_upper_bound_dyadic_checked`, along with expression constructors/evaluation. This confirms substantive LeanCert use rather than relying on a tactic spelling. I inspected its checked-bound theorem and the point tactic's checked-certificate construction at the singleton zero interval, plus the trust assertion implementation. Both rational point cuts request kernel trust. Their checked theorem supplies a real strict inequality from a true domain/bound certificate; the export axiom audit excludes a hidden native fallback. Evidence: `verification/final-referee-2-axioms-and-cuts.log` (audit process exit zero).

I also inspected the implementer's 3581-job final build log and four-export axiom log; they agree with my independent results. Comparator config names all four matching target signatures, no definition holes, and only the standard three permitted axioms. I have not executed the actual Linux Comparator and make no statement-equivalence/operational acceptance claim on its behalf.

## Quality, credit, and limits

Factoring roots by column, checking finite integer identities, and proving one-sided bounds avoids repeated irrational elimination and interval subdivision. Existing Mathlib finite-supremum, matrix multiplication/direct-finiteness, real square-root, and ordered-field APIs are reused. The generic all-path growth estimate is sensibly separated from the finite certificates and real lifting. Project-specific path definitions are transparent; proof lemmas do not strengthen their premises to only the two examples. The small style/deprecation warnings do not justify a mathematical revision.

George Stepaniants retains mathematical-counterexample credit; John Peca-Medlin retains conjecture/earlier analysis credit; Sidney Holden and Codex assistance are correctly distinguished as formalization attribution. README/formalization.yaml truthfully report local success and pending final/operational gates at these bytes, retain no-endorsement and AI-review qualifications, and credit Mathlib, LeanCert and shared reproduction work. I did not independently authenticate authorship priority, affiliations, ownership, external endorsement, or all third-party library proofs. Metadata may be updated after both reports, but this approval remains bound to the exact mathematical bytes reviewed here. No proof or metadata file was modified by this referee.

## SHA-256

- `NLA/IE05/Definitions.lean`: `39e5c319afb8d8b18b4c60518a3be0f79381416b2e5340b18cf3485a7b0528e6`
- `Challenge.lean`: `d9ee825a21016cd86c1d507e32f117bfd3039e6bb94e84597d35ec74f8911a0a`
- `NUMERICAL_TARGETS.md`: `349088fa17814d5122d1bcd9769adb9dfbd67b7424f59ab869a73100658c4241`
- `NLA/IE05/Bounds.lean`: `5372fb039987ccb138b944e02789f0ac8904f34ad8f4b8419edd953eb20a6e60`
- `NLA/IE05/IntegerCertificates.lean`: `73b7db5e17bd3cf3851b02d74b22742d78a6bcc0d2a7a8177d75c397fbd9c39f`
- `NLA/IE05/RealCertificates.lean`: `324d36d1ae11af5c611970b85ee4e50a064d835a73f1623f8adbc3c21a13c4f3`
- `NLA/IE05/Proof.lean`: `e7b19bce4ab022283190239bf489d6346a7f018a23fbe8876fd7fdfcd06f20bb`
- `Solution.lean`: `24c59beb585cf9ac0b8d4614773b4a9b0ed6dbb0f20c24bf9105c9ad750d07ed`
- `comparator.json`: `26518dfeeefdf7a8a293eaf5ad06b2cec04789e8cd6f82a2c9f9e104915109f8`
- `lakefile.toml`: `eddadc9ee1b75205a57c70e03e8a1a9ddcaab15a0ff50335445446f9c7add352`
- `lake-manifest.json`: `84d8f7719040dade88e1d169389aa9a9b937686ce5782ec5063d8cc0fa726c08`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- `formalization.yaml`: `9ce0fd1b574b07266dce5ef5cd34445bbdc42875812792ffbd28087077fa222b`
- `README.md`: `51b81f694395f036b3b58f94409cd8f42547edf5317da70a9c4b7aa1ba17a568`
- `verification/final-build.log`: `f8aba8e4bb64f11855d9150fda8cf8152cd1037495d4bc8f562bb801ed0779a0`
- `verification/AxiomAudit.lean`: `f21c603a53f2836a14b7e5eb05e8d5666cbfbdd80877d6bb84f2d0ed9289150c`
- `verification/axioms.log`: `f6d37b8de9f73484a5b3601552aebb013de1ab2bbae98bef8f9ac3140c8a7739`
- `reviews/proof-source-hashes.json`: `eb8741714a6fc66211d070fd55f6e55bf8dde722d57579a4b258f38b19d9863e`
- `verification/final-referee-2-source-check.json`: `cfbec37906daaa1c983273b5c8d2bed90cd0e8c8fff813abab4c808f9e2a3f1d`
- `verification/final-referee-2-elaboration.log`: `c25c4f292ed45811168af245679f0513f613191019da2ed8b6ac549e4c953ed8`
- `verification/FinalReferee2Audit.lean`: `6dfab8dff9cae2793907fb1d05884100efa9516a6c4a22873e8478a20e5df901`
- `verification/final-referee-2-axioms-and-cuts.log`: `43489cd29ce391bc08ad06fdfe30aafac35ece593ad3fdcb2af10d4968706a16`
- `.lake/packages/mathlib/Mathlib/Data/Finset/Lattice/Fold.lean`: `79b80dd5aa12886d31c582ab00585627dc4e7f1d7607c7b707484f38d95ce2f4`
- `.lake/packages/mathlib/Mathlib/Order/ConditionallyCompleteLattice/Basic.lean`: `4e4c9abe9993f2334c389d6cb4b75b31b44bb66bb87b65a95b3abac2dbd9fcc8`
- `.lake/packages/leancert/LeanCert/Tactic/IntervalAuto/PointIneq.lean`: `b88723998a7f63e9673b9af36811a039057fed75e2a550f4fd7788472180876f`
- `.lake/packages/leancert/LeanCert/Tactic/Verification.lean`: `2c576708b528acdde17796b0b715b83079f9cad377182dbd87c248323ff0a58c`
- `.lake/packages/leancert/LeanCert/Validity/DyadicBounds.lean`: `6f1cdbc11f32e425ef5e9f4a22966d64ff0d11614ec9453ed7dde498e31a7c47`
- Canonical `../README.md`: `b5e980fa1f171ac540465212341dfc589d4f34d33c0b59d54a520dd3b0a4f1f5`
- Canonical `../solution.md`: `1b94eda6df18066f2f09b66b8b28a18ca071c0c2fb070b536dc8c798992ae434`
