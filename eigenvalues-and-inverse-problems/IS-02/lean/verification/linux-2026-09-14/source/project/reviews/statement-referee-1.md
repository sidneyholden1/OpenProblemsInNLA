# IS-02 independent statement referee 1

**Verdict: PASS / approve these exact statements for proof implementation.** No blocking scope, semantic or feasibility findings.

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not the statement implementer. Phase: before proof bodies. Date: 2026-09-14. This review covers source fidelity, full scope, nonvacuity, proof feasibility, computation reduction, reused API and attribution under `docs/lean/REVIEW.md`'s Tau Ceti adaptation. It is not an official Tau Ceti assessment, endorsement or external human review.

## Sources and byte boundary

I read the complete canonical README and complete Colbrook `solution.md`, all Definitions and Challenge declarations, numerical targets, metadata, Comparator configuration, and exact symbolic precheck code/output. Both canonical sources are unchanged from base `9777c86853b40206f70438c92a47a7dec9bc66ae`. Their SHA-256 hashes are README `92f7c04c5ac0be67a7f6a4efd0d2439caaf000295fa27d259e01a22368f7ae24` and solution `ae29570308b2a78678875c5e56076ce09e65cea732ce6b51142399a4b234577f`.

I independently opened the [Mourad–Abbas primary preprint](https://arxiv.org/pdf/1310.1273), definitions on printed pages 1–2 and Conjecture 5.1 on printed page 10. Its admissible class is symmetric doubly stochastic, and its positive-trace necessary condition uses the same three segment families and polytope vertices. Its similarity-based spectral wording agrees with characteristic-polynomial equality on real symmetric matrices by diagonalizability. The source trace upper bound is automatic from nonnegative stochastic rows. The retained canonical restriction n≥4 excludes the already-treated order-three setting; the permitted order-four counterexample suffices.

Every entry in `reviews/statement-source-hashes.json` was independently recomputed and matched, including again at report creation:

| File | SHA-256 |
| --- | --- |
| `NLA/IS02/Definitions.lean` | `4194087b7690e047dc1eae2964f43c476b2164a4105bee5113dc7e1dfe0efd16` |
| `Challenge.lean` | `c80c3fe17912547c415735bbca1568360a625c323f946e4ef6bb93e6124918a3` |
| `NUMERICAL_TARGETS.md` | `2e0dd8ca18cc61cce5224d61e2aa11f85f6c7308e250526f5a1fa711693614cd` |
| `formalization.yaml` | `2221aba42ed16680fc8cc18339fc0bf28bdba032dc278f435bbf06fb0157833c` |
| `comparator.json` | `64f8b6a88c039b0ff1cbd574673af132ba1e76cb1f8fb52a751368fc9ef60aef` |
| `README.md` | `c3d896c0c4a07d56273a2bfec5785dac92aa8b94118487a57c227cfa19b0c067` |

## Semantic fidelity and degeneracy

`stochasticSet` imposes the actual real matrix symmetry equation, entrywise nonnegativity and every row sum equal to one. Symmetry implies column sums one, so this is precisely the symmetric stochastic polytope. No irreducibility, connectivity, fixed zero pattern, block form, rational-entry restriction or graph hypothesis is imposed on competitors. Diagonal entries are automatically at most one, hence trace≤n; retaining only the strict positive-trace hypothesis does not enlarge the original trace range.

`Matrix.charpoly` is Mathlib's actual determinant of the characteristic matrix, det(XI−A), which I inspected in `LinearAlgebra/Matrix/Charpoly/Basic.lean`; `Matrix.trace` is the diagonal sum. Equality of these polynomials records all algebraic multiplicities. All matrices relevant to spectral uniqueness are real symmetric, so no Jordan-form ambiguity weakens the source's same-spectrum/similarity condition. The concrete witness export requires characteristic polynomial X(X−1)²(X+1), trace exactly one, positive trace and actual admissibility.

`spectrallyUnique` quantifies over EVERY matrix B in that same class with the same characteristic polynomial. Its omission of A-membership inside the reusable predicate is harmless: the original conjecture and the separate witness certificate provide A-membership explicitly. The hypothesis is also nonvacuous, since a proved admissible A competes with itself. `permSimilar` ranges over genuine equivalences of Fin n and simultaneously reindexes both rows and columns. I inspected `Matrix.submatrix`: its entry is A(σ i)(σ j). This is exactly permutation similarity; choosing the inverse permutation merely reverses convention and does not change the existential relation. Arbitrary maps or separate row/column relabelings are not permitted.

`center n` has zero diagonal and off-diagonal 1/(n−1), exactly the canonical C_n. The conjecture assumes n≥4 and the witness uses n=4, so Lean's totalized division at n=1 is irrelevant. The literal matrix `1` in the locus is the identity matrix under the square-matrix instance, not the all-ones matrix.

I inspected actual `segment` and `Set.extremePoints` in the pinned Mathlib. Closed segment membership requires nonnegative real weights whose sum is one. This includes both endpoints and equals the canonical (1−t)X+tY parametrization. Extreme-point membership first requires membership in the WHOLE underlying set and then excludes nontrivial open-segment representations inside that set. Thus `proposedLocus` includes all actual polytope vertices, including non-permutation vertices, and all three segment families. No custom finite vertex list or assumption that vertices are permutation matrices is used. The stochastic class is convex by its linear equalities and nonnegativity inequalities, so the extreme-point interpretation matches the canonical convex-polytope wording.

The endpoint export requires two distinct admissible matrices and their exact midpoint equal to the witness. This supplies a genuine nontrivial convex combination and supports non-extremality. For segments from I, the witness's zero (0,0) diagonal forces the weight of I to zero; for segments from C, the zero (0,2) entry and C(0,2)=1/3 force the weight of C to zero. Both would make the witness equal the extreme endpoint, contradicting non-extremality. For [I,C], the same off-diagonal entry forces I, which differs from the witness. These arguments include endpoint cases and use only nonnegativity of the actual extreme endpoint.

`counterexample : ¬ LocusConjecture` therefore negates the complete original all-dimensions necessary condition. The other three exports establish all hypotheses and the contrary conclusion at n=4. No general classification, graph restriction, or sufficient-condition converse is advertised.

## Proof feasibility and independent exact diagnostics

The planned algebraic proof changes the source graph argument without changing its result or competitor scope. Symmetry and row sums let six arbitrary nonnegative off-diagonal variables parametrize every possible B; diagonal nonnegativity remains available. For the actual characteristic polynomial p, the proposed p′(1)=4T identity involves all sixteen spanning-tree monomials. The required repeated eigenvalue one makes p′(1)=0. Each monomial is nonnegative, so each must vanish. Splitting every edge into zero or positive covers every support, including boundary cases; there is no positive lower bound on nonzero edges.

I independently checked the identity using a separately written standard-library sparse-polynomial determinant expansion: p′(1) is the sum of the four principal cofactors of I−B, and this polynomial was exactly four times the sixteen tree monomials. I independently classified all 64 supports by connected-component merging: 38 connected, 23 with an isolated vertex, and only 3 consisting of two disjoint edges. This confirms the proposed finite reduction without using the author's SymPy program as an oracle.

An isolated vertex forces its diagonal to one. Trace one and nonnegative remaining diagonals force the other diagonals to zero; the remaining three row sums uniquely force the triangle's three entries to one half. I checked its determinant is 1/4, contradicting the zero determinant from the actual characteristic polynomial. The three disjoint-edge supports leave two symmetric stochastic 2×2 blocks with diagonal parameters t,s. Trace gives t+s=1/2, while determinant zero gives (2t−1)(2s−1)=0. Consequently the parameters are 0 and 1/2 in one order, exactly the witness up to simultaneous permutation. This covers all remaining cases. These coefficient/derivative/determinant and relabeling bridges must be proved in Lean during implementation; they are not yet formal evidence.

My exact rational diagnostics additionally checked witness symmetry, nonnegativity, row sums, trace, characteristic polynomial and the two admissible distinct midpoint endpoints. Characteristic-polynomial equality was checked as a degree-four identity at five distinct exact rational points. The diagnostic source uses integers/Fractions only, with no floating eigenvalues. All independent checks passed. The author's exact symbolic code/output also agrees.

This is an appropriate computation reduction: small exact finite algebra, no graph/Perron development, no spectral root isolation, and no interval subdivision. The planned LeanCert kernel positivity certificate and later export trust checks are suitable; using a simple scalar certificate does not replace the required general algebra. The definitions reuse actual Mathlib charpoly/trace/permutation/segment/extreme-point APIs rather than custom conclusion-shaped abstractions. Names and comments make the obligations clear.

## Elaboration, metadata and limitations

I inspected the author's 1797-job statement-build log and independently replayed pinned Lean 4.33.1 `lake env lean Challenge.lean` on local macOS with the shared dependency cache. Exit 0, with exactly four intentional Challenge `sorry` warnings. Definition elaboration and statement consistency are supported; the placeholders prove no mathematics.

The inspected formalization.yaml is truthful statement-stage scaffolding, preserves Colbrook's mathematical credit and the original Mourad–Abbas source, records Holden/Codex formalization credit, and makes no source-author endorsement or novelty claim. Comparator names all four public targets, no definition holes and only the standard three axioms. The parent's reported official schema validation was not independently repeated in this review. No proof trust audit, final proof review, Linux Comparator replay or rejection controls have yet been established for this project.

Additional source/evidence hashes:

- `verification/numerical_precheck.py`: `4fcbad9ab8ff565f7f478721808e92ef21f9f6240d07d9bdb3cbc20c1ebb6cd4`
- `verification/numerical-precheck.json`: `5a2caf9b941153850d6aa95410afe5b93e808d3fa68dacbf39d1af77844bb218`
- `verification/referee_1_statement_check.py`: `a9ec6574ccdae1ee45307b43ef6f2e145c301f0601c17d340bb6fe44f3adf28a`
- `verification/referee-1-statement-precheck.log`: `8b47192646b3496c55fb3d7a6fbb8325a683faebf39132001c4c2706f47d294d`
- `verification/referee-1-statement-build.log`: `0a8afda01773ace51522ea9c91e9ed6ddae22cf6fd42620b58dcabfa9e9f2256`

No blocking changes requested. I did not edit frozen mathematical files, metadata or implement any proof. Approval is specific to the bytes above and permits implementation only; final proof review must revisit every algebraic bridge. Canonical ID, path and target remain unchanged. Latest account usage check: 28% remaining, above the user's 25% checkpoint threshold.
