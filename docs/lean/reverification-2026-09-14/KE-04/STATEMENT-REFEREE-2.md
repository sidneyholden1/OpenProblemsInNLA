# KE-04 independent statement re-review 2

Date: 2026-09-14. Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of the authored implementation. Phase: statement boundary only, before this campaign's proof audit. Protocol: `docs/lean/REVIEW.md`, adapting Tau Ceti criteria without endorsement. Upstream base: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.

**Verdict: PASS — approve this exact boundary for independent proof audit.** No mathematical statement changes requested. This is a new review of the existing authored source, not a claim to have authored it or newly verified the completed proof.

## Fidelity, nonvacuity, reuse and credit

The target retains all real symmetric A, linearly independent starting columns, every permitted k,j,i, arbitrary independently selected orthonormal Krylov bases, strict open intervals and eigenvalue multiplicities. krylov is exactly the span of A^r V columns. FullBlockDimension contains only the actual finrank equality, not spectral conclusions. LastFullBlockIteration matches the maximal-s convention; the stronger arbitrary-full-prefix theorem has a separate implication to the canonical target. Zero block width has no largest full index, and its maximality existence contract correctly requires positive width. For all actual interval indices, the exported index-validity contract excludes the total eigenvalueAt fallback zero. The actual Mathlib IsSymmetric.eigenvalues is antitone with multiplicity and matched eigenvectors, so Fin.rev gives the intended increasing ordering. Basis existence, basis independence and characteristic ROOT MULTISET equality are obligations, excluding vacuity and accidental distinct-spectrum substitution. Compressed quadratic means Q q(Q transpose A Q) Q transpose, not the ambient polynomial with an extra constant term off the subspace. Nonannihilation, PSD, intersection existence, quadratic form equality and the later A-squared identity are all derived obligations, not final assumptions. This matches the complete three-section source proof, including coincident endpoints. No finite-precision claim is made. Original proof credit remains Colbrook, formalization Stepaniants, conjecture Simonova/Tichy.

## Evidence and limits

I read the entire canonical target, complete source manuscript, numerical-target plan, definitions and all Challenge signatures listed below; I inspected the actual relevant definitions in pinned Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`. I checked each listed worktree file is byte-identical to its upstream Git object. No implementation proof bodies were inspected or altered in this stage. Historical statement-stage prose is a preserved artifact, not a present claim that the upstream proof does not exist.

I inspected the coordinator's fresh `challenge-local.json` and `challenge-local.log`: exit code 0, successful macOS aarch64 Challenge elaboration under Lean 4.33.1, with intentional Challenge placeholder warnings. Log SHA-256: `35bd459d8af392f76af79832e2a5c891e900cd8770d054288dd85723c0318158`; I independently verified that hash. This was the coordinator's run, not a second independent run. Deliberate placeholders prove no mathematics. Actual proof replay, transitive axiom checks, materially consumed kernel LeanCert terms, Comparator identity and Linux operational controls remain separate pending gates of this re-verification campaign. Prior upstream PASS/status prose was not used as a substitute for this review.

Only this fresh report was written; canonical IDs, paths, source attribution, authored mathematical bytes, metadata and prior review/history were preserved.

## Reviewed SHA-256 identities

| Repository-relative file | SHA-256 |
| --- | --- |
| `eigenvalues-and-inverse-problems/KE-04/README.md` | `00f696298022dadf0aaf3e97e943682fcb9457b82b41a2d1e86331c6885f678d` |
| `eigenvalues-and-inverse-problems/KE-04/lean/NUMERICAL_TARGETS.md` | `ad963526a371cdfee8eaaf179674d5cabd2a1d5a9ae5b123c96ac2f2b4271c47` |
| `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Definitions.lean` | `ae1baccc0cb622f83103eff8bb4a5efe4cd9a3bae4822ccca38da29554ae9ca4` |
| `eigenvalues-and-inverse-problems/KE-04/lean/Challenge.lean` | `a27de227d483072e395b6658a97cbf31296503c7fab36e5f9dbf248b2efa299e` |
| `eigenvalues-and-inverse-problems/KE-04/solution.md` | `dd57fdb065f83dd9a5a4ac7946e3cd2801ec495b02c81f66110117f699fbaad6` |
