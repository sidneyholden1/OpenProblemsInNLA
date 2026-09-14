# MI-03 independent proof referee 2

- Phase/date: final source and local mechanical review, 2026-09-14.
- Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of the implementer; not a human referee or official Tau Ceti service.
- Statement freeze: `1546c3bfd87c104d2560cf41ca759ce3dc9a4b48`. Definitions, Challenge and NUMERICAL_TARGETS were compared with that revision and are unchanged.
- Verdict: **APPROVE** mathematical implementation and truthful pending-verification metadata at the hashes below. No substantive defect found. Isolated Linux Comparator remains a separate pending gate.

## Full-target fidelity

I read every line of Proof and Solution against the complete canonical README and full mathematical source reviewed in `statement-referee-2.md`. The actual Euclidean operator-norm, complex CFC modulus, PSD MatrixOrder and real-infimum boundary is unchanged. The all-dimensional contraction inequality and exact sharpness hold for every k≥2, supplying the complete original odd-k≥3 claim. Singular, zero and non-Hermitian summands remain admitted. No commuting hypothesis or dimensional restriction enters the upper bound. The optional Hermitian 3×3 extremizers remain outside the advertised result.

Solution imports the proved declarations from Proof; it does not import Challenge or recreate the statements with placeholders. Each of the four public declarations in Proof matches its corresponding frozen Challenge signature. The declarations retain real division and the literal nonempty, bounded-below infimum of all admissible constants. No custom definition hides the conclusion.

## Universal upper bound

`modulus_sub_sq_nonneg` first proves actual CFC modulus nonnegativity, then uses CFC norm preservation and `CStarAlgebra.norm_le_one_iff_of_nonneg` to obtain |A|≤I from the operator contraction. The necessary commutativity is proved only between |A| and I-|A|; the imported `Commute.mul_nonneg` therefore legitimately makes their product positive. It does not assume unrelated summands commute. I inspected the used norm/order and commuting-positive-product facts.

`sum_gram_gap_nonneg` sums positive Gram matrices over all ordered pairs (i,j). Its exact expansion is 2[kΣA_jᴴA_j-(ΣA_j)ᴴ(ΣA_j)]; the subsequent positive scaling by 1/2 is correct. The double sum accounts for both pair orientations and avoids any lost complex cross term. This holds in every matrix dimension.

`upper_bound` adds the positive contraction defects, that Gram gap, and the square of the self-adjoint R-kI/2. Self-adjointness of R is supplied by actual modulus nonnegativity; the scalar identity term is also shown self-adjoint. CFC.abs_sq and abs_mul_abs reduce the expression to k(kI/4+T-R), verified by exact noncommutative/module algebra. Only then is it scaled by 1/k. The hypothesis k≥2 supplies strict positivity and hence a legitimate inverse cancellation. `hn` is unused because the proof also happens to work in zero dimension; the public quantified target still requires n≥1. Nonnegativity of the proposed real constant is explicitly proved.

## Exact arbitrary-k sharpness

The local phase matrix is [[1/2,√3 z/2],[0,0]]. Relative to the source's v_j convention this uses conjugated phases; since the complete primitive-root phase family and its conjugates both have unit modulus and zero sum, the finite witness family has the same required sums. This is an exact permitted implementation variation, not an even-only replacement for arbitrary roots.

`phase_left_gram` proves AAᴴ=E=diag(1,0) from |z|=1 and the actual identity (sqrt 3)²=3. `E_projection` proves E is a star projection. `phase_contraction` uses its norm bound and the C*-identity ||AAᴴ||=||A||², yielding the genuine operator contraction. I inspected the imported star-projection norm bound. No coordinatewise norm proxy is used.

`phase_modulus` proves the Gram matrix AᴴA is idempotent using AAᴴ=E and EA=A. Because it is nonnegative, the imported `CFC.sqrt_unique` identifies its actual square root with itself. This avoids any unproved square-root choice for a singular matrix. The explicit Gram entries are then proved by exact complex-coordinate algebra.

The implementation uses the actual complex exponential exp(2πi/k), proves it is a primitive kth root with `Complex.isPrimitiveRoot_exp`, and obtains both its unit norm and exact finite geometric sum zero through the imported primitive-root API. I inspected these facts, including their nonzero-k and k>1 hypotheses, all discharged from k≥2. Conjugate phases also sum to zero by map_sum. The two resulting matrix sums are exactly kE/2 and diag(k/4,3k/4). Since kE/2 is nonnegative, `CFC.abs_of_nonneg` applies; subtraction then yields precisely sharpGap k. This proves a concrete extremizer for each allowed k, including k=2 and every odd count, without numeric spectral approximation.

## Sharp lower bound and genuine infimum

`lower_bound` applies an arbitrary admissible constant to the dimension-two witnesses, rearranges the order inequality into sharpGap≤cI, and takes the first diagonal entry of its PSD difference. I inspected the actual ComplexOrder meaning: nonnegativity contains nonnegativity of the real part and zero imaginary part. Taking the real-part conjunct therefore correctly yields c≥k/4 for these real diagonal entries; it is not an accidental entrywise matrix comparison.

`sharp_constant` supplies a concrete admissible member via `upper_bound` and a lower bound zero via the explicit nonnegative-constant conjunct. It applies `csInf_le` using boundedness below and that member, then `le_csInf` using nonemptiness and the proved lower bound for every admissible constant. Thus its infimum equality does not use an empty or unbounded default. `odd_sharp_constant` specializes the stronger all-k result to k≥3; not needing the Odd hypothesis is the intended strengthening, not an omitted original restriction.

## Independent mechanical checks and trust

I independently ran the pinned Lean 4.33.1 `lake env lean NLA/MI03/Proof.lean`; it exited 0. Output is retained in `verification/referee-2-proof-elaboration.log` and contains only the same nonessential sequencing-style linter at line 145. There are no sorry or proof errors. The author's `verification/proof-build.log` also builds Solution successfully (3523 jobs).

I independently imported Solution from a temporary audit file and ran `#print axioms` on all four public exports. This exited 0 and is retained in `verification/referee-2-exported-axioms.log`. Each depends exactly on `[propext, Classical.choice, Quot.sound]`; there is no sorry, compiler-trust or custom axiom in the exported closure. LeanCert is used for its transitive `#assert_trust kernel` commands, also executed during independent elaboration. It is not an interval-numerical certificate in this algebraic proof. The configuration names the four intended exports, has an empty definition-hole list, and allows only the three foundational axioms. I checked every entry of proof-source-hashes.json against the current bytes.

## Reuse, documentation and limits

The proof uses existing Mathlib CFC/norm/order, primitive roots, projections and conditional-infimum facts rather than new competing definitions. Private lemmas isolate the finite algebra and general PSD bridge. The exact double-sum expansion and singular rank-one Gram calculation are efficient; no interval subdivision or sampled computation is justified. The broad Mathlib.Tactic import and one style linter are nonblocking and do not warrant proof churn for this verification task.

Headers and metadata distinguish Colbrook's mathematical argument, Bourin–Lee's original question/known upper bound, and Sidney Holden's formalization with OpenAI Codex assistance. README and formalization.yaml truthfully state local compilation and standard-axiom checks passed while final reviews and isolated Linux Comparator are pending. They accurately exclude optional Hermitian extremizers and do not claim external human review, source-author endorsement or priority. I do not independently authenticate identities, affiliations, ownership or endorsement. README's residual “planned proof” wording is conservative but may be refreshed during final publication metadata updates.

This is independent AI proof/source review with local re-elaboration and exported-axiom inspection. I inspected the relevant imported mathematical facts identified above, not every transitive Mathlib implementation or the Lean/OS kernel. I did not run isolated Linux Comparator or independently validate the metadata schema. Those gates and operational evidence audit must precede promotion. Later mathematical changes require renewed hash-specific review; metadata-only status changes must be supported by their actual evidence.

## SHA-256

- `NLA/MI03/Definitions.lean`: `14688d721143401624b2ccb0db66f1c417d03128b2f998ba63c22a71e49305bf`
- `NLA/MI03/Proof.lean`: `f263b1bd489fd0460deb7965ce1b9ca2a9abb00bc84f3ff6ad4f6495255b2183`
- `Challenge.lean`: `eeb7b72d202166be496afc3fb0ca416dfdce3a3d5e8f86c58a44ea1cabcd4bb3`
- `Solution.lean`: `d0f871ddb83bb9f9397173d22c34b769861b38d470b2672ab4c7421798bb86ed`
- `NUMERICAL_TARGETS.md`: `6141b4786e29b2cfd4e6ee538df1f173ea2c4bf52f6972173ff460022fdd8b0b`
- `README.md`: `4ccd426e81d07a1f60c08c063df110af216fcc2ad207be36c47edf26a887a29c`
- `formalization.yaml`: `51767a103f0e1ecef72481fa5813d2ab6f3607b6994fab844c15bec346c1db4d`
- `comparator.json`: `6850e8bbfc1744dd8eb29b4336ecce6c7cff7ec2a4313dd49df129f60b6a0da0`
- `reviews/proof-source-hashes.json`: `7340c2a1679ec83c929b2aae55e400d61b545128751dc95f147abec96da8fb31`
- `verification/proof-build.log`: `0fcc922071647f1b2ff13d1d9dfb90bd11855be84738dcdfa07c24c361f259f4`
- `verification/referee-2-proof-elaboration.log`: `12d0feb1e249172ed28c795ada9ff7b437248d6f22412faa3283c3f61b856b7b`
- `verification/referee-2-exported-axioms.log`: `083712ba985cf97bfcef0d28da274152563f112ea591ad4b31e1c26ce19ecfba`
- `.lake/packages/mathlib/Mathlib/Analysis/CStarAlgebra/Basic.lean`: `b794153a478961a702212ea09d8eb777f44b07bf80fb8dc901ce850e058ba575`
- `.lake/packages/mathlib/Mathlib/Analysis/CStarAlgebra/ContinuousFunctionalCalculus/Order.lean`: `ea850ab2f6b0056a92e4f4c7155a4eeaf90e61eee0371730830e0676f56e17e1`
- `.lake/packages/mathlib/Mathlib/Analysis/CStarAlgebra/ContinuousFunctionalCalculus/Instances.lean`: `0bc04d350ea16313953d98ec4a73ba1767777414c08081572933e8b7dfddf163`
- `.lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Abs.lean`: `660c178d7405446d3ec489aa0554c65bb104ce95d58ae5134beba961f37e6932`
- `.lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Rpow/Basic.lean`: `5c87ec96e95be9c21e52857acc4892f9a6b7e69d7358f8d6fbbef93b0d249ef7`
- `.lake/packages/mathlib/Mathlib/RingTheory/RootsOfUnity/Complex.lean`: `a403d79d20137cc03f3e8899594a4c5c63333a690cfb4b77b066018dc3925a53`
- `.lake/packages/mathlib/Mathlib/RingTheory/RootsOfUnity/PrimitiveRoots.lean`: `d9e1f834ca3dbaa0dbce303d2e4216d9bfb8dff45860e7fe3a6fcff9418bc328`
- `.lake/packages/mathlib/Mathlib/Analysis/Complex/Order.lean`: `67cf9e2c39fa9c53e1a3d5e9f418718638ed01f9274135b49795a335abe64f7d`
