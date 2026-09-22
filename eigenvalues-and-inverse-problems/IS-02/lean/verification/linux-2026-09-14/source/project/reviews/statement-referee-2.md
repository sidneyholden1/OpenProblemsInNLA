# IS-02 independent statement referee 2

- Phase/date: pre-proof statement review, 2026-09-14.
- Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of implementation; not human peer review or an official Tau Ceti run.
- Verdict: **PASS / APPROVE** for the exact bytes below. No blocking or substantive statement correction requested. This approves the statement boundary and feasible proof design, not a mathematical proof or operational verification.
- Protocol: `docs/lean/REVIEW.md`; fidelity, correctness/degeneracy, computational reduction, API reuse, documentation and credit reviewed.

## Complete source and target

I read the complete canonical README and solution.md and independently compared their bytes with base `9777c86853b40206f70438c92a47a7dec9bc66ae`. I read every definition, all four Challenge targets, NUMERICAL_TARGETS, metadata, Comparator configuration and the author's exact precheck. Every entry of statement-source-hashes.json matches the actual file.

I independently opened the [original Mourad–Abbas preprint](https://arxiv.org/pdf/1310.1273), definitions on pp. 1–2 and Conjecture 5.1 on p. 10. It defines the symmetric nonnegative doubly stochastic class, its trace slices, permutation similarity and spectral determination within that symmetric class. Its positive-trace conjecture concerns segments from I and C to vertices, plus [I,C]. The canonical n≥4 necessary implication and the Lean boundary match these restrictions; the source's trace upper bound n is automatic from nonnegative stochastic diagonals. Real symmetric matrices are diagonalizable, so similarity/equal eigenvalues with multiplicities agrees with characteristic-polynomial equality in this class. No stronger uniqueness among nonsymmetric stochastic competitors is asserted.

`LocusConjecture` retains the full original quantification over all dimensions n≥4 and every admissible A. One order-four counterexample refutes it. The theorem does not claim a classification in every dimension, new spectral feasibility result, or a converse to the necessary condition. The source witness is exact, with characteristic polynomial X(X−1)^2(X+1) and trace one.

## Actual definitions and no hidden assumptions

`stochasticSet` requires equality with transpose, every entry nonnegative, and every row sum one. Symmetry implies all column sums one. It does not require irreducibility, a fixed block form, prescribed zero pattern, rank, connectivity, or a permutation structure. The row/column index types and scalar field are the intended Fin n and real numbers. Membership is explicit for the witness and both midpoint endpoints.

`spectrallyUnique` quantifies over every B in this full set with the same actual characteristic polynomial. I inspected Mathlib `Matrix.charpoly`: it is det(XI−B), not a custom certificate or selected eigenvalue list. Polynomial equality retains multiplicities, including the repeated eigenvalue one. The intended algebraic proof must extract coefficient/derivative consequences of this equality. The helper predicate does not assume its conclusion, graph components, or one of the final pairings.

`permSimilar` existentially quantifies an actual permutation equivalence and simultaneously reindexes both matrix arguments. I inspected `Matrix.submatrix` as entrywise reindexing. This represents permutation conjugation; either permutation orientation gives the same existential relation by inversion. It does not allow independent row and column permutations or arbitrary invertible similarities. `Matrix.trace` is the actual sum of diagonal entries.

`center n` has zero diagonal and off-diagonal 1/(n−1), exactly the indicated matrix. Its totalized denominator at n=1 cannot supply a counterexample, because the universal target explicitly requires n≥4 and all certificates use n=4. Matrix `1` denotes the identity, not the all-ones matrix.

I inspected Mathlib `segment`, `openSegment`, and `Set.extremePoints`. Closed segments use nonnegative real coefficients summing to one, so both endpoints are included; open segments use strictly positive coefficients. Actual extremePoints require membership in the whole set and exclude nontrivial open-segment representations. The proposed locus ranges over every extreme point of the full symmetric stochastic polytope. There is no substitution of symmetric permutation matrices for all vertices. The set is indeed convex, as symmetry and row-sum equalities and entry inequalities are preserved by convex combinations; Mathlib's definition does not require a separate convexity proof to state or refute extreme-point membership.

## Exact feasibility and independent diagnostics

I independently wrote `verification/Referee2Precheck.py`, using sparse exact polynomial arithmetic and Fraction, without running or importing the author's SymPy script. It checked witness characteristic polynomial; the sum of the four principal minors of I−B equals four times the sixteen spanning-tree products; and all 64 edge supports divide into 38 containing a tree, 23 having an isolated vertex after excluding trees, and three disjoint pairings. The sum of principal minors is p′(1) by the determinant derivative, so this independently corroborates the proposed algebraic reduction. These are diagnostic checks, not Lean certificates or extra hypotheses.

The six-variable parametrization is exhaustive: arbitrary symmetric B supplies the six upper off-diagonal entries, row sums determine its diagonals, and all six entries and all diagonals are nonnegative. The repeated root one gives p′(1)=0. Each tree product is nonnegative, so their sum zero forces every product zero. Case analysis on zero/nonzero edges is exhaustive even at boundary values; nonnegativity upgrades nonzero to positive whenever required.

An isolated vertex has diagonal one. Trace one and nonnegative other diagonals force those diagonals to zero. Symmetry and the remaining three row sums then force every remaining edge to 1/2. I independently checked the resulting determinant is 1/4, contradicting the actual zero constant coefficient. This also eliminates multiple isolated vertices; none are silently discarded. The only remaining supports are the three pairings. In a pair, row sums force equal diagonal parameter t and off-diagonal 1−t. Trace gives t+s=1/2; determinant zero gives (2t−1)(2s−1)=0, hence parameters 0 and 1/2 in either order. Actual permutations realizing all pairings/block orders must be supplied in the proof, rather than inferred by an unproved custom classification.

The two endpoints are distinct admissible matrices and their exact midpoint is A, excluding extreme-point membership. For [I,V], the zero (0,0) entry and nonnegative V force the coefficient of I to vanish; for [C,V], the zero (0,2) entry and C[0,2]=1/3 force the coefficient of C to vanish. Either case gives A=V, contradicting nonextremality. In [I,C], the same off-diagonal zero forces A=I, false from its diagonal. These arguments cover endpoints and every admissible vertex. No assumption that the midpoint endpoints themselves are vertices is needed.

## Trust, quality, credit and remaining work

I independently elaborated Challenge using the pinned Lean 4.33.1 runtime and existing cache, exit zero. `verification/referee-2-statement-elaboration.log` records exactly four deliberate sorry warnings. The implementer's statement-build.log shows the 1797-job success and the same four placeholders. Neither establishes the mathematics; no proof implementation was inspected or written.

The compact exact algebra plan avoids graph/Perron infrastructure, root approximation and interval subdivision while retaining every competing matrix. Existing characteristic-polynomial, trace, finite permutation and convex-geometry APIs are appropriate. LeanCert kernel scalar checks and export trust assertions are a reasonable planned use, but actual term dependencies and standard-axiom closure must be checked after implementation. The statement does not assume external symbolic output.

The manifest and README truthfully describe draft status, four statement holes and pending proof/review/operational gates. Comparator selects all four targets, no definition holes, and only propext, Classical.choice and Quot.sound. I inspected these fields but did not independently rerun the official schema validator or any Linux Comparator. Final proofs, two final reviews, exported axiom audits and actual isolated Linux/default-kernel/rejection controls remain mandatory before promotion.

Colbrook's mathematical counterexample, Mourad–Abbas's original conjecture, and Holden's formalization with Codex assistance are distinguished. AI provenance and lack of human/source-author endorsement remain explicit. I make no independent attribution-priority, identity, affiliation or license-ownership authentication. No frozen file or metadata was modified by this referee.

## SHA-256

- `NLA/IS02/Definitions.lean`: `4194087b7690e047dc1eae2964f43c476b2164a4105bee5113dc7e1dfe0efd16`
- `Challenge.lean`: `c80c3fe17912547c415735bbca1568360a625c323f946e4ef6bb93e6124918a3`
- `NUMERICAL_TARGETS.md`: `2e0dd8ca18cc61cce5224d61e2aa11f85f6c7308e250526f5a1fa711693614cd`
- `formalization.yaml`: `2221aba42ed16680fc8cc18339fc0bf28bdba032dc278f435bbf06fb0157833c`
- `comparator.json`: `64f8b6a88c039b0ff1cbd574673af132ba1e76cb1f8fb52a751368fc9ef60aef`
- `README.md`: `c3d896c0c4a07d56273a2bfec5785dac92aa8b94118487a57c227cfa19b0c067`
- `../README.md`: `92f7c04c5ac0be67a7f6a4efd0d2439caaf000295fa27d259e01a22368f7ae24`
- `../solution.md`: `ae29570308b2a78678875c5e56076ce09e65cea732ce6b51142399a4b234577f`
- `reviews/statement-source-hashes.json`: `46ae06c437547d440f6f858acf400e1e9a7abb1004a2268e533becd526fecd54`
- `verification/Referee2Precheck.py`: `e9a2fbc5ccbe96e567f915207961d5a2db32ba3eb700a596ce6cfd4b585c8202`
- `verification/referee-2-independent-precheck.json`: `5e7726dc165126d68ed45fb8934a8940c703e82ada531b550ea48b41ae071ff1`
- `verification/referee-2-statement-elaboration.log`: `0a8afda01773ace51522ea9c91e9ed6ddae22cf6fd42620b58dcabfa9e9f2256`
- `verification/numerical_precheck.py`: `4fcbad9ab8ff565f7f478721808e92ef21f9f6240d07d9bdb3cbc20c1ebb6cd4`
- `verification/numerical-precheck.json`: `5a2caf9b941153850d6aa95410afe5b93e808d3fa68dacbf39d1af77844bb218`
- `verification/statement-build.log`: `aa76e688884e5dcf685c29a309217265ca707a89b7d11ef5bd96048be2e53a35`
- `.lake/packages/mathlib/Mathlib/Analysis/Convex/Extreme.lean`: `c644f42325dd7b9b8802adb5d6a767c49cdcb4e3f2a1403943f9ba27c0315eca`
- `.lake/packages/mathlib/Mathlib/Analysis/Convex/Segment.lean`: `e4dcbfea5c693f69340ffa734aefa1f4ab428959c381b8774ec77ad95d0a715a`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/Charpoly/Basic.lean`: `584eb12d39eacb591155c98cfa2089479d88cfdea8eb5f31ba5ed687de200a9a`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/Trace.lean`: `8053b04dc1c67b3a7d14262acc43b574e521940085e031726947f3c2241b7a73`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/Defs.lean`: `d4e5b5a2762eb91e47bd4d913ed72cd3fac2f7ebf40b32ae4dc0db7f34332d54`
