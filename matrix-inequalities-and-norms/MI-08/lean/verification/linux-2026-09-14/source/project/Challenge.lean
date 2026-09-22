import NLA.MI08.Definitions
set_option autoImplicit false
open scoped BigOperators Matrix
noncomputable section
namespace NLA.MI08

theorem fixed_sign_equivalence (d q : ℕ) (hd : 0 < d) (hq : 0 < q) :
    (∃ U : Fin q → Mat d, FixedPinching U) ↔
    ∃ H : Matrix (Fin q) (Fin d) ℤ, SignDesign H := by sorry

theorem design_obstructions (d q : ℕ) (hq : 0 < q)
    (H : Matrix (Fin q) (Fin d) ℤ) (hH : SignDesign H) :
    d ≤ q ∧ (3 ≤ d → 4 ∣ q) := by sorry

theorem hadamard_twelve : SignDesign hadamardTwelve ∧ (0 : ℝ) < 12 := by sorry

theorem finite_minimums (d : ℕ) (hlo : 9 ≤ d) (hhi : d ≤ 12) :
    (pinchingLengths d).Nonempty ∧ IsLeast (pinchingLengths d) 12 ∧ phi d = 12 := by sorry
end NLA.MI08
