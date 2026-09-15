import NLA.SP04.PolynomialProof
import LeanCert.Tactic.Verification

/- Complete SP-04 exports; Challenge is never imported. -/
set_option autoImplicit false
open scoped BigOperators
namespace NLA.SP04

theorem positive_multiplier_exclusion (s : Fin 3 → ℝ) (hs : SingularInterval s)
    (c : ℝ) (hc : 0 ≤ c ∧ c ≤ (13 : ℝ) / 25) :
    ¬ ∃ x : Fin 3 → ℝ, |∏ i, x i| = 1 ∧
      ∀ i, (x i) ^ 2 - s i * x i + c = 0 := by
  exact positive_multiplier_exclusion_proved s hs c hc

theorem selected_negative_root (s : Fin 3 → ℝ) (hs : SingularInterval s) :
    ∃! t : ℝ, 0 < t ∧ t < (13 : ℝ) / 25 ∧ selectedProduct s t = 1 := by
  exact selected_negative_root_proved s hs

theorem diagonal_stationary_reduction (s : Fin 3 → ℝ) (hs : SingularInterval s)
    (X : Mat 3) (c : ℝ) (hX : Stationary (Matrix.diagonal s) X c) :
    ∃ x : Fin 3 → ℝ, X = Matrix.diagonal x ∧
      |∏ i, x i| = 1 ∧ ∀ i, (x i) ^ 2 - s i * x i + c = 0 := by
  exact diagonal_stationary_reduction_proved s hs X c hX

theorem diagonal_unique_failure (s : Fin 3 → ℝ) (hs : SingularInterval s) :
    Failure (Matrix.diagonal s) := by
  exact diagonal_unique_failure_proved s hs

theorem orbit_unique_failure (U : Mat 3) (hU : U ∈ counterexampleFamily) :
    Failure U := by
  exact orbit_unique_failure_proved U hU

theorem open_counterexample_family :
    counterexampleFamily.Nonempty ∧ IsOpen counterexampleFamily := by
  exact open_counterexample_family_proved

theorem avoids_every_proper_algebraic_exception
    (p : MvPolynomial (Fin 3 × Fin 3) ℝ) (hp : p ≠ 0) :
    ∃ U : Mat 3, U ∈ counterexampleFamily ∧ evalData p U ≠ 0 := by
  exact avoids_every_proper_algebraic_exception_proved p hp

theorem generic_counterexample (p : MvPolynomial (Fin 3 × Fin 3) ℝ) (hp : p ≠ 0) :
    ∃ U : Mat 3, evalData p U ≠ 0 ∧ Failure U := by
  exact generic_counterexample_proved p hp

theorem not_generic_smallest_multiplier :
    ¬ GenericSmallestMultiplierConjecture := by
  exact not_generic_smallest_multiplier_proved

set_option leancert.trust "kernel"
#assert_trust kernel NLA.SP04.positive_multiplier_exclusion
#print axioms NLA.SP04.positive_multiplier_exclusion
#assert_trust kernel NLA.SP04.selected_negative_root
#print axioms NLA.SP04.selected_negative_root
#assert_trust kernel NLA.SP04.diagonal_stationary_reduction
#print axioms NLA.SP04.diagonal_stationary_reduction
#assert_trust kernel NLA.SP04.diagonal_unique_failure
#print axioms NLA.SP04.diagonal_unique_failure
#assert_trust kernel NLA.SP04.orbit_unique_failure
#print axioms NLA.SP04.orbit_unique_failure
#assert_trust kernel NLA.SP04.open_counterexample_family
#print axioms NLA.SP04.open_counterexample_family
#assert_trust kernel NLA.SP04.avoids_every_proper_algebraic_exception
#print axioms NLA.SP04.avoids_every_proper_algebraic_exception
#assert_trust kernel NLA.SP04.generic_counterexample
#print axioms NLA.SP04.generic_counterexample
#assert_trust kernel NLA.SP04.not_generic_smallest_multiplier
#print axioms NLA.SP04.not_generic_smallest_multiplier

end NLA.SP04
