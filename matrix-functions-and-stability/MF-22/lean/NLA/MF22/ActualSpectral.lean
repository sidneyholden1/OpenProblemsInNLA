/- Actual transfer spectral data, all algebraic hypotheses discharged.
Formalization: Sidney Holden with Codex. Apache-2.0. -/
import NLA.MF22.Spectral
import NLA.MF22.Transfer
set_option autoImplicit false
set_option leancert.trust "kernel"
namespace NLA.MF22
 theorem transfer_spectral_decomposition (r : ℝ) (hr : 0<r) :
    ∃ lam : ℂ, ∃ P : FourMat, ∃ R : ℕ → FourMat, ∃ C : ℝ,
      1<‖lam‖ ∧ P 0 0 ≠ 0 ∧
      (∀ i j, P i 0*P 0 j=P 0 0*P i j) ∧
      (∀ k, (transfer r)^k=lam^k • P+R k) ∧ 0<C ∧ ∀ k i j, ‖R k i j‖ ≤ C :=
  spectral_decomposition_of_identities r hr (transfer r)
    (transfer_charpoly_eval r hr) (transfer_resolvent_adjugate r hr)
#assert_trust kernel transfer_spectral_decomposition
end NLA.MF22
