/-
Copyright (c) 2026 Sidney Holden. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Sidney Holden, with OpenAI Codex assistance

Matthew J. Colbrook's exact IV-06 counterexample. The proof eliminates
three eigenvector equations, then uses connectedness of real intervals.
-/
import NLA.IV06.Definitions
import Mathlib.Topology.Order.IntermediateValue
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Linarith
import LeanCert.Tactic.IntervalAuto.PointIneq

set_option autoImplicit false
set_option leancert.trust "kernel"
noncomputable section
namespace NLA.IV06

lemma witness_admissible {a b : ℝ} (ha : -166 ≤ a ∧ a ≤ -16)
    (hb : 9 ≤ b ∧ b ≤ 159) : witnessMatrix a b ∈ intervalFamily lower upper := by
  intro i j
  fin_cases i <;> fin_cases j <;> simp [lower, upper, witnessMatrix, ha, hb]

lemma admissible_representation {A : Matrix (Fin 3) (Fin 3) ℝ}
    (h : A ∈ intervalFamily lower upper) : A = witnessMatrix (A 0 1) (A 0 2) := by
  ext i j
  have hij := h i j
  fin_cases i <;> fin_cases j <;> simp [lower, upper, witnessMatrix] at hij ⊢ <;> linarith

lemma eigenpair_in {a b t : ℝ} {v : Fin 3 → ℝ}
    (ha : -166 ≤ a ∧ a ≤ -16) (hb : 9 ≤ b ∧ b ≤ 159)
    (hv : v ≠ 0) (he : (witnessMatrix a b).mulVec v = t • v) :
    t ∈ witnessSpectrum :=
  ⟨witnessMatrix a b, witness_admissible ha hb, v, hv, he⟩

theorem included_points_proved :
    (-3 : ℝ) ∈ witnessSpectrum ∧ 0 ∈ witnessSpectrum ∧
    3 ∈ witnessSpectrum ∧ 25 ∈ witnessSpectrum := by
  refine ⟨?_, ?_, ?_, ?_⟩
  · apply eigenpair_in (a := -21) (b := 154) (v := ![-4, 2, 1])
      (by norm_num) (by norm_num)
    · norm_num [funext_iff, Fin.forall_fin_succ]
    · norm_num [witnessMatrix, Matrix.mulVec, dotProduct, Fin.sum_univ_succ,
        funext_iff, Fin.forall_fin_succ]
  · apply eigenpair_in (a := -16) (b := 9) (v := ![-1, -1, 1])
      (by norm_num) (by norm_num)
    · norm_num [funext_iff, Fin.forall_fin_succ]
    · norm_num [witnessMatrix, Matrix.mulVec, dotProduct, Fin.sum_univ_succ,
        funext_iff, Fin.forall_fin_succ]
  · apply eigenpair_in (a := -146) (b := 29) (v := ![4, 1, 2])
      (by norm_num) (by norm_num)
    · norm_num [funext_iff, Fin.forall_fin_succ]
    · norm_num [witnessMatrix, Matrix.mulVec, dotProduct, Fin.sum_univ_succ,
        funext_iff, Fin.forall_fin_succ]
  · apply eigenpair_in (a := -91) (b := 84) (v := ![312, 12, 13])
      (by norm_num) (by norm_num)
    · norm_num [funext_iff, Fin.forall_fin_succ]
    · norm_num [witnessMatrix, Matrix.mulVec, dotProduct, Fin.sum_univ_succ,
        funext_iff, Fin.forall_fin_succ]

/-- The only LeanCert computation is a closed exact margin at a parameter
corner. Monotonicity removes both interval variables before certification. -/
lemma separator_margin : (0 : ℝ) < 1859 + 11 * (-166) + 13 * 9 := by
  interval_decide (trust := kernel)

lemma eigen_equations {t : ℝ} (ht : t ∈ witnessSpectrum) :
    ∃ a b : ℝ, (-166 ≤ a ∧ a ≤ -16) ∧ (9 ≤ b ∧ b ≤ 159) ∧
      ∃ v : Fin 3 → ℝ, v ≠ 0 ∧
      25 * v 0 + a * v 1 + b * v 2 = t * v 0 ∧
      v 0 - v 1 = t * v 1 ∧ v 0 + v 2 = t * v 2 := by
  obtain ⟨A, hA, v, hv, he⟩ := ht
  have ha := hA 0 1
  have hb := hA 0 2
  simp [lower, upper, witnessMatrix] at ha hb
  refine ⟨A 0 1, A 0 2, ha, hb, v, hv, ?_⟩
  rw [admissible_representation hA] at he
  have h0 := congrFun he 0
  have h1 := congrFun he 1
  have h2 := congrFun he 2
  simp [witnessMatrix, Matrix.mulVec, dotProduct, Fin.sum_univ_succ] at h0 h1 h2
  exact ⟨by linarith, by linarith, by linarith⟩

lemma vector_zero {v : Fin 3 → ℝ} (h0 : v 0 = 0) (h1 : v 1 = 0)
    (h2 : v 2 = 0) : v = 0 := by
  ext i
  fin_cases i <;> assumption

theorem excluded_separators_proved :
    (-1 : ℝ) ∉ witnessSpectrum ∧ 1 ∉ witnessSpectrum ∧
    12 ∉ witnessSpectrum := by
  refine ⟨?_, ?_, ?_⟩
  · intro ht
    obtain ⟨a, b, ha, hb, v, hv, h0, h1, h2⟩ := eigen_equations ht
    have z0 : v 0 = 0 := by linarith
    have z2 : v 2 = 0 := by linarith
    have z1 : v 1 = 0 := by
      have hp : a * v 1 = 0 := by nlinarith [h0]
      exact (mul_eq_zero.mp hp).resolve_left (by linarith [ha.2])
    exact hv (vector_zero z0 z1 z2)
  · intro ht
    obtain ⟨a, b, ha, hb, v, hv, h0, h1, h2⟩ := eigen_equations ht
    have z0 : v 0 = 0 := by linarith
    have z1 : v 1 = 0 := by linarith
    have z2 : v 2 = 0 := by
      have hp : b * v 2 = 0 := by nlinarith [h0]
      exact (mul_eq_zero.mp hp).resolve_left (by linarith [hb.1])
    exact hv (vector_zero z0 z1 z2)
  · intro ht
    obtain ⟨a, b, ha, hb, v, hv, h0, h1, h2⟩ := eigen_equations ht
    have e0 : v 0 = 13 * v 1 := by linarith
    have e2 : v 2 = (13 / 11) * v 1 := by linarith
    rw [e0, e2] at h0
    have hp : (1859 + 11 * a + 13 * b) * v 1 = 0 := by nlinarith [h0]
    have hc : 0 < 1859 + 11 * a + 13 * b := by
      linarith [ha.1, hb.1, separator_margin]
    have z1 := (mul_eq_zero.mp hp).resolve_left (ne_of_gt hc)
    exact hv (vector_zero (by linarith) z1 (by linarith))

/-- A missing intermediate real number separates actual connected components. -/
lemma separated_components {S : Set ℝ} {x y z : ℝ}
    (hx : x ∈ S) (hy : y ∈ S) (hz : z ∉ S) (hxz : x ≤ z) (hzy : z ≤ y) :
    connectedComponentIn S x ≠ connectedComponentIn S y := by
  intro he
  have hy' : y ∈ connectedComponentIn S x := he ▸ mem_connectedComponentIn hy
  exact hz (connectedComponentIn_subset S x
    (isPreconnected_connectedComponentIn.Icc_subset (mem_connectedComponentIn hx) hy'
      ⟨hxz, hzy⟩))

theorem counterexample_proved :
    (∀ i j, lower i j ≤ upper i j) ∧
    4 ≤ (components witnessSpectrum).encard := by
  obtain ⟨h0, h1, h2, h3⟩ := included_points_proved
  obtain ⟨s0, s1, s2⟩ := excluded_separators_proved
  let C := connectedComponentIn witnessSpectrum
  have n01 : C (-3) ≠ C 0 := separated_components h0 h1 s0 (by norm_num) (by norm_num)
  have n02 : C (-3) ≠ C 3 := separated_components h0 h2 s0 (by norm_num) (by norm_num)
  have n03 : C (-3) ≠ C 25 := separated_components h0 h3 s0 (by norm_num) (by norm_num)
  have n12 : C 0 ≠ C 3 := separated_components h1 h2 s1 (by norm_num) (by norm_num)
  have n13 : C 0 ≠ C 25 := separated_components h1 h3 s1 (by norm_num) (by norm_num)
  have n23 : C 3 ≠ C 25 := separated_components h2 h3 s2 (by norm_num) (by norm_num)
  have hc : ({C (-3), C 0, C 3, C 25} : Set (Set ℝ)).encard = 4 := by
    norm_num [Set.encard_insert_of_notMem, n01, n02, n03, n12, n13, n23]
  have hs : ({C (-3), C 0, C 3, C 25} : Set (Set ℝ)) ⊆ components witnessSpectrum := by
    intro K hK
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hK
    rcases hK with rfl | rfl | rfl | rfl
    · exact ⟨-3, h0, rfl⟩
    · exact ⟨0, h1, rfl⟩
    · exact ⟨3, h2, rfl⟩
    · exact ⟨25, h3, rfl⟩
  constructor
  · intro i j
    fin_cases i <;> fin_cases j <;> norm_num [lower, upper, witnessMatrix]
  · exact hc ▸ Set.encard_le_encard hs

theorem not_componentBoundConjecture_proved : ¬ ComponentBoundConjecture := by
  intro h
  have hb := h 3 (by norm_num) lower upper counterexample_proved.1
  have hbad := counterexample_proved.2.trans hb
  norm_num at hbad

#assert_trust kernel included_points_proved
#assert_trust kernel excluded_separators_proved
#assert_trust kernel counterexample_proved
#assert_trust kernel not_componentBoundConjecture_proved
end NLA.IV06
