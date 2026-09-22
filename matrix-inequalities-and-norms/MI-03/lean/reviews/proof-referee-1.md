# MI-03 independent proof referee 1

- Reviewer: `/root/iv06_statement_referee_1`, independent OpenAI Codex AI agent, not the proof implementer.
- Date: 2026-09-14.
- Phase: final mathematical correctness, original-target fidelity, norm/order/CFC semantics, infimum and axiom closure.
- Protocol: `docs/lean/REVIEW.md` and its Tau Ceti adaptation; not official Tau Ceti service review or human peer review.
- Verdict: **APPROVE on the exact hashes below**. No substantive correction requested. Actual isolated Linux Comparator and operational promotion remain pending.

## Source identity and frozen boundary

| Project file | SHA-256 |
|---|---|
| `NLA/MI03/Proof.lean` | `f263b1bd489fd0460deb7965ce1b9ca2a9abb00bc84f3ff6ad4f6495255b2183` |
| `Solution.lean` | `d0f871ddb83bb9f9397173d22c34b769861b38d470b2672ab4c7421798bb86ed` |
| `NLA/MI03/Definitions.lean` | `14688d721143401624b2ccb0db66f1c417d03128b2f998ba63c22a71e49305bf` |
| `Challenge.lean` | `eeb7b72d202166be496afc3fb0ca416dfdce3a3d5e8f86c58a44ea1cabcd4bb3` |
| `NUMERICAL_TARGETS.md` | `6141b4786e29b2cfd4e6ee538df1f173ea2c4bf52f6972173ff460022fdd8b0b` |

I independently compared Definitions, Challenge and the final numerical targets against Git blobs at frozen revision `1546c3bf`; all three are byte-identical. The complete original-source identity and scope review remain recorded in `statement-referee-1.md`. I read the entire final Proof and Solution rather than relying on author build summaries.

## Universal upper bound

The Euclidean operator-norm and positive-semidefinite-order scopes remain explicitly active throughout Proof, consistently with the reviewed definitions. No alternate entrywise norm or order is introduced. `modulus_sub_sq_nonneg` correctly uses `CFC.norm_abs` and the nonnegative-element norm/order equivalence to obtain `0 ≤ |A| ≤ I`. Its product positivity requires only that `|A|` commute with `I-|A|`; that commutation is explicitly proved. It does not assume that unrelated summands commute.

`sum_gram_gap_nonneg` proves the complete double-sum identity

`Σᵢ Σⱼ (Aᵢ-Aⱼ)ᴴ(Aᵢ-Aⱼ) = 2(k Σⱼ AⱼᴴAⱼ - (Σⱼ Aⱼ)ᴴ(Σⱼ Aⱼ))`.

Each summand is positive semidefinite, and scaling by `1/2` preserves that order. This correctly replaces the manuscript's unordered-pair sum without dropping terms or a factor of two. The upper-bound proof then adds the positive modulus defects and the square of the self-adjoint matrix `R-kI/2`. `CFC.abs_sq`/`abs_mul_abs` convert the Gram terms to modulus squares. Exact algebra yields `k(kI/4+T-R) ≥ 0`, and the explicit hypothesis `k ≥ 2` provides strictly positive `k` before scaling by its inverse. The resulting order inequality has exactly the reviewed direction and scalar `k/4`.

This argument is symbolic in both dimension and summand count, so it proves the universal claim for every allowed dimension and every complex matrix family. The unused positive-dimension hypothesis in the proof only reflects that the algebra also handles the zero-dimensional case; it does not remove any requested case. There is no self-adjointness assumption on the original summands.

## Exact sharpness family

For a unit-modulus phase `z`, `phaseMatrix z` has first row `(1/2, sqrt(3)z/2)` and zero second row. Relative to the source's `e₁vᴴ` convention, this simply conjugates the phase family, as permitted by the frozen plan. The proof establishes `A Aᴴ = E`, `E A = A`, and that `E` is a star projection. The C-star norm identity and projection norm bound give the actual Euclidean operator contraction. No coordinate norm is substituted.

The right Gram matrix is proved idempotent and positive. I inspected Mathlib's `CFC.sqrt_unique`: these hypotheses identify the actual positive square root with that Gram matrix. Hence `phase_modulus` proves a true modulus identity, not an assumed or custom surrogate. The subsequent two-by-two Gram formula uses exact `sqrt(3)^2 = 3` and `z*conj(z)=1`, including both conjugate off-diagonal entries.

The chosen phase is the actual complex exponential `exp(2πi/k)`. I inspected the pinned `Complex.isPrimitiveRoot_exp`, `IsPrimitiveRoot.norm'_eq_one`, and `geom_sum_eq_zero` APIs. The proof discharges their nonzero/greater-than-one count assumptions using `k ≥ 2`, translates the finite sum correctly, and also proves the conjugate sum vanishes. Both the even case `k=2` and every odd case are covered. Exact coordinate summation gives the sum of matrices `kE/2` and sum of moduli `diag(k/4,3k/4)`. The former is positive, so `CFC.abs_of_nonneg` applies, producing the exact frozen gap `diag(k/4,-3k/4)`.

## Lower bound, genuine infimum and original question

`lower_bound` applies an arbitrary admissible constant to the actual dimension-two contraction witnesses. Rearranging the matrix inequality gives `sharpGap k ≤ cI`. Mathlib's `Matrix.PosSemidef.diag_nonneg` is a genuine quadratic-form consequence, applied at index zero. Extracting the real component of its complex-order inequality yields exactly `k/4 ≤ c`; the imaginary-part condition does not supply a spurious scalar order.

`sharp_constant` exhibits the admissible upper bound as a member of the defining set, proves lower boundedness by zero from every member's required nonnegativity, and uses the conditionally complete infimum inequalities in the proper directions. Thus the asserted equality is about the actual nonempty bounded-below infimum. Neither default infimum values nor assumptions of the desired conclusion are used. Finally, the stronger all-`k ≥ 2` result is specialized to every odd `k ≥ 3`. The unused oddness hypothesis is legitimate because the stronger theorem was proved. The optional Hermitian three-dimensional extremizers are not claimed.

Solution imports Proof and exposes its four declarations under the same fully qualified names and signatures as Challenge, with no import of the placeholder environment. All original dimensions, complex fields, operator norms and order conventions are retained.

## Independent checks and computation policy

I independently re-elaborated Proof and Solution using the pinned Lean 4.33.1 runtime. Both returned exit zero. Proof emitted one nonblocking `unnecessarySeqFocus` style warning at line 145; Solution emitted no diagnostics. The warning concerns tactic sequencing, not proof content or an unresolved goal. No source change is requested for it.

A separate audit importing Solution printed the transitive axiom closures of all four exports. Each was exactly `[propext, Classical.choice, Quot.sound]`; no sorry, custom or native-compiler axiom was present. The audit source, commands and outputs are recorded in `verification/referee-1-local-checks.log`. LeanCert's kernel-trust assertions execute on the actual exports and agree with the independently printed closures.

The double sums and arbitrary-count phase cancellation are exact symbolic identities. Concrete computation is confined to two-by-two matrix arithmetic and exact rational/root algebra. No approximate spectrum, interval subdivision, numerical phase sampling or fixed-count enumeration substitutes for an unbounded quantifier. LeanCert is used for kernel-trust auditing; this proof does not execute an interval numerical certificate, consistent with the frozen computation plan. Standard Mathlib C-star, CFC, roots-of-unity and infimum APIs are reused rather than replaced by bespoke assumptions.

## Remaining limits

This approval concerns the identified mathematical sources and independent local elaboration only. I did not inspect a successful Linux Comparator run or operational evidence for MI-03 at this stage; no promotion follows from this report alone. Final metadata/publication review and original problem-number safeguards are separate. Authorship, original-upper-bound attribution and AI assistance are disclosed, and the allowed classical foundational axioms remain part of the trusted base. This report is independent AI review rather than external human certification.
