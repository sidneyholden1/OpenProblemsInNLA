/-
Copyright (c) 2026 Sidney Holden. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidney Holden, with OpenAI Codex assistance

Exact p=4 specialization of Matthew J. Colbrook's IE-23 proof.
The source attributes the matrix witness to Dokmanić–Gribonval's spectral-norm example.
-/
import NLA.IE23.Definitions
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Positivity
import LeanCert.Tactic.Verification

set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped BigOperators
noncomputable section
namespace NLA.IE23

lemma right_inverse_B : witnessA * witnessB = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [witnessA, witnessB, Matrix.mul_apply, Fin.sum_univ_succ]

lemma right_inverse_X : witnessA * witnessX = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [witnessA, witnessX, Matrix.mul_apply, Fin.sum_univ_succ]

lemma pseudoInverse_eq : pseudoInverse witnessA = witnessB := by
  let G : Matrix (Fin 2) (Fin 2) ℂ := !![2/3, -1/3; -1/3, 2/3]
  have hG : (witnessA * witnessA.conjTranspose) * G = 1 := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      norm_num [G, witnessA, Matrix.mul_apply, Matrix.conjTranspose_apply, Matrix.vecMul, dotProduct,
        Fin.sum_univ_succ]
  rw [pseudoInverse, Matrix.inv_eq_right_inv hG]
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [G, witnessA, witnessB, Matrix.mul_apply, Matrix.conjTranspose_apply,
      Fin.sum_univ_succ]

theorem witness_algebra_proved :
    FullRowRank witnessA ∧ pseudoInverse witnessA = witnessB ∧
    witnessA * witnessB = 1 ∧ witnessA * witnessX = 1 ∧ witnessX ≠ witnessB := by
  refine ⟨?_, pseudoInverse_eq, right_inverse_B, right_inverse_X, ?_⟩
  · intro v
    refine ⟨witnessX.mulVec v, ?_⟩
    rw [Matrix.mulVec_mulVec, right_inverse_X, Matrix.one_mulVec]
  · intro he
    have h := congrArg (fun M : Matrix (Fin 3) (Fin 2) ℂ => M 0 0) he
    norm_num [witnessX, witnessB] at h

lemma squared_norm_identity (v : Fin 2 → ℂ) :
    (∑ i, ‖witnessB.mulVec v i‖ ^ 2) + ‖v 0 + v 1‖ ^ 2 / 3 =
      ‖v 0‖ ^ 2 + ‖v 1‖ ^ 2 := by
  simp [witnessB, Matrix.mulVec, dotProduct, Fin.sum_univ_succ,
    Complex.sq_norm, Complex.normSq_apply]
  ring

lemma euclidean_X (v : Fin 2 → ℂ) :
    euclideanNorm (witnessX.mulVec v) = Real.sqrt (‖v 0‖ ^ 2 + ‖v 1‖ ^ 2) := by
  simp [euclideanNorm, witnessX, Matrix.mulVec, dotProduct, Fin.sum_univ_succ]

lemma euclidean_B_le_X (v : Fin 2 → ℂ) :
    euclideanNorm (witnessB.mulVec v) ≤ euclideanNorm (witnessX.mulVec v) := by
  rw [euclidean_X]
  apply Real.sqrt_le_sqrt
  have h := squared_norm_identity v
  nlinarith [sq_nonneg ‖v 0 + v 1‖]

lemma fourth_root_pow {x : ℝ} (hx : 0 ≤ x) :
    (x ^ (1 / 4 : ℝ)) ^ 4 = x := by
  simpa [one_div] using Real.rpow_inv_natCast_pow (n := 4) hx (by decide)

lemma pNorm_four (v : Fin 2 → ℂ) :
    pNorm 4 v = (‖v 0‖ ^ 4 + ‖v 1‖ ^ 4) ^ (1 / 4 : ℝ) := by
  norm_num [pNorm, Fin.sum_univ_succ, Real.rpow_natCast]

lemma quartic_sum_pos {v : Fin 2 → ℂ} (hv : v ≠ 0) :
    0 < ‖v 0‖ ^ 4 + ‖v 1‖ ^ 4 := by
  have h : ∃ i, v i ≠ 0 := by
    by_contra! h
    exact hv (funext h)
  obtain ⟨i, hi⟩ := h
  have hp := pow_pos (norm_pos_iff.mpr hi) 4
  fin_cases i <;> positivity

lemma pNorm_four_pos {v : Fin 2 → ℂ} (hv : v ≠ 0) : 0 < pNorm 4 v := by
  rw [pNorm_four]
  exact Real.rpow_pos_of_pos (quartic_sum_pos hv) _

lemma ratio_X_upper {v : Fin 2 → ℂ} (hv : v ≠ 0) :
    euclideanNorm (witnessX.mulVec v) / pNorm 4 v ≤ (2 : ℝ) ^ (1 / 4 : ℝ) := by
  have hd := pNorm_four_pos hv
  apply (div_le_iff₀ hd).mpr
  rw [euclidean_X]
  have hk : 0 ≤ (2 : ℝ) ^ (1 / 4 : ℝ) := Real.rpow_nonneg (by norm_num) _
  apply (pow_le_pow_iff_left₀ (Real.sqrt_nonneg _) (mul_nonneg hk hd.le)
    (n := 4) (by decide)).mp
  have hs : 0 ≤ ‖v 0‖ ^ 2 + ‖v 1‖ ^ 2 := by positivity
  have hsq := Real.sq_sqrt hs
  have hroot : pNorm 4 v ^ 4 = ‖v 0‖ ^ 4 + ‖v 1‖ ^ 4 := by
    rw [pNorm_four]
    exact fourth_root_pow (quartic_sum_pos hv).le
  rw [mul_pow, fourth_root_pow (by norm_num : (0 : ℝ) ≤ 2), hroot]
  nlinarith [sq_nonneg (‖v 0‖ ^ 2 - ‖v 1‖ ^ 2)]

lemma ratio_B_upper {v : Fin 2 → ℂ} (hv : v ≠ 0) :
    euclideanNorm (witnessB.mulVec v) / pNorm 4 v ≤ (2 : ℝ) ^ (1 / 4 : ℝ) :=
  (div_le_div_of_nonneg_right (euclidean_B_le_X v) (pNorm_four_pos hv).le).trans
    (ratio_X_upper hv)

lemma flat_vector_nonzero : (![1, -1] : Fin 2 → ℂ) ≠ 0 := by
  norm_num [funext_iff, Fin.forall_fin_succ]

lemma flat_ratio_value : Real.sqrt 2 / (2 : ℝ) ^ (1 / 4 : ℝ) =
    (2 : ℝ) ^ (1 / 4 : ℝ) := by
  apply (div_eq_iff (ne_of_gt (Real.rpow_pos_of_pos (by norm_num : (0 : ℝ) < 2) _))).mpr
  rw [← Real.rpow_add (by norm_num : (0 : ℝ) < 2)]
  norm_num [Real.sqrt_eq_rpow]

lemma ratio_X_attained : (2 : ℝ) ^ (1 / 4 : ℝ) ∈ ratios 4 witnessX := by
  refine ⟨![1, -1], flat_vector_nonzero, ?_⟩
  rw [euclidean_X, pNorm_four]
  norm_num only [Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_fin_one,
    norm_one, norm_neg, one_pow, one_add_one_eq_two]
  exact flat_ratio_value.symm

lemma ratio_B_attained : (2 : ℝ) ^ (1 / 4 : ℝ) ∈ ratios 4 witnessB := by
  refine ⟨![1, -1], flat_vector_nonzero, ?_⟩
  have he : witnessB.mulVec (![1, -1] : Fin 2 → ℂ) = ![0, 1, -1] := by
    ext i
    fin_cases i <;> norm_num [witnessB, Matrix.mulVec, dotProduct, Fin.sum_univ_succ]
  rw [he, euclideanNorm, pNorm_four]
  norm_num [Fin.sum_univ_succ, flat_ratio_value]

theorem norm_certificates_proved :
    (ratios 4 witnessB).Nonempty ∧ BddAbove (ratios 4 witnessB) ∧
    (ratios 4 witnessX).Nonempty ∧ BddAbove (ratios 4 witnessX) ∧
    inducedNorm 4 witnessB = (2 : ℝ) ^ (1 / 4 : ℝ) ∧
    inducedNorm 4 witnessX = (2 : ℝ) ^ (1 / 4 : ℝ) := by
  have hb : ∀ r ∈ ratios 4 witnessB, r ≤ (2 : ℝ) ^ (1 / 4 : ℝ) := by
    rintro r ⟨v, hv, rfl⟩
    exact ratio_B_upper hv
  have hx : ∀ r ∈ ratios 4 witnessX, r ≤ (2 : ℝ) ^ (1 / 4 : ℝ) := by
    rintro r ⟨v, hv, rfl⟩
    exact ratio_X_upper hv
  have nb : (ratios 4 witnessB).Nonempty := ⟨_, ratio_B_attained⟩
  have nx : (ratios 4 witnessX).Nonempty := ⟨_, ratio_X_attained⟩
  have bb : BddAbove (ratios 4 witnessB) := ⟨_, hb⟩
  have bx : BddAbove (ratios 4 witnessX) := ⟨_, hx⟩
  exact ⟨nb, bb, nx, bx, le_antisymm (csSup_le nb hb) (le_csSup bb ratio_B_attained),
    le_antisymm (csSup_le nx hx) (le_csSup bx ratio_X_attained)⟩

theorem not_uniquenessConjecture_proved : ¬ UniquenessConjecture := by
  intro h
  have bad := h 2 3 (by norm_num) (by norm_num) witnessA witness_algebra_proved.1
    4 (by norm_num) witnessX right_inverse_X
    (by simpa [pseudoInverse_eq] using witness_algebra_proved.2.2.2.2)
  rw [pseudoInverse_eq, norm_certificates_proved.2.2.2.2.1,
    norm_certificates_proved.2.2.2.2.2] at bad
  exact (lt_irrefl _) bad

#assert_trust kernel witness_algebra_proved
#assert_trust kernel norm_certificates_proved
#assert_trust kernel not_uniquenessConjecture_proved
end NLA.IE23
