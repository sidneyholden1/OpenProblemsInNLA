/- Exact expanding projector and bounded remainder for the actual MF-22 transfer.
The visibility proof uses the finite adjugate at the reciprocal expanding root.
Formalization: Sidney Holden with Codex. Apache-2.0. -/
import NLA.MF22.Decomposition
import NLA.MF22.Roots
import NLA.MF22.Coprime
set_option autoImplicit false
set_option leancert.trust "kernel"
noncomputable section
namespace NLA.MF22

lemma spectral_decomposition_of_identities (r : ℝ) (hr : 0<r) (T : FourMat)
    (hchar : ∀ t : ℂ, T.charpoly.eval t=quartic r t/coefA r)
    (hadj : ∀ z : ℂ, (1-z • T).adjugate 0 0=numerator r z/coefA r) :
    ∃ lam : ℂ, ∃ P : FourMat, ∃ R : ℕ → FourMat, ∃ C : ℝ,
      1<‖lam‖ ∧ P 0 0 ≠ 0 ∧
      (∀ i j, P i 0*P 0 j=P 0 0*P i j) ∧
      (∀ k, T^k=lam^k • P+R k) ∧ 0<C ∧ ∀ k i j, ‖R k i j‖ ≤ C := by
  obtain ⟨ev,hinj,hroots,hexp,hstable⟩ := roots_classified r hr
  have heigen : ∀ i, T.charpoly.IsRoot (ev i) := by
    intro i
    rw [Polynomial.IsRoot,hchar,(hroots i).2,zero_div]
  obtain ⟨b,hb⟩ := eigenbasis_exists T ev hinj heigen
  obtain ⟨R,C,hC,hpow,hbound⟩ := basis_bounded_remainder T ev b hb hstable
  have hden : denominator r (ev 0)⁻¹=0 := by
    have hh := quartic_reciprocal r (ev 0) (hroots 0).1
    rw [(hroots 0).2] at hh
    exact (mul_eq_zero.mp hh).resolve_left (pow_ne_zero _ (hroots 0).1)
  have hnum := numerator_ne_zero_of_denominator_eq_zero r hr _ hden
  have hvis : basisProjector b 0 0 0 ≠ 0 := by
    intro hz
    have hh := basis_adjugate_at_root T ev b hb (hroots 0).1 0 0
    rw [hz,mul_zero,hadj] at hh
    exact (div_ne_zero hnum (coefA_ne_zero r hr)) hh
  exact ⟨ev 0,basisProjector b 0,R,C,hexp,hvis,
    basis_projector_rank_one b 0,hpow,hC,hbound⟩
#assert_trust kernel spectral_decomposition_of_identities
end NLA.MF22
