/- Copyright (c) 2026 Sidney Holden. Released under Apache 2.0.
AI-assisted formalization of Matthew J. Colbrook's PF-02 witness.
Exact algebra preserves every real entry of the congruence matrix. -/
import NLA.PF02.Definitions
import Mathlib.Tactic
import LeanCert.Tactic.IntervalAuto.PointIneq

set_option autoImplicit false
set_option leancert.trust "kernel"
set_option maxRecDepth 100000
set_option maxHeartbeats 0
noncomputable section
open scoped BigOperators Classical
namespace NLA.PF02

lemma witnessM_pos : ∀ i j, 0 < witnessM i j := by
  intro i j
  fin_cases i <;> fin_cases j <;> norm_num [witnessM]

lemma witnessM_det : (witnessM).det = 8192 := by
  have h : (!![24,20,20,16,16,16;20,24,20,16,16,16;20,20,24,16,16,16;16,16,16,14,12,12;16,16,16,12,14,12;16,16,16,12,12,14] : Matrix (Fin 6) (Fin 6) ℤ).det = 8192 := by decide
  have hc := congrArg (Int.castRingHom ℝ) h
  rw [RingHom.map_det] at hc
  convert hc using 1 <;> norm_num [Matrix.map, rowCoordinates, symCoordinates,
    reflectedFactors, witnessFactors, witnessM, Fin.ext_iff]
  congr 1
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [rowCoordinates, symCoordinates, reflectedFactors, witnessFactors,
      witnessM, Matrix.map, Fin.ext_iff] <;> rfl

lemma witness_coordinates_det : (rowCoordinates witnessFactors).det = 32 := by
  have h : (!![4,2,2,0,0,0;2,4,2,0,0,0;2,2,4,0,0,0;2,2,2,1,0,0;2,2,2,0,1,0;2,2,2,0,0,1] : Matrix (Fin 6) (Fin 6) ℤ).det = 32 := by decide
  have hc := congrArg (Int.castRingHom ℝ) h
  rw [RingHom.map_det] at hc
  convert hc using 1 <;> norm_num [Matrix.map, rowCoordinates, symCoordinates,
    reflectedFactors, witnessFactors, witnessM, Fin.ext_iff]
  congr 1
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [rowCoordinates, symCoordinates, reflectedFactors, witnessFactors,
      witnessM, Matrix.map, Fin.ext_iff] <;> rfl

lemma reflected_coordinates_det : (rowCoordinates reflectedFactors).det = -32 := by
  have h : (!![4,2,2,0,0,0;2,4,2,0,0,0;2,2,4,0,0,0;2,2,2,-1,0,0;2,2,2,0,1,0;2,2,2,0,0,1] : Matrix (Fin 6) (Fin 6) ℤ).det = -32 := by decide
  have hc := congrArg (Int.castRingHom ℝ) h
  rw [RingHom.map_det] at hc
  convert hc using 1 <;> norm_num [Matrix.map, rowCoordinates, symCoordinates,
    reflectedFactors, witnessFactors, witnessM, Fin.ext_iff]
  congr 1
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [rowCoordinates, symCoordinates, reflectedFactors, witnessFactors,
      witnessM, Matrix.map, Fin.ext_iff] <;> rfl

private lemma sum_sq_pos {x : Fin 3 → ℝ} (hx : x ≠ 0) :
    0 < x 0 ^ 2 + x 1 ^ 2 + x 2 ^ 2 := by
  have h0 := sq_nonneg (x 0)
  have h1 := sq_nonneg (x 1)
  have h2 := sq_nonneg (x 2)
  by_contra h
  have hz0 : x 0 = 0 := by nlinarith
  have hz1 : x 1 = 0 := by nlinarith
  have hz2 : x 2 = 0 := by nlinarith
  apply hx
  funext i
  fin_cases i <;> simp_all

lemma witnessFactors_posDef : ∀ i, (witnessFactors i).PosDef := by
  intro i
  apply Matrix.PosDef.of_dotProduct_mulVec_pos
  · fin_cases i <;> ext j k <;> fin_cases j <;> fin_cases k <;>
      norm_num [witnessFactors, Matrix.IsHermitian, Matrix.conjTranspose]
  · intro x hx
    have h := sum_sq_pos hx
    have h01 := sq_nonneg (x 0 + x 1)
    have h02 := sq_nonneg (x 0 + x 2)
    have h12 := sq_nonneg (x 1 + x 2)
    have h0 := sq_nonneg (x 0)
    have h1 := sq_nonneg (x 1)
    have h2 := sq_nonneg (x 2)
    fin_cases i <;>
      simp [witnessFactors, dotProduct, Matrix.mulVec, Fin.sum_univ_succ] <;>
      nlinarith

lemma reflectedFactors_posDef : ∀ i, (reflectedFactors i).PosDef := by
  intro i
  by_cases hi : i = 3
  · subst i
    apply Matrix.PosDef.of_dotProduct_mulVec_pos
    · ext j k
      fin_cases j <;> fin_cases k <;>
        norm_num [reflectedFactors, Matrix.IsHermitian, Matrix.conjTranspose]
    · intro x hx
      have h := sum_sq_pos hx
      have h01 := sq_nonneg (x 0 - x 1)
      have h2 := sq_nonneg (x 2)
      simp [reflectedFactors, dotProduct, Matrix.mulVec, Fin.sum_univ_succ]
      nlinarith
  · simpa [reflectedFactors, hi] using witnessFactors_posDef i

lemma witnessTuple_valid : IsPSDFactorization witnessM witnessTuple := by
  refine ⟨fun i => (witnessFactors_posDef i).posSemidef,
    fun i => (witnessFactors_posDef i).posSemidef, ?_⟩
  intro i j
  fin_cases i <;> fin_cases j <;>
    norm_num [witnessTuple, witnessFactors, witnessM, Matrix.trace, Matrix.mul_apply,
      Fin.sum_univ_succ]

lemma reflectedTuple_valid : IsPSDFactorization witnessM reflectedTuple := by
  refine ⟨fun i => (reflectedFactors_posDef i).posSemidef,
    fun i => (reflectedFactors_posDef i).posSemidef, ?_⟩
  intro i j
  fin_cases i <;> fin_cases j <;>
    norm_num [reflectedTuple, reflectedFactors, witnessFactors, witnessM, Fin.ext_iff,
      Matrix.trace, Matrix.mul_apply, Fin.sum_univ_succ]

lemma trace_coordinate_bridge_proved (A B : Fin 6 → Mat 3)
    (hA : ∀ i, (A i).IsSymm) (hB : ∀ j, (B j).IsSymm) :
    (fun i j => (A i * B j).trace) =
      rowCoordinates A * traceMetric * (rowCoordinates B).transpose := by
  ext i j
  have ha01 := (hA i).apply 0 1
  have ha02 := (hA i).apply 0 2
  have ha12 := (hA i).apply 1 2
  have hb01 := (hB j).apply 0 1
  have hb02 := (hB j).apply 0 2
  have hb12 := (hB j).apply 1 2
  simp [rowCoordinates, symCoordinates, traceMetric, Matrix.trace, Matrix.mul_apply,
    Matrix.diagonal, Fin.sum_univ_succ, ha01, ha02, ha12, hb01, hb02, hb12]
  ring

lemma congruence_coordinate_action (S : Mat 3) (A : Fin 6 → Mat 3)
    (hA : ∀ i, (A i).IsSymm) :
    rowCoordinates (fun i => S.transpose * A i * S) =
      rowCoordinates A * congruenceCoordinates S := by
  ext i j
  have ha01 := (hA i).apply 0 1
  have ha02 := (hA i).apply 0 2
  have ha12 := (hA i).apply 1 2
  fin_cases j <;>
    simp [rowCoordinates, symCoordinates, congruenceCoordinates, symBasis,
      symOfCoordinates, Matrix.mul_apply, Fin.sum_univ_succ,
      Pi.single_apply, ha01, ha02, ha12] <;> ring

lemma congruence_coordinate_det (S : Mat 3) :
    (congruenceCoordinates S).det = S.det ^ 4 := by
  simp [congruenceCoordinates, symCoordinates, symBasis, symOfCoordinates,
    Matrix.mul_apply, Matrix.det_succ_row_zero, Matrix.det_fin_zero, Matrix.submatrix_apply, Fin.succAbove, Fin.sum_univ_succ, Pi.single_apply]
  ring

end NLA.PF02
