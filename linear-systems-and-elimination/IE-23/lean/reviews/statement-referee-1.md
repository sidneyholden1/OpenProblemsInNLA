# IE-23 independent statement referee 1

- Phase: pre-proof numerical statements and fidelity to the complete original target.
- Reviewer: `/root/iv06_statement_referee_1`, independent OpenAI Codex AI agent; not an implementer of IE-23.
- Date: 2026-09-14.
- Protocol: repository `docs/lean/REVIEW.md`, adapted Tau Ceti scope/correctness standards; not an official Tau Ceti service or human review.
- Verdict: **APPROVE** the exact bytes below. No changes requested.

## Reviewed identity

| File, relative to this Lean project | SHA-256 |
|---|---|
| `../README.md` | `922b5f8132432545fc92c29e441f672340ed964578fa65ed902d910dd251b415` |
| `../../../references/colbrook-recovered-2026-09-11/manuscripts/IE-23.tex` | `9ab20822bd6198c9a387509f2fe93182060d3d9c8ca491b8dc2d1cdd22ccc1a3` |
| `NUMERICAL_TARGETS.md` | `448fc539461059b80ce656251ccd8bd2a96e492e9c1f4ad3e564a62211c478a5` |
| `NLA/IE23/Definitions.lean` | `2ee00cdcdd36e75c481798c1522f899520790dfbbaa9e1ad831acbea14a89e81` |
| `Challenge.lean` | `145a96587f1d3026ef61af600254fd68f2a56a31d757905593a77829a80fb5e3` |
| `verification/statement-build.log` | `6b88b1c77fe5cd63fbe31648c095dbe40cf040a4afded0174dd3a74eae610051` |

I read the complete canonical README and full manuscript, including the higher-dimensional and minimizer-classification sections and the attribution notes. This approval concerns the documented counterexample scope, not formalization of every stronger manuscript result.

## Full-target fidelity

`UniquenessConjecture` quantifies over all natural dimensions `1 ≤ m < n`, all complex rectangular matrices of full row rank, every real exponent greater than two, and every complex right inverse different from the canonical pseudoinverse. A real exponent is finite, and neither excluded endpoint is added. Its strict inequality has the correct direction. The norm is applied to the right inverse itself, not to its product with the original matrix. No hypothesis on signs, real coordinates, symmetry, or an attained maximum restricts the universal inputs.

`FullRowRank` uses surjectivity of the actual `A.mulVec`. I inspected pinned Mathlib `LinearAlgebra/Matrix/Rank.lean`: matrix rank is `finrank` of the range of `A.mulVecLin`; `Matrix.coe_mulVecLin` in `Matrix/ToLin.lean` identifies the underlying function with `A.mulVec`. The `LinearMap.range_eq_top` equivalence and `Submodule.eq_top_of_finrank_eq` in `FiniteDimensional/Basic.lean`, together with the dimension of `Fin m → ℂ`, justify both directions of equivalence with rank `m`. Thus this is the usual full-row-rank condition, not a weaker custom predicate. The right-inverse identities concretely provide surjectivity and avoid a vacuous hypothesis.

`pseudoInverse` is literally conjugate transpose times the inverse of the Gram matrix. I inspected Mathlib's `conjTranspose` definition (`transpose.map star`) and the nonsingular matrix `Inv` instance (`det⁻¹ʳ • adjugate`). For full row rank over the complex field the Gram matrix is nonsingular, so this is the stated Moore–Penrose formula. For the particular `A`, its Gram matrix is `[[2,1],[1,2]]` with determinant 3, so the totalized singular-inverse default cannot supply the claimed concrete identity.

`euclideanNorm` is the square root of the sum of squared complex coordinate magnitudes. `pNorm` uses real powers for both the real exponent and its reciprocal; all bases are nonnegative. For `p > 2` and a nonzero vector at least one coordinate magnitude is positive, so the denominator is positive. The ratio set ranges over every nonzero complex vector, not a finite sample or a real subspace. `inducedNorm` is the actual real supremum. `norm_certificates` explicitly proves nonemptiness and boundedness for both concrete sets, preventing an equality justified by an empty/unbounded supremum default. The universal norms are also ordinary well-defined induced norms in these finite dimensions; the boundary does not assume their desired values.

## Exact numerical obligations and bridges

The three matrices coincide entrywise with the manuscript, interpreted in the complex field. The claimed pseudoinverse and right-inverse identities are consistent with the Gram inverse `(1/3)*[[2,-1],[-1,2]]`. The first entry distinguishes `X` from `B`. The full target is universal in `p`, so the allowed exponent `p = 4` and dimensions `m = 2`, `n = 3` suffice to disprove it. Restricting the certificate to that exponent does not restrict the conjecture being negated.

For complex coordinates `u,v`, the identity `||By||₂² = ||y||₂² - |u+v|²/3` correctly accounts for conjugate cross terms. It implies the required contraction. `X` preserves the Euclidean norm. The inequality `(|u|²+|v|²)² ≤ 2(|u|⁴+|v|⁴)` is equivalent to a nonnegative square, so it applies without any phase assumption. Positive denominators and nonnegative roots convert it to both ratio upper bounds `2^(1/4)`. The vector `(1,-1)` is nonzero and both outputs have Euclidean norm `sqrt 2`; its p-norm at four is `2^(1/4)`, giving the ratio `2^(1/4)` exactly. This supplies the lower bound/attainment and the nonempty-set obligation, while the global inequality supplies boundedness and the supremum upper bound. These are obligations to prove, not hypotheses built into the definitions.

The certificate equalities contradict the exact original strict-uniqueness implication. A separate formal theorem of global optimality among all right inverses is not needed to refute that implication; no stronger minimizer classification or all-exponent equality is claimed by these exports. All matrix, supremum and specialization bridges remain required proof work.

## Type-check and limits

I inspected the full statement-build log: Definitions and Challenge built successfully, the build ends with 2142 completed jobs, and the only diagnostics are the three deliberate Challenge `sorry` warnings. This establishes statement elaboration, not mathematical truth. No proof bodies were authored or inspected in this phase. LeanCert execution, final proof refereeing, transitive axiom audit and sandboxed Comparator remain separate gates. Source authorship, motivating-example attribution and AI formalization assistance are disclosed without making a novelty claim.
