/- Trusted statement environment only. Deliberate sorry placeholders establish
no result and must never be imported by a future Solution.lean. -/
import NLA.SP04.Definitions

set_option autoImplicit false
open scoped BigOperators
namespace NLA.SP04

theorem positive_multiplier_exclusion (s : Fin 3 → ℝ) (hs : SingularInterval s)
    (c : ℝ) (hc : 0 ≤ c ∧ c ≤ (13 : ℝ) / 25) :
    ¬ ∃ x : Fin 3 → ℝ, |∏ i, x i| = 1 ∧
      ∀ i, (x i) ^ 2 - s i * x i + c = 0 := by sorry

theorem selected_negative_root (s : Fin 3 → ℝ) (hs : SingularInterval s) :
    ∃! t : ℝ, 0 < t ∧ t < (13 : ℝ) / 25 ∧ selectedProduct s t = 1 := by sorry

theorem diagonal_stationary_reduction (s : Fin 3 → ℝ) (hs : SingularInterval s)
    (X : Mat 3) (c : ℝ) (hX : Stationary (Matrix.diagonal s) X c) :
    ∃ x : Fin 3 → ℝ, X = Matrix.diagonal x ∧
      |∏ i, x i| = 1 ∧ ∀ i, (x i) ^ 2 - s i * x i + c = 0 := by sorry

theorem diagonal_unique_failure (s : Fin 3 → ℝ) (hs : SingularInterval s) :
    Failure (Matrix.diagonal s) := by sorry

theorem orbit_unique_failure (U : Mat 3) (hU : U ∈ counterexampleFamily) :
    Failure U := by sorry

theorem open_counterexample_family :
    counterexampleFamily.Nonempty ∧ IsOpen counterexampleFamily := by sorry

theorem avoids_every_proper_algebraic_exception
    (p : MvPolynomial (Fin 3 × Fin 3) ℝ) (hp : p ≠ 0) :
    ∃ U : Mat 3, U ∈ counterexampleFamily ∧ evalData p U ≠ 0 := by sorry

theorem generic_counterexample (p : MvPolynomial (Fin 3 × Fin 3) ℝ) (hp : p ≠ 0) :
    ∃ U : Mat 3, evalData p U ≠ 0 ∧ Failure U := by sorry

theorem not_generic_smallest_multiplier :
    ¬ GenericSmallestMultiplierConjecture := by sorry

end NLA.SP04
