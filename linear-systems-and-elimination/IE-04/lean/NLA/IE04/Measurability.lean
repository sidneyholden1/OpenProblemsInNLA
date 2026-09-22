/- Copyright (c) 2026 Sidney Holden. Released under Apache 2.0.
AI-assisted formalization of the genuine all-schedule GEPP tail event.
The finite legal-schedule union uses Growth.lean's proved maximum semantics. -/
import NLA.IE04.Growth
import Mathlib.MeasureTheory.Order.Lattice
import Mathlib.Tactic
set_option autoImplicit false
noncomputable section
open scoped BigOperators Classical NNReal
open MeasureTheory ProbabilityTheory
namespace NLA.IE04

lemma measurable_matrix_entry {n : ℕ} (i j : Fin n) :
    Measurable (fun A : Mat n => A i j) :=
  (measurable_pi_apply j).comp (measurable_pi_apply i)

lemma measurable_states_entry {n : ℕ} (π : Schedule n) (k : ℕ) (i j : Fin n) :
    Measurable (fun A : Mat n => states A π k i j) := by
  induction k generalizing i j with
  | zero => exact measurable_matrix_entry i j
  | succ k ih =>
    simp only [states]
    split_ifs with hk
    · simp only [schurStep]
      split_ifs
      · exact (ih _ _).sub (((ih _ _).div (ih _ _)).mul (ih _ _))
      · exact measurable_const
    · exact measurable_const

lemma measurable_nnreal_finset_sup {ι α : Type*} [MeasurableSpace α]
    (s : Finset ι) (f : ι → α → ℝ≥0) (hf : ∀ i, Measurable (f i)) :
    Measurable (fun x => s.sup (fun i => f i x)) := by
  induction s using Finset.induction_on with
  | empty => simpa using (measurable_const : Measurable (fun _ : α => (0 : ℝ≥0)))
  | @insert i s hi ih =>
    simpa only [Finset.sup_insert] using (hf i).max ih

lemma measurable_entryMax {n : ℕ} : Measurable (@entryMax n) := by
  exact (measurable_nnreal_finset_sup Finset.univ
    (fun ij : Fin n × Fin n => fun A : Mat n => ‖A ij.1 ij.2‖₊)
    (fun ij => (measurable_matrix_entry ij.1 ij.2).nnnorm)).coe_nnreal_real

lemma measurable_pathGrowth {n : ℕ} (π : Schedule n) :
    Measurable (fun A : Mat n => pathGrowth A π) := by
  exact ((measurable_nnreal_finset_sup Finset.univ
    (fun kij : Fin n × Fin n × Fin n => fun A : Mat n =>
      ‖states A π kij.1.val kij.2.1 kij.2.2‖₊)
    (fun kij => (measurable_states_entry π kij.1.val kij.2.1 kij.2.2).nnnorm)).coe_nnreal_real).div
      measurable_entryMax

lemma measurableSet_legal {n : ℕ} (π : Schedule n) :
    MeasurableSet {A : Mat n | IsLegal A π} := by
  simp only [IsLegal, Set.ofPred_forall]
  apply MeasurableSet.iInter
  intro k
  apply MeasurableSet.inter
  · exact MeasurableSet.const _
  · apply MeasurableSet.inter
    · exact (measurableSet_eq_fun (measurable_states_entry π k.val (π k) k)
        measurable_const).compl
    · have h : ∀ i : Fin n, MeasurableSet {A : Mat n | k ≤ i →
          |states A π k.val i k| ≤ |states A π k.val (π k) k|} := by
        intro i
        by_cases hki : k ≤ i
        · simpa only [hki, true_implies] using
            measurableSet_le (measurable_states_entry π k.val i k).abs
              (measurable_states_entry π k.val (π k) k).abs
        · simp only [hki, false_implies, Set.ofPred_true]
          exact MeasurableSet.univ
      apply (MeasurableSet.iInter h).congr
      ext A
      simp
      rfl

lemma measurable_perturb {n : ℕ} (center : Mat n) (σ : ℝ) :
    Measurable (perturb center σ) := by
  apply measurable_pi_lambda
  intro i
  apply measurable_pi_lambda
  intro j
  exact measurable_const.add (measurable_const.mul (measurable_matrix_entry i j))

lemma measurable_matrix_det {n : ℕ} : Measurable (fun A : Mat n => A.det) := by
  simp only [Matrix.det_apply']
  apply Finset.measurable_sum
  intro π _
  apply measurable_const.mul
  exact Finset.measurable_prod _ (fun i _ => measurable_matrix_entry (π i) i)

lemma ppGrowth_zero_dim (A : Mat 0) : ppGrowth A = 0 := by
  simp [ppGrowth, growthValues, pathGrowth, entryMax, IsLegal]

lemma measurable_tail_proved {n : ℕ} (center : Mat n) (σ t : ℝ) :
    MeasurableSet (tailEvent center σ t) := by
  by_cases hn : n = 0
  · subst n
    simpa [tailEvent, ppGrowth_zero_dim] using
      (MeasurableSet.const (α := Mat 0) (t < 0))
  have hnpos : 1 ≤ n := by omega
  have hF := measurable_perturb center σ
  have hd : Measurable (fun G : Mat n => (perturb center σ G).det) :=
    measurable_matrix_det.comp hF
  have he : tailEvent center σ t =
      {G : Mat n | (perturb center σ G).det ≠ 0} ∩
      ⋃ π : Schedule n, {G : Mat n | IsLegal (perturb center σ G) π ∧
        t < pathGrowth (perturb center σ G) π} := by
    ext G
    simp only [tailEvent, Set.mem_ofPred_eq, Set.mem_inter_iff, Set.mem_iUnion]
    by_cases hdet : (perturb center σ G).det = 0
    · simp [hdet]
    · obtain ⟨_, _, _, _, _, _, _, hiff⟩ :=
        growth_semantics_proved hnpos (perturb center σ G) hdet
      exact and_congr_right (fun _ => hiff t)
  rw [he]
  apply MeasurableSet.inter
  · exact (measurableSet_eq_fun hd measurable_const).compl
  · apply MeasurableSet.iUnion
    intro π
    exact ((measurableSet_legal π).preimage hF).inter
      (measurableSet_lt measurable_const ((measurable_pathGrowth π).comp hF))

end NLA.IE04
