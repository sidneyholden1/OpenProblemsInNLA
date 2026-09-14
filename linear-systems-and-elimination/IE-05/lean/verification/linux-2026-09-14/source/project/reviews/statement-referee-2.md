# IE-05 independent statement referee 2

- Phase/date: pre-proof statement review, 2026-09-14.
- Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of the implementer; not a human referee or official Tau Ceti service.
- Immutable mathematical source base: `9777c86853b40206f70438c92a47a7dec9bc66ae`.
- Verdict: **PASS / APPROVE** at the exact hashes below. No substantive or blocking correction requested. This is not proof verification.

## Full original target and source fidelity

I read the complete canonical README, complete Stepaniants solution.md, Definitions, Challenge, numerical targets, and numerical precheck script/data. I independently compared canonical/source bytes with the immutable base and checked every entry of statement-source-hashes.json against actual files.

The boundary retains the original question in every dimension n≥2: the supremum over every real orthogonal matrix and all admissible GEPP tie paths should equal the growth of the prescribed positive-diagonal QR candidate under its first-available-row path. The order-eight witness disproves that full universal equality. No true orthogonal supremum value, optimality classification, or asymptotic leading-constant claim is added. All arithmetic and matrix entries are real; this is element growth, not spectral/Frobenius norm growth or complete pivoting.

`ExtremizerConjecture` quantifies over factors and paths satisfying their actual defining properties rather than naming an unproved algorithmic output. Positive-diagonal QR of the nonsingular lowerMatrix is unique, and the first-available-row convention fixes the relevant elimination states. Thus this relational formulation expresses the prescribed candidate. The explicit n=8 QR/path exports also prevent the refutation from exploiting nonexistent witnesses or vacuous candidate assumptions.

## Actual elimination paths and ties

I inspected `Equiv.swap`: it swaps exactly its two arguments and fixes all others. In `schurStep`, the surviving row i is read from old row swap(k,p,i), its pivot-column multiplier divides by the old selected pivot A[p,k], and the pivot row update uses old row p. This is exactly row swap followed by Schur elimination. In particular, when p>k and i=p survives, the formula correctly uses old row k. No column exchange is performed. Only i,j>k entries survive; earlier rows and columns become zero.

`isPath` starts S[0]=A and, for every k in Fin n, requires p[k]≥k, a nonzero selected pivot, and maximal absolute value in the entire active column. It allows every tie. For k+1<n it enforces exactly the Schur recurrence; the final stage is included in pivot/max conditions but requires no irrelevant trailing update. Although zero padding is not a separate conjunct, it follows for every relevant later state from the recurrence. Values at indices≥n do not enter growth and cannot inflate it.

`isFirstPath` requires the selected pivot index to be no larger than every tied active index, exactly the first available row in the current ordering. It does not incorrectly choose the smallest original row label after previous swaps. Both concrete paths choose p(k)=k and must prove all pivot and recurrence conditions; the LU state formula is not used as a substitute for them.

Orthogonality QᵀQ=I makes every square witness nonsingular. The path's explicit nonzero pivot requirement is appropriate for exact partial pivoting on nonsingular matrices and prevents totalized division by zero from manufacturing growth. For n≥1 it also forces a strictly positive input entry maximum. The n=0 empty-index behavior is immaterial to the original n≥2 theorem and n=8 witness.

## Genuine maxima, supremum and QR

`entryMax` uses Finset.univ.sup on nonnegative real magnitudes of individual real entries. I inspected the finite-supremum implementation: it folds lattice supremum from bottom, so this is the actual largest absolute entry, with zero only for an empty index set. Coercing the nonnegative norm to ℝ recovers the ordinary real absolute value. `growth` takes the same finite maximum over all triples (stage,row,column), with stage in Fin n, then divides by the actual input maximum. It is not defined to be only a final pivot ratio. Zero padding does not alter a maximum of nonnegative active magnitudes.

`orthogonalGrowths` ranges over all real orthogonal Q and every admitted path. The real sSup is genuine. `growth_separation` explicitly requires nonemptiness and boundedness above at n=8 before asserting candidate growth lies strictly below that supremum. The imported conditional-supremum inequalities require the appropriate hypotheses. The planned all-path stage estimate is valid: pivot maximality and nonzero denominator bound each multiplier by one, so each Schur entry is at most twice the preceding maximum. Iterating and using a positive input maximum gives a finite bound; 2^n is sufficient. This bridge must be formally proved, not assumed only for the no-swap witness paths.

`positiveQR` means QᵀQ=I, QR=L, upper-triangular R and strictly positive diagonal. Both candidate and modified lower matrix are covered by qr_certificates. The modified entry is exactly zero-based (7,1), the source's row8,column2. Integer-column normalization divides by genuine positive square roots, and all listed D entries are positive. Defining R=QᵀL is appropriate once orthogonality and the QR product/triangularity are proved. This does not confuse QR with the separately used no-exchange LU relation H=LT.

## Independent exact numerical review

I independently parsed the actual integer matrices/vectors in Definitions and matched them to the precheck data. Without executing the author's precheck, I verified HᵀH=diag(D), H=LT, and upper-triangular HᵀL with positive diagonal for both examples. These establish the planned orthogonality and positive QR convention after positive column normalization.

I then independently performed rational elimination on each integer H, factoring out its fixed positive column roots. At every stage the first maximal pivot was the diagonal row and nonzero. Every generated state matched the specified trailing LU formula, including all zero-padded entries. I checked all 204 active entries for each example, 408 in total. Candidate initial/peak squared maxima are 2601/3286 and 5462; witness initial/peak squared maxima are 3969/5272 and 5272. Their squared growths are respectively 17948132/2601 and 27793984/3969, matching the source and precheck. The rational separator satisfies 17948132/2601<(167/2)²<(5272/63)².

Those diagnostic exact checks do not enlarge the promised formal scope. The actual exports only require the candidate upper bound, witness lower bound, strict separation, nonempty bounded growth set and strict supremum comparison. These one-sided inequalities suffice: a legitimate witness path gives a member of the supremum set exceeding the prescribed candidate. No formalization of every source table maximum or exact growth equality is necessary. Factorizing common positive column roots before comparing pivots and bounding entries is sound and reduces repeated irrational algebra.

## Reuse, credit and remaining gates

Existing Mathlib row-swap permutations, finite nonnegative suprema, conditional real suprema, ordinary matrix algebra and real square-root identities are appropriate. Path semantics are project-specific but are fully defined in elementary operations and reviewed above. Exact integer/rational certificates and positive-root cancellation avoid unjustified numerical spectral work or interval subdivisions. Any LeanCert point cuts should remain kernel-trust only and be distinguished from the external Fraction diagnostics.

The mathematical counterexample is credited to George Stepaniants, the conjecture and growth analysis to John Peca-Medlin, and formalization to Sidney Holden with OpenAI Codex assistance. The full source retains substantial AI assistance and automated-review qualifications. I make no independent priority, identity, affiliation, ownership or endorsement authentication, and no human-review claim.

I inspected `verification/statement-build.log`: Definitions and Challenge built successfully (2380 jobs), with exactly four deliberate Challenge sorry warnings. I did not independently rerun that build. No mathematical proof implementation was reviewed or written. Final code reviews must inspect both real QR certificates, all first-path Schur/pivot bridges, actual finite-max bounds, denominator positivity, the universal all-tie boundedness argument, and the genuine-supremum/full-negation bridge. Exported axiom closure and isolated Comparator/default-kernel replay remain mandatory. Metadata scaffolding added separately is outside this statement approval unless reviewed later. No statement approval alone warrants canonical promotion.

## SHA-256

- `../README.md`: `b5e980fa1f171ac540465212341dfc589d4f34d33c0b59d54a520dd3b0a4f1f5`
- `../solution.md`: `1b94eda6df18066f2f09b66b8b28a18ca071c0c2fb070b536dc8c798992ae434`
- `NLA/IE05/Definitions.lean`: `39e5c319afb8d8b18b4c60518a3be0f79381416b2e5340b18cf3485a7b0528e6`
- `Challenge.lean`: `d9ee825a21016cd86c1d507e32f117bfd3039e6bb94e84597d35ec74f8911a0a`
- `NUMERICAL_TARGETS.md`: `349088fa17814d5122d1bcd9769adb9dfbd67b7424f59ab869a73100658c4241`
- `reviews/statement-source-hashes.json`: `789594ef06e2b1ace634b0dd25925af97a7c5ba24e23c5b615a1aca546956b45`
- `verification/numerical_precheck.py`: `44b6502d1b4eddc0330a70abcd436d0a503ce814133a000e7dc71e859182e7d3`
- `verification/numerical-precheck.json`: `0b3d2d0d2c0348dd29a94d5263a1d9a0a55b1151550c7f2bc99ad31368a01e4b`
- `verification/statement-build.log`: `d5957c387ae0119f162f2218891b5581ff90bcaa1755f7a97e7d659d4bd69d85`
- `.lake/packages/mathlib/Mathlib/Data/Finset/Lattice/Fold.lean`: `79b80dd5aa12886d31c582ab00585627dc4e7f1d7607c7b707484f38d95ce2f4`
- `.lake/packages/mathlib/Mathlib/Logic/Equiv/Basic.lean`: `5b69b238b9fb70f3b1fdede5be53fa5d69047943bf1b1e36162f37de71b67cc8`
- `.lake/packages/mathlib/Mathlib/Analysis/Normed/Group/Basic.lean`: `85d307e042cb03073a2e9160c52adbfcef85c921d2f9b17584b13597d8a5c7bc`
- `.lake/packages/mathlib/Mathlib/Order/ConditionallyCompleteLattice/Basic.lean`: `4e4c9abe9993f2334c389d6cb4b75b31b44bb66bb87b65a95b3abac2dbd9fcc8`
