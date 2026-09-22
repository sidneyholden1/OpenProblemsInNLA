# IE-17 independent statement referee 1

- Reviewer: `/root/iv06_statement_referee_1`, independent OpenAI Codex AI agent; not an IE-17 proof implementer.
- Date: 2026-09-14.
- Phase: pre-proof semantic fidelity, numerical statements and required proof bridges.
- Protocol: `docs/lean/REVIEW.md` and its Tau Ceti adaptation; not official Tau Ceti service review or human peer review.
- Verdict: **PASS / APPROVE** the exact bytes below. No blocking correction requested.

## Reviewed identity

I read the entire canonical README, complete Colbrook manuscript, full numerical plan, Definitions and Challenge. I independently compared the two canonical-source files against Git blobs at base `9777c86853b40206f70438c92a47a7dec9bc66ae`; both matched. Lean-project paths below are relative to this directory.

| File | SHA-256 |
|---|---|
| Repository `linear-systems-and-elimination/IE-17/README.md` | `53cba6429e84e1c8e055e10e5b7093f03ee0d1a94c8bf57f30ed150ae4cc08dc` |
| Repository `references/colbrook-recovered-2026-09-11/manuscripts/IE-17.tex` | `d0e446f7b9ee5669c1beece9ca91a89387b2f8e340c19bca8254f556386efbcd` |
| `NLA/IE17/Definitions.lean` | `eda180881ac84c75c75735bc4e8525bdf326862bed550890efe6381a14f4c90b` |
| `Challenge.lean` | `8c5aa2240fa18627857e190591374dd50066f2962aed5fab0c6591b3eec1537a` |
| `NUMERICAL_TARGETS.md` | `767f706cbf630848334c82a5de73798ad0a6f5a11d16af4e3ac95e8c07dca516` |
| `verification/numerical_precheck.py` | `051008c0a0121031bd803d183a10ecf8c6ac5737aeff21e29b0173b445278161` |
| `verification/numerical-precheck.json` | `de8a23f41e40e30e56d1c26d82dc9acde3d3e4e9185f7a7f8e5eb6279af5ccf1` |
| `verification/statement-build.log` | `10702b6b1d27730e07228a50a74b30cd8c6bafcea55b22a249e0d6dcbcc4aeb1` |

## Both original questions and exact iterates

`counterexample` explicitly negates each monotonicity assertion separately, as a conjunction of two negative claims. A failure only of their conjunction would be weaker; this boundary correctly requires both failures. The preceding exports require actual increases of the two defined errors for the same exact iterates. No normal-residual decrease is substituted for a backward-error statement.

`krylovSpace` is the real linear span of `(AᵀA)^j Aᵀb` for exactly `0 ≤ j < k`, implementing the zero initial guess. `isLSMRIterate` requires membership, minimization of the actual Euclidean normal-residual norm over the entire subspace, and least Euclidean length among all ties. This is the equivalent variational characterization explicitly supplied by the canonical problem, not a hand-picked recurrence or restricted test set. Full column rank is not imposed on the universal monotonicity questions; the injectivity claim is correctly attached only to the concrete witness.

`monotonicError` compares indices `k` and `k+1`, requires `k ≥ 1` and both iterates nonzero, and requires the first normal residual to be nonzero. It therefore excludes comparisons starting after exact termination while permitting the second iterate to be the terminating one. The witness export proves both normal residuals nonzero, so neither actual comparison invokes an exceptional termination value. Zero dimensions introduce no additional relevant cases: a zero-dimensional unknown vector cannot be nonzero, and a zero-dimensional observation space has zero normal residual.

## Actual norms, infimum and Moore–Penrose projector

I inspected pinned Mathlib `Analysis/Normed/Lp/PiLp.lean`: `norm_eq_of_L2` identifies the `WithLp 2` norm with the square root of the sum of squared coordinate norms. Thus `vnorm` genuinely uses Euclidean length, including on the sum-indexed stacked vector. I also inspected `Analysis/CStarAlgebra/Matrix.lean`: `Matrix.Norms.L2Operator` activates the rectangular matrix norm transported from continuous linear maps between Euclidean spaces. The explicit scope in Definitions and Challenge therefore gives spectral norms of perturbations, not function-entry or Frobenius norms.

`feasible` is exactly the perturbed normal equation with only `A` changed and `b` fixed. Its residual sign differs from the named residual by an overall minus sign, which leaves the zero equation unchanged. `backwardError` is the real infimum of all actual feasible perturbation norms. The set is structurally nonempty (`E=-A`) and bounded below by zero (norm nonnegativity); the witness export additionally requires attainment of both infima and hence actual minima. At an exact least-squares solution `E=0` makes this infimum zero, matching the canonical convention without a separate conditional definition. No empty-set value or asserted optimum is hidden in the definition.

Mathlib's `Matrix.fromRows` is the actual `Sum.elim` row concatenation. Therefore `stacked` is precisely `[A;ηI]`, and the vector in `approxError` is precisely `[r;0]`. The norm is taken after multiplying by `K*leftPseudo K`, then divided by `||x||₂`, in the canonical order. `leftPseudo` uses the actual inverse in `(KᵀK)⁻¹Kᵀ`. This full-column-rank formula is valid throughout the relevant nonterminated/nonzero domain: nonzero normal residual implies `r ≠ 0`, so `η=||r||₂/||x||₂>0`, which makes the lower block injective regardless of the rank of `A`. At termination the approximation is explicitly zero. Thus the universal approximation assertion is not weakened by a rank-deficient pseudo-inverse substitute. The witness certificate also explicitly proves all four real Moore–Penrose equations, including both symmetry conditions, so the two displayed values must be values of the genuine projector. These equations are conclusions to prove, not assumed hypotheses.

## Exact arithmetic independently checked

I performed independent standard-library rational arithmetic, separate from the supplied precheck script, using the manuscript matrix/vector entries. It verified the two Krylov coefficient formulas, normal-residual stationarity against the appropriate `Hg`/`H²g` columns, the exact displayed residual vectors, and nonzero iterates/residuals/normal residuals. The three nonzero diagonal entries of `A` ensure full column rank. Stationarity and injectivity of the normal-equation operator on the relevant subspaces provide the variational and unique/minimum-length proof route; the formal export still requires those complete facts.

The independent calculation reproduced the twelve rational upper-perturbation entries from the source formula and checked the perturbed normal equation exactly. It checked `κI-EᵀE = L diag(D)Lᵀ` using the recorded rational factors and strictly positive diagonal, with `κ=1979/2000`. This supplies consistent data for a genuine spectral-norm proof; the external calculation is not that proof.

For the lower certificate it verified every entry of `(5/6)C+(1/6)D-(99/100)I = K/2407881992100`, all four weighted diagonal-dominance slacks for weights `(2000,2,37,258)`, and the zero-new-residual bound `||r2||₂²/||x2||₂² > 99/100`. The planned uniform argument correctly separates zero and nonzero new residuals before any normalization. The exported weak endpoint `sqrt(99/100) ≤ μ(x2)` is sufficient because `1979/2000 < 99/100`; it avoids inferring a strict infimum bound from merely pointwise strict inequalities. Both infimum attainments are separate mathematical obligations, requiring a finite-dimensional existence argument rather than an unjustified optimizer invocation.

Finally, independent exact diagonal-Gram calculation reproduced both large rational approximation squares verbatim and verified the strict cuts `503/500` and `1007/1000`. The source's squared projector formula is used here only as a numerical consistency check. The formal export must connect it to the actual stacked projector and Moore–Penrose identities, then use nonnegative norms to pass from ordered squares to ordered errors. No floating-point calculation, approximate eigenvalue or fixed finite test substitutes for a universal perturbation bound.

## Elaboration and outstanding gates

I inspected the full statement-build log: Definitions and Challenge built successfully in 2,711 jobs, with exactly four intentional Challenge-placeholder warnings. Those warnings are expected in the isolated statement environment and prove no mathematics. I did not implement any proof body or modify the boundary. The exact prechecks above validate proposed data only. All four exports still require proof implementation, independent final code/scope review, LeanCert kernel-trust and transitive-axiom audits, and actual isolated Linux Comparator/default-kernel replay before promotion. This report does not assert that any Linux run or final proof gate has completed. Original attribution and AI assistance are disclosed; no conclusion concerning Frobenius errors, perturbed right-hand sides, or a damped method is inferred.
