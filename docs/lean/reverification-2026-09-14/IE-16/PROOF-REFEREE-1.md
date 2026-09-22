# IE-16 independent proof reverification — referee 1

**Verdict: PASS for mathematical correctness, complete frozen scope and local proof closure. No blocking finding. Fresh Linux Comparator acceptance is a separate operational gate, not claimed here.**

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not the author or implementer of these upstream proofs. Date: 2026-09-14. Applied the correctness, scope, API/reuse, efficiency and attribution angles of `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is AI review, not official Tau Ceti or human peer review.

The two statement approvals were frozen in `statement-gate.json` before this campaign's proof inspection. I read the complete 10-module ACTIVE Solution import closure, all 15 frozen Challenge contracts and their implementations, together with the previously reviewed complete canonical/informal source. Historical evidence copies were not mistaken for active dependencies. I independently checked every active source byte against upstream `deb549fa9ddd6b119e6c59016f268237e645dfa2` and the gate; all match. The current candidate is `bea9efc9d9345c7f2f47b4926cd1968f47b7cff9`. No existing source, metadata, historical evidence, attribution, problem ID or canonical target was edited.

## Mathematical audit and scope

The fifteen public contracts prove the complete negative target at n=9 and k=4, using the unchanged nine complex points and exact Holden minimax value. All feasible degree-at-most-four complex polynomials and ALL five-point subsets remain quantified. The real infimum M is identified with an attained least feasible value, for the full set and every subset; no empty-set or unbounded-infimum fallback supplies the result.

Numeric verifies the nine-point injection, nonzero nodes, cubic-root algebra and the explicit polynomial's degree/normalization. Exact norm-squared calculations prove the same positive objective at all nine points. It certifies positive rational weights summing to one and all four weighted complex moments. WeightedBridge expands every arbitrary feasible difference p-pstar into its four nonconstant coefficients, using the true polynomial degree bound and zero constant term. Thus the moments imply the actual cross term is zero. The weighted square-norm identity gives a lower bound for EVERY feasible polynomial, and the explicit witness attains it. FullMinimum converts the genuine IsLeast to the sInf equality and the claimed strict rational lower bound.

Minimax independently proves the five-node Lagrange formula, with genuine nonzero Lagrange coefficients, positive sum, normalized degree-four interpolation attainer and constant attained modulus. The lower bound uses exact interpolation at zero, triangle inequality and the finite maximum. SubsetGeometry pulls every actual five-point subset back to the injective nine-label grid; image and cardinality equalities are proved, not assumed. The finite occupancy disjunction includes all subsets (ordinary kernel decide, not native_decide): either at least four nodes have a close companion or at least three have two. Shared bounds on point moduli and near/far distances give strict Lagrange-coefficient bounds 109 or 146 and hence a sum greater than 10000/23. This avoids repeating irrational computation for 126 subsets while retaining them all.

FinalContracts proves the subset family nonempty, derives positivity of every subset minimum from its positive Lagrange sum, and uses the true finite supremum for subsetMax. Thus division by the denominator is justified. The full/subset strict bounds give a ratio above 13/10, and Mathlib's proved pi bound gives 4/pi < 13/10. Specializing the original all-n/all-k conjecture yields the contradiction. No normalized polynomial family replaces arbitrary feasible polynomials, and the all-subset upper bound is not mistaken for just one favorable subset.

LeanCert is used for the kernel trust audit of all fifteen exports. Exact algebra reduces all powers of sqrt(3), the finite label computation is kernel reduction, and the pi comparison uses Mathlib; no interval arithmetic or numeric minimizer is relied on. The active historical filenames ending Draft contain complete proved bridges, not placeholders. Holden retains the mathematical credit and Stepaniants the formalization credit. The optional amplification/general limiting sharp-constant discussion in the source is excluded, as at the frozen boundary.

## Fresh evidence, trust and limits

I inspected the coordinator's fresh macOS aarch64 Lean 4.33.1 `solution-local.json` and full `solution-local.log`, checked the recorded SHA-256 against the actual log, observed exit 0 and successful Solution completion. This was a coordinator build, not a build independently run by this referee. Historical PASS reports were not substituted. Active source scanning and manual reading found no `sorry`, `admit`, custom `axiom`, `native_decide`, `unsafe` or `implemented_by` in executable code. Challenge's intentional placeholders are outside the active Solution import closure. All 15 exports have active `#assert_trust kernel` checks.

I also inspected referee 2's NEW independent export-consumer evidence, which checks the actual theorem types and prints every exported axiom closure; every closure contains only `propext`, `Classical.choice` and `Quot.sound` (universe annotations do not add axioms). This consumer was run by referee 2, not by me. My independent evidence script verified every configured export has an active declaration, a kernel audit, and a matching standard-only axiom line in that fresh consumer log. The exact caller statements and proof branches were read as mathematical code; later Linux Comparator must still verify full declaration identity in its own sandbox and default-kernel replay. No fresh Linux success, sandbox acceptance or publication approval is inferred from these local checks.

The review is bound to `referee-1-proof-evidence.json` SHA-256 `7abf6c15021757d9c8f7c2d6ca31d605e20a72755fb4941cccef5fdd412a7530`. It records the full active dependency graph, exact source and boundary hashes, all 15 export names and individual axiom lists, direct external imports and hashes of inspected fresh evidence. The log/source byte checks were independently executed by this referee; they do not replace Lean checking. No additional proof build was repeated because the coordinator and second referee supplied fresh complementary execution evidence.

## Export coverage

Every name below was traced from the frozen contract through its active implementation and checked against the fresh consumer's permitted-axiom record:

- `NLA.IE16.explicitL_card`
- `NLA.IE16.explicitL_admissible`
- `NLA.IE16.witness_feasible`
- `NLA.IE16.witness_objective`
- `NLA.IE16.full_minimum_exact`
- `NLA.IE16.full_minimum_isLeast`
- `NLA.IE16.full_lower_bound`
- `NLA.IE16.every_five_point_subset_upper`
- `NLA.IE16.every_five_point_subset_minimum_isLeast`
- `NLA.IE16.subset_max_upper`
- `NLA.IE16.subset_max_positive`
- `NLA.IE16.ratio_lower_bound`
- `NLA.IE16.ratio_exceeds_candidate`
- `NLA.IE16.counterexample`
- `NLA.IE16.not_IE16Conjecture`

## Exact active source hashes

- `linear-systems-and-elimination/IE-16/lean/NLA/IE16/Definitions.lean`: `e4681f2083d71d8980adcd70e7cf26367e0e84dbc1773f4d2f082bf2417c9507`
- `linear-systems-and-elimination/IE-16/lean/NLA/IE16/FinalContractsDraft.lean`: `a0aa3d1e08cf699c06a397540987f166f76693c87c8ed427f8d30836a9b01752`
- `linear-systems-and-elimination/IE-16/lean/NLA/IE16/FullMinimumDraft.lean`: `78f9c847d1438c5ce1b53c49bf0178ccde7a8cb542ad07a0b99172542c7c95e6`
- `linear-systems-and-elimination/IE-16/lean/NLA/IE16/Minimax.lean`: `d933b2609842519f9af59b21699af15414a2768376fa9a7deb9decb84fd9842c`
- `linear-systems-and-elimination/IE-16/lean/NLA/IE16/Numeric.lean`: `1acf85379ec7c69a632726920ef6be780fa059ccb1e3e6c9f8273b2f7625164f`
- `linear-systems-and-elimination/IE-16/lean/NLA/IE16/SubsetBoundsDraft.lean`: `6a3bef42b0356e36db434099e87a4aa4d01682c2de09092497035fe796a33709`
- `linear-systems-and-elimination/IE-16/lean/NLA/IE16/SubsetGeometryDraft.lean`: `e0f73f3268d289371906e3df7388249b51e7ae93c0b1b7c0b5c8fe04449d48ab`
- `linear-systems-and-elimination/IE-16/lean/NLA/IE16/WeightedBridgeDraft.lean`: `e68654e1a1f21c1f29b2391edf69374365438c583ff4181323be29a39f6fd008`
- `linear-systems-and-elimination/IE-16/lean/NLA/IE16/WeightedDraft.lean`: `d87c2fe573fbdd31a85ca7170ee9f9700fd406243f44e4631f0feb243694a9e1`
- `linear-systems-and-elimination/IE-16/lean/Solution.lean`: `9ec27288b7d4824b91a8c0006c7be1fd7e6493b2444ce45941bdb9104b17a419`

## Fresh evidence hashes

- `statement-gate.json`: `fc66a0c8ecde6babddb4fd99ee5e6a550d8e7fcc054a56af4c9d30dbd577fbd5`
- `solution-local.json`: `6e6b4594525ab56dc781ea57329aa7ea2aa9e573ddb8f49821544e74ddeefa95`
- `solution-local.log`: `b49ba770b92f861ae542ee1614cfa9f0a9f16e44a7e3a6f883c27c3202cf4c21`
- `referee-2-export-audit.lean`: `e99646bfb1bf997329dafe0ff809fd6c8fb533c80fbd537138534e6b2bfbfbb9`
- `referee-2-export-audit.log`: `e32cf3c563a4e2d4d77f00f8de45bef3dd9c94de8b5c8ac022dee2ac0f6c30f6`
