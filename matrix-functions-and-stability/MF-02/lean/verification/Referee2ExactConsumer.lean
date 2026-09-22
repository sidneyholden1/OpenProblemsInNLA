import Solution
import LeanCert.Tactic.Verification
open NLA.MF02
set_option autoImplicit false
open Polynomial
noncomputable section
namespace MF02IndependentFinal

theorem error_sets_valid (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) :
    (∀ p : ℝ[X], (pointErrors δ p).Nonempty ∧ BddAbove (pointErrors δ p) ∧
      uniformError δ p ∈ pointErrors δ p) ∧
    (∀ m, (unrestrictedErrors m δ).Nonempty ∧ BddBelow (unrestrictedErrors m δ)) ∧
    (∀ T, (cubicErrors T δ).Nonempty ∧ BddBelow (cubicErrors T δ)) := by exact NLA.MF02.error_sets_valid δ hδ hδ1

theorem register_degree_bound (m : ℕ) (p : ℝ[X]) (hp : computable m p) :
    p.natDegree ≤ 2^m := by exact NLA.MF02.register_degree_bound m p hp

theorem degree_error_bound (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (D : ℕ) (hD : 1 ≤ D) (p : ℝ[X]) (hp : p.natDegree ≤ D) :
    gapRatio δ ^ D ≤ uniformError δ p := by exact NLA.MF02.degree_error_bound δ hδ hδ1 D hD p hp

theorem cubic_bounds_and_strict (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) :
    (∀ T, gapRatio δ ^ (3^T) ≤ cubicError T δ) ∧
    (∀ T, 1 ≤ T → cubicError T δ ≤ gapRatio δ ^ (2^T)) ∧
    StrictAnti (fun T => cubicError T δ) := by exact NLA.MF02.cubic_bounds_and_strict δ hδ hδ1

theorem stages_computable (cs : List (ℝ × ℝ)) :
    computable (2*cs.length) (composeCubics cs) := by exact NLA.MF02.stages_computable cs

theorem genuine_stage_minimum (m : ℕ) (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) :
    (feasibleStages m δ).Nonempty ∧ minimumStages m δ ∈ feasibleStages m δ ∧
    ∀ T ∈ feasibleStages m δ, minimumStages m δ ≤ T := by exact NLA.MF02.genuine_stage_minimum m δ hδ hδ1

theorem stage_bounds (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) :
    minimumStages 0 δ = 1 ∧ minimumStages 1 δ = 1 ∧
    (∀ m : ℕ, 2 ≤ m → m/2 ≤ minimumStages m δ ∧ minimumStages m δ ≤ m) ∧
    (∀ m : ℕ, ((m : ℝ)+1)/4 ≤ (minimumStages m δ : ℝ) ∧
      (minimumStages m δ : ℝ) ≤ (m : ℝ)+1) := by exact NLA.MF02.stage_bounds δ hδ hδ1
end MF02IndependentFinal

#assert_trust kernel NLA.MF02.error_sets_valid
#print axioms NLA.MF02.error_sets_valid

#assert_trust kernel NLA.MF02.register_degree_bound
#print axioms NLA.MF02.register_degree_bound

#assert_trust kernel NLA.MF02.degree_error_bound
#print axioms NLA.MF02.degree_error_bound

#assert_trust kernel NLA.MF02.cubic_bounds_and_strict
#print axioms NLA.MF02.cubic_bounds_and_strict

#assert_trust kernel NLA.MF02.stages_computable
#print axioms NLA.MF02.stages_computable

#assert_trust kernel NLA.MF02.genuine_stage_minimum
#print axioms NLA.MF02.genuine_stage_minimum

#assert_trust kernel NLA.MF02.stage_bounds
#print axioms NLA.MF02.stage_bounds
