# IE-15 independent final referee 1

**Verdict: PASS.** The complete original pair of sharp constants is proved locally, with no material correctness or scope finding. Actual isolated Linux Comparator, default-kernel replay and rejection controls remain separate gates; this report does not promote the canonical page.

Reviewer: `/root/iv06_statement_referee_1`, OpenAI Codex AI agent, 2026-09-22. I authored none of the IE-15 mathematical implementation. I performed its earlier statement review, then freshly read the full canonical page, complete Stepaniants `solution.md`, numerical contract, unchanged Definitions and Challenge, and all eleven active Lean files (ten NLA modules plus Solution). Responsibilities cover fidelity, correctness, optimization, imported APIs, reuse, documentation and attribution under `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is not official Tau Ceti review or external human peer review.

## Scope and nonvacuity

The four exports preserve both original orders, arbitrary real nonsingular inputs, every admissible rook choice and tie, and all intermediate entries. The row and column maxima are independent and restricted to the actual active region; no complete-pivoting hypothesis is inserted. The two swaps and trailing Schur expression are literal. Values after stage n−1 do not enter the finite maximum. Zero padding is proved from the recurrence, so it cannot introduce a larger entry or an unbounded unconstrained state.

The first nonzero pivot proves strictly positive initial entry maximum (`path_input_pos`), before division or normalization. The final upper-bound exports do not need their determinant hypothesis because the complete path itself supplies all required nonzero pivots; this strengthens the internal theorem and does not weaken the original boundary. Nonsingularity remains required in `rookGrowths`, and the exact witnesses prove actual nonsingularity.

The final supremum is the real `sSup` of the genuine set of all growth values. `three_mem` and `four_mem` give attained members. Universal bounds give explicit upper bounds. `csSup_le` consumes nonemptiness and `le_csSup` consumes boundedness, as confirmed in the pinned Mathlib implementation. There is no reliance on an empty/unbounded-supremum convention or a normalized-coordinate surrogate for the original growth set.

## Complete proof chain

- `PathReduction`: the remaining row and column swaps are composed in the correct order. Future permutations fix every already eliminated index and therefore preserve the active region. `reindex_schur` proves exact covariance of the actual recurrence. `diagonalized_path` transports every original admissible path, including ties, to diagonal order; inverse permutations later transport every measured entry back.
- `SignScaling`: independent unit row/column signs and positive scaling preserve each Schur update and rook inequality. The explicit signs simultaneously make every pivot positive and all last-row active pivot-column entries nonnegative. The last sign is justified from the nonzero last pivot. Each sign has modulus one, and every field cancellation has a proved nonzero pivot or scale. `normalizedBound` is only an intermediate proposition: both concrete instances are proved, then discharged in the final exports.
- `PathBounds`: every earlier active entry is bounded by 2^k using the actual recurrence and a rook column multiplier of modulus at most one. Thus the order-three earlier stages have bounds 1,2 and order-four stages 1,2,4. These are entrywise bounds, not pivot-only estimates.
- `Scalar`: all real parameter ranges and all three original-entry constraints from the source are retained. The q≤1 branch and every sign branch when q>1 are covered. The clipped-product estimate replaces the source's derivative/piecewise-monotonicity argument with proved polynomial inequalities. `scalar_three_bound` requires only the first two positive pivots and proves the two-update contribution bound; it imposes no nonzero last Schur value. This correctly covers the possibly singular three-index subproblem used at order four.
- `ScalarFour`: exact bilinear interpolation on the unit square proves the four-corner bound without numerical optimization or a grid. The signed bilinear term is controlled on the full [-1,1]^2 domain. The scalar-three result bounds the first three corners and the complete two-pivot inequality bounds the fourth. Multiplying the three actual original-entry inequalities by nonnegative C,D gives the final 11/3 contribution bound.
- `NormalizedProof`: actual matrix ratios and two successive Schur identities derive every scalar hypothesis from the input entry bounds and rook path. The implementation retains the actual last diagonal entry and bounds it by one, so it does not need to modify the matrix or assume the source's optional last-entry replacement. The D≤0 case is explicitly handled; C=0 and all multiplier endpoints are admitted. The positive last pivot and zero-padding lemma convert its scalar estimate into the full stage bound.
- `Witnesses`, `Supremum`, `Solution`: exact rational proofs establish determinants 3 and 70/9, every rook row/column inequality, all nonzero pivots, initial maxima one, and full growth values 3 and 14/3. Both witnesses include ties. The final four wrappers discharge every original hypothesis without importing Challenge or assuming an upper-bound conclusion.

## Mechanical evidence and trust

I independently verified all 22 entries in `reviews/proof-source-hashes.json`; all match. The mathematical boundary and configuration files are byte-identical to frozen base `2f84bb4d`, checked using a Git diff. Current metadata/README appropriately replace only the earlier draft status; their old reviewed bytes are preserved in the statement-review snapshot.

My fresh `verification/Referee1Consumer20260922.lean` copies all four unchanged Challenge signatures as anonymous examples and consumes the actual Solution exports. Pinned `lake env lean` returned exit 0. Its log reports exactly `propext`, `Classical.choice`, and `Quot.sound` for each export; all four LeanCert kernel assertions pass. I read LeanCert's actual `collectAxioms`/classification implementation: native compiler axioms, sorry and custom axioms are rejected. No interval arithmetic is used or needed here; LeanCert's material role is the trust audit. I do not mislabel `norm_num`, `nlinarith`, or rational witness enumeration as an interval certificate.

I also inspected the coordinator's fresh 3087-job Solution build log and metadata validator PASS (four declarations), binding both hashes. That whole build was run by the coordinator, not by this referee. My source scan finds no active `sorry`, custom axiom, `unsafe`, `native_decide`, or compiler-reduction escape. Challenge's four deliberate placeholders are not imported by Solution. Comparator names all four exact exports, permits only the three standard axioms, and replaces no definitions.

## Quality, reuse and credit

The scalar polynomial and bilinear arguments materially reduce computation compared with searching intervals or reproducing analytic differentiation. Finite witness enumeration is small (orders three/four). Generic path transports retain arbitrary n and are separate from the finite-order estimates. The finite maximum helpers correctly reuse Mathlib's semilattice API; the final supremum uses its standard conditionally complete lattice API. IE-05 adaptation is credited. George Stepaniants retains mathematical authorship, Nicholas Higham question attribution, and Sidney Holden/Codex the formalization credit; no novelty or author endorsement is claimed.

Nonblocking maintenance observations: the copied lockfile retains its historical root name `NLAIV06` although the actual Lake project is `NLAIE15`; pinned package identities are explicit and the fresh build works. Several finite-case witness simplification lists are repetitive and the broad `Mathlib.Tactic` import could later be narrowed. Neither affects semantics or trust, and no change is requested during this verification freeze.

## Exact binding

`reviews/referee-1-proof-evidence-20260922.json` lists SHA-256 for every active Lean file, every boundary/configuration file, canonical/source prose, actual library files inspected, and all execution attachments. Its exact SHA-256 is `9654cde155ef5097ff195eee83af4b58fa35cd42a4eceaa6aa1bcbbd74dafaab`. The key exported implementation hashes are:

| File | SHA-256 |
| --- | --- |
| `Solution.lean` | `f2bc6dea43fae4603652dbe315f9aee46a72357602cb017ca7dc413a5e6579ae` |
| `NLA/IE15/Bounds.lean` | `cb3befd5285cd7021ed77eb2f381eb2019860456d5600aca5e7ebfd6ee317ced` |
| `NLA/IE15/Definitions.lean` | `f63b4ac19b98baad4db5941b35bd6ed5cc99f6b4d9c646cbd82523c5612b4ccf` |
| `NLA/IE15/NormalizedProof.lean` | `77d033d74dabf42a1bdf2aa50e2400865f99604a1543a4cf676f73529c141a39` |
| `NLA/IE15/PathBounds.lean` | `1f9a2ea718e8f1173b892e2de34c6e0848d8db59cc708dc7fdf7ffac9bc5e326` |
| `NLA/IE15/PathReduction.lean` | `9dfa7b62fb7af76333248facb94e07c416a9ef93a273d700d7a4117bc2179ca5` |
| `NLA/IE15/Scalar.lean` | `adbf3658839170cb7f2d2eccb400ac2056cdce77bae98705e2ca46eaed995567` |
| `NLA/IE15/ScalarFour.lean` | `4b6ca9835997292da9a2a47c1f41ff62879f9a11e2bbf6fdb35c92a41e1a2b1c` |
| `NLA/IE15/SignScaling.lean` | `0395e39523450f635de4c8f66f93f5e38295bbb699ed3b51bbe35b4126f6b20e` |
| `NLA/IE15/Supremum.lean` | `114b43b1df9e6a575dbfaae582f75d064b96c33c56912bc9d69c68ff041e1129` |
| `NLA/IE15/Witnesses.lean` | `8afae06810da482d34b27812f7460a9604079c9fac01d0aff469c8156dfca73a` |

This approval binds those bytes. Later publication-only prose changes may describe completed external gates after they actually pass; any mathematical change requires renewed review.
