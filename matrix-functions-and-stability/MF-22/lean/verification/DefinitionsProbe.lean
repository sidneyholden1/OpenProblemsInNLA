import NLA.MF22.Definitions
set_option autoImplicit false
open scoped Matrix.Norms.L2Operator
open NLA.MF22
example (ρ : ℝ) (n : ℕ) : ‖H ρ n‖ = ‖(Matrix.toEuclideanLin (H ρ n)).toContinuousLinearMap‖ := rfl
example (ρ : ℝ) (n : ℕ) (h : (H ρ n).det = 0) : conditionNumber ρ n = ⊤ := by simp [conditionNumber,h]
example (ρ : ℝ) (n : ℕ) (h : (H ρ n).det ≠ 0) : conditionNumber ρ n = ENNReal.ofReal (‖H ρ n‖ * ‖(H ρ n)⁻¹‖) := by simp [conditionNumber,h]
example (n : ℕ) : Fintype.card (Ix n) = 2*n := by simp [Ix,Nat.mul_comm]
