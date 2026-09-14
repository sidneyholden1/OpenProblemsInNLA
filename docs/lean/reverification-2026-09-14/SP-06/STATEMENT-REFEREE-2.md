# SP-06 independent statement re-review 2

Date: 2026-09-14. Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of the authored implementation. Phase: statement boundary only, before this campaign's proof audit. Protocol: `docs/lean/REVIEW.md`, adapting Tau Ceti criteria without endorsement. Upstream base: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.

**Verdict: PASS — approve this exact boundary for independent proof audit.** No mathematical statement changes requested. This is a new review of the existing authored source, not a claim to have authored it or newly verified the completed proof.

## Fidelity, nonvacuity, reuse and credit

The original canonical question requires a Jordan curve avoiding zero, not a separately formalized enclosure theorem. hasRealJordanCurve is exactly a continuous injective map of Mathlib Circle into the complex plane, nowhere zero and with the Laurent evaluation real at EVERY point. Circle is the actual complex unit sphere. The source additionally constructs a star-shaped curve enclosing zero; excluding a separate enclosure export therefore does not weaken this target. Arbitrary finite complex Laurent coefficients, positive lower/upper bandwidths with nonzero extremes, and every positive finite Toeplitz size are retained. Integer exponents and i-j indexing agree with the source; actual spectrum is the complement of the algebra resolvent set, not a supplied eigenvalue list. Existence and continuity of the whole radius profile are theorem obligations, not assumptions in the final negative target. The scalar endpoint, separation and Lipschitz statements cover complete intervals and suffice for a genuine curve by IVT and continuous root choice. The seven coefficients and order-two section agree with the complete source. The actual nonreal spectrum witness -128+8i disproves allFiniteSpectraReal at n=2, then the entire targetImplication. No finite mesh or limiting-spectrum result is substituted. Mathematical proof credit Colbrook and formalization credit Stepaniants are retained.

## Evidence and limits

I read the entire canonical target, complete source manuscript, numerical-target plan, definitions and all Challenge signatures listed below; I inspected the actual relevant definitions in pinned Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`. I checked each listed worktree file is byte-identical to its upstream Git object. No implementation proof bodies were inspected or altered in this stage. Historical statement-stage prose is a preserved artifact, not a present claim that the upstream proof does not exist.

I inspected the coordinator's fresh `challenge-local.json` and `challenge-local.log`: exit code 0, successful macOS aarch64 Challenge elaboration under Lean 4.33.1, with intentional Challenge placeholder warnings. Log SHA-256: `7d44fa04512805619e4b6b7d76f3f3cc3a05039764e1892e498be36969ab626c`; I independently verified that hash. This was the coordinator's run, not a second independent run. Deliberate placeholders prove no mathematics. Actual proof replay, transitive axiom checks, materially consumed kernel LeanCert terms, Comparator identity and Linux operational controls remain separate pending gates of this re-verification campaign. Prior upstream PASS/status prose was not used as a substitute for this review.

Only this fresh report was written; canonical IDs, paths, source attribution, authored mathematical bytes, metadata and prior review/history were preserved.

## Reviewed SHA-256 identities

| Repository-relative file | SHA-256 |
| --- | --- |
| `eigenvalues-and-inverse-problems/SP-06/README.md` | `192cf2a4e40cc05b579248a5e9693d48f6727fedb054d98eafc8af97274b5077` |
| `eigenvalues-and-inverse-problems/SP-06/lean/NUMERICAL_TARGETS.md` | `bfd2a0bcc5c5328ac9f3fd85d56ac7d3b8a5d551236cee68e227cb9acbea1959` |
| `eigenvalues-and-inverse-problems/SP-06/lean/NLA/SP06/Definitions.lean` | `5f3e071b9aabbbda27a794f9396022e54585f5d2d254827e50ea90baf80e72b1` |
| `eigenvalues-and-inverse-problems/SP-06/lean/Challenge.lean` | `cd75a8f37a174d7dfb68927f7e6aeb23cf0982eb3161d7d9e5a63a7583d73bef` |
| `eigenvalues-and-inverse-problems/SP-06/solution.md` | `c7adb8f97238049b20e82044d8527b70301779ba041169f74fe603a88ea1ae7a` |
