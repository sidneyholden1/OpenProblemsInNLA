/- Four deliberately unproved complete MF-22 contracts. -/
import Solution
set_option autoImplicit false
open scoped Matrix.Norms.L2Operator
open NLA.MF22
namespace MF22AuthorAudit

theorem uniform_norm_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ D : ℝ, 0 < D ∧ ∀ n : ℕ, 1 ≤ n → ‖H ρ n‖ ≤ D := by
  exact NLA.MF22.uniform_norm_bound ρ hρ

theorem eventual_inverse_entry_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ C : ℝ, 0 < C ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      (H ρ n).det ≠ 0 ∧ ∀ i j : Ix n, ‖(H ρ n)⁻¹ i j‖ ≤ C := by
  exact NLA.MF22.eventual_inverse_entry_bound ρ hρ

theorem linear_condition_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ K : ℝ, 0 < K ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      (H ρ n).det ≠ 0 ∧ ‖H ρ n‖ * ‖(H ρ n)⁻¹‖ ≤ K * (n : ℝ) := by
  exact NLA.MF22.linear_condition_bound ρ hρ

theorem original_target (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ K α : ℝ, 0 < K ∧ 0 ≤ α ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      conditionNumber ρ n ≤ ENNReal.ofReal (K * (n : ℝ) ^ α) := by
  exact NLA.MF22.original_target ρ hρ
end MF22AuthorAudit
#assert_trust kernel NLA.MF22.uniform_norm_bound
#print axioms NLA.MF22.uniform_norm_bound
#assert_trust kernel NLA.MF22.eventual_inverse_entry_bound
#print axioms NLA.MF22.eventual_inverse_entry_bound
#assert_trust kernel NLA.MF22.linear_condition_bound
#print axioms NLA.MF22.linear_condition_bound
#assert_trust kernel NLA.MF22.original_target
#print axioms NLA.MF22.original_target
