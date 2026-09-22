/- Complete MF-22 contracts, proved from the actual finite Toeplitz matrix.
Source mathematics: George Stepaniants. Formalization: Sidney Holden with Codex. -/
import NLA.MF22.FinalBounds
set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped Matrix.Norms.L2Operator
namespace NLA.MF22

theorem uniform_norm_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ D : ℝ, 0 < D ∧ ∀ n : ℕ, 1 ≤ n → ‖H ρ n‖ ≤ D := by
  exact uniform_norm_bound_proved ρ hρ

theorem eventual_inverse_entry_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ C : ℝ, 0 < C ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      (H ρ n).det ≠ 0 ∧ ∀ i j : Ix n, ‖(H ρ n)⁻¹ i j‖ ≤ C := by
  exact eventual_inverse_entry_bound_proved ρ hρ

theorem linear_condition_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ K : ℝ, 0 < K ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      (H ρ n).det ≠ 0 ∧ ‖H ρ n‖ * ‖(H ρ n)⁻¹‖ ≤ K * (n : ℝ) := by
  exact linear_condition_bound_proved ρ hρ

theorem original_target (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ K α : ℝ, 0 < K ∧ 0 ≤ α ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      conditionNumber ρ n ≤ ENNReal.ofReal (K * (n : ℝ) ^ α) := by
  exact original_target_proved ρ hρ
#assert_trust kernel uniform_norm_bound
#print axioms uniform_norm_bound
#assert_trust kernel eventual_inverse_entry_bound
#print axioms eventual_inverse_entry_bound
#assert_trust kernel linear_condition_bound
#print axioms linear_condition_bound
#assert_trust kernel original_target
#print axioms original_target
end NLA.MF22
