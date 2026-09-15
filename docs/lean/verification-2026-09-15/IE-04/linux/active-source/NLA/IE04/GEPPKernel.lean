import NLA.IE04.Definitions
import Mathlib

/-! Actual active-block kernel semantics for GEPP. Formalization by Sidney Holden
with Codex assistance; the mathematical counterexample is George Stepaniants'.
The padded Schur convention is shared with the earlier IE-05 formalization. -/
set_option autoImplicit false
set_option maxHeartbeats 2000000
noncomputable section
open scoped BigOperators Classical
open Matrix
namespace NLA.IE04

def Supported {n : ℕ} (k : ℕ) (v : Fin n → ℝ) : Prop :=
  ∀ j, j.val < k → v j = 0

def ActiveInjective {n : ℕ} (A : Mat n) (k : ℕ) : Prop :=
  ∀ v : Fin n → ℝ, Supported k v →
    (∀ i : Fin n, k ≤ i.val → A i ⬝ᵥ v = 0) → v = 0

lemma active_zero_iff {n : ℕ} (A : Mat n) : ActiveInjective A 0 ↔ A.det ≠ 0 := by
  have hu : A.det ≠ 0 ↔ IsUnit A := by
    rw [Matrix.isUnit_iff_isUnit_det, isUnit_iff_ne_zero]
  rw [hu, ← Matrix.mulVec_injective_iff_isUnit]
  constructor
  · intro h v w hvw
    have hz : v - w = 0 := h (v-w) (by intro j hj; omega) (by
      intro i hi
      have hh := congrFun hvw i
      simpa [Matrix.mulVec, dotProduct_sub] using sub_eq_zero.mpr hh)
    exact sub_eq_zero.mp hz
  · intro h v hs hz
    apply h
    ext i
    simpa [Matrix.mulVec] using hz i (Nat.zero_le _)

lemma active_end {n : ℕ} (A : Mat n) : ActiveInjective A n := by
  intro v hs hz
  ext j
  exact hs j j.isLt

lemma swap_active {n : ℕ} (k r i : Fin n) (hr : k ≤ r) (hi : k ≤ i) :
    k ≤ Equiv.swap k r i := by
  by_cases hik : i = k
  · simp [hik, hr]
  by_cases hir : i = r
  · simp [hir]
  simpa [Equiv.swap_apply_of_ne_of_ne hik hir] using hi

lemma schur_dot {n : ℕ} (A : Mat n) (k r i : Fin n)
    (v : Fin n → ℝ) (hv : Supported (k.val+1) v) (hi : k < i) :
    schurStep A k r i ⬝ᵥ v =
      A (Equiv.swap k r i) ⬝ᵥ v - A (Equiv.swap k r i) k / A r k * (A r ⬝ᵥ v) := by
  simp only [dotProduct, Finset.mul_sum, ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro j hj
  by_cases hkj : k < j
  · simp [schurStep, hi, hkj]; ring
  · have hz := hv j (by simpa using (le_of_not_gt hkj))
    simp [hz]

lemma dot_tail {n : ℕ} (A : Mat n) (v : Fin n → ℝ) (k i : Fin n) :
    A i ⬝ᵥ (v - Pi.single k (v k)) = A i ⬝ᵥ v - A i k * v k := by
  simp [dotProduct_sub, dotProduct_single]

lemma dot_lift {n : ℕ} (A : Mat n) (v : Fin n → ℝ) (k i : Fin n) (c : ℝ) :
    A i ⬝ᵥ (v + Pi.single k c) = A i ⬝ᵥ v + A i k * c := by
  simp [dotProduct_add, dotProduct_single]

lemma active_schur_iff {n : ℕ} (A : Mat n) (k r : Fin n)
    (hr : k ≤ r) (hp : A r k ≠ 0) :
    ActiveInjective (schurStep A k r) (k.val+1) ↔ ActiveInjective A k.val := by
  constructor
  · intro hs v hv hz
    let w := v - Pi.single k (v k)
    have hw : Supported (k.val+1) w := by
      intro j hj
      by_cases hjk : j = k
      · simp [w, hjk]
      · have hjlt : j.val < k.val := by have hn : j.val ≠ k.val := fun h => hjk (Fin.ext h); omega
        simp [w, Pi.single_eq_of_ne hjk, hv j hjlt]
    have hzw : w = 0 := hs w hw (by
      intro i hi
      have hki : k < i := hi
      rw [schur_dot _ _ _ _ _ hw hki]
      have hswa := swap_active k r i hr hki.le
      rw [show w = v - Pi.single k (v k) from rfl, dot_tail, dot_tail,
        hz _ hswa, hz r hr]
      field_simp
      ring)
    have hvk : v k = 0 := by
      have hdot := congrArg (fun t : Fin n → ℝ => A r ⬝ᵥ t) hzw
      simp only [w, dot_tail, hz r hr, dotProduct_zero, zero_sub, neg_eq_zero] at hdot
      exact (mul_eq_zero.mp hdot).resolve_left hp
    have hveq : w = v := by simp [w, hvk]
    exact hveq.symm.trans hzw
  · intro ha v hv hz
    let c : ℝ := -(A r ⬝ᵥ v) / A r k
    let w : Fin n → ℝ := v + Pi.single k c
    have hw : Supported k.val w := by
      intro j hj
      have hjk : j ≠ k := by intro h; subst j; omega
      simp [w, Pi.single_eq_of_ne hjk, hv j (by omega)]
    have rowr : A r ⬝ᵥ w = 0 := by
      rw [show w = v + Pi.single k c from rfl, dot_lift]
      dsimp [c]
      field_simp
      ring
    have hzw : w = 0 := ha w hw (by
      intro i hi
      by_cases hir : i = r
      · simpa [hir] using rowr
      let j := Equiv.swap k r i
      have hkj : k < j := by
        have hjge := swap_active k r i hr hi
        have hjne : j ≠ k := by
          intro hj
          have := congrArg (Equiv.swap k r) hj
          exact hir (by simpa [j] using this)
        exact lt_of_le_of_ne hjge (Ne.symm hjne)
      have hh := hz j hkj
      rw [schur_dot _ _ _ _ _ hv hkj] at hh
      simp only [j, Equiv.swap_apply_self] at hh
      rw [show w = v + Pi.single k c from rfl, dot_lift]
      dsimp [c]
      have heq : A i k * (-(A r ⬝ᵥ v) / A r k) =
          -(A i k / A r k * (A r ⬝ᵥ v)) := by ring
      rw [heq]
      exact hh)
    ext j
    by_cases hjk : j = k
    · subst j
      exact hv k (Nat.lt_succ_self _)
    · have hh := congrFun hzw j
      simpa [w, Pi.single_eq_of_ne hjk] using hh

lemma active_column_nonzero {n : ℕ} (A : Mat n) (k : Fin n)
    (ha : ActiveInjective A k.val) : ∃ r : Fin n, k ≤ r ∧ A r k ≠ 0 := by
  by_contra h
  push Not at h
  have hh := ha (Pi.single k (1 : ℝ)) (by
    intro j hj
    have hjk : j ≠ k := by intro he; subst j; omega
    simp [Pi.single_eq_of_ne hjk]) (by
      intro i hi
      simpa [dotProduct_single] using h i hi)
  have hhk := congrFun hh k
  simp at hhk

end NLA.IE04
