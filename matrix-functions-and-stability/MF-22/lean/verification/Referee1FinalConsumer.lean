/- Four deliberately unproved complete MF-22 contracts. -/
import Solution
set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped Matrix.Norms.L2Operator
namespace Referee1
open NLA.MF22

theorem checked_uniform_norm_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ D : ℝ, 0 < D ∧ ∀ n : ℕ, 1 ≤ n → ‖H ρ n‖ ≤ D := by exact NLA.MF22.uniform_norm_bound ρ hρ

theorem checked_eventual_inverse_entry_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ C : ℝ, 0 < C ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      (H ρ n).det ≠ 0 ∧ ∀ i j : Ix n, ‖(H ρ n)⁻¹ i j‖ ≤ C := by exact NLA.MF22.eventual_inverse_entry_bound ρ hρ

theorem checked_linear_condition_bound (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ K : ℝ, 0 < K ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      (H ρ n).det ≠ 0 ∧ ‖H ρ n‖ * ‖(H ρ n)⁻¹‖ ≤ K * (n : ℝ) := by exact NLA.MF22.linear_condition_bound ρ hρ

theorem checked_original_target (ρ : ℝ) (hρ : 0 < ρ) :
    ∃ K α : ℝ, 0 < K ∧ 0 ≤ α ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      conditionNumber ρ n ≤ ENNReal.ofReal (K * (n : ℝ) ^ α) := by exact NLA.MF22.original_target ρ hρ
end Referee1

#assert_trust kernel Referee1.checked_uniform_norm_bound
#print axioms NLA.MF22.uniform_norm_bound
#check @NLA.MF22.uniform_norm_bound
#assert_trust kernel Referee1.checked_eventual_inverse_entry_bound
#print axioms NLA.MF22.eventual_inverse_entry_bound
#check @NLA.MF22.eventual_inverse_entry_bound
#assert_trust kernel Referee1.checked_linear_condition_bound
#print axioms NLA.MF22.linear_condition_bound
#check @NLA.MF22.linear_condition_bound
#assert_trust kernel Referee1.checked_original_target
#print axioms NLA.MF22.original_target
#check @NLA.MF22.original_target

open scoped Matrix.Norms.L2Operator
example (r : ℝ) (n : ℕ) : ‖NLA.MF22.H r n‖ =
  ‖Matrix.toEuclideanCLM (n := NLA.MF22.Ix n) (𝕜 := ℂ) (NLA.MF22.H r n)‖ := rfl
example (r : ℝ) (n : ℕ) : ‖(NLA.MF22.H r n)⁻¹‖ =
  ‖Matrix.toEuclideanCLM (n := NLA.MF22.Ix n) (𝕜 := ℂ) ((NLA.MF22.H r n)⁻¹)‖ := rfl
example (r : ℝ) (n : ℕ) (h : (NLA.MF22.H r n).det = 0) :
    NLA.MF22.conditionNumber r n = ⊤ := by simp [NLA.MF22.conditionNumber,h]
