/- Four deliberately unproved complete MF-22 contracts. -/
import NLA.MF22.Definitions
set_option autoImplicit false
open scoped Matrix.Norms.L2Operator
namespace NLA.MF22

theorem uniform_norm_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ D : ℝ, 0 < D ∧ ∀ n : ℕ, 1 ≤ n → ‖H ρ n‖ ≤ D := by sorry

theorem eventual_inverse_entry_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ C : ℝ, 0 < C ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      (H ρ n).det ≠ 0 ∧ ∀ i j : Ix n, ‖(H ρ n)⁻¹ i j‖ ≤ C := by sorry

theorem linear_condition_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ K : ℝ, 0 < K ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      (H ρ n).det ≠ 0 ∧ ‖H ρ n‖ * ‖(H ρ n)⁻¹‖ ≤ K * (n : ℝ) := by sorry

theorem original_target (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ K α : ℝ, 0 < K ∧ 0 ≤ α ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      conditionNumber ρ n ≤ ENNReal.ofReal (K * (n : ℝ) ^ α) := by sorry
end NLA.MF22
