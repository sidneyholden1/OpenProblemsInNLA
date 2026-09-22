/- Spectral condition number and the exact original eventual polynomial target.
Source mathematics: George Stepaniants. Formalization: Sidney Holden with Codex. -/
import NLA.MF22.InverseConstruction
import NLA.MF22.UniformNorm
set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped Matrix.Norms.L2Operator
namespace NLA.MF22

theorem linear_condition_bound_proved (r : ℝ) (hr : 0<r) :
    ∃ K : ℝ, 0<K ∧ ∃ N : ℕ, 1≤N ∧ ∀ n : ℕ, N≤n →
      (H r n).det ≠ 0 ∧ ‖H r n‖*‖(H r n)⁻¹‖ ≤ K*(n:ℝ) := by
  obtain ⟨D,hD,hforward⟩ := uniform_norm_bound_proved r hr
  obtain ⟨C,hC,N,hN,hinverse⟩ := eventual_inverse_entry_bound_proved r hr
  refine ⟨2*D*C,by positivity,N,hN,?_⟩
  intro n hn
  obtain ⟨hdet,hentries⟩ := hinverse n hn
  refine ⟨hdet,?_⟩
  have hi := spectral_norm_le_card_entry ((H r n)⁻¹) C hC.le hentries
  have hi' : ‖(H r n)⁻¹‖ ≤ (2*(n:ℝ))*C := by
    simpa [Ix,Fintype.card_prod,Fintype.card_fin,mul_comm] using hi
  calc
    ‖H r n‖*‖(H r n)⁻¹‖ ≤ D*((2*(n:ℝ))*C) :=
      mul_le_mul (hforward n (hN.trans hn)) hi' (norm_nonneg _) hD.le
    _ = (2*D*C)*(n:ℝ) := by ring

theorem original_target_proved (r : ℝ) (hr : 0<r) :
    ∃ K α : ℝ, 0<K ∧ 0≤α ∧ ∃ N : ℕ, 1≤N ∧ ∀ n : ℕ, N≤n →
      conditionNumber r n ≤ ENNReal.ofReal (K*(n:ℝ)^α) := by
  obtain ⟨K,hK,N,hN,hbound⟩ := linear_condition_bound_proved r hr
  refine ⟨K,1,hK,by norm_num,N,hN,?_⟩
  intro n hn
  obtain ⟨hd,hb⟩ := hbound n hn
  simp only [conditionNumber,if_neg hd,Real.rpow_one]
  exact ENNReal.ofReal_le_ofReal hb

#assert_trust kernel linear_condition_bound_proved
#assert_trust kernel original_target_proved
end NLA.MF22
