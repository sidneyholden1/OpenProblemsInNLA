/- Copyright (c) 2026 Sidney Holden. Released under Apache 2.0.
AI-assisted formalization of Matthew J. Colbrook's SP-04 genericity argument.
The analytic identity theorem is applied on the entire real matrix space. -/
import NLA.SP04.Definitions
import NLA.SP04.TopologyProof
import NLA.SP04.MatrixProof
set_option autoImplicit false
noncomputable section
open scoped BigOperators Classical Topology Matrix.Norms.Operator
namespace NLA.SP04

lemma analytic_evalData (p : MvPolynomial (Fin 3 × Fin 3) ℝ) :
    AnalyticOnNhd ℝ (evalData p) Set.univ := by
  let f : (Fin 3 × Fin 3) → Mat 3 →ₗ[ℝ] ℝ := fun ij =>
    { toFun := fun X => X ij.1 ij.2
      map_add' := fun _ _ => rfl
      map_smul' := fun _ _ => rfl }
  exact AnalyticOnNhd.eval_linearMap' f p

lemma nonzero_polynomial_avoids_open (p : MvPolynomial (Fin 3 × Fin 3) ℝ) (hp : p ≠ 0)
    (V : Set (Mat 3)) (hV : IsOpen V) (hne : V.Nonempty) :
    ∃ U : Mat 3, U ∈ V ∧ evalData p U ≠ 0 := by
  by_contra h
  push Not at h
  obtain ⟨U,hU⟩ := hne
  have he : (evalData p) =ᶠ[𝓝 U] 0 := by
    filter_upwards [hV.mem_nhds hU] with X hX
    exact h X hX
  have hz : evalData p = (fun _ => 0) :=
    (analytic_evalData p).eq_of_eventuallyEq analyticOnNhd_const he
  apply hp
  apply MvPolynomial.funext
  intro x
  have hx := congrFun hz (fun i j => x (i,j))
  simpa [evalData] using hx

lemma avoids_every_proper_algebraic_exception_proved
    (p : MvPolynomial (Fin 3 × Fin 3) ℝ) (hp : p ≠ 0) :
    ∃ U : Mat 3, U ∈ counterexampleFamily ∧ evalData p U ≠ 0 :=
  nonzero_polynomial_avoids_open p hp counterexampleFamily
    open_counterexample_family_proved.2 open_counterexample_family_proved.1

lemma generic_counterexample_proved
    (p : MvPolynomial (Fin 3 × Fin 3) ℝ) (hp : p ≠ 0) :
    ∃ U : Mat 3, evalData p U ≠ 0 ∧ Failure U := by
  obtain ⟨U,hU,he⟩ := avoids_every_proper_algebraic_exception_proved p hp
  exact ⟨U,he,orbit_unique_failure_proved U hU⟩

lemma not_generic_smallest_multiplier_proved : ¬ GenericSmallestMultiplierConjecture := by
  intro h
  obtain ⟨p,hp,hgen⟩ := h 3 (by norm_num)
  obtain ⟨U,he,X,c,hleast,hnot⟩ := generic_counterexample_proved p hp
  exact hnot (hgen U X c he hleast)

end NLA.SP04
