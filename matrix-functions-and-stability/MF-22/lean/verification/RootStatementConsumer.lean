import Challenge
set_option autoImplicit false
open scoped Matrix.Norms.L2Operator
open NLA.MF22
#check (uniform_norm_bound : ∀ ρ : ℝ, 0 < ρ → ∃ D : ℝ, 0 < D ∧ ∀ n : ℕ, 1 ≤ n → ‖H ρ n‖ ≤ D)
#check (eventual_inverse_entry_bound : ∀ ρ : ℝ, 0 < ρ → ∃ C : ℝ, 0 < C ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n → (H ρ n).det ≠ 0 ∧ ∀ i j : Ix n, ‖(H ρ n)⁻¹ i j‖ ≤ C)
#check (linear_condition_bound : ∀ ρ : ℝ, 0 < ρ → ∃ K : ℝ, 0 < K ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n → (H ρ n).det ≠ 0 ∧ ‖H ρ n‖ * ‖(H ρ n)⁻¹‖ ≤ K * (n : ℝ))
#check (original_target : ∀ ρ : ℝ, 0 < ρ → ∃ K α : ℝ, 0 < K ∧ 0 ≤ α ∧ ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n → conditionNumber ρ n ≤ ENNReal.ofReal (K * (n : ℝ) ^ α))
example (ρ : ℝ) (n : ℕ) : conditionNumber ρ n =
    if (H ρ n).det = 0 then ⊤ else ENNReal.ofReal
      (‖(Matrix.toEuclideanLin (H ρ n)).toContinuousLinearMap‖ *
       ‖(Matrix.toEuclideanLin ((H ρ n)⁻¹)).toContinuousLinearMap‖) := rfl
