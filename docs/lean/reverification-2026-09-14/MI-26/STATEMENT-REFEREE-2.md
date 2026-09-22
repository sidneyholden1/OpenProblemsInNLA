# MI-26 — independent statement referee 2

**PASS — approved for proof audit at the hashes below.** Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_2`, 2026-09-14. Covers fidelity/scope, nonvacuity, numerical obligations, relevant API reuse and attribution under `docs/lean/REVIEW.md`'s Tau Ceti adaptation, without claiming official endorsement or human peer review.

This is independent reverification of existing authored statements preserved at `deb549fa9ddd6b119e6c59016f268237e645dfa2`, not newly authored formalization or the current upstream main. The separately observed upstream main `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f` is not the source base. I read the full canonical page, complete informal proof, numerical plan, Definitions and Challenge before inspecting any implementation. Historic statement-stage wording and prior verification claims remain archival; neither supplies this approval. George Stepaniants retains formalization authorship; Colbrook retains mathematical credit except NR-03's complete counterexample by Sidney Holden. No source bytes were changed.

The function class is exactly real-valued concavity on the nonnegative half-line plus f(0)≥0. It does not add global nonnegativity, monotonicity or endpoint continuity; f(t)=t−t², with f(2)=−2, is therefore admissible. `admissibleFunction_iff` exports the full scalar convex-combination definition. Extending half-line functions arbitrarily below zero is harmless: the genuine CFC extension-independence theorem is an explicit obligation.

Actual Mathlib CFC on a Hermitian matrix agrees with its finite spectral formula for every scalar function, without requiring continuity on the whole half-line. This resolves the possible endpoint-discontinuity concern. The polynomial-CFC bridge applies to every Hermitian input, not a witness-specific redefinition. MatrixOrder is true PSD order; every arbitrary complex unitary is allowed. The original theorem's all-input quantifiers and the unconditional complete negation are preserved.

I independently checked both rational projection identities, the exact matrix image −(PQ+QP), and the complex quadratic value w*Fw=6/5 for w=(1,−2). Right-side CFC images vanish before any unitary choice, whereas the positive quadratic value excludes left≤0. The strict scalar must be supplied by a material kernel LeanCert certificate in the later proof. The stronger positive-definite perturbation in the complete source is excluded, and no claim refutes the narrower globally nonnegative concave class. Both exclusions are accurate without weakening the original PSD-input target.

The Comparator roster matches all 7 Challenge declarations exactly, with no definition exceptions and only the three standard permitted axioms. I independently matched every reviewed local source to its immutable Git blob (git-show supplied sparse references). The coordinator's fresh macOS `lake build Challenge` passed; I checked its complete short log, 7 deliberate placeholder warnings, exit zero and SHA256 `0966a1b2dfb0381838b79cc3d0cebe7f102cb0789ba8ea837569d667efa9ab42`. This was the coordinator's execution, not mine, and establishes statement elaboration only. Fresh proof review, all-export trust checks and actual Linux Comparator execution remain separate gates. No historical PASS is being substituted for those future gates.

`referee-2-statement-checks.json` records the exact supplemental computations, read methods, export names, fresh build receipt and inspected Mathlib definitions/ranges at the pinned revision. All read primary-source hashes are below; metadata was inspected for scope/attribution, without re-auditing its historical run claims.

| Source | SHA256 |
| --- | --- |
| `matrix-inequalities-and-norms/MI-26/README.md` | `b0b24fc96ce9105d9e0428c886877ee412cf88f4ba10ea0c1e204f74540f9f8c` |
| `matrix-inequalities-and-norms/MI-26/lean/NUMERICAL_TARGETS.md` | `ecc403bb0f57fc49f2e3be78c9012f7e606ca8035d92af83fa95bddfbe994257` |
| `matrix-inequalities-and-norms/MI-26/lean/Challenge.lean` | `85eafac2fc875ddacb35c37f832834cfe79e6b10730f2656185209592f608fe1` |
| `matrix-inequalities-and-norms/MI-26/lean/NLA/MI26/Definitions.lean` | `821cb1b2a29f7382a1f36bd6b506bc6b249b9da0b61837702658173814995f63` |
| `matrix-inequalities-and-norms/MI-26/lean/comparator.json` | `011a5cf15cdf8019f9eed9ac42b9d99a172c114ff7bb36882277a7ba2a510f51` |
| `matrix-inequalities-and-norms/MI-26/lean/formalization.yaml` | `c444e408b373ee6a61e95c617fd72b05f100fe513811f764a8655759027e1230` |
| `docs/lean/REVIEW.md` | `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553` |
| `matrix-inequalities-and-norms/MI-26/solution.tex` | `1a26f0d71bf6284d1b5a4c255d48f2318883ded008cd6f778481fe6a8de3bd02` |
| `matrix-inequalities-and-norms/MI-26/solution.md` | `4600a93133cd9fdc1a90d34695e6ac6295eb2cffb44477f5ac81d58226996d87` |
| `references/colbrook-matrix-2026-09-11/original-proofs/MI-26.tex` | `3ca2f7dc760b25d45f24706336acf1adf6af790864ea3fad7526c12046466ea0` |

Imported semantic definitions inspected (complete file hashes recorded in machine evidence): `Analysis/Matrix/Order.lean`, `LinearAlgebra/Matrix/PosDef.lean`, `LinearAlgebra/UnitaryGroup.lean`, `Analysis/Convex/Function.lean`, `Analysis/Matrix/HermitianFunctionalCalculus.lean`.
