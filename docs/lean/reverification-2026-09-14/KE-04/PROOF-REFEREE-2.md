# KE-04 independent proof re-review 2

Date: 2026-09-14. Reviewer: OpenAI Codex AI agent `/root/iv06_statement_referee_2`, independent of the original implementation. Protocol: `docs/lean/REVIEW.md`; Tau Ceti correctness, full-target fidelity, nonvacuity, proof quality, reuse, clarity and credit criteria are adapted without official endorsement.

**Verdict: PASS — no mathematical or trust blocker found in this frozen active proof.** This approves the unchanged authored proof after this campaign's two fresh statement approvals. It does not create a new proof or by itself certify a new Linux run.

## Actual proof path and scope

Krylov proves actual range/coefficient formulas, monotonicity, one-power shift and full-prefix independence from finrank equality. Positive block width and a finite-dimensional bound establish the genuine largest full iteration. Frames constructs orthonormal frames from actual subspace bases, proves range equality and actual orthogonal projector and compression equations; it never assumes compatible bases at different iterations. Spectral reverses the genuine antitone eigenvalue family and matched eigenbasis, preserving the characteristic-root multiset. SpectralWindow counts p+1 DISTINCT BASIS INDICES even with repeated eigenvalues, constructs the nonpositive-form subspace and proves arbitrary-basis independence by orthogonal similarity and characteristic-polynomial equality.

Intersection uses the actual submodule dimension formula to obtain a nonzero vector in K_(k-1). Transport proves equality only of the earlier and later quadratic FORMS there; the later vector identity separately uses x, Ax and A-squared x in its subspace. The PSD zero-form/kernel equivalence is the genuine Mathlib result, including singular PSD matrices. Nonannihilation gives a particularly clear alternative to a highest-degree polynomial calculation: zero extension and shift of finite coefficient arrays, backward induction from the last coefficient, and full-rank injectivity exclude eigenvectors one degree earlier. Applying that argument to the two affine factors proves quadratic nonannihilation even when endpoints coincide. Completion combines these actual facts into strict occupancy and derives the maximal-s canonical theorem. The index contract explicitly rules out out-of-range eigenvalueAt fallback branches. All 24 public Proof declarations retain the Challenge signatures.

LeanCert's role is transitive kernel trust audits. There is no interval numerical certificate and no need to invent one for this exact finite-dimensional argument. I inspected the implementation of #assert_trust: kernel mode rejects custom, sorry and native-compiler axioms while allowing the standard three. Zero width and k=1 remain correctly vacuous only because no source interval index exists; existence contracts use the necessary positive-width premise. No finite-precision result is claimed. Colbrook's proof, Stepaniants's formalization and the disclosed helper contributors remain credited.

## Independent checks actually performed

I read every active local module reachable from Solution, including Definitions and the public export wrappers: 11 files and 1440 source lines. Historical duplicate snapshots and unused files were excluded from this active-closure count. Every active source hash was independently compared with both upstream `deb549fa9ddd6b119e6c59016f268237e645dfa2` and the frozen `statement-gate.json`; all matched. The reviewed canonical/source/numerical boundary remains bound by `STATEMENT-REFEREE-2.md`.

I manually followed every Challenge export through its public declaration to the active implementation and independently verified that comparator.json lists exactly these 24 names, has no definition exceptions and permits exactly propext, Classical.choice and Quot.sound. The fresh `referee-2-export-audit.lean` consumer imports Solution, queries every actual type and transitive axiom closure, and applies LeanCert #assert_trust kernel to every export. I executed it with pinned Lean 4.33.1 on macOS aarch64; exit code 0. All 24 axiom outputs contain exactly the standard three, with no custom axiom, sorryAx or native/compiler trust. The active source scan likewise found no proof holes, unsafe implementations, external implementations or Challenge import. The scan is supplementary, not a replacement for the actual transitive audits.

I also inspected the coordinator's fresh successful full Solution build receipt and log, and independently verified its recorded log hash `d1deefd9f0cc0e377cd610774665d2f1ad40a2fda67c31c3ced24736d8c3ea97`. That full build is the coordinator's run. My own run was the independent fresh export consumer/term inspection on its resulting local objects, not a second full source/dependency rebuild. For IS-03 and RA-08, the additional retained numerical-checker queries inspect the actual auxiliary Boolean certificate terms and also exit successfully. Relevant imported Mathlib facts and LeanCert trust/checker implementations were checked directly; pinned dependency axioms are covered transitively, rather than claiming a human-style read of all Mathlib.

Exact fresh evidence hashes and all per-export axiom results are in `referee-2-proof-checks.json`; the complete module roster is in `referee-2-active-inputs.json`. No authored Lean source, canonical target, configuration, publication metadata or historical evidence was altered. All inspection files live in this new external audit directory.

## Separate operational limits

The isolated Linux Comparator, full statement identity including definitions, default-kernel export replay, actual sandbox and rejection controls, artifact/source provenance and publication acceptance remain separate gates. This report does not substitute historical PASS text or a local consumer for those checks. It makes no human peer-review, Tau Ceti endorsement or novelty claim. Only the mathematical scope listed above is approved.

## Every reviewed export

- `NLA.KE04.real_matrix_semantics`
- `NLA.KE04.krylov_range_semantics`
- `NLA.KE04.krylov_nesting_and_shift`
- `NLA.KE04.fullBlockDimension_iff_independent`
- `NLA.KE04.fullBlockDimension_prefix`
- `NLA.KE04.lastFullBlockIteration_exists`
- `NLA.KE04.krylovBasis_exists`
- `NLA.KE04.frameProjection_semantics`
- `NLA.KE04.compression_semantics`
- `NLA.KE04.orderedSpectrum_semantics`
- `NLA.KE04.compression_basis_independent`
- `NLA.KE04.interval_index_validity`
- `NLA.KE04.quadratic_semantics`
- `NLA.KE04.spectral_gap_quadratic_psd`
- `NLA.KE04.spectral_window_subspace`
- `NLA.KE04.krylov_intersection_nonzero`
- `NLA.KE04.psd_zero_form_iff_kernel`
- `NLA.KE04.compressedQuadratic_semantics`
- `NLA.KE04.quadratic_forms_agree`
- `NLA.KE04.later_quadratic_identity`
- `NLA.KE04.fullRank_quadratic_nonannihilation`
- `NLA.KE04.strictIntervalOccupancy`
- `NLA.KE04.fullPrefix_implies_canonical`
- `NLA.KE04.blockLanczosConjecture`

## Exact active-source SHA-256 identities

| Repository-relative active file | SHA-256 |
| --- | --- |
| `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Completion.lean` | `4014011a7c6435c362ce4cf304aed8d7a8ad2e32ffb03448fbf43223c59a3f97` |
| `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Definitions.lean` | `ae1baccc0cb622f83103eff8bb4a5efe4cd9a3bae4822ccca38da29554ae9ca4` |
| `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Frames.lean` | `bfea6b02091db4e999c2c870b4b1f238cb546ad84df010c7d5431fe82904db0b` |
| `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Intersection.lean` | `85acdc5925c94da8c48f5840bfce5055b6660ed11529a5554953f8acd598cb95` |
| `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Krylov.lean` | `4912fc18fe64afafdb77a3dd19647ad623b05ee87d63ce56c4fbdad933d99ef3` |
| `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Nonannihilation.lean` | `fec6e511329419a04ba4de0bd5c69b1366e851b3ade713a78ab90cd058a866e2` |
| `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Proof.lean` | `f3920f297fdd8de840e88cad46322ce69ddcfd106b6dec51dd92fc386ccc76da` |
| `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Spectral.lean` | `64e8255697387e32e65cf591a0cb7dbf7986f471c82b4f1715c9a88a7650e20e` |
| `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/SpectralWindow.lean` | `c59a80ed6a6dff4e879fb6b8ca602a1d0946ef29b61ff400ffba0122bc86760f` |
| `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Transport.lean` | `f8bbd7a8095c333efe899bc71aae896dd6731002f89cefa2296f09aba7ecddbb` |
| `eigenvalues-and-inverse-problems/KE-04/lean/Solution.lean` | `4bd85171d2284ab4ef1bcb914d1eae2763d3e5f6a279b120aec2709b0628bf13` |
