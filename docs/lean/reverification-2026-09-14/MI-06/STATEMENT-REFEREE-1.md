# MI-06 independent statement reverification — referee 1

**Verdict: PASS on the exact boundary below. No blocking fidelity or scope issue.**

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`; not the original implementer. Date: 2026-09-14. Applied the source-fidelity, correctness, scope, API/reuse, computation and attribution angles in `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is AI review, not official Tau Ceti or external human peer review. Per coordinator direction, this new report is outside the unchanged proof project.

Provenance: the deliberately preserved source base is `deb549fa9ddd6b119e6c59016f268237e645dfa2`, carried forward from the previous batch. It is NOT described as current upstream main: the coordinator observed upstream main at `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. This is a fresh review of an already authored formalization, not a newly written proof. Historical statement-first prose and prior success claims are retained as dated source evidence. I read the complete canonical README, complete informal argument (including excluded extensions), numerical plan, Definitions and all 6 Challenge signatures. I did not inspect existing implementation proof bodies. All read repository bytes were independently checked against the preserved immutable base.

## Fidelity, scope and obligations

The six contracts preserve the complete original factor-sqrt(2) assertion and its negation: every positive n, every pair of complex matrices, and arbitrary complex unitary choices with the ordinary PSD comparison. There are no Hermitian-input, invertibility, real-unitary or preferred-unitary restrictions. CFC.abs is the actual sqrt(star X * X); star is the conjugate transpose, and MatrixOrder is exactly positivity of right minus left. The generic modulus/square-root/PSD bridge and all six witness modulus identifications are conclusions, not assumed tables.

I independently reconstructed the t=3/4 source specialization, all six rational modulus squares, their PSD principal minors and both rank-one decompositions. The missing coordinates 2 and 1 correctly encode source coordinates 3 and 2. The all-two-vector orthogonality assertion in complex dimension three explicitly requires positive squared Euclidean length, with no independence assumptions; it cannot be satisfied by zero. Its homogeneous quadratic bounds have exactly 3/8, 1/8 and 1/8 and use the actual moduli and arbitrary conjugated directions. Thus the planned LeanCert singleton 2<9/4, connected through sqrt(2)<3/2, would close the all-unitary obstruction. It must be consumed in the final proof, not merely computed nearby.

The full Colbrook argument additionally excludes every finite constant. That stronger varying-parameter result is explicitly outside these six exports; the fixed rational example fully refutes the original sqrt(2) target. No norm triangle inequality is substituted. Reusing CFC square-root uniqueness, Gram positivity and finite-dimensional kernel APIs is appropriate and avoids numerical spectral calculations.

## Evidence and remaining gates

The coordinator's NEW `challenge-local.json` and log have matching independently checked SHA-256, successful exit 0 and exactly 6 deliberate Challenge-placeholder warnings. Log SHA-256: `b492b231d481e1a5fbad6afbf7225047d6e245294800770202dd0699771f5480`. This was the coordinator's Lean 4.33.1 macOS aarch64 typecheck using pinned dependencies; I did not rerun it. It proves well-formed statements, not their mathematics. Prior archived builds or Linux success were not used as substitutes. The Comparator configuration names all 6 contracts, allows no definition replacement and permits only propext, Classical.choice and Quot.sound.

The exact diagnostic is supplementary and not a Lean proof. Its script/log are retained alongside this report; the log marks the RA-09 expansion as a manual symbolic check, not a numerical universal verification. The imported definitions were inspected directly in the pinned Mathlib source where relevant; exact hashes are in `referee-1-statement-evidence.json` (SHA-256 `db91ccfa7404c4d9ff93c6175bc1d2ec51e607615c37ff36f65b3efcade43b4c`). That evidence lists all source hashes, access method, configured exports and inspected fresh build evidence. A second independent boundary approval precedes proof inspection; fresh implementation/axiom audits and actual Linux Comparator/default-kernel replay remain separate gates. No proof acceptance or new Linux run is claimed here. Original George Stepaniants formalization credit and the source authors' credits remain unchanged. No source, metadata, historical report, ID or canonical target was edited.

## Exact reviewed repository hashes

- `docs/lean/REVIEW.md`: `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553`
- `matrix-inequalities-and-norms/MI-06/README.md`: `475c228e3f6b57ed8e667dcf44fd44a47564b8b2cd06660e5ccc069b18f8ba53`
- `matrix-inequalities-and-norms/MI-06/lean/NUMERICAL_TARGETS.md`: `792aa98aa94d18d7b49e4e4b66edca89881f1e38cf51c3aacfed8525644509a4`
- `matrix-inequalities-and-norms/MI-06/lean/NLA/MI06/Definitions.lean`: `a89c6604d36aec8ae3428df7663a2dbb6f2f923b13ca5f7746aaf4f424cb29d2`
- `matrix-inequalities-and-norms/MI-06/lean/Challenge.lean`: `7774d76c9e362c0f808ee4c1fec3b5607359048d5af82d0e99f60b74c52326dc`
- `matrix-inequalities-and-norms/MI-06/lean/comparator.json`: `1fe56d984d534e7daa8e8eeaacca0543a8be5404f1dc513bf635afb7e54a5dfc`
- `matrix-inequalities-and-norms/MI-06/solution.tex`: `ae2092528c425b8572c73b07678a01307ed3029399d091a670f78a4d28304bd6`
- `matrix-inequalities-and-norms/MI-06/solution.md`: `ff78cc8fb227cabb5aa646bd44af7075b53ae6b679b0f71f690df1348a637494`
- `references/colbrook-matrix-2026-09-11/original-proofs/MI-06.tex`: `1324c6ecd4a845e6782081e79d401a9dd59612463e40b7ecc176a9ea9003c1e9`
