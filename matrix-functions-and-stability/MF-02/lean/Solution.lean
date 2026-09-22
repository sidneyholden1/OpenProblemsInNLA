/- Full original MF-02 target. Source: George Stepaniants; optimized cubic: Chen–Chow; prior asymptotic order: Cheon–Kim–Kim. Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.MF02.Stages
import NLA.MF02.DegreeError
import LeanCert.Tactic.Verification
set_option autoImplicit false
open Polynomial
noncomputable section
namespace NLA.MF02

theorem error_sets_valid (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) :
    (∀ p : ℝ[X], (pointErrors δ p).Nonempty ∧ BddAbove (pointErrors δ p) ∧
      uniformError δ p ∈ pointErrors δ p) ∧
    (∀ m, (unrestrictedErrors m δ).Nonempty ∧ BddBelow (unrestrictedErrors m δ)) ∧
    (∀ T, (cubicErrors T δ).Nonempty ∧ BddBelow (cubicErrors T δ)) := by
  exact error_sets_valid_proved δ hδ hδ1

theorem register_degree_bound (m : ℕ) (p : ℝ[X]) (hp : computable m p) :
    p.natDegree ≤ 2^m := by
  exact register_degree_bound_proved m p hp

theorem degree_error_bound (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (D : ℕ) (hD : 1 ≤ D) (p : ℝ[X]) (hp : p.natDegree ≤ D) :
    gapRatio δ ^ D ≤ uniformError δ p := by
  exact degree_error_bound_proved δ hδ hδ1 D hD p hp

theorem cubic_bounds_and_strict (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) :
    (∀ T, gapRatio δ ^ (3^T) ≤ cubicError T δ) ∧
    (∀ T, 1 ≤ T → cubicError T δ ≤ gapRatio δ ^ (2^T)) ∧
    StrictAnti (fun T => cubicError T δ) := by
  have hd : DegreeBound δ := degree_error_bound_proved δ hδ hδ1
  exact ⟨cubic_lower δ hδ hδ1 hd,cubic_upper δ hδ hδ1 hd,cubic_strict δ hδ hδ1 hd⟩

theorem stages_computable (cs : List (ℝ × ℝ)) :
    computable (2*cs.length) (composeCubics cs) := by
  exact stages_computable_proved cs

theorem genuine_stage_minimum (m : ℕ) (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) :
    (feasibleStages m δ).Nonempty ∧ minimumStages m δ ∈ feasibleStages m δ ∧
    ∀ T ∈ feasibleStages m δ, minimumStages m δ ≤ T := by
  exact genuine_stage_minimum_from_degree m δ hδ hδ1 (degree_error_bound_proved δ hδ hδ1)

theorem stage_bounds (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) :
    minimumStages 0 δ = 1 ∧ minimumStages 1 δ = 1 ∧
    (∀ m : ℕ, 2 ≤ m → m/2 ≤ minimumStages m δ ∧ minimumStages m δ ≤ m) ∧
    (∀ m : ℕ, ((m : ℝ)+1)/4 ≤ (minimumStages m δ : ℝ) ∧
      (minimumStages m δ : ℝ) ≤ (m : ℝ)+1) := by
  exact stage_bounds_from_degree δ hδ hδ1 (degree_error_bound_proved δ hδ hδ1)
#assert_trust kernel error_sets_valid
#print axioms error_sets_valid
#assert_trust kernel register_degree_bound
#print axioms register_degree_bound
#assert_trust kernel degree_error_bound
#print axioms degree_error_bound
#assert_trust kernel cubic_bounds_and_strict
#print axioms cubic_bounds_and_strict
#assert_trust kernel stages_computable
#print axioms stages_computable
#assert_trust kernel genuine_stage_minimum
#print axioms genuine_stage_minimum
#assert_trust kernel stage_bounds
#print axioms stage_bounds
end NLA.MF02
