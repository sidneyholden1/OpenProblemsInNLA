import NLA.MF22.Definitions
import Mathlib.Tactic
set_option autoImplicit false
open scoped Matrix.Norms.L2Operator
open NLA.MF22
example (ρ : ℝ) (n : ℕ) : ‖H ρ n‖ = ‖Matrix.toEuclideanCLM (H ρ n)‖ := rfl
example (ρ : ℝ) (n : ℕ) : ‖(H ρ n)⁻¹‖ = ‖Matrix.toEuclideanCLM ((H ρ n)⁻¹)‖ := rfl
example (n : ℕ) : Fintype.card (Ix n)=2*n := by simp [Ix,Nat.mul_comm]
example (ρ : ℝ) (n : ℕ) (x : ℝ) (h : conditionNumber ρ n ≤ ENNReal.ofReal x) :
    (H ρ n).det ≠ 0 := by
  intro hd
  have ht : (⊤ : ENNReal) ≤ ENNReal.ofReal x := by simpa [conditionNumber,hd] using h
  exact ENNReal.ofReal_ne_top (top_le_iff.mp ht)
example (ρ : ℝ) (n : ℕ) (h : (H ρ n).det ≠ 0) :
    H ρ n * (H ρ n)⁻¹=1 := Matrix.mul_nonsing_inv _ (isUnit_iff_ne_zero.mpr h)
example (y : ℝ) : 480*(120*y^2-3337*y+34200)=(240*y-3337)^2+5280431 := by ring
example (y : ℝ) : 70*(134136+32436*y-10404*y^2)+867*(-103032-40632*y+840*y^2)=
    -79939224-32957424*y := by ring
example (ρ : ℝ) (h : ρ^2=10) : (400-1500*ρ^2 : ℝ)=-14600 := by rw [h]; norm_num
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (0,0) (1,0) = -(ρ:ℂ)-6*Complex.I := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (0,0) (1,1) = 0 := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (0,1) (1,0) = -7*(ρ:ℂ)-30*Complex.I := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (0,1) (1,1) = 0 := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (0,0) (0,0) = -24*(ρ:ℂ) := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (0,0) (0,1) = -7*(ρ:ℂ)-30*Complex.I := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (0,1) (0,0) = 96*Complex.I := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (0,1) (0,1) = -25*(ρ:ℂ)-30*Complex.I := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (1,0) (0,0) = 25*(ρ:ℂ)-30*Complex.I := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (1,0) (0,1) = 96*Complex.I := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (1,1) (0,0) = 7*(ρ:ℂ)-30*Complex.I := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (1,1) (0,1) = 24*(ρ:ℂ) := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (2,0) (0,0) = 0 := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (2,0) (0,1) = 7*(ρ:ℂ)-30*Complex.I := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (2,1) (0,0) = 0 := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (2,1) (0,1) = (ρ:ℂ)-6*Complex.I := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (3,0) (0,0) = 0 := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
example (ρ : ℝ) : (80:ℂ)*H ρ 4 (0,0) (2,0) = 0 := by
  norm_num [H,B,C,Matrix.smul_apply,Matrix.cons_val_zero,Matrix.cons_val_one]
  <;> ring
