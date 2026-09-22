/- Uniform Green entries for the actual MF-22 transfer, with all hypotheses derived.
Formalization: Sidney Holden with Codex. Apache-2.0. -/
import NLA.MF22.ActualSpectral
import NLA.MF22.GreenBounds
set_option autoImplicit false
set_option leancert.trust "kernel"
namespace NLA.MF22
 theorem transfer_green_bounded (r : ℝ) (hr : 0<r) :
    ∃ C : ℝ, 0<C ∧ ∃ N : ℕ, 1≤N ∧ ∀ n, N≤n →
      ((transfer r)^n) 0 0 ≠ 0 ∧ ∀ j, j≤n → ∀ l, l<n → ∀ i s,
        ‖greenEntry (transfer r) n j l i s‖≤C := by
  obtain ⟨lam,P,R,B,hL,hGamma,hRank,hPower,hB,hR⟩ := transfer_spectral_decomposition r hr
  exact green_bounded_of_decomposition (transfer r) lam P R B hL hGamma hRank hPower hB hR
#assert_trust kernel transfer_green_bounded
#print axioms transfer_green_bounded
end NLA.MF22
