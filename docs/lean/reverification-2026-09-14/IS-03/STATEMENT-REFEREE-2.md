# IS-03 independent statement re-review 2

Date: 2026-09-14. Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of the authored implementation. Phase: statement boundary only, before this campaign's proof audit. Protocol: `docs/lean/REVIEW.md`, adapting Tau Ceti criteria without endorsement. Upstream base: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.

**Verdict: PASS — approve this exact boundary for independent proof audit.** No mathematical statement changes requested. This is a new review of the existing authored source, not a claim to have authored it or newly verified the completed proof.

## Fidelity, nonvacuity, reuse and credit

The target retains every natural n >= 5, every real entrywise-nonnegative n by n matrix, and existence at exactly order n-1. EntrywiseNonnegative is the pointwise relation, not PSD order. normalizedDerivative uses the actual Polynomial.derivative and reciprocal real dimension, and the equality is genuine polynomial equality with Matrix.charpoly. There is no irreducibility, symmetry, zero-trace, invertibility or diagonalizability premise. The unchanged order-seven cycle-block witness has the correct shape and positive trace. trace_moment_certificate is universally quantified over EVERY real order-six matrix with that actual characteristic polynomial; its seven trace values are conclusions. Thus a single companion calculation is not substituted for the essential universal bridge. The generic nonnegative_power_trace and the strict seventh sign logically give the complete universal negation. I independently recomputed the seven Newton moments using exact rational arithmetic: 3/7, 79/49, 48/343, 6731/2401, 5213/16807, 219766/117649, -8593/823543. This diagnostic is not a proof oracle. Zero padding and the separate Monov consequence are outside the exports and not needed to settle the canonical exact-order target. Mathlib Charpoly/Basic defines charpoly as det(charmatrix), Trace defines the diagonal sum, and Polynomial/Derivative defines the actual formal derivative. natDegree zero totalization causes no escape because monicity/degree are explicit witness conclusions. Mathematical credit remains Colbrook, formalization credit Stepaniants, and original conjecture credit is retained.

## Evidence and limits

I read the entire canonical target, complete source manuscript, numerical-target plan, definitions and all Challenge signatures listed below; I inspected the actual relevant definitions in pinned Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`. I checked each listed worktree file is byte-identical to its upstream Git object. No implementation proof bodies were inspected or altered in this stage. Historical statement-stage prose is a preserved artifact, not a present claim that the upstream proof does not exist.

I inspected the coordinator's fresh `challenge-local.json` and `challenge-local.log`: exit code 0, successful macOS aarch64 Challenge elaboration under Lean 4.33.1, with intentional Challenge placeholder warnings. Log SHA-256: `b8aa1711082d76915054b2a237c7a555d2b52febbe317c045b96fbb6c188713f`; I independently verified that hash. This was the coordinator's run, not a second independent run. Deliberate placeholders prove no mathematics. Actual proof replay, transitive axiom checks, materially consumed kernel LeanCert terms, Comparator identity and Linux operational controls remain separate pending gates of this re-verification campaign. Prior upstream PASS/status prose was not used as a substitute for this review.

Only this fresh report was written; canonical IDs, paths, source attribution, authored mathematical bytes, metadata and prior review/history were preserved.

## Reviewed SHA-256 identities

| Repository-relative file | SHA-256 |
| --- | --- |
| `eigenvalues-and-inverse-problems/IS-03/README.md` | `b993f8a77090f811ff68b06e1cad5da4b5fc979d9c482b1c82e25df7d84c65fe` |
| `eigenvalues-and-inverse-problems/IS-03/lean/NUMERICAL_TARGETS.md` | `b1fe777e2d4853b4d60d75e4d0628939f19434434ca82ac4ffe2a3e5bdbf1787` |
| `eigenvalues-and-inverse-problems/IS-03/lean/NLA/IS03/Definitions.lean` | `8b4b581e9831b0438d0635b013a60df0cf0139fa9087850b842d8e58975ea1a9` |
| `eigenvalues-and-inverse-problems/IS-03/lean/Challenge.lean` | `4a8817f7c983819fac0a9206092831e72709fcfdb73b0687350914162ef23440` |
| `eigenvalues-and-inverse-problems/IS-03/solution.md` | `236c6d4105baeb6c79cb16dc4899924377a6ed7ee92d4aea3840df0e46d1c10b` |
