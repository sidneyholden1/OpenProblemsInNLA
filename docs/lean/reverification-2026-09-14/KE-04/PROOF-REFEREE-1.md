# KE-04 independent proof reverification — referee 1

**Verdict: PASS for mathematical correctness, complete frozen scope and local proof closure. No blocking finding. Fresh Linux Comparator acceptance is a separate operational gate, not claimed here.**

Reviewer: independent OpenAI Codex AI agent `/root/iv06_statement_referee_1`, not the author or implementer of these upstream proofs. Date: 2026-09-14. Applied the correctness, scope, API/reuse, efficiency and attribution angles of `docs/lean/REVIEW.md`'s Tau Ceti adaptation. This is AI review, not official Tau Ceti or human peer review.

The two statement approvals were frozen in `statement-gate.json` before this campaign's proof inspection. I read the complete 11-module ACTIVE Solution import closure, all 24 frozen Challenge contracts and their implementations, together with the previously reviewed complete canonical/informal source. Historical evidence copies were not mistaken for active dependencies. I independently checked every active source byte against upstream `deb549fa9ddd6b119e6c59016f268237e645dfa2` and the gate; all match. The current candidate is `367acf8ecb423c609d501ccfea910de91ed4c82e`. No existing source, metadata, historical evidence, attribution, problem ID or canonical target was edited.

## Mathematical audit and scope

All 24 contracts and the full positive block-Lanczos target are implemented, with arbitrary real symmetric matrix, positive block size, full starting block, every permitted earlier/later iteration, all valid interval indices and every orthonormal compression basis. The proof retains strict open interval occupancy, repeated eigenvalues, equal endpoint cases and exact stopping semantics; it adds no spectral gap premise.

Krylov identifies the actual column span with the range of the finite linear combination map, proves nesting and multiplication shifts, and equates full dimension with column independence. Prefix full rank is inherited by an injective index embedding. Finite-dimensional bounds and Nat.findGreatest provide a genuine last full iteration. Frames constructs actual orthonormal bases from Mathlib, derives Q-transpose-Q identities, the true QQ-transpose projection and Q-transpose-A-Q compression. Spectral reverses Mathlib's internal antitone eigenvalue order using Fin.rev, proving that the public orderedSpectrum is nondecreasing and identifies the actual characteristic-polynomial roots including multiplicity. SpectralWindow proves invariance under changes of frame by orthogonal conjugation, and spans p+1 actual eigenvectors in the stated window; repeated eigenvalues do not collapse their independent basis vectors.

Intersection uses the actual submodule dimension formula to find a nonzero vector in the window and the preceding Krylov space. The quadratic polynomial is identified by Polynomial.aeval and genuine matrix multiplication. Absence of a later eigenvalue in the open interval makes this quadratic PSD in the later compression; on the earlier spectral window it is nonpositive. Importantly, Transport proves equality of quadratic FORMS for the earlier compression where x and Ax lie in the frame, and separately proves the stronger ACTION equality later, where x, Ax and A-squared-x are in the larger space. There is no false assumption that the earlier compressed square equals the compression of A-squared.

The PSD zero-form/kernel bridge uses Mathlib's actual PosSemidef.dotProduct_mulVec_zero_iff, which covers singular PSD matrices. Nonannihilation is derived from full block independence: coefficient extension and shift plus reverse induction exclude a nonzero eigenvector in the preceding Krylov space; applying that argument twice excludes the quadratic annihilator, including equal roots. Completion combines these ingredients, with all index and prefix conditions discharged, to force strict occupancy and then the exact canonical statement. This is an economical exact alternative to expanding full matrix polynomials.

LeanCert is genuinely used for kernel trust audits of all exports; there are no interval computations or unsupported numerical-sign claims. This algebraic proof has no numerical interval obligation. Mathlib spectral, dimension, orthonormal-basis and polynomial APIs are reused with their actual semantics. Colbrook's original argument and Stepaniants's existing formalization credit are preserved. This audit does not claim extra convergence rates, nonsymmetric extensions, floating-point stability, or an algorithmic treatment of rank-deficient starting blocks outside the canonical assumptions.

## Fresh evidence, trust and limits

I inspected the coordinator's fresh macOS aarch64 Lean 4.33.1 `solution-local.json` and full `solution-local.log`, checked the recorded SHA-256 against the actual log, observed exit 0 and successful Solution completion. This was a coordinator build, not a build independently run by this referee. Historical PASS reports were not substituted. Active source scanning and manual reading found no `sorry`, `admit`, custom `axiom`, `native_decide`, `unsafe` or `implemented_by` in executable code. Challenge's intentional placeholders are outside the active Solution import closure. All 24 exports have active `#assert_trust kernel` checks.

I also inspected referee 2's NEW independent export-consumer evidence, which checks the actual theorem types and prints every exported axiom closure; every closure contains only `propext`, `Classical.choice` and `Quot.sound` (universe annotations do not add axioms). This consumer was run by referee 2, not by me. My independent evidence script verified every configured export has an active declaration, a kernel audit, and a matching standard-only axiom line in that fresh consumer log. The exact caller statements and proof branches were read as mathematical code; later Linux Comparator must still verify full declaration identity in its own sandbox and default-kernel replay. No fresh Linux success, sandbox acceptance or publication approval is inferred from these local checks.

The review is bound to `referee-1-proof-evidence.json` SHA-256 `7cbcb70cba88b3114077acbe75f45f948a23142ce149d53590d127837896b687`. It records the full active dependency graph, exact source and boundary hashes, all 24 export names and individual axiom lists, direct external imports and hashes of inspected fresh evidence. The log/source byte checks were independently executed by this referee; they do not replace Lean checking. No additional proof build was repeated because the coordinator and second referee supplied fresh complementary execution evidence.

## Export coverage

Every name below was traced from the frozen contract through its active implementation and checked against the fresh consumer's permitted-axiom record:

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

## Exact active source hashes

- `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Completion.lean`: `4014011a7c6435c362ce4cf304aed8d7a8ad2e32ffb03448fbf43223c59a3f97`
- `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Definitions.lean`: `ae1baccc0cb622f83103eff8bb4a5efe4cd9a3bae4822ccca38da29554ae9ca4`
- `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Frames.lean`: `bfea6b02091db4e999c2c870b4b1f238cb546ad84df010c7d5431fe82904db0b`
- `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Intersection.lean`: `85acdc5925c94da8c48f5840bfce5055b6660ed11529a5554953f8acd598cb95`
- `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Krylov.lean`: `4912fc18fe64afafdb77a3dd19647ad623b05ee87d63ce56c4fbdad933d99ef3`
- `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Nonannihilation.lean`: `fec6e511329419a04ba4de0bd5c69b1366e851b3ade713a78ab90cd058a866e2`
- `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Proof.lean`: `f3920f297fdd8de840e88cad46322ce69ddcfd106b6dec51dd92fc386ccc76da`
- `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Spectral.lean`: `64e8255697387e32e65cf591a0cb7dbf7986f471c82b4f1715c9a88a7650e20e`
- `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/SpectralWindow.lean`: `c59a80ed6a6dff4e879fb6b8ca602a1d0946ef29b61ff400ffba0122bc86760f`
- `eigenvalues-and-inverse-problems/KE-04/lean/NLA/KE04/Transport.lean`: `f8bbd7a8095c333efe899bc71aae896dd6731002f89cefa2296f09aba7ecddbb`
- `eigenvalues-and-inverse-problems/KE-04/lean/Solution.lean`: `4bd85171d2284ab4ef1bcb914d1eae2763d3e5f6a279b120aec2709b0628bf13`

## Fresh evidence hashes

- `statement-gate.json`: `ac755e46dbae48485f5c1054fc68c94bdbb74a52fa02f2af3ea2826f8f4f8ffe`
- `solution-local.json`: `0fe5972d8c306ecf66fd6d770b542e92f05219e2cc20d1788ff9f36734aed72d`
- `solution-local.log`: `d1deefd9f0cc0e377cd610774665d2f1ad40a2fda67c31c3ced24736d8c3ea97`
- `referee-2-export-audit.lean`: `1c929258a4d06057dff9fc0c997a719ad10aad2be633827af9c884afc46b18b7`
- `referee-2-export-audit.log`: `781f243029df29e4f4139277812606269fccf823f22f5da500490e4eb97f040f`
