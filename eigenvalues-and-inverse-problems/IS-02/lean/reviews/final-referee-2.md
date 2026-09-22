# IS-02 independent final referee 2

- Phase/date: final proof review, 2026-09-14.
- Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of implementation; not human peer review or official Tau Ceti service.
- Verdict: **PASS for full-target fidelity and local proof review**, bound to the exact hashes below. No blocking or substantive correction requested.
- Actual isolated Linux Comparator/default-kernel replay and rejection controls remain pending. This report does not claim those gates passed or authorize canonical promotion.
- Protocol: `docs/lean/REVIEW.md`; correctness, full scope, degeneracy, computation reduction, API use, clarity, and attribution covered.

## Source and immutable statement alignment

I read Algebra, Support, Classification, Proof, Solution and their actual definitions/signatures, and reviewed the complete canonical README and Colbrook solution.md already inspected in the statement phase. I independently checked all 17 entries of proof-source-hashes.json, all three mathematical boundary files against frozen commit `4e9976ff`, and both canonical source files against `9777c86853b40206f70438c92a47a7dec9bc66ae`. All match. Both original statement-reviewed metadata files match their preserved statement-review-snapshot copies. No earlier substantive finding required a fix.

The target remains the full universal positive-trace necessary condition for real symmetric nonnegative stochastic matrices in every n≥4. The four-dimensional witness has actual characteristic polynomial X(X−1)^2(X+1), trace one, uniqueness against every admissible competitor with that polynomial, and exclusion from the full extreme-point segment locus. This is a full negative resolution, not a classification in all dimensions. Characteristic-polynomial equality retains multiplicities; symmetry makes it equivalent to the source's isospectral/similarity condition in the intended class. Simultaneous permutation reindexing is the intended permutation conjugacy, and all vertices are actual extreme points of the complete set, not just permutation matrices.

## Actual algebra and universal competitor bridge

`det_four` is proved from Mathlib's actual determinant expansion along row zero and its 3×3 determinant theorem, followed by ring arithmetic. I inspected the imported expansion: its minors, signs and row/column deletions are genuine determinant operations. `model_charpoly` first proves equality with the actual characteristic matrix, then expands its determinant in Polynomial ℝ. The resulting identity is exact for every six-tuple of real numbers:

p(X)=(X−1)^4+2 edgeSum (X−1)^3+pairSum (X−1)^2+4 treeSum (X−1).

It is not an assumed coefficient table, a polynomial selected by definition, or an equality only at sampled arguments. `model_spectral_constraints` uses the actual equality to X(X−1)^2(X+1), the actual trace coefficient theorem, derivative evaluation at one, and polynomial evaluation at zero. These yield edgeSum=3/2, pairSum=2, treeSum=0. The trace coefficient uses index card(Fin4)−1=3, correctly preserving the degree-four characteristic polynomial and repeated root one. Neither squarefree reduction nor approximate root comparison appears.

`stochastic_model` proves that every arbitrary B in stochasticSet4 equals the six-parameter model: transpose equality gives all mirrored entries, and four actual row sums determine all diagonals. `spectral_uniqueness` starts with arbitrary B, its genuine membership and characteristic-polynomial equality, rewrites using this proved model equality, then applies classification. No irreducibility, graph decomposition, positive-edge pattern, rank, or block hypothesis is imposed on B.

## Exhaustive support and degeneration

`support_shape` branches on equality-to-zero versus strict positivity using each of the six nonnegativity premises. Its branches close early only by producing one of four isolated-vertex zero cuts or three pairing zero patterns, or by proving treeSum>0 from an actually positive tree product and nonnegative remaining products. This pruned tree is exhaustive; zero entries, multiple isolated vertices and overlaps between zero patterns are covered. The terminal patterns do not improperly assert surviving edges positive. The subsequent equations eliminate any further degeneracy.

`model_unique` obtains nonnegative diagonal constraints from genuine membership and combines them with the spectral constraints. In each isolated-vertex case, the remaining edges are forced to 1/2 by those linear equalities/inequalities. Substituting into pairSum gives 9/4 instead of 2, a contradiction. This is the exact coefficient version of the proposed determinant contradiction: pairSum=2 was derived using actual evaluation at zero together with edgeSum/treeSum. A separate determinant-zero lemma is unnecessary, and nothing is omitted by using this shorter argument.

For each pairing pattern, edgeSum and pairSum force its two surviving off-diagonal entries to be 1 and 1/2 in either order. The proof obtains a product of two linear factors, uses the exact no-zero-divisor property of ℝ, and treats both roots. It supplies actual bijections for all six cases and proves every matrix entry equals the witness simultaneously reindexed by that bijection. These are kernel-proved `Equiv.ofBijective` constructions, not arbitrary functions assumed to be permutations. I independently checked the six arrays are bijective, give six distinct matrices, and cover the entire 24-permutation orbit of the witness; `verification/final-referee-2-permutations.json` retains that additional diagnostic check. It is not a substitute for the Lean equalities.

No variable denominator is introduced in the classification. The only rational constants have fixed nonzero natural denominators. The center's denominator n−1 is used at n=4, so its totalized value at n=1 is irrelevant. There is no vacuous or impossible witness hypothesis: witness membership, polynomial and positive trace are explicitly proved.

## Full locus exclusion and counterexample

Both displayed endpoints are proved symmetric, nonnegative and stochastic, with exact distinctness and midpoint identity. `witness_not_vertex` uses Mathlib's real openSegment with strictly positive coefficients 1/2,1/2 and the actual extreme-point definition. It obtains the forbidden endpoint=witness equality and contradicts their (2,2) entries. It need not assume either endpoint is itself a vertex.

`witness_not_locus` exhausts the exact three branches of proposedLocus. For [I,C], entries (0,2) and (0,0) contradict the convex coefficient sum. For [I,V], the zero witness diagonal plus V's nonnegativity forces the I coefficient to zero. For [C,V], C[0,2]=1/3 and the same zero witness entry force the C coefficient to zero. In both vertex branches the remaining coefficient is one, giving V=witness and contradicting the established nonvertex theorem. All coefficients are those of actual closed real segments, including endpoints; no generic-parameter or interior-only assumption is added. I inspected the imported extreme-point membership theorem and segment definitions.

`counterexample` applies the entire original conjecture at n=4 to the already-proved membership, full spectral_uniqueness, and strict positive trace. Its conclusion contradicts actual locus exclusion. The quantified conjecture is neither redefined nor weakened in the proof layer.

## Independent replay and actual trust evidence

I independently ran `lake env lean` using the pinned Lean4.33.1 runtime on Algebra, Support, Classification, Proof and Solution. All five exit codes were zero, with no warnings in the independent replay log. Evidence: `verification/final-referee-2-elaboration.log`. This uses the shared pinned local dependency cache, not a fresh isolated Linux environment.

I separately wrote and ran `verification/FinalReferee2Audit.lean`, exit zero. All four public exports have exactly `[propext, Classical.choice, Quot.sound]` as their transitive axiom closure. No sorry, custom axiom, or native compiler dependency appears. The audit also traverses the actual witness_certificates proof term and finds `LeanCert.Validity.verify_strict_upper_bound_dyadic_checked`, with expression evaluation/constant constructors. Thus the retained positive-trace point check actually uses LeanCert. Its role is only the elementary 0<1 obligation after the exact trace identity; it is not a numerical eigenvalue oracle. I inspected the checked-bound theorem, which turns a true domain/bound certificate into a real strict inequality. Kernel trust is requested explicitly, and the independent axiom closure excludes native fallback. Evidence: `verification/final-referee-2-axioms-and-cuts.log`.

All four Solution trust assertions pass. Solution imports the implementation rather than Challenge, whose four intentional placeholders remain isolated in the statement environment. I inspected the implementer's 3582-job build and axiom logs; they agree with the independent results. Comparator config selects all four matching public target signatures, no replaceable definition holes, and the same three permitted axioms. The actual Linux Comparator and rejection controls have not been executed by this referee; local signature inspection is not a substitute for that gate.

## Quality, metadata, attribution and limitations

The symbolic determinant identity, pruned finite case proof and linear/quadratic classification remove the need for Perron theory, graph APIs, spectral approximations or interval subdivision while preserving the full quantifier. Reuse of Mathlib's determinant, trace coefficient, finite permutations and convex geometry is appropriate. I searched the pinned determinant files for an existing det_fin_four helper; none was found, and the small generic four-dimensional expansion is a reasonable local lemma derived from existing APIs. Module separation makes the univariate algebra, exhaustive support argument, classification and geometric exclusion independently reviewable. No mathematical result from an example project is silently assumed.

README/formalization.yaml accurately distinguish local kernel success, AI statement reviews, pending final reviews and pending actual Linux verification at the reviewed bytes. The preserved statement metadata resolves potential stale-review ambiguity. Colbrook's counterexample, Mourad–Abbas's conjecture, Holden's formalization and Codex assistance remain distinguished; source-author nonendorsement and AI provenance are explicit. I did not independently rerun the official schema validator, authenticate source priority/affiliation/ownership, reprove all imported library mathematics, or claim human review. No proof or metadata bytes were modified by this referee. Final wrapper updates may follow both reviews, but mathematical approval remains bound to these exact hashes.

## SHA-256

- `NLA/IS02/Definitions.lean`: `4194087b7690e047dc1eae2964f43c476b2164a4105bee5113dc7e1dfe0efd16`
- `Challenge.lean`: `c80c3fe17912547c415735bbca1568360a625c323f946e4ef6bb93e6124918a3`
- `NUMERICAL_TARGETS.md`: `2e0dd8ca18cc61cce5224d61e2aa11f85f6c7308e250526f5a1fa711693614cd`
- `NLA/IS02/Algebra.lean`: `586d36609e870520127bb9c4aa295fa9083f31f2b60dabbe115ad0fe836e0379`
- `NLA/IS02/Support.lean`: `8bbfbd59a4fc234000b690516f1e670e5df41e9a8d95e6d2b8d5d3a4daaa566f`
- `NLA/IS02/Classification.lean`: `3bee9f0d0c2cb5d1b873c3f9faeae469f0797c60974f01fb73df7451618d8860`
- `NLA/IS02/Proof.lean`: `c39ce54b49ac58b00fb6bfa239bbd9085f2147a830af887a4e2750da9954e919`
- `Solution.lean`: `86949f0c5712d52ab026ac22bec706c6938dcebf155539d7837dda4f1bc2eb29`
- `comparator.json`: `64f8b6a88c039b0ff1cbd574673af132ba1e76cb1f8fb52a751368fc9ef60aef`
- `lakefile.toml`: `c7dab59556c63adeb79fa9814e35ec43edb004160d8d79c314a1760c66b046ca`
- `lake-manifest.json`: `84d8f7719040dade88e1d169389aa9a9b937686ce5782ec5063d8cc0fa726c08`
- `lean-toolchain`: `3aac669c7a910ec2389f4e4f921b605adf6ebf2d1e0c9b9cd0be4d33f3f5db71`
- `formalization.yaml`: `50b203dabab86243d05b3a61dea16640bebfef1348e0b5a25b0e036fb6ff6fb3`
- `README.md`: `b912021dad087ed98775fabcd118cf7220b19ef54dcb67c2a09a98227a478cef`
- `verification/final-build.log`: `343c10f323bca5be5cc9b128a90d6a24616ae9d6b029dd948230c507982e1170`
- `verification/AxiomAudit.lean`: `83d2504c923307a3f4393ac828fb01aaf8eec35729698140ece20987984ab120`
- `verification/axioms.log`: `971e80367aacf039541bf88d725d1c86fc94387ad128c325ffaf9043335fbe76`
- `reviews/proof-source-hashes.json`: `63f3a1e84041209f372655ad1418fd628396d2e8d142356532a06dd8cb87ae21`
- `verification/final-referee-2-source-check.json`: `bd1f7061591547c7470dae2808d6c783eefeeca4d05f0f2879e59985bfcdfcda`
- `verification/final-referee-2-elaboration.log`: `30537829729595d2b4a1195da0f41922e1305ed30b8fd86c74ca1f14920bcfee`
- `verification/FinalReferee2Audit.lean`: `515d3c18ed717d52a9ae9d9d1a022a8223c5d5b1ef76ecdbd0b7346ceb878695`
- `verification/final-referee-2-axioms-and-cuts.log`: `46a3853c3d98e815454fbe25fc420297247ffbc57d9f6882431b51730f29566f`
- `verification/final-referee-2-permutations.json`: `ec3924751d9367d87e01e4f3c47e8d4f9201e59d6c9ce5ce009ad04024e0f577`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/Charpoly/Coeff.lean`: `465ebaa7462113f8c411a1bbfb582309a0224786c69ff381db8b78ed986e6eef`
- `.lake/packages/mathlib/Mathlib/LinearAlgebra/Matrix/Determinant/Basic.lean`: `37646a248748fd65e37c20a21b4a20fea11539d4312aae4f277e4faef8ed2b87`
- `.lake/packages/mathlib/Mathlib/Analysis/Convex/Extreme.lean`: `c644f42325dd7b9b8802adb5d6a767c49cdcb4e3f2a1403943f9ba27c0315eca`
- `.lake/packages/mathlib/Mathlib/Analysis/Convex/Segment.lean`: `e4dcbfea5c693f69340ffa734aefa1f4ab428959c381b8774ec77ad95d0a715a`
- `.lake/packages/leancert/LeanCert/Validity/DyadicBounds.lean`: `6f1cdbc11f32e425ef5e9f4a22966d64ff0d11614ec9453ed7dde498e31a7c47`
- `canonical/README.md`: `92f7c04c5ac0be67a7f6a4efd0d2439caaf000295fa27d259e01a22368f7ae24`
- `canonical/solution.md`: `ae29570308b2a78678875c5e56076ce09e65cea732ce6b51142399a4b234577f`
- `reviews/statement-review-snapshot/README.md`: `c3d896c0c4a07d56273a2bfec5785dac92aa8b94118487a57c227cfa19b0c067`
- `reviews/statement-review-snapshot/formalization.yaml`: `2221aba42ed16680fc8cc18339fc0bf28bdba032dc278f435bbf06fb0157833c`
