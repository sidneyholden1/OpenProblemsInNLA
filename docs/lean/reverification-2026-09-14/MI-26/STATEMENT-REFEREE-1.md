# MI-26 independent statement reverification — referee 1

**Verdict: PASS on the exact boundary below. No blocking fidelity or scope issue.**

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`; not the original implementer. Date: 2026-09-14. Applied the source-fidelity, correctness, scope, API/reuse, computation and attribution angles in `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is AI review, not official Tau Ceti or external human peer review. Per coordinator direction, this new report is outside the unchanged proof project.

Provenance: the deliberately preserved source base is `deb549fa9ddd6b119e6c59016f268237e645dfa2`, carried forward from the previous batch. It is NOT described as current upstream main: the coordinator observed upstream main at `ab754fabe3d48dc8d6eab6bcffce583e46d2b88f`. This is a fresh review of an already authored formalization, not a newly written proof. Historical statement-first prose and prior success claims are retained as dated source evidence. I read the complete canonical README, complete informal argument (including excluded extensions), numerical plan, Definitions and all 7 Challenge signatures. I did not inspect existing implementation proof bodies. All read repository bytes were independently checked against the preserved immutable base.

## Fidelity, scope and obligations

The seven contracts retain the exact real-valued concave function class, PSD COMPLEX inputs, arbitrary complex unitaries and full unconditional negation. AdmissibleFunction is ConcaveOn on the nonnegative half-line together with f(0)>=0. Its exported scalar equivalence covers every theta in [0,1]; convexity of the fixed half-line is not a new hypothesis on f. No monotonicity, global nonnegativity, endpoint continuity or positive-definite restriction is imposed. Representing a half-line function by an arbitrary real extension is harmless, and the explicit nonnegative-spectrum congruence theorem must prove this irrelevance for every PSD matrix.

functionalCalculus is actual cfc, not the polynomial by definition. The generic spectral-formula contract quantifies every real scalar function on a Hermitian matrix without continuity assumptions. This is legitimate: the actual spectrum is finite and Mathlib's HermitianFunctionalCalculus.cfc_eq has exactly this bare-function scope. Consequently possible concave endpoint discontinuity does not create a missing-domain hypothesis or exploit CFC's fallback. The polynomial bridge is separately required for every Hermitian complex matrix.

The complete source's projection example is preserved. My exact reconstruction verifies P and Q are PSD projections, (P+Q)-(P+Q)^2 equals the displayed image, and w*Fw=6/5 with nonzero w=(1,-2). f(2)=-2 explicitly records why this is not a counterexample for the narrower globally nonnegative function class. Witness admissibility, actual CFC values and strict positivity are all conclusions. The planned material LeanCert point sign feeds the all-unitary failure because both right-hand CFC matrices vanish. The optional positive-definite perturbation and the narrower nonnegative-valued function question are not claimed. Exact 2-by-2 algebra and existing finite-spectrum/polynomial APIs suffice.

## Evidence and remaining gates

The coordinator's NEW `challenge-local.json` and log have matching independently checked SHA-256, successful exit 0 and exactly 7 deliberate Challenge-placeholder warnings. Log SHA-256: `0966a1b2dfb0381838b79cc3d0cebe7f102cb0789ba8ea837569d667efa9ab42`. This was the coordinator's Lean 4.33.1 macOS aarch64 typecheck using pinned dependencies; I did not rerun it. It proves well-formed statements, not their mathematics. Prior archived builds or Linux success were not used as substitutes. The Comparator configuration names all 7 contracts, allows no definition replacement and permits only propext, Classical.choice and Quot.sound.

The exact diagnostic is supplementary and not a Lean proof. Its script/log are retained alongside this report; the log marks the RA-09 expansion as a manual symbolic check, not a numerical universal verification. The imported definitions were inspected directly in the pinned Mathlib source where relevant; exact hashes are in `referee-1-statement-evidence.json` (SHA-256 `c09d8f8134c00384d6b2b1546a8a16b46035e25c867f29036aecdcccee8d2e2b`). That evidence lists all source hashes, access method, configured exports and inspected fresh build evidence. A second independent boundary approval precedes proof inspection; fresh implementation/axiom audits and actual Linux Comparator/default-kernel replay remain separate gates. No proof acceptance or new Linux run is claimed here. Original George Stepaniants formalization credit and the source authors' credits remain unchanged. No source, metadata, historical report, ID or canonical target was edited.

## Exact reviewed repository hashes

- `docs/lean/REVIEW.md`: `d967ddce620d4e754e2f9c25548f30cb537f76f4ddcf8ecf2574945bcd332553`
- `matrix-inequalities-and-norms/MI-26/README.md`: `b0b24fc96ce9105d9e0428c886877ee412cf88f4ba10ea0c1e204f74540f9f8c`
- `matrix-inequalities-and-norms/MI-26/lean/NUMERICAL_TARGETS.md`: `ecc403bb0f57fc49f2e3be78c9012f7e606ca8035d92af83fa95bddfbe994257`
- `matrix-inequalities-and-norms/MI-26/lean/NLA/MI26/Definitions.lean`: `821cb1b2a29f7382a1f36bd6b506bc6b249b9da0b61837702658173814995f63`
- `matrix-inequalities-and-norms/MI-26/lean/Challenge.lean`: `85eafac2fc875ddacb35c37f832834cfe79e6b10730f2656185209592f608fe1`
- `matrix-inequalities-and-norms/MI-26/lean/comparator.json`: `011a5cf15cdf8019f9eed9ac42b9d99a172c114ff7bb36882277a7ba2a510f51`
- `matrix-inequalities-and-norms/MI-26/solution.tex`: `1a26f0d71bf6284d1b5a4c255d48f2318883ded008cd6f778481fe6a8de3bd02`
- `matrix-inequalities-and-norms/MI-26/solution.md`: `4600a93133cd9fdc1a90d34695e6ac6295eb2cffb44477f5ac81d58226996d87`
- `references/colbrook-matrix-2026-09-11/original-proofs/MI-26.tex`: `3ca2f7dc760b25d45f24706336acf1adf6af790864ea3fad7526c12046466ea0`
