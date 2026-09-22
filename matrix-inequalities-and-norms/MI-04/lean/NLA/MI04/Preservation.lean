/- MI-04: exact scalar and unitary transports. Source mathematics: Colbrook;
formal-proof adaptation: Sidney Holden with OpenAI Codex assistance. -/
import NLA.MI04.Definitions
import Mathlib.Analysis.Matrix.Order
import Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Order
import Mathlib.Analysis.CStarAlgebra.Unitary.Maps
import Mathlib.LinearAlgebra.Matrix.SchurComplement
import Mathlib.Tactic
set_option autoImplicit false
set_option maxHeartbeats 1000000
open scoped ComplexOrder MatrixOrder Matrix.Norms.L2Operator
open Matrix
noncomputable section
namespace NLA.MI04

lemma norm_unitary_conjugate {ι : Type*} [Fintype ι] [DecidableEq ι]
    (U : unitary (Matrix ι ι ℂ)) (A : Matrix ι ι ℂ) :
    ‖(star U : Matrix ι ι ℂ) * A * (U : Matrix ι ι ℂ)‖ = ‖A‖ := by
  rw [CStarRing.norm_mul_coe_unitary]
  simpa using CStarRing.norm_coe_unitary_mul (star U) A

lemma universal_smul {n : ℕ} {X : Mat n} (hX : UniversalBlockNorm X)
    (r : ℝ) (hr : 0 < r) : UniversalBlockNorm (r • X) := by
  intro A B hA hB hP
  have hscaled : (fromBlocks (r⁻¹ • A) X Xᴴ (r⁻¹ • B)).PosSemidef := by
    convert hP.smul (inv_nonneg.mpr hr.le) using 1 <;>
      simp [fromBlocks_smul, conjTranspose_smul, smul_smul, hr.ne']
  have h := hX (r⁻¹ • A) (r⁻¹ • B)
    (hA.smul (isSelfAdjoint_iff.mp rfl)) (hB.smul (isSelfAdjoint_iff.mp rfl)) hscaled
  have heq : fromBlocks (r⁻¹ • A) X Xᴴ (r⁻¹ • B) =
      r⁻¹ • fromBlocks A (r • X) (r • X)ᴴ B := by
    simp [fromBlocks_smul, conjTranspose_smul, smul_smul, hr.ne']
  rw [heq, ← smul_add, norm_smul, norm_smul, Real.norm_of_nonneg (inv_nonneg.mpr hr.le)] at h
  nlinarith [inv_pos.mpr hr]


def blockUnitary {n : ℕ} (U : unitary (Mat n)) :
    unitary (Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ) := by
  have hL : (U : Mat n)ᴴ * (U : Mat n) = 1 := U.property.1
  have hR : (U : Mat n) * (U : Mat n)ᴴ = 1 := U.property.2
  refine ⟨fromBlocks (U : Mat n) 0 0 (U : Mat n), ?_⟩
  change star _ * _ = 1 ∧ _ * star _ = 1
  constructor <;> simp only [star_eq_conjTranspose, fromBlocks_conjTranspose,
    conjTranspose_zero, fromBlocks_multiply, mul_zero, zero_mul, add_zero,
    zero_add, hL, hR, fromBlocks_one]

lemma conjugate_blocks {n : ℕ} (U A B C D : Mat n) :
    (fromBlocks U 0 0 U)ᴴ * fromBlocks A B C D * fromBlocks U 0 0 U =
      fromBlocks (Uᴴ * A * (U : Mat n)) (Uᴴ * B * (U : Mat n)) (Uᴴ * C * (U : Mat n)) (Uᴴ * D * (U : Mat n)) := by
  simp [fromBlocks_conjTranspose, fromBlocks_multiply]

lemma unitary_cancel {n : ℕ} (U : unitary (Mat n)) (A : Mat n) :
    (U : Mat n) * ((star U : Mat n) * A * (U : Mat n)) * (star U : Mat n) = A := by
  have hu : (U : Mat n) * (star U : Mat n) = 1 := U.property.2
  simp only [← mul_assoc, hu, one_mul]
  simp only [mul_assoc, hu, mul_one]

set_option backward.isDefEq.respectTransparency false in
lemma universal_unitary {n : ℕ} {X : Mat n} (hX : UniversalBlockNorm X)
    (U : unitary (Mat n)) : UniversalBlockNorm ((star U : Mat n) * X * (U : Mat n)) := by
  intro A B hA hB hP
  let A' := (U : Mat n) * A * (star U : Mat n)
  let B' := (U : Mat n) * B * (star U : Mat n)
  have hA' : A'.IsHermitian := by
    dsimp [A']; simpa [star_eq_conjTranspose] using Matrix.isHermitian_mul_mul_conjTranspose (U : Mat n) hA
  have hB' : B'.IsHermitian := by
    dsimp [B']; simpa [star_eq_conjTranspose] using Matrix.isHermitian_mul_mul_conjTranspose (U : Mat n) hB
  have hEq : (fromBlocks ((star U : Mat n)) 0 0 ((star U : Mat n)))ᴴ *
      fromBlocks A ((star U : Mat n) * X * (U : Mat n))
        (((star U : Mat n) * X * (U : Mat n))ᴴ) B *
      fromBlocks ((star U : Mat n)) 0 0 ((star U : Mat n)) = fromBlocks A' X Xᴴ B' := by
    rw [conjugate_blocks]
    simp only [← star_eq_conjTranspose, star_star, star_mul]
    have hu : (U : Mat n) * (star U : Mat n) = 1 := U.property.2
    simp only [← mul_assoc, hu, one_mul]
    simp only [mul_assoc, hu, mul_one]
    simp only [A', B', mul_assoc]
  have hP' := hP.conjTranspose_mul_mul_same (blockUnitary (star U) : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ)
  change ((fromBlocks (star U : Mat n) 0 0 (star U : Mat n))ᴴ *
    fromBlocks A ((star U : Mat n) * X * (U : Mat n))
      (((star U : Mat n) * X * (U : Mat n))ᴴ) B *
    fromBlocks (star U : Mat n) 0 0 (star U : Mat n)).PosSemidef at hP'
  rw [hEq] at hP'
  have h := hX A' B' hA' hB' hP'
  have hnorm : ‖fromBlocks A' X Xᴴ B'‖ =
      ‖fromBlocks A ((star U : Mat n) * X * (U : Mat n)) (((star U : Mat n) * X * (U : Mat n))ᴴ) B‖ := by
    rw [← hEq]
    exact norm_unitary_conjugate (blockUnitary (star U)) _
  have hsum : A' + B' = (U : Mat n) * (A+B) * (star U : Mat n) := by
    dsimp only [A', B']
    rw [mul_add, add_mul]
  rw [hnorm, hsum] at h
  have hnormsum : ‖(U : Mat n) * (A+B) * (star U : Mat n)‖ = ‖A+B‖ :=
    (CStarRing.norm_mul_coe_unitary ((U : Mat n) * (A+B)) (star U)).trans
      (CStarRing.norm_coe_unitary_mul U (A+B))
  rw [hnormsum] at h
  exact h

end NLA.MI04
