# IS-03 independent proof re-review 2

Date: 2026-09-14. Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of the original implementation. Protocol: `docs/lean/REVIEW.md`; Tau Ceti correctness, full-target fidelity, nonvacuity, proof quality, reuse, clarity and credit criteria are adapted without official endorsement.

**Verdict: PASS — no mathematical or trust blocker found in this frozen active proof.** This approves the unchanged authored proof after this campaign's two fresh statement approvals. It does not create a new proof or by itself certify a new Linux run.

## Actual proof path and scope

Algebra proves a genuine polynomial Bezout identity with the derivative, hence separability; Witness computes the actual characteristic polynomial through a 3+4 block reindexing, expanding at most a fourth-order determinant. Formal differentiation, monicity and degree six are independently proved. Spectral derives six distinct complex roots from this proved separability and algebraic closure, then a genuine eigenbasis for EVERY possible real B by complexification and eigenvector independence. Thus the source's no-diagonalizability-premise requirement is respected: diagonalizability is a consequence of this particular characteristic polynomial, not an extra premise. The basis change identifies actual traces of all matrix powers and the complete product polynomial. Newton evaluates Mathlib's Vieta and multivariate Newton identities at the six actual indexed roots; its arbitrary-family argument retains multiplicities and establishes all seven rational values. The final proof equates the seventh actual trace to the negative value and contradicts generic entrywise nonnegative matrix powers. Every reference export is supplied by an exact public wrapper in Solution.

The singleton numerical_negative_moment proof uses LeanCert.Validity.verify_strict_upper_bound_dyadic_checked on the constant expression -8593/823543, domain [0,0], upper bound 0, precision -53 and depth 10. I printed its actual term and its auxiliary checker proof: checkStrictUpperBoundDyadicChecked = true is proved by of_decide_eq_true (id (Eq.refl true)). This is kernel reduction, not native execution. The sign flows through negative_moment_proved into counterexample_proved and the universal negation. No approximate roots or interval subdivision is performed. The exact Bezout identity is a useful computational reduction; a generic non-diagonalizable trace theorem would be another route but is unnecessary here.

Scope is the complete original exact-order conjecture. Arbitrary zero padding and the separate Monov result remain outside the exports. All source and formalization credit is preserved.

## Independent checks actually performed

I read every active local module reachable from Solution, including Definitions and the public export wrappers: 8 files and 570 source lines. Historical duplicate snapshots and unused files were excluded from this active-closure count. Every active source hash was independently compared with both upstream `deb549fa9ddd6b119e6c59016f268237e645dfa2` and the frozen `statement-gate.json`; all matched. The reviewed canonical/source/numerical boundary remains bound by `STATEMENT-REFEREE-2.md`.

I manually followed every Challenge export through its public declaration to the active implementation and independently verified that comparator.json lists exactly these 7 names, has no definition exceptions and permits exactly propext, Classical.choice and Quot.sound. The fresh `referee-2-export-audit.lean` consumer imports Solution, queries every actual type and transitive axiom closure, and applies LeanCert #assert_trust kernel to every export. I executed it with pinned Lean 4.33.1 on macOS aarch64; exit code 0. All 7 axiom outputs contain exactly the standard three, with no custom axiom, sorryAx or native/compiler trust. The active source scan likewise found no proof holes, unsafe implementations, external implementations or Challenge import. The scan is supplementary, not a replacement for the actual transitive audits.

I also inspected the coordinator's fresh successful full Solution build receipt and log, and independently verified its recorded log hash `a7939dbc9a3a4bc05298a09c53187a255d2564d08e77d61b891f18f043f36f33`. That full build is the coordinator's run. My own run was the independent fresh export consumer/term inspection on its resulting local objects, not a second full source/dependency rebuild. For IS-03 and RA-08, the additional retained numerical-checker queries inspect the actual auxiliary Boolean certificate terms and also exit successfully. Relevant imported Mathlib facts and LeanCert trust/checker implementations were checked directly; pinned dependency axioms are covered transitively, rather than claiming a human-style read of all Mathlib.

Exact fresh evidence hashes and all per-export axiom results are in `referee-2-proof-checks.json`; the complete module roster is in `referee-2-active-inputs.json`. No authored Lean source, canonical target, configuration, publication metadata or historical evidence was altered. All inspection files live in this new external audit directory.

## Separate operational limits

The isolated Linux Comparator, full statement identity including definitions, default-kernel export replay, actual sandbox and rejection controls, artifact/source provenance and publication acceptance remain separate gates. This report does not substitute historical PASS text or a local consumer for those checks. It makes no human peer-review, Tau Ceti endorsement or novelty claim. Only the mathematical scope listed above is approved.

## Every reviewed export

- `NLA.IS03.nonnegative_power_trace`
- `NLA.IS03.witness_admissible`
- `NLA.IS03.witness_polynomials`
- `NLA.IS03.trace_moment_certificate`
- `NLA.IS03.negative_moment`
- `NLA.IS03.counterexample`
- `NLA.IS03.not_derivativeRealizabilityConjecture`

## Exact active-source SHA-256 identities

| Repository-relative active file | SHA-256 |
| --- | --- |
| `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Algebra.lean` | `8578821ec515e8e11f3fa5fc94ae48ee0bd57b61338c501fd09e8ed1efad5125` |
| `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Definitions.lean` | `8b4b581e9831b0438d0635b013a60df0cf0139fa9087850b842d8e58975ea1a9` |
| `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Newton.lean` | `451953080999a9b7aec73af27af178018fec6d340439c3b4081716165a7f1ddd` |
| `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Numerical.lean` | `707f69cea0fe650904f016177b7906a6cec308b6a287005369295a133b54659d` |
| `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Proof.lean` | `39c6be952b030622404a216c625d86404a579dc8a6c992a268a7bdf10ea30c28` |
| `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Spectral.lean` | `a4886a8bc7c00607bf2cb0209a5ee153e7661d4bd837e12658ee8e66c8322424` |
| `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Witness.lean` | `b10da5ff41667f45ba6385edabc3fb2d74ede53b1b1208d0de2b3026ad879cfd` |
| `eigenvalues-and-inverse-problems/IS-03/lean/Solution.lean` | `1b3d7ebe1fabc51a04c3012c694f4bd52efe654ebb933e273b87153b267d7508` |
