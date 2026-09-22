/- Elementary LU-to-GEPP bridge for the explicit IE-13 attaining family.
Source construction: Matthew J. Colbrook. Formalization: Sidney Holden with
OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE13.Definitions
import Mathlib.Tactic
import Mathlib.LinearAlgebra.Matrix.Block
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxHeartbeats 2000000
open scoped BigOperators Classical Matrix NNReal
noncomputable section
namespace NLA.IE13

/-- The uneliminated part of a product, indexed by factor rows. -/
def luTail {n : ℕ} (L U : Mat n) (k : ℕ) (i j : Fin n) : ℂ :=
  ∑ a : Fin n, if k ≤ a.val then L i a * U a j else 0

lemma luTail_zero {n : ℕ} (L U : Mat n) (i j : Fin n) :
    luTail L U 0 i j = (L * U) i j := by
  simp [luTail, Matrix.mul_apply]

lemma luTail_split {n : ℕ} (L U : Mat n) (k i j : Fin n) :
    luTail L U k.val i j = L i k * U k j + luTail L U (k.val+1) i j := by
  have h : ∀ a : Fin n,
      (if k.val ≤ a.val then L i a * U a j else 0) =
      (if a = k then L i k * U k j else 0) +
      (if k.val+1 ≤ a.val then L i a * U a j else 0) := by
    intro a
    by_cases he : a = k
    · subst a; simp
    · have hv : a.val ≠ k.val := fun h => he (Fin.ext h)
      by_cases hk : k.val ≤ a.val
      · simp [he,hk,show k.val+1 ≤ a.val by omega]
      · simp [he,hk,show ¬k.val+1 ≤ a.val by omega]
  simp only [luTail,h,Finset.sum_add_distrib]
  simp

lemma luTail_column {n : ℕ} (L U : Mat n)
    (hu : ∀ a b : Fin n, b < a → U a b = 0) (k i : Fin n) :
    luTail L U k.val i k = L i k * U k k := by
  unfold luTail
  rw [Finset.sum_eq_single k]
  · simp
  · intro a _ ha
    by_cases hk : k.val ≤ a.val
    · have hlt : k < a := by
        have hv : a.val ≠ k.val := fun h => ha (Fin.ext h)
        simp only [Fin.lt_def]; omega
      simp [hk,hu a k hlt]
    · simp [hk]
  · simp

lemma luTail_row {n : ℕ} (L U : Mat n)
    (hl : ∀ a b : Fin n, a < b → L a b = 0)
    (hd : ∀ a : Fin n, L a a = 1) (k j : Fin n) :
    luTail L U k.val k j = U k j := by
  unfold luTail
  rw [Finset.sum_eq_single k]
  · simp [hd]
  · intro a _ ha
    by_cases hk : k.val ≤ a.val
    · have hlt : k < a := by
        have hv : a.val ≠ k.val := fun h => ha (Fin.ext h)
        simp only [Fin.lt_def]; omega
      simp [hk,hl k a hlt]
    · simp [hk]
  · simp

/-- Actual padded stages, with the factor row currently at each active position. -/
def luStage {n : ℕ} (L U : Mat n) (label : ℕ → Fin n → Fin n)
    (k : ℕ) : Mat n := fun i j =>
  if k ≤ i.val ∧ k ≤ j.val then luTail L U k (label k i) j else 0

lemma luStage_zero {n : ℕ} (L U : Mat n) (label : ℕ → Fin n → Fin n) :
    luStage L U label 0 = (L*U).submatrix (label 0) id := by
  ext i j
  simp [luStage,luTail_zero]

lemma luStage_pivot_row {n : ℕ} (L U : Mat n) (label : ℕ → Fin n → Fin n)
    (hl : ∀ a b : Fin n, a < b → L a b = 0)
    (hd : ∀ a : Fin n, L a a = 1)
    (k r j : Fin n) (hr : k ≤ r) (hj : k ≤ j)
    (hlabel : label k.val r = k) :
    luStage L U label k.val r j = U k j := by
  simp [luStage,show k.val ≤ r.val from hr,show k.val ≤ j.val from hj,
    hlabel,luTail_row L U hl hd]

lemma luStage_column {n : ℕ} (L U : Mat n) (label : ℕ → Fin n → Fin n)
    (hu : ∀ a b : Fin n, b < a → U a b = 0)
    (k i : Fin n) (hi : k ≤ i) :
    luStage L U label k.val i k = L (label k.val i) k * U k k := by
  simpa [luStage,show k.val ≤ i.val from hi] using luTail_column L U hu k (label k.val i)

lemma luStage_step {n : ℕ} (L U : Mat n) (label : ℕ → Fin n → Fin n)
    (hl : ∀ a b : Fin n, a < b → L a b = 0)
    (hd : ∀ a : Fin n, L a a = 1)
    (hu : ∀ a b : Fin n, b < a → U a b = 0)
    (hz : ∀ a : Fin n, U a a ≠ 0)
    (k r : Fin n) (hr : k ≤ r) (hpivot : label k.val r = k)
    (hnext : ∀ i : Fin n, k < i →
      label (k.val+1) i = label k.val (Equiv.swap k r i)) :
    schurStep (luStage L U label k.val) k r = luStage L U label (k.val+1) := by
  ext i j
  by_cases hij : k < i ∧ k < j
  · have hswap : k ≤ Equiv.swap k r i := by
      by_cases he : i = r
      · subst i; simp
      · rw [Equiv.swap_apply_of_ne_of_ne hij.1.ne' he]
        exact hij.1.le
    rw [schurStep,if_pos hij]
    rw [luStage_column L U label hu k _ hswap]
    rw [luStage_pivot_row L U label hl hd k r k hr le_rfl hpivot]
    rw [luStage_pivot_row L U label hl hd k r j hr hij.2.le hpivot]
    have hactive : k.val ≤ (Equiv.swap k r i).val ∧ k.val ≤ j.val := ⟨hswap,hij.2.le⟩
    have hfuture : k.val+1 ≤ i.val ∧ k.val+1 ≤ j.val := by
      simp only [Fin.lt_def] at hij; omega
    simp only [luStage,if_pos hactive,if_pos hfuture]
    rw [hnext i hij.1,luTail_split L U k]
    field_simp [hz k]
    <;> ring
  · have hfuture : ¬(k.val+1 ≤ i.val ∧ k.val+1 ≤ j.val) := by
      simp only [Fin.lt_def] at hij; omega
    simp [schurStep,hij,luStage,hfuture]

lemma luStage_isPath {n : ℕ} (L U : Mat n) (label : ℕ → Fin n → Fin n)
    (r : Fin n → Fin n)
    (hl : ∀ a b : Fin n, a < b → L a b = 0)
    (hd : ∀ a : Fin n, L a a = 1)
    (hu : ∀ a b : Fin n, b < a → U a b = 0)
    (hz : ∀ a : Fin n, U a a ≠ 0)
    (hb : ∀ k i : Fin n, k ≤ i → ‖L (label k.val i) k‖ ≤ 1)
    (hr : ∀ k : Fin n, k ≤ r k)
    (hpivot : ∀ k : Fin n, label k.val (r k) = k)
    (hnext : ∀ k i : Fin n, k < i →
      label (k.val+1) i = label k.val (Equiv.swap k (r k) i)) :
    isPath ((L*U).submatrix (label 0) id) (luStage L U label) r := by
  refine ⟨luStage_zero L U label,fun k => ⟨hr k,?_,?_,?_⟩⟩
  · rw [luStage_pivot_row L U label hl hd k (r k) k (hr k) le_rfl (hpivot k)]
    exact hz k
  · intro i hi
    rw [luStage_column L U label hu k i hi]
    rw [luStage_pivot_row L U label hl hd k (r k) k (hr k) le_rfl (hpivot k)]
    rw [norm_mul]
    exact mul_le_of_le_one_left (norm_nonneg _) (hb k i hi)
  · intro _
    exact (luStage_step L U label hl hd hu hz k (r k) (hr k) (hpivot k) (hnext k)).symm

end NLA.IE13
