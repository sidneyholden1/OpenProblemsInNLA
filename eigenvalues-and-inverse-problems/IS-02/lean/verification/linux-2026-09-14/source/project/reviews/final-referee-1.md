# IS-02 independent final proof referee 1

**Verdict: PASS for full-target mathematical fidelity and the completed local Lean proof.** No blocking correctness, scope or trust findings. Actual isolated Linux Comparator/default-kernel replay with rejection controls remains a separate pending gate; no canonical promotion follows from this report alone.

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not an implementer. Date: 2026-09-14. Phase: final proof. Responsibilities: source fidelity, complete quantifiers, characteristic-polynomial/multiplicity semantics, support classification, permutation semantics, extreme-point/segment definitions, trust and computation review under the repository Tau Ceti adaptation in `docs/lean/REVIEW.md`. This is not official Tau Ceti review or external human certification.

## Sources and hashes

I read the full Algebra, Support, Classification, Proof and Solution implementations, reread Definitions and Challenge, and inspected current metadata/configuration/logs. The complete canonical README and Colbrook solution were read in the preceding statement review; I independently verified both remain byte-identical to `9777c86853b40206f70438c92a47a7dec9bc66ae`. Their hashes remain README `92f7c04c5ac0be67a7f6a4efd0d2439caaf000295fa27d259e01a22368f7ae24` and solution `ae29570308b2a78678875c5e56076ce09e65cea732ce6b51142399a4b234577f`. The statement review also checked the [primary preprint](https://arxiv.org/pdf/1310.1273), definitions on pp. 1–2 and Conjecture 5.1 on p. 10; no source change requires a different interpretation.

Definitions, Challenge and numerical targets match pre-proof freeze `4e9976ff` byte for byte. Preserved README/formalization files in `reviews/statement-review-snapshot` match the original statement-review hashes. All 17 final snapshot entries were independently recomputed, matched, and rechecked when writing this report:

| File | SHA-256 |
| --- | --- |
| `NLA/IS02/Definitions.lean` | `4194087b7690e047dc1eae2964f43c476b2164a4105bee5113dc7e1dfe0efd16` |
| `Challenge.lean` | `c80c3fe17912547c415735bbca1568360a625c323f946e4ef6bb93e6124918a3` |
| `NUMERICAL_TARGETS.md` | `2e0dd8ca18cc61cce5224d61e2aa11f85f6c7308e250526f5a1fa711693614cd` |
| `NLA/IS02/Algebra.lean` | `586d36609e870520127bb9c4aa295fa9083f31f2b60dabbe115ad0fe836e0379` |
| `NLA/IS02/Support.lean` | `8bbfbd59a4fc234000b690516f1e670e5df41e9a8d95e6d2b8d5d3a4daaa566f` |
| `NLA/IS02/Classification.lean` | `3bee9f0d0c2cb5d1b873c3f9faeae469f0797c60974f01fb73df7451618d8860` |
| `NLA/IS02/Proof.lean` | `c39ce54b49ac58b00fb6bfa239bbd9085f2147a830af887a4e2750da9954e919` |
| `Solution.lean` | `86949f0c5712d52ab026ac22bec706c6938dcebf155539d7837dda4f1bc2eb29` |
| `comparator.json` | `64f8b6a88c039b0ff1cbd574673af132ba1e76cb1f8fb52a751368fc9ef60aef` |
| `lakefile.toml` | `c7dab59556c63adeb79fa9814e35ec43edb004160d8d79c314a1760c66b046ca` |
| `lake-manifest.json` | `84d8f7719040dade88e1d169389aa9a9b937686ce5782ec5063d8cc0fa726c08` |
| `lean-toolchain` | `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71` |
| `formalization.yaml` | `50b203dabab86243d05b3a61dea16640bebfef1348e0b5a25b0e036fb6ff6fb3` |
| `README.md` | `b912021dad087ed98775fabcd118cf7220b19ef54dcb67c2a09a98227a478cef` |
| `verification/final-build.log` | `343c10f323bca5be5cc9b128a90d6a24616ae9d6b029dd948230c507982e1170` |
| `verification/AxiomAudit.lean` | `83d2504c923307a3f4393ac828fb01aaf8eec35729698140ece20987984ab120` |
| `verification/axioms.log` | `971e80367aacf039541bf88d725d1c86fc94387ad128c325ffaf9043335fbe76` |

## Complete competitor classification

`stochasticSet` remains the full real symmetric, entrywise nonnegative, row-stochastic class; symmetry gives column sums one. Every admissible competitor B is rewritten by `stochastic_model` into the six-variable model using actual symmetry and all four row equations. The six variables are B's actual upper-triangle entries. Neither a graph decomposition nor zero pattern, rationality, irreducibility or positive lower bound on nonzero edges is assumed.

`det_four` derives the determinant expression from Mathlib's Laplace expansion and three-dimensional determinant theorem. I inspected these imported APIs. `model_charpoly` proves equality with the actual Mathlib characteristic matrix, then expands its actual determinant over the polynomial ring and closes the exact identity with `ring`. It does not define a surrogate polynomial or infer a polynomial equality from sampled numerical eigenvalues. The formula in powers of X−1 has coefficients 2·edgeSum, pairSum and 4·treeSum.

`model_spectral_constraints` uses the actual trace/characteristic-coefficient theorem, derivative evaluated at one, and evaluation at zero to derive edgeSum=3/2, pairSum=2, treeSum=0. I checked the trace theorem's coefficient index is card(Fin 4)−1=3 and its nonempty assumption is satisfied. The derivative calculation uses the repeated eigenvalue one in X(X−1)²(X+1); constant evaluation retains the zero eigenvalue. Degree and multiplicities are therefore not discarded. Characteristic-polynomial equality is the canonical same-spectrum condition for real symmetric matrices, which are diagonalizable, and the admissible source class is unchanged.

`support_shape` exhaustively splits the six nonnegative real variables into zero or strictly positive, pruning branches as soon as an isolated-vertex pattern or pairing pattern is obtained. Positive-tree branches prove treeSum>0 from an actually positive product plus nonnegative remaining terms and contradict treeSum=0. Every zero boundary is included. The result lists four isolated-vertex patterns and three pairings, without additionally assuming the surviving edges are nonzero. The latter degeneracy is resolved by the subsequent equations. This implements the previously independently checked 64-support reduction in Lean proof terms; the external precheck is not an imported theorem.

`model_unique` handles all seven patterns. For each isolated vertex, the trace-derived edge sum and nonnegative diagonal inequalities force the remaining triangle weights to 1/2. This gives pairSum=9/4, contradicting pairSum=2. The frozen plan described this as a determinant-zero contradiction: the implementation instead uses the equivalent constraint obtained from polynomial evaluation at zero together with trace and derivative. This is a valid smaller algebraic route, not a statement change or omitted case.

For each pairing, edgeSum and pairSum force the two remaining edge weights to 1 and 1/2 in either order. The quadratic factorization is proved over arbitrary real values, and both zero-product branches are handled. Thus all six possibilities are included. `perm0` through `perm5` are genuine `Equiv.Perm (Fin 4)` values whose bijectivity is proved by kernel decision. Every resulting matrix is checked entrywise against the witness simultaneously reindexed by the selected permutation. This is full permutation similarity, not independent row/column reordering or a nonbijective map. The public `spectral_uniqueness` theorem starts with an arbitrary admissible B and applies this classification; no competitor is prefiltered by a hidden custom predicate.

## Witness, geometry and universal negation

The witness is proved symmetric, nonnegative and row-stochastic by actual finite entry checks. Its polynomial is established through `witness_model` and the proved general polynomial identity, with exact rational entries. Its actual trace is one. Thus all hypotheses of the original positive-trace implication are established, and spectral uniqueness is not vacuous.

Both explicit endpoints are proved admissible and distinct, and the witness is their exact midpoint. `witness_not_vertex` constructs an actual open-segment membership with positive half weights, applies Mathlib's actual extreme-point criterion, and contradicts endpointLeft's (2,2) entry differing from the witness. It does not assume that the polytope vertices are permutation matrices.

`witness_not_locus` eliminates all branches of the actual proposed union. It unfolds membership in each closed real segment into nonnegative weights a,b with a+b=1. In [I,C], the (0,2) and (0,0) entries contradict one another. In [I,V], the zero diagonal and V's nonnegativity force the weight of I to zero. In [C,V], the zero (0,2) entry, C(0,2)=1/3 and V's nonnegativity force the weight of C to zero. Both latter branches give V=witness and contradict non-extremality. Membership of V in the whole stochastic set comes from actual extreme-point membership. Endpoint cases are included; there is no division by a possibly zero segment weight. The only center denominator used is 4−1=3, and the conjecture itself restricts dimensions to n≥4.

Finally `counterexample` specializes the unchanged universal conjecture at n=4 with the witness's proved admissibility, full spectral uniqueness and positive trace. Its conclusion contradicts the proved full-locus exclusion. All four Challenge signatures are preserved in the Solution environment. The source's complete negative target is settled locally; no classification at other dimensions or converse necessary/sufficient statement is claimed.

## Independent replay and LeanCert trust

I independently re-elaborated Algebra, Support, Classification, Proof, Solution and the author's AxiomAudit with pinned Lean 4.33.1 on local macOS using the shared pinned cache. All six exited 0. I also ran my own separately named audit, printing axiom closures for all four exports and for `model_charpoly`, `support_shape` and `model_unique`. Every audited declaration depends exactly on `[propext, Classical.choice, Quot.sound]`. The four export `#assert_trust kernel` checks replayed. The solution sources contain no `sorry`, `admit`, extra `axiom`, `native_decide`, `unsafe` or `implemented_by`; Challenge's four intentional placeholders are in its separate, unimported statement module.

I printed and inspected the actual `witness_certificates` term. After rewriting the genuine trace equality, its positivity proof invokes `LeanCert.Validity.verify_strict_upper_bound_dyadic_checked` on constant zero, bound one, singleton interval [0,0], precision −53 and depth 10. This proves 0<1 and is transported back to 0<trace(witness). I inspected the imported theorem's checked-domain/evaluation-bound argument and LeanCert's kernel closure using `mkDecideProof` and eager `mkAuxLemma` kernel validation. Explicit kernel mode does not use native fallback. The actual term and transitive axiom audit support the claimed trust mode. LeanCert's scalar use is intentionally small; the substantial characteristic-polynomial/classification proof is exact kernel-checked algebra, not an interval oracle.

The implementation is reasonably economical: a reusable ring-level determinant lemma from Mathlib APIs, one exact symbolic charpoly identity, pruned support cases, six finite permutation checks, and direct coordinate arguments for the locus. There is no interval subdivision, approximate spectrum, heavyweight graph theorem or exhaustive numerical eigenvalue search. Names/placement distinguish definitions, algebra, support, classification and final exports. Source credit to Colbrook and the original Mourad–Abbas conjecture, Holden's formalization credit and Codex assistance remain visible.

Own evidence:

- `verification/referee-1-final-hashes.log`: `c0b0dbf0d8da29ab44d2d1d548a539357604d6db4915e6c9c10421a38e4c8398`
- `verification/referee-1-final-replay.log`: `9ad6cb37b9a65d7fdf289b0aab6e5c4e12c802fa1141621b7943bbaa2d478ad9`
- `verification/Referee1FinalAudit.lean`: `4b142fac8449aab7767bd75d4bbcdedb395f06da6b9521d3cf50a1ba5fa36547`
- `verification/referee-1-final-axioms-and-terms.log`: `6348a3aeca03f29e52360489b1fd02a286a52aa63fb9524efa183edb1bfbbc62`

## Remaining gates and limitations

Local replay uses the existing pinned dependency cache; it is not a clean or isolated Linux build. The author build log records 3582 jobs, which I inspected, but the independently executed commands above are the evidence for this review. The Comparator configuration correctly names all four exports, permits only the three standard axioms and has no definition holes; that inspection is not a Comparator run. Actual isolated Linux Comparator/default-kernel replay and rejection controls remain pending due the reported push-approval block. No such run or canonical status promotion is claimed here. Current metadata accurately records pending final reviews/Linux at the reviewed hashes and may be updated after reviews without changing mathematical bytes. I did not change proof or metadata. Latest account check: 27% remaining, above the user's 25% checkpoint threshold.
