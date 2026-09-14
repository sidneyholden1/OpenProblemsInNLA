# RA-08 independent statement re-review 2

Date: 2026-09-14. Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of the authored implementation. Phase: statement boundary only, before this campaign's proof audit. Protocol: `docs/lean/REVIEW.md`, adapting Tau Ceti criteria without endorsement. Upstream base: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.

**Verdict: PASS — approve this exact boundary for independent proof audit.** No mathematical statement changes requested. This is a new review of the existing authored source, not a claim to have authored it or newly verified the completed proof.

## Fidelity, nonvacuity, reuse and credit

The complete target retains all n >= 2 and 1 <= k < n, arbitrary real symmetric PSD pairs with actual PSD order, every continuous/nonnegative/nondecreasing/concave half-line function, all epsilon >= 0 and every allowed ordered orthogonal eigendecomposition. It does not assume generic f(0)=0 or operator monotonicity. spectralNorm is the norm of Matrix.toEuclideanCLM on actual L2 Euclidean space, not the default matrix norm. OrderedSpectralData requires orthogonality, antitone nonnegative eigenvalues and exact reconstruction; existence for EVERY PSD matrix and true eigenvector/CFC semantics remain exported obligations. The same eigenvectors define both truncations, with omitted entries zero even if f(0)>0. Actual cfc is used. Its total zero fallback does not weaken the target: PSD supplies self-adjointness and finite spectrum makes every scalar function continuous there; I checked Mathlib HermitianFunctionalCalculus.cfc_eq and the actual generic cfc definition. MatrixOrder is exactly (A-Ahat).PosSemidef. The unchanged source rational witness and kink function are admissible obligations, as are positivity, actual spectral containment, the fourth eigenvalue, every-basis tail identities and same-matrix CFC minorant domination. The strict rational gap is a conclusion feeding an unconditional complete negation, not an assumed enclosure or spectral table. The weaker positive polynomial-minorant gap suffices for the original yes/no target; the source stronger contour ratio, separate Nystrom identity, nuclear examples and strictly increasing perturbation are expressly outside these exports. All are present in the complete source read, so these exclusions were checked against the whole manuscript. Original mathematical proof credit Colbrook, formalization Stepaniants and original-question credit Persson/Meyer/Musco are retained.

## Evidence and limits

I read the entire canonical target, complete source manuscript, numerical-target plan, definitions and all Challenge signatures listed below; I inspected the actual relevant definitions in pinned Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`. I checked each listed worktree file is byte-identical to its upstream Git object. No implementation proof bodies were inspected or altered in this stage. Historical statement-stage prose is a preserved artifact, not a present claim that the upstream proof does not exist.

I inspected the coordinator's fresh `challenge-local.json` and `challenge-local.log`: exit code 0, successful macOS aarch64 Challenge elaboration under Lean 4.33.1, with intentional Challenge placeholder warnings. Log SHA-256: `ff93cd00708928bea981bbee38ae8d4e474cbe3d524861f1c530061e368b593e`; I independently verified that hash. This was the coordinator's run, not a second independent run. Deliberate placeholders prove no mathematics. Actual proof replay, transitive axiom checks, materially consumed kernel LeanCert terms, Comparator identity and Linux operational controls remain separate pending gates of this re-verification campaign. Prior upstream PASS/status prose was not used as a substitute for this review.

Only this fresh report was written; canonical IDs, paths, source attribution, authored mathematical bytes, metadata and prior review/history were preserved.

## Reviewed SHA-256 identities

| Repository-relative file | SHA-256 |
| --- | --- |
| `randomized-and-low-rank-approximation/RA-08/README.md` | `2f3af42c63b5726e4360b496ed13a077ff418d47e62962df4ede44b929a067d6` |
| `randomized-and-low-rank-approximation/RA-08/lean/NUMERICAL_TARGETS.md` | `a1fa22ee4cf7b3481795e68f9b04217b4da9761e3adb60c9cb3551ad2e4a1148` |
| `randomized-and-low-rank-approximation/RA-08/lean/NLA/RA08/Definitions.lean` | `8c2f3a76e44730b1f9d5bc8e896070c10868bae817d0c3d11ace22b3c7d94c41` |
| `randomized-and-low-rank-approximation/RA-08/lean/Challenge.lean` | `6dfe1fe49431bd3f5dc4c91360911d02c6aaf73d902a40fcabec79155fb11c18` |
| `references/colbrook-transfer-2026-09-11/manuscripts/03_concave_transfer_counterexamples.tex` | `6f52104ffcbc29ab7fa2de47537bfe2be7a2a3f56bf2e2c65d090036680cb0ed` |
