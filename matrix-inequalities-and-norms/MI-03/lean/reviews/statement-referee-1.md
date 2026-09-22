# MI-03 independent statement referee 1

- Reviewer: `/root/iv06_statement_referee_1`, independent OpenAI Codex AI agent; not a proof implementer.
- Date: 2026-09-14.
- Phase: pre-proof full-target fidelity, actual Mathlib semantics and exact numerical/analytic obligations.
- Protocol: `docs/lean/REVIEW.md` and its Tau Ceti scope/correctness adaptation; not an official Tau Ceti service or human review.
- Verdict: **APPROVE** the final bytes below. No mathematical correction requested.

## Exact source identity

I read the entire canonical README, complete standalone `solution.tex`, and complete original proof. I independently compared all three against Git blobs at base `9777c86853b40206f70438c92a47a7dec9bc66ae`; their bytes agree exactly. Paths beginning with `NLA/`, `Challenge`, `NUMERICAL`, or `verification/` below are relative to this Lean project.

| File | SHA-256 |
|---|---|
| Repository `matrix-inequalities-and-norms/MI-03/README.md` | `fc504918a1f2ca1d83bc0e3b68ff4864d349ad215ff50116e9bfab2776378ba3` |
| Repository `matrix-inequalities-and-norms/MI-03/solution.tex` | `bd7a553bdcb0cd76543960b299f952a30e0f5829192cc89c869ffe1676454703` |
| Repository `references/colbrook-matrix-2026-09-11/original-proofs/MI-03.tex` | `2d2d0ac01e22de1c6d63471c0965b1c17362d5eda23d53cbf397ab4932be32b3` |
| `NLA/MI03/Definitions.lean` | `14688d721143401624b2ccb0db66f1c417d03128b2f998ba63c22a71e49305bf` |
| `Challenge.lean` | `eeb7b72d202166be496afc3fb0ca416dfdce3a3d5e8f86c58a44ea1cabcd4bb3` |
| `NUMERICAL_TARGETS.md` | `6141b4786e29b2cfd4e6ee538df1f173ea2c4bf52f6972173ff460022fdd8b0b` |
| `verification/statement-build.log` | `7b269d5fb8b331067cf8a54096c3b48f1a9da1a08b536236b31ab3742efe4c8b` |

During review, the numerical-target examples paragraph was corrected to identify IE-23 as a genuine-supremum example, rather than attributing an infimum example to it. I reread the entire corrected file and approve the final hash above. This attribution-of-examples correction does not alter any mathematical target.

## Fidelity and library semantics

`admissible k c` states both `c ≥ 0` and the required matrix inequality for every natural dimension `n ≥ 1`, every complex `n × n` matrix family indexed by `Fin k`, and every such family with each operator norm at most one. It imposes no Hermitian, commuting, invertibility, positivity or rank condition on the summands. Zero and singular matrices remain allowed. The dimension quantifier is universal and unbounded; a dimension-two sharpness certificate does not replace the universal upper bound. Natural-number indexing is equivalent to the original positive integer dimensions and summand count under the stated inequalities.

I inspected the pinned Mathlib implementations, not only their names. `Analysis/CStarAlgebra/Matrix.lean` transports the continuous-linear-map operator norm between Euclidean spaces to matrices; `Matrix.instL2OpNormedAddCommGroup` and related instances are activated by `Matrix.Norms.L2Operator`. The reviewed definitions and Challenge explicitly open this scope, so the contraction norm is the required Euclidean operator norm, not a matrix entrywise or Frobenius norm. The same file supplies its compatible C-star instances.

`Analysis/Matrix/Order.lean` defines the `MatrixOrder` relation by `A ≤ B` iff `(B-A).PosSemidef`; the explicit scoped instances therefore express the required positive-semidefinite matrix order. `ComplexOrder` supplies the compatible scalar-order structure and does not introduce an entrywise matrix-order assumption. In `Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Abs.lean`, `CFC.abs a` is exactly `CFC.sqrt (star a * a)`. The matrix star is conjugate transpose. The same file proves nonnegativity and `abs a * abs a = star a * a`; `CFC.sqrt` is the continuous functional calculus of `NNReal.sqrt`, with the usual positive-square-root identities in `Rpow/Basic.lean`. For the Gram matrix these are genuine positive-square-root operations. No normality hypothesis on `a` appears in the definition or the modulus-square identity.

The real scalar action `c • 1` is the real scalar multiple of the complex identity matrix, matching `cI`. The inequality direction is correct. `bestConstant` is the literal real `sInf` of all admissible constants, rather than a custom certificate minimum. The `sharp_constant` export explicitly requires nonemptiness and lower boundedness together with the claimed value, preventing use of an empty or unbounded infimum default. Nonnegativity supplies the lower bound zero, and the universal upper-bound theorem is required to exhibit an actual admissible constant.

`oddSharpConstantConjecture` preserves precisely every odd natural `k ≥ 3`. The all-`k ≥ 2` exports are stronger than the original question and specialize to it; no odd case is lost. The stronger all-count source theorem is sufficient without formalizing the optional Hermitian three-dimensional construction. Challenge does not advertise that optional result or require an unproved rank-one label for the existential sharpness family.

## Exact certificate and proof bridges

The planned upper-bound identity is algebraically correct: the pairwise-difference sum equals `k Σ A_jᴴ A_j - (Σ A_j)ᴴ(Σ A_j)`. Combining `|A_j|² = A_jᴴA_j`, `R² = (Σ A_j)ᴴ(Σ A_j)`, and the square `(R-kI/2)²` yields exactly `k(T+kI/4-R)`. Each term is positive semidefinite for contractions, with scalar positivity ensured by `k ≥ 2`. The alternative vector Cauchy–Schwarz proof has the same full-dimensional scope. Neither route assumes different summands commute. The contraction-to-positive-modulus bound and all order/functional-calculus conversions remain proof obligations.

The root-of-unity construction is exact for every `k ≥ 2`: its phases have norm one and sum zero. The two vector coordinates have squared moduli `1/4` and `3/4`, so the vectors have norm one. For `A_j = e₁v_jᴴ`, the Gram matrix is the projection `v_jv_jᴴ`, hence this projection is the modulus. The phase cancellation gives sums `diag(k/2,0)` and `diag(k/4,3k/4)`; their modulus difference is `diag(k/4,-3k/4)`. `sharpGap` has exactly these entries and coercions, including the negative sign of the second entry. Conjugating the phases does not change cancellation.

Taking the `(0,0)` quadratic form of the admissibility inequality at these actual contractions forces every admissible real `c` to satisfy `c ≥ k/4`. Together with an attained admissible upper bound and the explicit set-validity obligations this determines the genuine infimum. These are nonvacuous mathematical tasks: no witness, modulus identity, lower bound, supremum/infimum fact or final conjecture conclusion is supplied as a hypothesis to an exported theorem. Equivalent exact phase families permitted by the numerical plan must still establish the same four frozen signatures.

## Elaboration and limits

I inspected the complete statement-build log: Definitions and Challenge build successfully, the log ends with 3,029 completed jobs, and the only diagnostics are the four intentional Challenge placeholders. Those placeholders establish no mathematics. No proof body was written or approved during this phase. Final code/fidelity referees, LeanCert kernel-trust audits, explicit transitive axiom checks, real isolated Linux Comparator and default-kernel replay remain required before promotion. The use of purely exact algebra needs no artificial interval calculation, and this review does not claim any numerical certification has already run. Original authorship, original-question attribution and AI assistance are stated in the reviewed sources.
