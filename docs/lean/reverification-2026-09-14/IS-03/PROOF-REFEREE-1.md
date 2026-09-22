# IS-03 independent proof reverification — referee 1

**Verdict: PASS for mathematical correctness, complete frozen scope and local proof closure. No blocking finding. Fresh Linux Comparator acceptance is a separate operational gate, not claimed here.**

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not the author or implementer of these upstream proofs. Date: 2026-09-14. Applied the correctness, scope, API/reuse, efficiency and attribution angles of `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is AI review, not official Tau Ceti or human peer review.

The two statement approvals were frozen in `statement-gate.json` before this campaign's proof inspection. I read the complete 8-module ACTIVE Solution import closure, all 7 frozen Challenge contracts and their implementations, together with the previously reviewed complete canonical/informal source. Historical evidence copies were not mistaken for active dependencies. I independently checked every active source byte against upstream `deb549fa9ddd6b119e6c59016f268237e645dfa2` and the gate; all match. The current candidate is `072fdd9c7eb819b557daec9ea77f081bff387786`. No existing source, metadata, historical evidence, attribution, problem ID or canonical target was edited.

## Mathematical audit and scope

The complete exact-order negative target is proved. The seven public contracts cover arbitrary-order nonnegative power traces; the actual 7-by-7 source witness; its characteristic polynomial and normalized derivative; all seven power traces of EVERY real 6-by-6 realization; the strict negative seventh moment; the concrete nonrealizability; and the unconditional negation of the all-n conjecture. The implementation does not replace arbitrary realizations with a companion matrix or assume diagonalizability.

Algebra supplies an exact rational Bezout identity for q and q', establishing separability rather than imposing it. Witness computes the actual block determinant using the 1+2+4 decomposition. Spectral maps each arbitrary real candidate into complex matrices, derives six distinct roots from degree, splitting and separability, obtains actual eigenvectors, proves their independence and cardinality, and constructs a basis. In that basis powers have the actual trace equal to the sum of root powers. Newton connects polynomial coefficients to evaluated elementary symmetric polynomials and uses Mathlib's Newton identities. The seventh elementary symmetric term vanishes because there are only six indices. All seven exact source moments follow, including -8593/823543. No multiplicity is silently dropped: simplicity is proved for this polynomial. The real/complex map is injective, so the trace statements return to the original real candidates.

The imported eigenvector independence theorem explicitly requires injective eigenvalues and actual nonzero eigenvectors; both are discharged. The root-set cardinality and Newton APIs retain their genuine algebraic meanings. Entrywise nonnegativity of every natural matrix power gives a nonnegative diagonal sum; the seventh negative trace contradicts this for any candidate. Empty-dimensional and zero-power generic assertions remain valid.

LeanCert has a material singleton role: numerical_negative_moment is proved by interval_decide with explicit kernel trust, and its theorem feeds negative_moment, counterexample and the final negation. I inspected referee 2's fresh printed checker term: checkStrictUpperBoundDyadicChecked of the exact rational expression at the singleton zero interval equals true, reduced by of_decide_eq_true (id (Eq.refl true)). It introduces no numerical-root oracle. The source's stronger zero-padding exclusion and separate Monov consequence are not claimed. Colbrook retains the mathematical credit and Stepaniants the existing formalization credit.

## Fresh evidence, trust and limits

I inspected the coordinator's fresh macOS aarch64 Lean 4.33.1 `solution-local.json` and full `solution-local.log`, checked the recorded SHA-256 against the actual log, observed exit 0 and successful Solution completion. This was a coordinator build, not a build independently run by this referee. Historical PASS reports were not substituted. Active source scanning and manual reading found no `sorry`, `admit`, custom `axiom`, `native_decide`, `unsafe` or `implemented_by` in executable code. Challenge's intentional placeholders are outside the active Solution import closure. All 7 exports have active `#assert_trust kernel` checks.

I also inspected referee 2's NEW independent export-consumer evidence, which checks the actual theorem types and prints every exported axiom closure; every closure contains only `propext`, `Classical.choice` and `Quot.sound` (universe annotations do not add axioms). This consumer was run by referee 2, not by me. My independent evidence script verified every configured export has an active declaration, a kernel audit, and a matching standard-only axiom line in that fresh consumer log. The exact caller statements and proof branches were read as mathematical code; later Linux Comparator must still verify full declaration identity in its own sandbox and default-kernel replay. No fresh Linux success, sandbox acceptance or publication approval is inferred from these local checks.

The review is bound to `referee-1-proof-evidence.json` SHA-256 `9b55e1dbdcb318bfdafc4c7f0819c2bde3b752a32d4c640777dea78eae23d1b1`. It records the full active dependency graph, exact source and boundary hashes, all 7 export names and individual axiom lists, direct external imports and hashes of inspected fresh evidence. The log/source byte checks were independently executed by this referee; they do not replace Lean checking. No additional proof build was repeated because the coordinator and second referee supplied fresh complementary execution evidence.

## Export coverage

Every name below was traced from the frozen contract through its active implementation and checked against the fresh consumer's permitted-axiom record:

- `NLA.IS03.nonnegative_power_trace`
- `NLA.IS03.witness_admissible`
- `NLA.IS03.witness_polynomials`
- `NLA.IS03.trace_moment_certificate`
- `NLA.IS03.negative_moment`
- `NLA.IS03.counterexample`
- `NLA.IS03.not_derivativeRealizabilityConjecture`

## Exact active source hashes

- `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Algebra.lean`: `8578821ec515e8e11f3fa5fc94ae48ee0bd57b61338c501fd09e8ed1efad5125`
- `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Definitions.lean`: `8b4b581e9831b0438d0635b013a60df0cf0139fa9087850b842d8e58975ea1a9`
- `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Newton.lean`: `451953080999a9b7aec73af27af178018fec6d340439c3b4081716165a7f1ddd`
- `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Numerical.lean`: `707f69cea0fe650904f016177b7906a6cec308b6a287005369295a133b54659d`
- `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Proof.lean`: `39c6be952b030622404a216c625d86404a579dc8a6c992a268a7bdf10ea30c28`
- `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Spectral.lean`: `a4886a8bc7c00607bf2cb0209a5ee153e7661d4bd837e12658ee8e66c8322424`
- `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Witness.lean`: `b10da5ff41667f45ba6385edabc3fb2d74ede53b1b1208d0de2b3026ad879cfd`
- `eigenvalues-and-inverse-problems/IS-03/lean/Solution.lean`: `1b3d7ebe1fabc51a04c3012c694f4bd52efe654ebb933e273b87153b267d7508`

## Fresh evidence hashes

- `statement-gate.json`: `f1d2650177853eabf16cd3b6c3cd9f2160dcbfa4713f4bc90d32f10e39ff17e0`
- `solution-local.json`: `3191bbff418ddd1c5d324558578bcdd7af3a528bbaf0fafbbbca7dd002acdc33`
- `solution-local.log`: `a7939dbc9a3a4bc05298a09c53187a255d2564d08e77d61b891f18f043f36f33`
- `referee-2-export-audit.lean`: `34026a4ab43089f3d923de1810b55141287d58871e559e4342f63eb651838e37`
- `referee-2-export-audit.log`: `e045517ee348106d0180b06971c68a70dcc1b82bb87cdc096eed3cb1640bec54`
- `referee-2-numerical-checker.lean`: `5987de6726d44cdc16a30fc14fa97fe32fb4eab6eaf2a9330c62a89dd9b7f58f`
- `referee-2-numerical-checker.log`: `5aea2e57c639d6047065747d2ddd44a8cccafbe44e445bd2e5a3751d370a94bd`
