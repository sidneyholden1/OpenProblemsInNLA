/- Independently authored final consumer: OpenAI Codex /root, MF-22 nonauthor.
This imports the completed implementation, never the Challenge placeholders. -/
import Solution
set_option autoImplicit false
open scoped Matrix.Norms.L2Operator
open NLA.MF22

example : ∀ ρ : ℝ, 0 < ρ → ∃ D : ℝ, 0 < D ∧
    ∀ n : ℕ, 1 ≤ n → ‖H ρ n‖ ≤ D := uniform_norm_bound

example : ∀ ρ : ℝ, 0 < ρ → ∃ C : ℝ, 0 < C ∧
    ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      (H ρ n).det ≠ 0 ∧ ∀ i j : Fin n × Fin 2, ‖(H ρ n)⁻¹ i j‖ ≤ C :=
  eventual_inverse_entry_bound

example : ∀ ρ : ℝ, 0 < ρ → ∃ K : ℝ, 0 < K ∧
    ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      (H ρ n).det ≠ 0 ∧ ‖H ρ n‖ * ‖(H ρ n)⁻¹‖ ≤ K * (n : ℝ) :=
  linear_condition_bound

example : ∀ ρ : ℝ, 0 < ρ → ∃ K α : ℝ, 0 < K ∧ 0 ≤ α ∧
    ∃ N : ℕ, 1 ≤ N ∧ ∀ n : ℕ, N ≤ n →
      (if (H ρ n).det = 0 then (⊤ : ENNReal)
        else ENNReal.ofReal (‖H ρ n‖ * ‖(H ρ n)⁻¹‖)) ≤
          ENNReal.ofReal (K * (n : ℝ) ^ α) := original_target

example (ρ : ℝ) (n : ℕ) : ‖H ρ n‖ =
    ‖Matrix.toEuclideanCLM (n := Fin n × Fin 2) (𝕜 := ℂ) (H ρ n)‖ := rfl
example (ρ : ℝ) (n : ℕ) : ‖(H ρ n)⁻¹‖ =
    ‖Matrix.toEuclideanCLM (n := Fin n × Fin 2) (𝕜 := ℂ) ((H ρ n)⁻¹)‖ := rfl
example (n : ℕ) : Fintype.card (Ix n) = 2*n := by simp [Ix, Nat.mul_comm]

#print axioms uniform_norm_bound
#print axioms eventual_inverse_entry_bound
#print axioms linear_condition_bound
#print axioms original_target
#assert_trust kernel uniform_norm_bound
#assert_trust kernel eventual_inverse_entry_bound
#assert_trust kernel linear_condition_bound
#assert_trust kernel original_target
