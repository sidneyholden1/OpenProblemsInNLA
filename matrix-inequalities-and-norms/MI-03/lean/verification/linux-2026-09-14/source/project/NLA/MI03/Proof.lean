/-
Copyright (c) 2026 Sidney Holden. All rights reserved.
Released under Apache 2.0 license as described in LICENSE.
Authors: Sidney Holden, with OpenAI Codex assistance.
Mathematical argument: Matthew J. Colbrook. Original upper bound: Bourin and Lee.
-/
import NLA.MI03.Definitions
import Mathlib.RingTheory.RootsOfUnity.Complex
import Mathlib.Tactic
import LeanCert.Tactic.Verification

set_option autoImplicit false
set_option leancert.trust "kernel"
open scoped BigOperators Classical ComplexOrder MatrixOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MI03

private lemma modulus_sub_sq_nonneg {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ)
    (hA : ‖A‖ ≤ 1) : 0 ≤ modulus A - (modulus A)^2 := by
  have h0 : 0 ≤ modulus A := CFC.abs_nonneg _
  have h1 : modulus A ≤ 1 := (CStarAlgebra.norm_le_one_iff_of_nonneg _ h0).mp
    (by simpa [modulus, CFC.norm_abs] using hA)
  have hc : Commute (modulus A) (1 - modulus A) := (Commute.one_right _).sub_right (Commute.refl _)
  simpa only [mul_sub, mul_one, ← sq] using hc.mul_nonneg h0 (sub_nonneg.mpr h1)

private lemma sum_gram_gap_nonneg {n k : ℕ} (A : Fin k → Matrix (Fin n) (Fin n) ℂ) :
    0 ≤ (k : ℝ) • (∑ j, star (A j) * A j) - star (∑ j, A j) * (∑ j, A j) := by
  have h : 0 ≤ ∑ i, ∑ j, star (A i - A j) * (A i - A j) :=
    Finset.sum_nonneg fun i _ => Finset.sum_nonneg fun j _ => star_mul_self_nonneg _
  have heq : (∑ i, ∑ j, star (A i - A j) * (A i - A j)) =
      (2 : ℝ) • ((k : ℝ) • (∑ j, star (A j) * A j) - star (∑ j, A j) * (∑ j, A j)) := by
    simp only [star_sub, sub_mul, mul_sub, Finset.sum_sub_distrib, Finset.sum_const,
      Finset.card_univ, Fintype.card_fin, ← Finset.sum_mul, ← Finset.mul_sum, ← star_sum,
      ← Finset.smul_sum, Nat.cast_smul_eq_nsmul ℝ]
    module
  rw [heq] at h
  have hh := smul_nonneg (by norm_num : (0 : ℝ) ≤ 1/2) h
  simpa only [smul_smul, show (1/2 : ℝ)*2=1 by norm_num, one_smul] using hh

/-- The exact positive decomposition proves the universal upper bound. -/
theorem upper_bound (k : ℕ) (hk : 2 ≤ k) : admissible k ((k : ℝ) / 4) := by
  refine ⟨by positivity, ?_⟩
  intro n hn A hA
  let R := modulus (∑ j, A j)
  let T := ∑ j, modulus (A j)
  have hR : IsSelfAdjoint R := (CFC.abs_nonneg _).isSelfAdjoint
  have hs : 0 ≤ (R - ((k : ℝ)/2) • (1 : Matrix (Fin n) (Fin n) ℂ))^2 :=
    (hR.sub ((IsSelfAdjoint.all ((k : ℝ)/2)).smul (IsSelfAdjoint.one _))).sq_nonneg
  have hp := add_nonneg (add_nonneg
    (smul_nonneg (Nat.cast_nonneg k : (0 : ℝ) ≤ k)
      (Finset.sum_nonneg (s := Finset.univ) fun j _ => modulus_sub_sq_nonneg (A j) (hA j)))
    (sum_gram_gap_nonneg A)) hs
  have heq : (k : ℝ) • (∑ j, (modulus (A j) - (modulus (A j))^2)) +
      ((k : ℝ) • (∑ j, star (A j) * A j) - star (∑ j, A j) * (∑ j, A j)) +
      (R - ((k : ℝ)/2) • (1 : Matrix (Fin n) (Fin n) ℂ))^2 =
      (k : ℝ) • (((k : ℝ)/4) • (1 : Matrix (Fin n) (Fin n) ℂ) + T - R) := by
    have hsq : star (∑ j, A j) * (∑ j, A j) = R*R := (CFC.abs_mul_abs _).symm
    simp only [Finset.sum_sub_distrib, modulus, CFC.abs_sq]
    simp only [hsq, sq, sub_mul,
      mul_sub, mul_smul_comm, smul_mul_assoc, mul_one, one_mul]
    dsimp [T, modulus]
    module
  rw [heq] at hp
  have hkpos : (0 : ℝ) < k := by exact_mod_cast (show 0 < k by omega)
  have hh := smul_nonneg (inv_nonneg.mpr hkpos.le) hp
  rw [smul_smul, inv_mul_cancel₀ hkpos.ne', one_smul] at hh
  exact sub_nonneg.mp hh

private def phaseMatrix (z : ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![1/2, (Real.sqrt 3 : ℂ)/2 * z; 0, 0]

private def E : Matrix (Fin 2) (Fin 2) ℂ := !![1, 0; 0, 0]

private lemma phase_left_gram (z : ℂ) (hz : ‖z‖ = 1) :
    phaseMatrix z * star (phaseMatrix z) = E := by
  have hs : (Real.sqrt 3 : ℂ)^2 = 3 := by exact_mod_cast Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)
  have hzz : z * starRingEnd ℂ z = 1 := by
    simp only [Complex.mul_conj, Complex.normSq_eq_norm_sq, hz, one_pow,
      Complex.ofReal_one]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [phaseMatrix, E, Matrix.mul_apply, Fin.sum_univ_two, Matrix.star_eq_conjTranspose,
      Matrix.conjTranspose_apply, map_mul, map_div₀, map_ofNat, ← starRingEnd_apply]
  linear_combination (z * starRingEnd ℂ z / 4) * hs + (3/4 : ℂ) * hzz

private lemma E_phase (z : ℂ) : E * phaseMatrix z = phaseMatrix z := by
  ext i j
  fin_cases i <;> fin_cases j <;> simp [E, phaseMatrix, Matrix.mul_apply, Fin.sum_univ_two]

private lemma E_projection : IsStarProjection E := by
  constructor
  · ext i j
    fin_cases i <;> fin_cases j <;> simp [E, Matrix.mul_apply, Fin.sum_univ_two]
  · ext i j
    fin_cases i <;> fin_cases j <;> simp [E]

private lemma phase_contraction (z : ℂ) (hz : ‖z‖ = 1) : ‖phaseMatrix z‖ ≤ 1 := by
  have he := IsStarProjection.norm_le E E_projection
  have hsq : ‖phaseMatrix z‖^2 = ‖E‖ := by
    rw [sq, ← CStarRing.norm_self_mul_star, phase_left_gram z hz]
  nlinarith [norm_nonneg (phaseMatrix z)]

private lemma phase_modulus (z : ℂ) (hz : ‖z‖ = 1) :
    modulus (phaseMatrix z) = star (phaseMatrix z) * phaseMatrix z := by
  have hsq : (star (phaseMatrix z) * phaseMatrix z) *
      (star (phaseMatrix z) * phaseMatrix z) = star (phaseMatrix z) * phaseMatrix z := by
    calc
      _ = star (phaseMatrix z) * (phaseMatrix z * star (phaseMatrix z)) * phaseMatrix z := by noncomm_ring
      _ = star (phaseMatrix z) * E * phaseMatrix z := by rw [phase_left_gram z hz]
      _ = _ := by rw [mul_assoc, E_phase]
  exact CFC.sqrt_unique hsq (star_mul_self_nonneg _)

private lemma phase_gram_formula (z : ℂ) (hz : ‖z‖ = 1) :
    star (phaseMatrix z) * phaseMatrix z =
      !![1/4, (Real.sqrt 3 : ℂ)/4 * z; (Real.sqrt 3 : ℂ)/4 * star z, 3/4] := by
  have hs : (Real.sqrt 3 : ℂ)^2 = 3 := by exact_mod_cast Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 3)
  have hzz : z * starRingEnd ℂ z = 1 := by
    simp only [Complex.mul_conj, Complex.normSq_eq_norm_sq, hz, one_pow,
      Complex.ofReal_one]
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [phaseMatrix, Matrix.mul_apply, Fin.sum_univ_two, Matrix.star_eq_conjTranspose,
      Matrix.conjTranspose_apply, map_mul, map_div₀, map_ofNat, ← starRingEnd_apply]
  all_goals first | (solve | ring) | linear_combination (z * starRingEnd ℂ z / 4) * hs + (3/4 : ℂ) * hzz

/-- Root-of-unity phases give an exact extremizer for every k≥2. -/
theorem sharpness (k : ℕ) (hk : 2 ≤ k) :
    ∃ A : Fin k → Matrix (Fin 2) (Fin 2) ℂ,
      (∀ j, ‖A j‖ ≤ 1) ∧ modulus (∑ j, A j) - ∑ j, modulus (A j) = sharpGap k := by
  let w : ℂ := Complex.exp (2 * Real.pi * Complex.I / k)
  have hk0 : k ≠ 0 := by omega
  have hw : IsPrimitiveRoot w k := Complex.isPrimitiveRoot_exp k hk0
  have hw1 : ‖w‖ = 1 := hw.norm'_eq_one hk0
  have hn (j : Fin k) : ‖w^j.val‖ = 1 := by rw [norm_pow, hw1, one_pow]
  have hz : ∑ j : Fin k, w^j.val = 0 := by
    rw [Fin.sum_univ_eq_sum_range]
    exact hw.geom_sum_eq_zero (by omega)
  have hzc : ∑ j : Fin k, starRingEnd ℂ (w^j.val) = 0 := by
    rw [← map_sum, hz, map_zero]
  simp only [map_pow] at hzc
  refine ⟨fun j => phaseMatrix (w^j.val), fun j => phase_contraction _ (hn j), ?_⟩
  have ha : (∑ j : Fin k, phaseMatrix (w^j.val)) = ((k : ℝ)/2) • E := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [phaseMatrix, E, Matrix.sum_apply, ← Finset.mul_sum, hz, nsmul_eq_mul] <;> ring
  have hg : (∑ j : Fin k, modulus (phaseMatrix (w^j.val))) =
      !![(k : ℂ)/4, 0; 0, 3*(k : ℂ)/4] := by
    simp_rw [phase_modulus _ (hn _), phase_gram_formula _ (hn _)]
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.sum_apply, ← Finset.mul_sum, hz, hzc, ← starRingEnd_apply, nsmul_eq_mul] <;> ring
  have he0 : 0 ≤ E := E_projection.nonneg
  have hsum0 : 0 ≤ ((k : ℝ)/2) • E := smul_nonneg (by positivity) he0
  rw [ha, show modulus (((k : ℝ)/2) • E) = ((k : ℝ)/2) • E from CFC.abs_of_nonneg _ hsum0, hg]
  ext i j
  fin_cases i <;> fin_cases j <;> simp [sharpGap, E, Matrix.diagonal] <;> ring

private lemma lower_bound (k : ℕ) (hk : 2 ≤ k) (c : ℝ) (hc : admissible k c) :
    (k : ℝ)/4 ≤ c := by
  obtain ⟨A, hA, hgap⟩ := sharpness k hk
  have h := hc.2 2 (by omega) A hA
  have hg : sharpGap k ≤ c • (1 : Matrix (Fin 2) (Fin 2) ℂ) := by
    rw [← hgap]
    exact sub_le_iff_le_add.mpr (by simpa only [add_comm] using h)
  have hd := Matrix.PosSemidef.diag_nonneg (Matrix.le_iff.mp hg) (i := (0 : Fin 2))
  simp [sharpGap, Matrix.sub_apply, Matrix.diagonal] at hd
  have hr := hd.1
  simpa using hr

/-- The infimum is over an actual nonempty, lower-bounded set. -/
theorem sharp_constant (k : ℕ) (hk : 2 ≤ k) :
    {c : ℝ | admissible k c}.Nonempty ∧ BddBelow {c : ℝ | admissible k c} ∧
      bestConstant k = (k : ℝ) / 4 := by
  have hu := upper_bound k hk
  have hne : {c : ℝ | admissible k c}.Nonempty := ⟨(k : ℝ)/4, hu⟩
  have hb : BddBelow {c : ℝ | admissible k c} := ⟨0, fun _ hc => hc.1⟩
  refine ⟨hne, hb, le_antisymm (csInf_le hb hu) ?_⟩
  exact le_csInf hne fun c hc => lower_bound k hk c hc

/-- The complete retained conjecture for all odd summand counts. -/
theorem odd_sharp_constant : oddSharpConstantConjecture := by
  intro k hk _
  exact (sharp_constant k (by omega)).2.2

#assert_trust kernel upper_bound
#assert_trust kernel sharpness
#assert_trust kernel sharp_constant
#assert_trust kernel odd_sharp_constant
end NLA.MI03
