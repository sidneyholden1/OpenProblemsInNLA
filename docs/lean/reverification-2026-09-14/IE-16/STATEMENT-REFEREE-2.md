# IE-16 independent statement re-review 2

Date: 2026-09-14. Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of the authored implementation. Phase: statement boundary only, before this campaign's proof audit. Protocol: `docs/lean/REVIEW.md`, adapting Tau Ceti criteria without endorsement. Upstream base: `deb549fa9ddd6b119e6c59016f268237e645dfa2`.

**Verdict: PASS — approve this exact boundary for independent proof audit.** No mathematical statement changes requested. This is a new review of the existing authored source, not a claim to have authored it or newly verified the completed proof.

## Fidelity, nonvacuity, reuse and credit

The target retains every finite set of n >= 3 distinct nonzero COMPLEX points and every 1 <= k <= n-2, using actual Real.pi. Polynomial coefficients are arbitrary complex numbers; feasibility is actual natDegree <= k with eval 0 = 1, which excludes the zero polynomial and the misleading zero natDegree branch. maxModulus is Finset.sup' of the genuine complex norm; M is genuine real sInf of ALL feasible objective values, and subsetFamily is precisely the complete powerset filtered by card k+1. Finset already enforces distinctness. The empty maxima branches cannot occur under canonical hypotheses: L is nonempty and k+1 <= n, and at the witness explicit cardinality/admissibility are conclusions. FeasibleValues is nonempty (constant one) and bounded below (zero) for every finite set. For the actual counterexample the full minimum and EVERY five-point subset minimum must explicitly satisfy IsLeast, so no unattained or junk infimum supplies the contradiction. The subset maximum is explicitly positive before division. The exact nine points and cubic candidate agree with the full source. Universal subset quantification cannot be replaced by one representative or a numerical sampling assertion. I independently checked the rational full lower bound and (299/100000)/(23/10000)=13/10; pi>31/10 suffices for 4/pi<13/10. These are diagnostics, not Lean proof checks. The full source also proves an unbounded ratio, but the finite counterexample alone refutes the entire original inequality; that stronger theorem and an explicit GMRES matrix/residual are correctly excluded. NUMERICAL_TARGETS names a historical submitted/source/solution.tex path absent in this checkout. I resolved source access by reading the entire canonical solution.tex, including all amplification sections and weighted optimality; its exact hash is recorded below. This historical path is not a mathematical blocker or a proof dependency. Original proof/certificate credit remains Sidney Holden and formalization credit George Stepaniants.

## Evidence and limits

I read the entire canonical target, complete source manuscript, numerical-target plan, definitions and all Challenge signatures listed below; I inspected the actual relevant definitions in pinned Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`. I checked each listed worktree file is byte-identical to its upstream Git object. No implementation proof bodies were inspected or altered in this stage. Historical statement-stage prose is a preserved artifact, not a present claim that the upstream proof does not exist.

I inspected the coordinator's fresh `challenge-local.json` and `challenge-local.log`: exit code 0, successful macOS aarch64 Challenge elaboration under Lean 4.33.1, with intentional Challenge placeholder warnings. Log SHA-256: `2f2cf6b13b333762cf45c6e00a9da509b6226176b17c36fb728492cd33ced1ff`; I independently verified that hash. This was the coordinator's run, not a second independent run. Deliberate placeholders prove no mathematics. Actual proof replay, transitive axiom checks, materially consumed kernel LeanCert terms, Comparator identity and Linux operational controls remain separate pending gates of this re-verification campaign. Prior upstream PASS/status prose was not used as a substitute for this review.

Only this fresh report was written; canonical IDs, paths, source attribution, authored mathematical bytes, metadata and prior review/history were preserved.

## Reviewed SHA-256 identities

| Repository-relative file | SHA-256 |
| --- | --- |
| `linear-systems-and-elimination/IE-16/README.md` | `203371c8dcf675a94ab5bd5d59f0f566725e6a7611f2ba525651222bb5875c59` |
| `linear-systems-and-elimination/IE-16/lean/NUMERICAL_TARGETS.md` | `0bea606a903e7956cac9765048db9881f07f29819f405269545f1da12ec6d682` |
| `linear-systems-and-elimination/IE-16/lean/NLA/IE16/Definitions.lean` | `e4681f2083d71d8980adcd70e7cf26367e0e84dbc1773f4d2f082bf2417c9507` |
| `linear-systems-and-elimination/IE-16/lean/Challenge.lean` | `85cbe24c7657d9ddc37728db5bb1740a80ddab60e3eb4676e329df40a7b1737c` |
| `linear-systems-and-elimination/IE-16/solution.tex` | `194dcd089f8f5460812bf36a8eb76bccf1694075cf1982256494942b6c332a43` |
