# IE-23 independent statement referee 2

- Phase/date: pre-proof mathematical statements, 2026-09-14.
- Reviewer: `/root/iv06_statement_referee_2`, independent OpenAI Codex AI agent, assigned to IE-23; not a human referee or official Tau Ceti service.
- Repository base: `9777c86853b40206f70438c92a47a7dec9bc66ae`; new boundary reviewed from the working tree.
- Mathlib revision: `0df444a360eaa60ab8c11dca51a86af692955474`.
- Verdict: **APPROVE** at the hashes below. No substantive statement correction requested. Successful challenge elaboration was inspected, but deliberate Challenge placeholders prove no mathematics.

## Full original target and mathematical semantics

I read the complete canonical README, the complete supplied IE-23 manuscript (including the stronger minimizer classifications and attribution qualifications), the numerical targets, Definitions, and Challenge. `UniquenessConjecture` quantifies over every pair of dimensions 1≤m<n, every full-row-rank complex m×n matrix, every finite real p>2, and every complex n×m right inverse distinct from the displayed pseudoinverse. The order of the strict conclusion is correct: the distinct right inverse must have strictly larger induced norm. Since p is a real number, infinity is excluded without an extra finiteness hypothesis. The witness p=4 is within the requested open range. Negating this universally quantified implication is a complete negative answer to the original question even though the source proves a stronger all-p result.

`FullRowRank` is surjectivity of the actual matrix-vector map. I inspected Mathlib's `Matrix.rank`, which is the finite dimension of the range of `mulVecLin`, and the matrix-map API. In finite-dimensional complex spaces, the range equals the whole m-dimensional codomain exactly when its dimension is m, so this expresses full row rank faithfully. A right inverse gives surjectivity directly by mapping a codomain vector to X times that vector. No symmetry, real-only restriction, or positive-definiteness hypothesis is added.

`pseudoInverse A` is Aᴴ times the actual nonsingular matrix inverse of A Aᴴ. I inspected the imported inverse instance: it is the determinant ring inverse times the adjugate, with genuine matrix multiplication, not entrywise inversion. For full-row-rank complex A, A Aᴴ is invertible. For the witness it is [[2,1],[1,2]], with determinant 3, so no default singular inverse can create the claimed identity. Conjugate transpose is the correct complex adjoint.

The numerator uses the square root of the sum of squared complex magnitudes. The imported complex norm is sqrt(normSq), not the magnitude of a real part or a coordinatewise real norm. The denominator uses real powers on nonnegative real magnitudes; the imported Real.rpow agrees with the ordinary positive-base power and has the correct zero behavior for p>2. Both 1/p and the certificate exponent 1/4 are real division, not natural division. For any nonzero vector and p>2, at least one coordinate magnitude is strictly positive, so the denominator is strictly positive. Establishing and using this fact is a required implementation step when manipulating ratios.

`ratios` ranges over every nonzero complex input vector, and `inducedNorm` is literally the real supremum of that set. Challenge explicitly requires nonemptiness and boundedness above for both concrete ratio sets before the norm equalities. I inspected the conditional-supremum API, whose `le_csSup` and `csSup_le` require precisely boundedness and nonemptiness respectively. A proof using these gates, universal upper bounds, and an attained ratio cannot exploit an empty or unbounded supremum default. No hypothesis already assumes the desired equalities. The target concerns X alone, not the separate product XA objective.

## Independent exact certificate check

An independent Python Fraction calculation checked AB=AX=I₂; (AAᴴ)⁻¹=[[2/3,-1/3],[-1/3,2/3]]; Aᴴ(AAᴴ)⁻¹=B; B≠X; BᴴB=[[2/3,-1/3],[-1/3,2/3]]; XᴴX=I₂; and B(1,-1)=X(1,-1)=(0,1,-1). This is exact rational arithmetic, not a Lean proof. These identities match the manuscript's matrices and support both the inverse and attainment targets.

For arbitrary complex u,v, the Gram identity yields ||By||₂²=||y||₂²-|u+v|²/3≤||y||₂². X preserves ||y||₂. With a=|u|² and b=|v|², (a+b)²≤2(a²+b²) follows from (a-b)²≥0; it gives the p=4 upper bound 2^(1/4) after legitimate nonnegative roots and positive-denominator division. At (1,-1), the ratio is sqrt(2)/2^(1/4)=2^(1/4). Thus the proposed equalities concern the actual supremum and do not rely on finitely sampled upper bounds. No interval search, complex spectral approximation, or subdivision is needed.

`witness_algebra` supplies every concrete algebraic prerequisite. `norm_certificates` supplies both actual norm values and the nonempty/bounded gates. `not_uniquenessConjecture` requires the full negation, rather than only an isolated arithmetic observation. Proving minimum over every right inverse, all-p norm equalities, minimality of dimensions, or complete minimizer disks/balls is unnecessary for this negated implication and is explicitly excluded from the formalization scope. Final documentation must retain that distinction.

## Reuse and attribution

The boundary reuses Mathlib matrix inversion, complex magnitudes, real powers, matrix-vector multiplication, and conditional supremum rather than inventing substitutes. Direct finite coordinate algebra is appropriate for this small counterexample. The source mathematical argument is credited to Matthew J. Colbrook; the numerical targets also preserve the recovered notes' attribution of the smallest matrix construction to Dokmanić and Gribonval. Formalization is credited separately to Sidney Holden with OpenAI Codex assistance. I make no independent priority, novelty, affiliation-authentication, ownership, source-author endorsement, or human-peer-review claim.

## Mechanical evidence and limitations

I inspected `verification/statement-build.log`: Definitions and Challenge built successfully (2142 jobs), with exactly three deliberate Challenge sorry warnings. I did not rerun this build. No proof implementation was reviewed or written, and I ran no LeanCert certificate, transitive axiom audit, or Comparator. The actual proof must establish strict denominator positivity and global ratio upper bounds, invoke the actual matrix inverse correctly, discharge the nonempty/bounded gates, and derive the public full negation. Separate independent proof reviews, an exported-axiom audit, and isolated Comparator remain necessary. Mathematical statement approval alone is not Lean verification.

## SHA-256 of reviewed sources and evidence

- `../README.md`: `922b5f8132432545fc92c29e441f672340ed964578fa65ed902d910dd251b415`
- `../../../references/colbrook-recovered-2026-09-11/manuscripts/IE-23.tex`: `9ab20822bd6198c9a387509f2fe93182060d3d9c8ca491b8dc2d1cdd22ccc1a3`
- `NUMERICAL_TARGETS.md`: `448fc539461059b80ce656251ccd8bd2a96e492e9c1f4ad3e564a62211c478a5`
- `NLA/IE23/Definitions.lean`: `2ee00cdcdd36e75c481798c1522f899520790dfbbaa9e1ad831acbea14a89e81`
- `Challenge.lean`: `145a96587f1d3026ef61af600254fd68f2a56a31d757905593a77829a80fb5e3`
- `verification/statement-build.log`: `6b88b1c77fe5cd63fbe31648c095dbe40cf040a4afded0174dd3a74eae610051`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/NonsingularInverse.lean`: `1ee785b6ebd213ad2ed971bf3c804afee8cc6ce52be69e63572b4cf1bdb5e880`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/Rank.lean`: `67b4fa7bee02c1806f29562718bfb34c0e1f40af5ec6a91ef91cc33610657491`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/ToLin.lean`: `4a7eaa18d2821f36ecf2146f6116703a08223a15c494b66824e94259f98cceaf`
- `.lake/packages/mathlib/Mathlib/Analysis/Complex/Norm.lean`: `815efa05d2282b0b234139eac16d614f1128d69e39cf02249df887934ccc9741`
- `.lake/packages/mathlib/Mathlib/Analysis/SpecialFunctions/Pow/Real.lean`: `1f4e64fc28a20f4e19291a94dafd68daa82588b46f6ee5b9203df373ba595fa3`
- `.lake/packages/mathlib/Mathlib/Order/ConditionallyCompleteLattice/Basic.lean`: `4e4c9abe9993f2334c389d6cb4b75b31b44bb66bb87b65a95b3abac2dbd9fcc8`
