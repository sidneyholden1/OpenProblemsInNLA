/- Exact source coordinates and actual Euclidean operator-norm bounds. -/
import NLA.MF12.Definitions
import Mathlib.Tactic
import Mathlib.LinearAlgebra.Matrix.StdBasis
import Mathlib.LinearAlgebra.Matrix.Kronecker
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option maxHeartbeats 3000000
open scoped BigOperators Matrix Matrix.Norms.L2Operator Kronecker
noncomputable section
namespace NLA.MF12

lemma abs_entry_le_norm {m n : Type*} [Fintype m] [Fintype n] [DecidableEq n]
    (A : Matrix m n ℝ) (i : m) (j : n) : |A i j| ≤ ‖A‖ := by
  let x : EuclideanSpace ℝ n := EuclideanSpace.single j 1
  have h := A.l2_opNorm_mulVec x
  have hi := PiLp.norm_apply_le (WithLp.toLp 2 (A.mulVec x)) i
  have hx : ‖x‖ = 1 := by simp [x]
  rw [hx,mul_one] at h
  have he : (A.mulVec x) i = A i j := by simp [x,Matrix.mulVec, dotProduct]
  simpa [he,Real.norm_eq_abs] using hi.trans h

/-- Fixed finite-dimensional constants avoid an unnecessary SVD/tensor-norm theorem. -/
def entryConstant {m n : Type*} [Fintype m] [Fintype n] [DecidableEq m] [DecidableEq n] : ℝ :=
  1 + ∑ i : m, ∑ j : n, ‖Matrix.single i j (1 : ℝ)‖

lemma entryConstant_pos {m n : Type*} [Fintype m] [Fintype n] [DecidableEq m] [DecidableEq n] :
    0 < entryConstant (m:=m) (n:=n) := by unfold entryConstant; positivity

lemma norm_le_entry_bound {m n : Type*} [Fintype m] [Fintype n] [DecidableEq m] [DecidableEq n]
    (A : Matrix m n ℝ) (b : ℝ) (hb : 0 ≤ b) (h : ∀ i j, |A i j| ≤ b) :
    ‖A‖ ≤ entryConstant (m:=m) (n:=n) * b := by
  have he : A = ∑ i : m, ∑ j : n, (A i j) • Matrix.single i j (1 : ℝ) := by
    simp only [Matrix.smul_single,smul_eq_mul,mul_one]
    exact Matrix.matrix_eq_sum_single A
  calc
    ‖A‖ = ‖∑ i : m, ∑ j : n, (A i j) • Matrix.single i j (1 : ℝ)‖ := congrArg norm he
    _ ≤ ∑ i : m, ∑ j : n, ‖(A i j) • Matrix.single i j (1 : ℝ)‖ :=
      (norm_sum_le _ _).trans (Finset.sum_le_sum fun i _ => norm_sum_le _ _)
    _ ≤ ∑ i : m, ∑ j : n, b * ‖Matrix.single i j (1 : ℝ)‖ := by
      gcongr with i hi j hj
      simpa only [norm_smul,Real.norm_eq_abs] using mul_le_mul_of_nonneg_right (h i j) (norm_nonneg _)
    _ ≤ entryConstant (m:=m) (n:=n) * b := by
      simp only [← Finset.mul_sum]
      unfold entryConstant
      nlinarith

def seedPower (μ : ℝ) (q : ℕ) : Mat 6 := !![
  1,0,0,0,0,0;
  0,(1/4:ℝ)^q,(q:ℝ)*(1/4:ℝ)^q,0,0,0;
  0,0,(1/4:ℝ)^q,0,0,0;
  0,0,0,μ^q,(q:ℝ)*μ^q,0;
  0,0,0,0,μ^q,0;
  0,0,0,0,0,1]

lemma seed_pow (μ : ℝ) (q : ℕ) : seed μ ^ q = seedPower μ q := by
  induction q with
  | zero => ext i j; fin_cases i <;> fin_cases j <;> norm_num [seedPower,Matrix.one_apply]
  | succ q ih =>
    rw [pow_succ,ih]
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [seedPower,seed,Matrix.mul_apply,Fin.sum_univ_succ,pow_succ,Nat.cast_add,Nat.cast_one] <;> ring

lemma UV_identity : compressU * embedV = 1 := by
  ext i j; fin_cases i <;> fin_cases j <;>
    norm_num [compressU,embedV,Matrix.mul_apply,Fin.sum_univ_succ,Matrix.one_apply]

lemma VU_reset : embedV * compressU = reset := by
  ext i j; fin_cases i <;> fin_cases j <;>
    norm_num [compressU,embedV,reset,Matrix.mul_apply,Fin.sum_univ_succ]

lemma compressed_powers_proved (μ : ℝ) (q : ℕ) :
    compressU * seed μ ^ q * embedV = !![1-(q:ℝ)*(1/4:ℝ)^q,(q:ℝ)*μ^q;0,1] := by
  rw [seed_pow]
  ext i j; fin_cases i <;> fin_cases j <;>
    simp [compressU,embedV,seedPower,Matrix.mul_apply,Fin.sum_univ_succ] <;> ring

lemma seed_ne_reset (μ : ℝ) : seed μ ≠ reset := by
  intro h
  have hh := congrFun (congrFun h (0:Fin 6)) (1:Fin 6)
  norm_num [seed,reset] at hh

#assert_trust kernel compressed_powers_proved
end NLA.MF12
