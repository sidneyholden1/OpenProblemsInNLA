# SP-06 independent proof re-review 2

Date: 2026-09-14. Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of the original implementation. Protocol: `docs/lean/REVIEW.md`; Tau Ceti correctness, full-target fidelity, nonvacuity, proof quality, reuse, clarity and credit criteria are adapted without official endorsement.

**Verdict: PASS — no mathematical or trust blocker found in this frozen active proof.** This approves the unchanged authored proof after this campaign's two fresh statement approvals. It does not create a new proof or by itself certify a new Linux run.

## Actual proof path and scope

Numeric proves the complete seven-coefficient Laurent identity at every nonzero complex z, the actual band extremes and the real polynomial endpoint bounds. Its factored difference estimate proves a uniform lower slope over the whole fixed box; the root Lipschitz bound follows from that separation and the bound on the coefficient r-cubed/4. Curve uses the actual intermediate value theorem to produce a root, excludes endpoints, and proves uniqueness. The choice of one root at every circle point is made continuous by the global Lipschitz estimate in the inherited circle metric. Positive radii and unit-circle norms prove injectivity and avoidance of zero by cancellation, not a sampled polar plot. The inverse-on-circle/conjugation identity proves the auxiliary symbol's imaginary part formula, hence reality of the Laurent symbol everywhere on the curve. The genuine order-two Toeplitz section and charpoly-spectrum equivalence give an actual nonreal spectral point. Proof then negates the full universal implication. All twenty declarations are present with the reviewed types.

LeanCert is used for kernel trust audits of every export and transparent target definition; the scalar inequalities themselves are exact nlinarith/ring/field_simp proofs. No numerical interval certificate or interval covering is claimed. This proof reduces the analytic burden effectively: one scalar root equation, IVT and a global Lipschitz estimate suffice, avoiding an implicit-function theorem or subdivisions. Denominators require the explicitly proved positive radius or nonzero complex input. The curve's existence is unconditional, so no custom-data vacuity remains.

Scope is the complete canonical finite-section implication. A separate formal enclosure theorem and the limiting-spectrum question remain outside the exports. Original Colbrook mathematical credit and Stepaniants formalization credit are preserved.

## Independent checks actually performed

I read every active local module reachable from Solution, including Definitions and the public export wrappers: 5 files and 409 source lines. Historical duplicate snapshots and unused files were excluded from this active-closure count. Every active source hash was independently compared with both upstream `deb549fa9ddd6b119e6c59016f268237e645dfa2` and the frozen `statement-gate.json`; all matched. The reviewed canonical/source/numerical boundary remains bound by `STATEMENT-REFEREE-2.md`.

I manually followed every Challenge export through its public declaration to the active implementation and independently verified that comparator.json lists exactly these 20 names, has no definition exceptions and permits exactly propext, Classical.choice and Quot.sound. The fresh `referee-2-export-audit.lean` consumer imports Solution, queries every actual type and transitive axiom closure, and applies LeanCert #assert_trust kernel to every export. I executed it with pinned Lean 4.33.1 on macOS aarch64; exit code 0. All 20 axiom outputs contain exactly the standard three, with no custom axiom, sorryAx or native/compiler trust. The active source scan likewise found no proof holes, unsafe implementations, external implementations or Challenge import. The scan is supplementary, not a replacement for the actual transitive audits.

I also inspected the coordinator's fresh successful full Solution build receipt and log, and independently verified its recorded log hash `397c5dea2d0a1b699e6478b2539e90ce992b9a6368d1bff7c05c8abde660443d`. That full build is the coordinator's run. My own run was the independent fresh export consumer/term inspection on its resulting local objects, not a second full source/dependency rebuild. For IS-03 and RA-08, the additional retained numerical-checker queries inspect the actual auxiliary Boolean certificate terms and also exit successfully. Relevant imported Mathlib facts and LeanCert trust/checker implementations were checked directly; pinned dependency axioms are covered transitively, rather than claiming a human-style read of all Mathlib.

Exact fresh evidence hashes and all per-export axiom results are in `referee-2-proof-checks.json`; the complete module roster is in `referee-2-active-inputs.json`. No authored Lean source, canonical target, configuration, publication metadata or historical evidence was altered. All inspection files live in this new external audit directory.

## Separate operational limits

The isolated Linux Comparator, full statement identity including definitions, default-kernel export replay, actual sandbox and rejection controls, artifact/source provenance and publication acceptance remain separate gates. This report does not substitute historical PASS text or a local consumer for those checks. It makes no human peer-review, Tau Ceti endorsement or novelty claim. Only the mathematical scope listed above is approved.

## Every reviewed export

- `NLA.SP06.witness_admissible`
- `NLA.SP06.witness_composition`
- `NLA.SP06.radial_lower_endpoint`
- `NLA.SP06.radial_upper_endpoint`
- `NLA.SP06.radial_uniform_slope`
- `NLA.SP06.radial_root_exists_unique`
- `NLA.SP06.radial_roots_lipschitz`
- `NLA.SP06.continuous_radius_exists`
- `NLA.SP06.radial_curve_continuous`
- `NLA.SP06.radial_curve_injective`
- `NLA.SP06.radial_curve_nonzero`
- `NLA.SP06.auxiliary_radial_im`
- `NLA.SP06.radial_curve_symbol_real`
- `NLA.SP06.witness_real_jordan_curve`
- `NLA.SP06.witness_toeplitz_two`
- `NLA.SP06.witness_eigenvalue_mem`
- `NLA.SP06.witness_eigenvalue_im`
- `NLA.SP06.witness_nonreal_finite_spectrum`
- `NLA.SP06.witness_counterexample`
- `NLA.SP06.not_targetImplication`

## Exact active-source SHA-256 identities

| Repository-relative active file | SHA-256 |
| --- | --- |
| `eigenvalues-and-inverse-problems/SP-06/lean/NLA/SP06/Curve.lean` | `151ff3586667091b16eab3acf03aed32fa5c7db8422a4077095bf914c4392677` |
| `eigenvalues-and-inverse-problems/SP-06/lean/NLA/SP06/Definitions.lean` | `5f3e071b9aabbbda27a794f9396022e54585f5d2d254827e50ea90baf80e72b1` |
| `eigenvalues-and-inverse-problems/SP-06/lean/NLA/SP06/Numeric.lean` | `16052a754e8680c587163e1a57d150094ae96a36464a56cc499ec09e9aa5b111` |
| `eigenvalues-and-inverse-problems/SP-06/lean/NLA/SP06/Proof.lean` | `d22146a65804efd8ff5c7f7b81ddcd55af8dc1bab7a2518f4961d7699abc9b48` |
| `eigenvalues-and-inverse-problems/SP-06/lean/Solution.lean` | `4aa92168bf3dccc0a03180795c60b404a7e6b531b188eb4ab1d93cf109c3eb42` |
