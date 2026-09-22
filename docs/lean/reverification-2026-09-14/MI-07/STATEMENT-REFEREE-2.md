# MI-07 — independent statement referee 2

**PASS — approved for proof audit at the hashes below.** Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_2`, 2026-09-14. Covers fidelity/scope, nonvacuity, numerical obligations, relevant API reuse and attribution under `docs/lean/REVIEW.md`'s Tau Ceti adaptation, without claiming official endorsement or human peer review.

This is independent reverification of existing authored statements preserved at `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored formalization or the current upstream main. The separately observed upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f` is not the source base. I read the full canonical page, complete informal proof, numerical plan, Definitions and Challenge before inspecting any implementation. Historic statement-stage wording and prior verification claims remain archival; neither supplies this approval. George Stepaniants retains formalization authorship; Colbrook retains mathematical credit except NR-03's complete counterexample by Sidney Holden. No source bytes were changed.

The full constant-one conjecture retains all positive dimensions, arbitrary complex input matrices and existential arbitrary complex unitaries, using ordinary PSD order. The root sequence uses actual matrix natural powers at every positive integer r+1 and the genuine unital CFC real power at its strictly positive reciprocal. It is not an entrywise root. The generic spectral-norm convergence equivalence uses the scoped Euclidean operator norm, whose Mathlib instance preserves the finite-product topology.

`Filter.limUnder` is totalized. This is acceptable for this negative target because a separate unconditional export requires actual convergence at all three witness arguments, and the generic limit-identification theorem fixes every occurrence used in the counterexample. No default value or assumed convergence supplies the obstruction; a generic convergence theorem for unrelated inputs is explicitly excluded. The later proof must distinguish positive exponents of a singular projection from its unital exponent-zero power, and use exponent-zero continuity only on the positive definite spanning sum.

Independent rational reconstruction confirms all six modulus square identities, projector idempotence, spanning-sum leading minor 313/169 and determinant 25/169, and the positive trace gap 1/3. Thus the source family specialization t=5/12, rather than its optional t=1/2 example, is legitimate and computationally cheaper. The three required limits give left trace 13/6 and every-unitary right trace 11/6, ruling out PSD domination. Neither numerical limit sampling nor a selected-unitary search is adequate. The original constant-one assertion is fully negated; the stronger no-finite-constant manuscript result is excluded. Actual material LeanCert point-certificate use remains for proof audit.

The Comparator roster matches all 7 Challenge declarations exactly, with no definition exceptions and only the three standard permitted axioms. I independently matched every reviewed local source to its immutable Git blob (git-show supplied sparse references). The coordinator's fresh macOS `lake build Challenge` passed; I checked its complete short log, 7 deliberate placeholder warnings, exit zero and SHA256 `b529aabfb91e2471a1168679acd90330f77d00a892979d958dfc680bbe154c3c`. This was the coordinator's execution, not mine, and establishes statement elaboration only. Fresh proof review, all-export trust checks and actual Linux Comparator execution remain separate gates. No historical PASS is being substituted for those future gates.

`referee-2-statement-checks.json` records the exact supplemental computations, read methods, export names, fresh build receipt and inspected Mathlib definitions/ranges at the pinned revision. All read primary-source hashes are below; metadata was inspected for scope/attribution, without re-auditing its historical run claims.

| Source | SHA256 |
| --- | --- |
| `matrix-inequalities-and-norms/MI-07/README.md` | `72115f553928a5ec56ed87362f852b4c081e8a083f3061126423f9bbf2dd3aba` |
| `matrix-inequalities-and-norms/MI-07/lean/NUMERICAL_TARGETS.md` | `70272f54de929a95347db186b09b66d534313eed87ab7daa8e7fe5c8aaa8bd1e` |
| `matrix-inequalities-and-norms/MI-07/lean/Challenge.lean` | `62fee2804dc12a4ad7edecfa8c1dda2dc39acc2d94475d29805e8e55c3288a59` |
| `matrix-inequalities-and-norms/MI-07/lean/NLA/MI07/Definitions.lean` | `369e99eaf3df8a8bbfb214973129ab71fbc95445ba9d176e91d52bca3bc46bc5` |
| `matrix-inequalities-and-norms/MI-07/lean/comparator.json` | `2e9d5b3a4b0e29f0208a75b42e22fe28f2743a2e9c908d9fc1c451161e0b60b7` |
| `matrix-inequalities-and-norms/MI-07/lean/formalization.yaml` | `a83751a905c3f603631a4d2f880fb0679a2092d6b72eadc5c565b7291c7fa28e` |
| `docs/lean/REVIEW.md` | `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553` |
| `matrix-inequalities-and-norms/MI-07/solution.tex` | `de4f6e94c47123d16e28c19cd9bb18010189d66ab0b02c1aad99bf7ca62aaa46` |
| `matrix-inequalities-and-norms/MI-07/solution.md` | `af29a8929d438aa50b2497ab5fc315286710ba5e8474e4a1d407612ab2dd2cb5` |
| `references/colbrook-matrix-2026-09-11/original-proofs/MI-07.tex` | `0a5351a8ee77d87faa491093ca801c0797227b7e70c3945d7368e16d9d733d2e` |

Imported semantic definitions inspected (complete file hashes recorded in machine evidence): `Analysis/Matrix/Order.lean`, `LinearAlgebra/Matrix/PosDef.lean`, `LinearAlgebra/UnitaryGroup.lean`, `Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Abs.lean`, `Analysis/SpecialFunctions/ContinuousFunctionalCalculus/Rpow/Basic.lean`, `Topology/Defs/Filter.lean`, `Analysis/CStarAlgebra/Matrix.lean`.
