# SP-06 independent proof reverification — referee 1

**Verdict: PASS for mathematical correctness, complete frozen scope and local proof closure. No blocking finding. Fresh Linux Comparator acceptance is a separate operational gate, not claimed here.**

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not the author or implementer of these upstream proofs. Date: 2026-09-14. Applied the correctness, scope, API/reuse, efficiency and attribution angles of `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is AI review, not official Tau Ceti or human peer review.

The two statement approvals were frozen in `statement-gate.json` before this campaign's proof inspection. I read the complete 5-module ACTIVE Solution import closure, all 20 frozen Challenge contracts and their implementations, together with the previously reviewed complete canonical/informal source. Historical evidence copies were not mistaken for active dependencies. I independently checked every active source byte against upstream `deb549fa9ddd6b119e6c59016f268237e645dfa2` and the gate; all match. The current candidate is `6725a6f00b141b7b854518cdc93331372bdf539e`. No existing source, metadata, historical evidence, attribution, problem ID or canonical target was edited.

## Mathematical audit and scope

The full negative implication is proved, not merely a scalar diagnostic: the explicit admissible finite Laurent band has an actual Jordan curve, continuously and injectively parametrized by the unit circle, avoiding zero and lying entirely in the real locus of the symbol, while its actual finite Toeplitz matrix of order two has a nonreal spectral value. All 20 contracts are present and their dependencies close this exact target.

Numeric proves the support/extreme coefficient conditions, evaluates the finite Laurent sum at every nonzero complex z, and identifies it with auxiliary(z) minus auxiliary(z)-squared. Uniform endpoint inequalities and a factored difference establish F(r,c) - F(s,c) >= (r-s)/4 for every 1/2 <= s <= r <= 2 and every c in [-1,1], where F is radialEquation. The ordered-root estimate and its reversed case give the global 8-Lipschitz bound. These are exact inequalities; no finite grid of angles replaces the universal quantifiers.

Curve uses the intermediate value theorem for existence of a root in (1/2,2), the uniform slope for uniqueness, and the root comparison for continuity of the chosen radius on the actual complex unit Circle. The radial curve is injective because norms recover the positive radius and cancellation recovers the unit direction. Every curve point is nonzero. The actual imaginary-part formula uses the unit-circle inverse/conjugate identity and a strictly positive denominator; the defining radial equation therefore makes the Laurent symbol real at EVERY curve point. Circle has Mathlib's actual unit-sphere topology. These facts meet the reviewed Jordan-curve predicate without assuming a curve, continuity or uniqueness.

The order-two Toeplitz entries are evaluated from the original coefficients. Matrix.mem_spectrum_iff_isRoot_charpoly and the evaluated characteristic determinant certify -128+8i as an actual eigenvalue, whose imaginary part is exactly eight. Proof uses this fact to negate allFiniteSpectraReal, packages the curve and admissibility, and negates the original implication.

LeanCert supplies actual kernel trust audits for all exported algebraic/topological theorems; no interval tactic is invoked, and no floating-point evidence is used as proof. The global factored slope bound, finite Laurent identity and one 2-by-2 determinant minimize computation without shrinking the original domain. Existing Colbrook mathematics and Stepaniants formalization credit are preserved. Zero-enclosure, limiting spectrum, the reverse implication and classification of all valid symbols are not claimed.

## Fresh evidence, trust and limits

I inspected the coordinator's fresh macOS aarch64 Lean 4.33.1 `solution-local.json` and full `solution-local.log`, checked the recorded SHA-256 against the actual log, observed exit 0 and successful Solution completion. This was a coordinator build, not a build independently run by this referee. Historical PASS reports were not substituted. Active source scanning and manual reading found no `sorry`, `admit`, custom `axiom`, `native_decide`, `unsafe` or `implemented_by` in executable code. Challenge's intentional placeholders are outside the active Solution import closure. All 20 exports have active `#assert_trust kernel` checks.

I also inspected referee 2's NEW independent export-consumer evidence, which checks the actual theorem types and prints every exported axiom closure; every closure contains only `propext`, `Classical.choice` and `Quot.sound` (universe annotations do not add axioms). This consumer was run by referee 2, not by me. My independent evidence script verified every configured export has an active declaration, a kernel audit, and a matching standard-only axiom line in that fresh consumer log. The exact caller statements and proof branches were read as mathematical code; later Linux Comparator must still verify full declaration identity in its own sandbox and default-kernel replay. No fresh Linux success, sandbox acceptance or publication approval is inferred from these local checks.

The review is bound to `referee-1-proof-evidence.json` SHA-256 `178ce9862139eb0beec1e5451307f28c4125ce797300fb02d22c96e8d0293edd`. It records the full active dependency graph, exact source and boundary hashes, all 20 export names and individual axiom lists, direct external imports and hashes of inspected fresh evidence. The log/source byte checks were independently executed by this referee; they do not replace Lean checking. No additional proof build was repeated because the coordinator and second referee supplied fresh complementary execution evidence.

## Export coverage

Every name below was traced from the frozen contract through its active implementation and checked against the fresh consumer's permitted-axiom record:

- `NLA.SP06.witness_admissible`
- `NLA.SP06.witness_composition`
- `NLA.SP06.radial_lower_endpoint`
- `NLA.SP06.radial_upper_endpoint`
- `NLA.SP06.radial_uniform_slope`
- `NLA.SP06.radial_root_exists_unique`
- `NLA.SP06.radial_roots_lipschitz`
- `NLA.SP06.continuous_radius_exists`
- `NLA.SP06.radial_curve_continuous`
- `NLA.SP06.radial_curve_injective`
- `NLA.SP06.radial_curve_nonzero`
- `NLA.SP06.auxiliary_radial_im`
- `NLA.SP06.radial_curve_symbol_real`
- `NLA.SP06.witness_real_jordan_curve`
- `NLA.SP06.witness_toeplitz_two`
- `NLA.SP06.witness_eigenvalue_mem`
- `NLA.SP06.witness_eigenvalue_im`
- `NLA.SP06.witness_nonreal_finite_spectrum`
- `NLA.SP06.witness_counterexample`
- `NLA.SP06.not_targetImplication`

## Exact active source hashes

- `eigenvalues-and-inverse-problems/SP-06/lean/NLA/SP06/Curve.lean`: `151ff3586667091b16eab3acf03aed32fa5c7db8422a4077095bf914c4392677`
- `eigenvalues-and-inverse-problems/SP-06/lean/NLA/SP06/Definitions.lean`: `5f3e071b9aabbbda27a794f9396022e54585f5d2d254827e50ea90baf80e72b1`
- `eigenvalues-and-inverse-problems/SP-06/lean/NLA/SP06/Numeric.lean`: `16052a754e8680c587163e1a57d150094ae96a36464a56cc499ec09e9aa5b111`
- `eigenvalues-and-inverse-problems/SP-06/lean/NLA/SP06/Proof.lean`: `d22146a65804efd8ff5c7f7b81ddcd55af8dc1bab7a2518f4961d7699abc9b48`
- `eigenvalues-and-inverse-problems/SP-06/lean/Solution.lean`: `4aa92168bf3dccc0a03180795c60b404a7e6b531b188eb4ab1d93cf109c3eb42`

## Fresh evidence hashes

- `statement-gate.json`: `eaa93ee860b9627b6d8340005b49d1d07c1b9b98b92852fdbbb2ec33599e168e`
- `solution-local.json`: `3f50a2ef380087617501083857f04acc5997e9b659bd92082c4d1263275079fe`
- `solution-local.log`: `397c5dea2d0a1b699e6478b2539e90ce992b9a6368d1bff7c05c8abde660443d`
- `referee-2-export-audit.lean`: `e6be79662bf61d853af253774d3bae1de8d0604cbae8dadf541104e2faea0471`
- `referee-2-export-audit.log`: `9d35b204c40c028f6553b1ce58fa81a11c493755df61b6a59ff45b8f0e2f04fb`
