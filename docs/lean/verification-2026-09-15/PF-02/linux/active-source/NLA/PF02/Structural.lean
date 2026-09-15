/- Copyright (c) 2026 Sidney Holden. Released under Apache 2.0.
AI-assisted formalization of Matthew J. Colbrook's PF-02 counterexample.
The quotient and minimum retain every admissible factorization. -/
import NLA.PF02.StructuralBase
import NLA.PF02.Numeric
import Mathlib.Topology.Order.IntermediateValue

set_option autoImplicit false
noncomputable section
open scoped BigOperators Classical
namespace NLA.PF02

def witnessFactorization : Factorization witnessM 3 := ⟨witnessTuple, witnessTuple_valid⟩
def reflectedFactorization : Factorization witnessM 3 := ⟨reflectedTuple, reflectedTuple_valid⟩

lemma witnessM_rank : witnessM.rank = 6 := by
  have hd : witnessM.det ≠ 0 := by rw [witnessM_det]; norm_num
  simpa using Matrix.rank_of_det_ne_zero hd

lemma witness_size_least : IsLeast (feasibleSizes witnessM) 3 := by
  refine ⟨⟨by norm_num, ⟨witnessFactorization⟩⟩, ?_⟩
  intro k hk
  obtain ⟨hk, ⟨F⟩⟩ := hk
  have hr := rank_le_factor_size_sq F
  rw [witnessM_rank] at hr
  by_contra h
  have hkle : k ≤ 2 := by omega
  interval_cases k <;> norm_num at *

lemma witness_psdRank : psdRank witnessM = 3 := witness_size_least.csInf_eq

lemma witness_exact_data_proved :
    (∀ i j, 0 < witnessM i j) ∧ witnessM.det = 8192 ∧ witnessM.rank = 6 ∧
    (∀ i, (witnessFactors i).PosDef ∧ (reflectedFactors i).PosDef) ∧
    IsPSDFactorization witnessM witnessTuple ∧
    IsPSDFactorization witnessM reflectedTuple ∧
    (rowCoordinates witnessFactors).det = 32 ∧
    (rowCoordinates reflectedFactors).det = -32 ∧
    IsLeast (feasibleSizes witnessM) 3 ∧ psdRank witnessM = 3 :=
  ⟨witnessM_pos, witnessM_det, witnessM_rank,
    fun i => ⟨witnessFactors_posDef i, reflectedFactors_posDef i⟩,
    witnessTuple_valid, reflectedTuple_valid, witness_coordinates_det,
    reflected_coordinates_det, witness_size_least, witness_psdRank⟩

lemma factor_left_symm (F : Factorization witnessM 3) : ∀ i, (F.val.1 i).IsSymm := by
  intro i
  simpa only [Matrix.isHermitian_iff_isSymm] using (F.property.1 i).isHermitian

lemma factor_right_symm (F : Factorization witnessM 3) : ∀ i, (F.val.2 i).IsSymm := by
  intro i
  simpa only [Matrix.isHermitian_iff_isSymm] using (F.property.2.1 i).isHermitian

lemma factor_coordinate_det_ne_zero (F : Factorization witnessM 3) :
    (rowCoordinates F.val.1).det ≠ 0 := by
  have h := trace_coordinate_bridge_proved F.val.1 F.val.2
    (factor_left_symm F) (factor_right_symm F)
  have he : witnessM = rowCoordinates F.val.1 * traceMetric *
      (rowCoordinates F.val.2).transpose := by
    rw [← h]
    ext i j
    exact (F.property.2.2 i j).symm
  intro hz
  have hd := congrArg Matrix.det he
  rw [witnessM_det, Matrix.det_mul, Matrix.det_mul, hz] at hd
  norm_num at hd

lemma orientation_eq_ratio (A : Fin 6 → Mat 3) (h : (rowCoordinates A).det ≠ 0) :
    rowOrientation A = (rowCoordinates A).det / |(rowCoordinates A).det| := by
  unfold rowOrientation
  split_ifs with hp
  · rw [abs_of_pos hp, div_self h]
  · have hn : (rowCoordinates A).det < 0 := lt_of_le_of_ne (le_of_not_gt hp) h
    rw [abs_of_neg hn, div_neg, div_self h]

lemma orientation_continuous :
    Continuous (fun F : Factorization witnessM 3 => rowOrientation F.val.1) := by
  have hd : Continuous (fun F : Factorization witnessM 3 =>
      (rowCoordinates F.val.1).det) := by
    apply Continuous.matrix_det
    unfold rowCoordinates symCoordinates
    fun_prop
  have hc := hd.div hd.abs (fun F => abs_ne_zero.mpr (factor_coordinate_det_ne_zero F))
  exact hc.congr (fun F => (orientation_eq_ratio F.val.1 (factor_coordinate_det_ne_zero F)).symm)

lemma orientation_congruent (F G : Factorization witnessM 3) (h : Congruent F G) :
    rowOrientation F.val.1 = rowOrientation G.val.1 := by
  obtain ⟨S, hA, _hB⟩ := h
  have he : rowCoordinates G.val.1 = rowCoordinates F.val.1 * congruenceCoordinates S.val := by
    rw [show G.val.1 = fun i => S.val.transpose * F.val.1 i * S.val from funext hA]
    exact congruence_coordinate_action S.val F.val.1 (factor_left_symm F)
  have hd : (rowCoordinates G.val.1).det = (rowCoordinates F.val.1).det * S.val.det ^ 4 := by
    rw [he, Matrix.det_mul, congruence_coordinate_det]
  have hn : S.val.det ≠ 0 := (Matrix.isUnits_det_units S).ne_zero
  have hp : 0 < S.val.det ^ 4 := by positivity
  have hs : 0 < (rowCoordinates G.val.1).det ↔ 0 < (rowCoordinates F.val.1).det := by
    rw [hd]
    exact mul_pos_iff_of_pos_right hp
  simp only [rowOrientation, hs]

lemma orientation_invariant_proved :
    (∀ F : Factorization witnessM 3, (rowCoordinates F.val.1).det ≠ 0) ∧
    Continuous (fun F : Factorization witnessM 3 => rowOrientation F.val.1) ∧
    (∀ F G : Factorization witnessM 3, Congruent F G →
      rowOrientation F.val.1 = rowOrientation G.val.1) :=
  ⟨factor_coordinate_det_ne_zero, orientation_continuous, orientation_congruent⟩

lemma quotient_orientation_proved :
    ∃ orientation : OrbitSpace witnessM 3 → ℝ,
      Continuous orientation ∧
      (∀ F : Factorization witnessM 3, orientation (orbitClass F) = rowOrientation F.val.1) ∧
      Set.range orientation = {(-1 : ℝ), 1} := by
  let o : OrbitSpace witnessM 3 → ℝ := Quot.lift
    (fun F => rowOrientation F.val.1) orientation_congruent
  refine ⟨o, continuous_quot_lift orientation_congruent orientation_continuous,
    fun _ => rfl, ?_⟩
  ext y
  constructor
  · rintro ⟨x, rfl⟩
    induction x using Quot.inductionOn with | h F =>
      change rowOrientation F.val.1 ∈ ({(-1 : ℝ), 1} : Set ℝ)
      unfold rowOrientation
      split_ifs <;> simp
  · intro hy
    rcases (by simpa using hy : y = -1 ∨ y = 1) with rfl | rfl
    · refine ⟨orbitClass reflectedFactorization, ?_⟩
      change rowOrientation reflectedFactors = -1
      simp [rowOrientation, reflected_coordinates_det]
    · refine ⟨orbitClass witnessFactorization, ?_⟩
      change rowOrientation witnessFactors = 1
      simp [rowOrientation, witness_coordinates_det]

lemma disconnected_counterexample_proved :
    EntrywiseNonnegative witnessM ∧ witnessM.rank = 3 * (3 + 1) / 2 ∧
    psdRank witnessM = 3 ∧ Nonempty (OrbitSpace witnessM 3) ∧
    ¬ IsPreconnected (Set.univ : Set (OrbitSpace witnessM 3)) := by
  refine ⟨fun i j => (witnessM_pos i j).le, ?_, witness_psdRank,
    ⟨orbitClass witnessFactorization⟩, ?_⟩
  · norm_num [witnessM_rank]
  · intro hc
    obtain ⟨o, ho, _hdesc, hr⟩ := quotient_orientation_proved
    have hi := hc.image o ho.continuousOn
    rw [Set.image_univ, hr] at hi
    have hz := hi.Icc_subset (by simp : (-1 : ℝ) ∈ ({(-1 : ℝ), 1} : Set ℝ))
      (by simp : (1 : ℝ) ∈ ({(-1 : ℝ), 1} : Set ℝ))
      (by norm_num : (0 : ℝ) ∈ Set.Icc (-1 : ℝ) 1)
    norm_num at hz

lemma not_connectedOrbitConjecture_proved : ¬ ConnectedOrbitConjecture := by
  intro h
  obtain ⟨hn, hr, hp, _hne, hd⟩ := disconnected_counterexample_proved
  exact hd (h 3 6 6 (by norm_num) (by norm_num) (by norm_num) witnessM hn hr hp).2

end NLA.PF02
