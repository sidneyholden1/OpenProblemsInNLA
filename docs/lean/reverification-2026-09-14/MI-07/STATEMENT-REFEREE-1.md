# MI-07 independent statement reverification — referee 1

**Verdict: PASS on the exact boundary below. No blocking fidelity or scope issue.**

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`; not the original implementer. Date: 2026-09-14. Applied the source-fidelity, correctness, scope, API/reuse, computation and attribution angles in `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is AI review, not official Tau Ceti or external human peer review. Per coordinator direction, this new report is outside the unchanged proof project.

Provenance: the deliberately preserved source base is `deb549fa9ddd6b119e6c59016f268237e645dfa2`, carried forward from the previous batch. It is NOT described as current upstream main: the coordinator observed upstream main at `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. This is a fresh review of an already authored formalization, not a newly written proof. Historical statement-first prose and prior success claims are retained as dated source evidence. I read the complete canonical README, complete informal argument (including excluded extensions), numerical plan, Definitions and all 7 Challenge signatures. I did not inspect existing implementation proof bodies. All read repository bytes were independently checked against the preserved immutable base.

## Fidelity, scope and obligations

The seven contracts preserve every complex matrix and unitary quantifier in the original constant-one assertion, with ordinary PSD comparison. rootSequence uses all positive natural exponents r+1 as actual matrix powers and an explicitly named CFC.rpow outer root. It cannot accidentally resolve to pointwise real powers. The generic spectralNorm convergence equivalence refers to the explicitly scoped Euclidean operator norm. I inspected Mathlib's topology replacement in instL2OpMetricSpace: it retains the finite matrix topology, so the topological and operator-norm limits express the same convergence.

Filter.limUnder is totalized through Classical.epsilon. This is an important boundary issue, resolved at all counterexample occurrences by the explicit Tendsto obligations for A, B and A+B, plus the generic limit-identification theorem. No convergence premise is appended to the final negation. Generic convergence at unrelated matrices is not exported; a negative result only needs actual limits at its witness. The maximal modulus is neither entrywise maximum nor a stipulation of the desired table.

I independently reconstructed the source family at t=5/12, s=13/12 (the source's optional fixed example instead has t=1/2). All six polar square-root tables are PSD and square to their actual Gram matrices. P and Q are projections, R=P+Q has positive first principal entry and determinant 25/169, and the trace gap is 13/6-11/6=1/3. Actual CFC/natural-power conversions and all reciprocal-exponent limits must still be proved to connect these tables to the root sequence. The all-unitary trace statement then excludes PSD domination; the LeanCert strict gap must participate in that contradiction. The varying-parameter no-finite-constant theorem and generic convergence theorem are explicit exclusions, not missing parts of the original constant-one counterexample.

## Evidence and remaining gates

The coordinator's NEW `challenge-local.json` and log have matching independently checked SHA-256, successful exit 0 and exactly 7 deliberate Challenge-placeholder warnings. Log SHA-256: `b529aabfb91e2471a1168679acd90330f77d00a892979d958dfc680bbe154c3c`. This was the coordinator's Lean 4.33.1 macOS aarch64 typecheck using pinned dependencies; I did not rerun it. It proves well-formed statements, not their mathematics. Prior archived builds or Linux success were not used as substitutes. The Comparator configuration names all 7 contracts, allows no definition replacement and permits only propext, Classical.choice and Quot.sound.

The exact diagnostic is supplementary and not a Lean proof. Its script/log are retained alongside this report; the log marks the RA-09 expansion as a manual symbolic check, not a numerical universal verification. The imported definitions were inspected directly in the pinned Mathlib source where relevant; exact hashes are in `referee-1-statement-evidence.json` (SHA-256 `448b1a6155becf2225866a7881f9057cdb079e143d632bf8626bfc75449bdefa`). That evidence lists all source hashes, access method, configured exports and inspected fresh build evidence. A second independent boundary approval precedes proof inspection; fresh implementation/axiom audits and actual Linux Comparator/default-kernel replay remain separate gates. No proof acceptance or new Linux run is claimed here. Original George Stepaniants formalization credit and the source authors' credits remain unchanged. No source, metadata, historical report, ID or canonical target was edited.

## Exact reviewed repository hashes

- `docs/lean/REVIEW.md`: `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553`
- `matrix-inequalities-and-norms/MI-07/README.md`: `72115f553928a5ec56ed87362f852b4c081e8a083f3061126423f9bbf2dd3aba`
- `matrix-inequalities-and-norms/MI-07/lean/NUMERICAL_TARGETS.md`: `70272f54de929a95347db186b09b66d534313eed87ab7daa8e7fe5c8aaa8bd1e`
- `matrix-inequalities-and-norms/MI-07/lean/NLA/MI07/Definitions.lean`: `369e99eaf3df8a8bbfb214973129ab71fbc95445ba9d176e91d52bca3bc46bc5`
- `matrix-inequalities-and-norms/MI-07/lean/Challenge.lean`: `62fee2804dc12a4ad7edecfa8c1dda2dc39acc2d94475d29805e8e55c3288a59`
- `matrix-inequalities-and-norms/MI-07/lean/comparator.json`: `2e9d5b3a4b0e29f0208a75b42e22fe28f2743a2e9c908d9fc1c451161e0b60b7`
- `matrix-inequalities-and-norms/MI-07/solution.tex`: `de4f6e94c47123d16e28c19cd9bb18010189d66ab0b02c1aad99bf7ca62aaa46`
- `matrix-inequalities-and-norms/MI-07/solution.md`: `af29a8929d438aa50b2497ab5fc315286710ba5e8474e4a1d407612ab2dd2cb5`
- `references/colbrook-matrix-2026-09-11/original-proofs/MI-07.tex`: `0a5351a8ee77d87faa491093ca801c0797227b7e70c3945d7368e16d9d733d2e`
