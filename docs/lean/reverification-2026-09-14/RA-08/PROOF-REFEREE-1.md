# RA-08 independent proof reverification — referee 1

**Verdict: PASS for mathematical correctness, complete frozen scope and local proof closure. No blocking finding. Fresh Linux Comparator acceptance is a separate operational gate, not claimed here.**

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not the author or implementer of these upstream proofs. Date: 2026-09-14. Applied the correctness, scope, API/reuse, efficiency and attribution angles of `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is AI review, not official Tau Ceti or human peer review.

The two statement approvals were frozen in `statement-gate.json` before this campaign's proof inspection. I read the complete 17-module ACTIVE Solution import closure, all 14 frozen Challenge contracts and their implementations, together with the previously reviewed complete canonical/informal source. Historical evidence copies were not mistaken for active dependencies. I independently checked every active source byte against upstream `deb549fa9ddd6b119e6c59016f268237e645dfa2` and the gate; all match. The current candidate is `5e1e682e0559800d1f0619553bf385c88eec2330`. No existing source, metadata, historical evidence, attribution, problem ID or canonical target was edited.

## Mathematical audit and scope

All fourteen public contracts close the complete spectral-norm transfer counterexample. The actual PSD order, continuous functional calculus and Euclidean operator norm are retained. The source pair in dimension six and rank three defeats the epsilon-zero implication for EVERY permitted ordered eigenbasis; the final theorem negates the original all-dimension/all-function/all-parameter assertion without conditional spectral premises.

OrderedExistence transports Mathlib's spectral theorem into a full decreasing orthonormal decomposition, with multiplicities and even zero dimension handled. SpectralCFC does not define a surrogate calculus: its selected evaluation/diagonal/unitary star-algebra homomorphism is proved continuous and sends identity to A, so the genuine CFC uniqueness theorem identifies it with cfcHom. A bare scalar function is continuous on the actual finite matrix spectrum; the proof follows the correctly credited Mathlib architecture and discharges the CFC side conditions. Spectral derives genuine eigenvectors, PSD reconstruction, orthogonal-conjugation operator norms and the exact kth-tail formulas for every allowed selected basis. The temporary coefficient-vector norm is the finite sup norm appropriate to a diagonal operator, and the matrix norm is explicitly the L2 operator norm. Rayleigh bounds pass through toEuclideanCLM and EuclideanSpace, not a Frobenius or entrywise norm.

Witness proves the unchanged rational projection F is symmetric/idempotent, PSD with PSD complement, the approximation is PSD, A is positive definite and Ahat <= A. ProjectionNorm proves the residual norm exactly using a genuine star projection and a unit eigenvector attaining its norm. Location rules out the WHOLE forbidden spectral gap by removing one coordinate of an actual eigenvector, applying the proved compression bound and nonnegative length; it does not assume a numerical eigenvalue enclosure. Fourth uses two rectangular-kernel dimension arguments in an arbitrary selected eigenbasis to prove the exact fourth eigenvalue. Tails proves approximation truncation and function truncation identities for all choices, resolving repeated-eigenvalue and preferred-basis concerns.

Scalar proves a polynomial minorant on precisely the derived spectral set by a nonnegative shifted polynomial. Functional uses pointwise-on-spectrum CFC order; this is not an unsupported operator-monotonicity claim for min(x,1). Polynomial identifies the minorant and approximation CFC with actual matrix polynomials. Certificate evaluates only three matrix-vector products, then uses symmetry to express the degree-six quadratic form as a squared length. Its exact rational Rayleigh value, together with the genuine functional order and operator Rayleigh bound, gives the strict failure of the desired comparison.

The strict rational witnessGap is a material LeanCert singleton certificate explicitly using kernel trust. I inspected referee 2's fresh printed checker term: checkStrictUpperBoundDyadicChecked at zero bounds the exact positive rational gap, with proof of the Boolean check by of_decide_eq_true (id (Eq.refl true)). Proof consumes numerical_gap_positive_proved in the strict Rayleigh contradiction and final negation. No eigenvalue intervals or floating-point spectral oracle enter the result. The scalar obstruction alone would not suffice, but all required matrix bridges are proved. Colbrook mathematics, Stepaniants formalization, and Bannon/Loreaux Mathlib architecture credit are retained. The separate nuclear-norm extensions, smooth-function variants and stronger relative-gap questions in the source are not claimed.

## Fresh evidence, trust and limits

I inspected the coordinator's fresh macOS aarch64 Lean 4.33.1 `solution-local.json` and full `solution-local.log`, checked the recorded SHA-256 against the actual log, observed exit 0 and successful Solution completion. This was a coordinator build, not a build independently run by this referee. Historical PASS reports were not substituted. Active source scanning and manual reading found no `sorry`, `admit`, custom `axiom`, `native_decide`, `unsafe` or `implemented_by` in executable code. Challenge's intentional placeholders are outside the active Solution import closure. All 14 exports have active `#assert_trust kernel` checks.

I also inspected referee 2's NEW independent export-consumer evidence, which checks the actual theorem types and prints every exported axiom closure; every closure contains only `propext`, `Classical.choice` and `Quot.sound` (universe annotations do not add axioms). This consumer was run by referee 2, not by me. My independent evidence script verified every configured export has an active declaration, a kernel audit, and a matching standard-only axiom line in that fresh consumer log. The exact caller statements and proof branches were read as mathematical code; later Linux Comparator must still verify full declaration identity in its own sandbox and default-kernel replay. No fresh Linux success, sandbox acceptance or publication approval is inferred from these local checks.

The review is bound to `referee-1-proof-evidence.json` SHA-256 `be5979e7fd665043df9086f2753e8ed43062e0205f87efe05d29156992664e4b`. It records the full active dependency graph, exact source and boundary hashes, all 14 export names and individual axiom lists, direct external imports and hashes of inspected fresh evidence. The log/source byte checks were independently executed by this referee; they do not replace Lean checking. No additional proof build was repeated because the coordinator and second referee supplied fresh complementary execution evidence.

## Export coverage

Every name below was traced from the frozen contract through its active implementation and checked against the fresh consumer's permitted-axiom record:

- `NLA.RA08.orderedSpectral_exists`
- `NLA.RA08.orderedSpectral_semantics`
- `NLA.RA08.functionalCalculus_spectral`
- `NLA.RA08.spectral_tail_norms`
- `NLA.RA08.operator_rayleigh_bound`
- `NLA.RA08.witness_data`
- `NLA.RA08.witness_spectral_location`
- `NLA.RA08.minorant_scalar`
- `NLA.RA08.minorant_functional_calculus`
- `NLA.RA08.witness_tail_data`
- `NLA.RA08.witness_rational_certificate`
- `NLA.RA08.numerical_gap_positive`
- `NLA.RA08.counterexample`
- `NLA.RA08.not_concaveSpectralTransferConjecture`

## Exact active source hashes

- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Basis.lean`: `d8e6500500d2c8f42a7fbe60ef837372d56c65b25f6f0a3d50fdda12406942cc`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Certificate.lean`: `0b778f56004f1616d27d22df87ff8b041b7904348ff19449ccdb537400fe963b`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Definitions.lean`: `8c2f3a76e44730b1f9d5bc8e896070c10868bae817d0c3d11ace22b3c7d94c41`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Fourth.lean`: `e414ce445e90dda38d27df3fa7ec615d3b1da36406e61753978c242ee308965a`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Functional.lean`: `1ce46effb082c1719943700b3166a995b652efa3d95ff52ff9c1e249972590a9`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Location.lean`: `824dfeda0dec85e0588d8051ecbfc5684fb8311bed118a04c1dbd36b74910537`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Numerical.lean`: `91d63b0a0cc41d4edde6782e8ff7726ebcbead479d2d56ee566968bc91f1b989`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/OrderedExistence.lean`: `4da2bb55befc17bca7d520fbae186aafede693927bcb2768e810790a0a3de37b`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Polynomial.lean`: `126f5035af58b4bf070132deca3728988170379d12be3ae05ca4e8e1b1798445`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/ProjectionNorm.lean`: `a825d41bcee3599049bb7e97bd1354377a7f0fb76caa185268c6b1cd658a699d`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Proof.lean`: `8e225fd88e4fb1d546a26241f835dca9ee08756cc52e3f7fe640ba8b11cf8318`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Scalar.lean`: `8dae02527bfb5592a965a9cd73df20974c314c75c38d414248879719c11c063f`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Spectral.lean`: `8b700ff01b12e8d37c330ebbdb799a61af766483606e1870f555a6d182ca8833`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/SpectralCFC.lean`: `df90bbcab9837df4b0c51de0a98de4795745b204b1f58ab7690e4707ab0d59d6`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Tails.lean`: `5bce3453792e45ec9b74e86648092090738254fa08ea5e9b488b90c32ea84449`
- `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Witness.lean`: `b6c03b390059df9ecc5f2fcf5899869d4dbf3d959f05a0d2dfbad858fd6c3420`
- `randomized-and-low-rank-approximation/RA-08/lean/Solution.lean`: `7dc0f17661a7eead3e4555bbc692ebcc0add5e10b8c6414d51f2cd43c69730cc`

## Fresh evidence hashes

- `statement-gate.json`: `60c18188a1ef0fe5349ca0690e3b177224cc490cf935a44a318420d6ad36a8ea`
- `solution-local.json`: `110cb0919a7db36467927aef241bd6dd7bd1e8d07b8a3aeaa7fc08872a701fe7`
- `solution-local.log`: `ccc2cf5bce32a66d1d37f38c625defb4ef7d414e02c2043ea3403bb52a49c428`
- `referee-2-export-audit.lean`: `95208a11421a46dfd42616e4441817e4e2dc3f65e89294237030ee9d7c4a62b6`
- `referee-2-export-audit.log`: `6baa5c270ddf658b979a17a9fcda79ee885a866803c16c2139c7d79bcaa8e985`
- `referee-2-numerical-checker.lean`: `3d4a212c75a57f43e04e786bc5939ab8a630bb56842d6b1a466c72640ad32896`
- `referee-2-numerical-checker.log`: `f3d19c5212dd85479d0e8d9cdd10fe6f80773776dba85d70e6477ac2fe000732`
