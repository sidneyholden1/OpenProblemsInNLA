/- Exact arrow Schur complement for the MI-04 formal-proof adaptation. -/
import NLA.MI04.PositiveLimit
import Mathlib.LinearAlgebra.Matrix.SchurComplement
set_option autoImplicit false
set_option maxHeartbeats 800000
set_option maxRecDepth 2000
open scoped ComplexOrder MatrixOrder Matrix.Norms.L2Operator BigOperators
open Matrix Complex
noncomputable section
namespace NLA.MI04
variable {n : ℕ}

def rowWeight (X : Mat n) (i : Fin n) (e : Fin n → ℝ) : ℝ :=
  ∑ j, ‖X i j‖^2 / e j

def arrowTop (i : Fin n) (e : Fin n → ℝ) : Mat n :=
  diagonal (fun j => if j=i then 1 else ((2-e j : ℝ) : ℂ))
def arrowBottom (i : Fin n) (e : Fin n → ℝ) (t : ℝ) : Mat n :=
  diagonal (fun j => if j=i then ((2-t^2 : ℝ) : ℂ) else (e j : ℂ))
def arrowCross (X : Mat n) (i : Fin n) (s t : ℝ) : Mat n :=
  fun j k => (if j=i then (s : ℂ) else ((t*s : ℝ) : ℂ))*X j k

def arrowMatrix (X : Mat n) (i : Fin n) (e : Fin n → ℝ) (s t : ℝ) :
    Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℂ :=
  fromBlocks (arrowTop i e) (arrowCross X i s t) (arrowCross X i s t)ᴴ
    (arrowBottom i e t)

lemma arrowBottom_zero (i : Fin n) (e : Fin n → ℝ) (hi : e i=2) :
    arrowBottom i e 0 = diagonal (fun j => (e j : ℂ)) := by
  unfold arrowBottom
  congr 1; funext j
  by_cases h : j=i <;> simp [h,hi]

lemma arrow_schur (X : Mat n) (i : Fin n) (e : Fin n → ℝ) (s : ℝ) (hi : e i=2) (he : ∀ j, e j ≠ 0) :
    arrowTop i e - arrowCross X i s 0 * (arrowBottom i e 0)⁻¹ *
      (arrowCross X i s 0)ᴴ =
    diagonal (fun j => if j=i then ((1-s^2*rowWeight X i e : ℝ) : ℂ)
      else ((2-e j : ℝ) : ℂ)) := by
  rw [arrowBottom_zero i e hi]
  have hinv : (diagonal (fun j => (e j : ℂ)))⁻¹ =
      diagonal (fun j => (e j : ℂ)⁻¹) := by
    apply Matrix.inv_eq_right_inv
    rw [diagonal_mul_diagonal, ← diagonal_one]
    congr 1; funext j
    exact mul_inv_cancel₀ (Complex.ofReal_ne_zero.mpr (he j))
  rw [hinv]
  ext j k
  by_cases hj : j=i <;> by_cases hk : k=i
  · subst j; subst k
    simp only [Matrix.sub_apply, arrowTop, diagonal_apply_eq, if_pos rfl]
    rw [Matrix.mul_apply]
    simp only [Matrix.mul_diagonal, arrowCross, if_pos rfl, conjTranspose_apply,
      ite_true, zero_mul, ofReal_zero, star_mul,
      Complex.star_def, Complex.conj_ofReal, ofReal_sub, ofReal_one, ofReal_mul,
      ofReal_pow, rowWeight, ofReal_sum, ofReal_div]
    congr 1
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro a _
    have hx : X i a * star (X i a) = (‖X i a‖^2 : ℝ) := by
      simpa only [Complex.normSq_eq_norm_sq, Complex.star_def] using Complex.mul_conj (X i a)
    calc
      (s:ℂ)*X i a*(e a:ℂ)⁻¹*(star (X i a)*(s:ℂ)) =
          (s:ℂ)^2*(X i a*star (X i a))/(e a:ℂ) := by ring
      _ = _ := by rw [hx]; push_cast; ring
  · simp [arrowTop,arrowCross,Matrix.sub_apply,mul_apply,mul_diagonal,conjTranspose_apply,hj,hk,Ne.symm hk]
  · simp [arrowTop,arrowCross,Matrix.sub_apply,mul_apply,mul_diagonal,conjTranspose_apply,hj,hk]
  · by_cases hjk : j=k <;>
      simp [arrowTop,arrowCross,Matrix.sub_apply,mul_apply,mul_diagonal,conjTranspose_apply,hj,hk,hjk]

lemma rowWeight_nonneg (X : Mat n) (i : Fin n) (e : Fin n → ℝ)
    (he : ∀ j, 0 < e j) : 0 ≤ rowWeight X i e := by
  exact Finset.sum_nonneg (fun j _ => div_nonneg (sq_nonneg _) (he j).le)

lemma arrowBottom_posDef (i : Fin n) (e : Fin n → ℝ) (hi : e i=2)
    (he : ∀ j, 0 < e j) : (arrowBottom i e 0).PosDef := by
  rw [arrowBottom_zero i e hi, Matrix.posDef_diagonal_iff]
  intro j; exact_mod_cast he j

lemma arrow_zero_bound (X : Mat n) (i : Fin n) (e : Fin n → ℝ) (s : ℝ)
    (hi : e i=2) (he : ∀ j, 0 < e j)
    (hQ : (arrowMatrix X i e s 0).PosSemidef) : s^2*rowWeight X i e ≤ 1 := by
  have hE := arrowBottom_posDef i e hi he
  letI := hE.isUnit.invertible
  have hS := (Matrix.PosDef.fromBlocks₂₂ (arrowTop i e) (arrowCross X i s 0) hE).mp hQ
  rw [arrow_schur X i e s hi (fun j => (he j).ne')] at hS
  have hd := hS.diag_nonneg (i := i)
  simp only [diagonal_apply_eq, ite_true] at hd
  have hd' : (0:ℝ) ≤ 1-s^2*rowWeight X i e := by exact_mod_cast hd
  linarith

lemma arrow_zero_posDef (X : Mat n) (i : Fin n) (e : Fin n → ℝ) (s : ℝ)
    (hi : e i=2) (he : ∀ j, 0 < e j) (he2 : ∀ j, j≠i → e j<2)
    (hs : s^2*rowWeight X i e < 1) : (arrowMatrix X i e s 0).PosDef := by
  have hE := arrowBottom_posDef i e hi he
  letI := hE.isUnit.invertible
  have hS : (arrowTop i e - arrowCross X i s 0 * (arrowBottom i e 0)⁻¹ *
      (arrowCross X i s 0)ᴴ).PosDef := by
    rw [arrow_schur X i e s hi (fun j => (he j).ne'), Matrix.posDef_diagonal_iff]
    intro j
    split_ifs with hj
    · exact_mod_cast sub_pos.mpr hs
    · exact_mod_cast sub_pos.mpr (he2 j hj)
  have hp : (arrowMatrix X i e s 0).PosSemidef :=
    (Matrix.PosDef.fromBlocks₂₂ _ _ hE).mpr hS.posSemidef
  apply hp.posDef_iff_det_ne_zero.mpr
  unfold arrowMatrix
  rw [Matrix.det_fromBlocks₂₂, Matrix.invOf_eq_nonsing_inv]
  exact mul_ne_zero (ne_of_gt hE.det_pos) (ne_of_gt hS.det_pos)

lemma arrow_hermitian (X : Mat n) (i : Fin n) (e : Fin n → ℝ) (s t : ℝ) :
    (arrowMatrix X i e s t).IsHermitian := by
  apply Matrix.IsHermitian.fromBlocks
  · rw [arrowTop, Matrix.isHermitian_diagonal_iff]
    intro j; split_ifs <;> simp [IsSelfAdjoint]
  · rfl
  · rw [arrowBottom, Matrix.isHermitian_diagonal_iff]
    intro j; split_ifs <;> simp [IsSelfAdjoint]

lemma arrow_continuous (X : Mat n) (i : Fin n) (e : Fin n → ℝ) (s : ℝ) :
    Continuous (arrowMatrix X i e s) := by
  apply continuous_matrix
  intro j k
  cases j <;> cases k <;>
    simp only [arrowMatrix, fromBlocks_apply₁₁, fromBlocks_apply₁₂,
      fromBlocks_apply₂₁, fromBlocks_apply₂₂, arrowTop, arrowBottom, arrowCross,
      diagonal_apply, conjTranspose_apply] <;> split_ifs <;> fun_prop

end NLA.MI04
