import NLA.MI03.Definitions
set_option autoImplicit false
open scoped BigOperators Classical ComplexOrder MatrixOrder Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MI03

/-- All dimensions, including singular and non-Hermitian summands. -/
theorem upper_bound (k : ℕ) (hk : 2 ≤ k) : admissible k ((k : ℝ) / 4) := by sorry

/-- Actual dimension-two complex contractions attain the exact matrix gap. -/
theorem sharpness (k : ℕ) (hk : 2 ≤ k) :
    ∃ A : Fin k → Matrix (Fin 2) (Fin 2) ℂ,
      (∀ j, ‖A j‖ ≤ 1) ∧ modulus (∑ j, A j) - ∑ j, modulus (A j) = sharpGap k := by sorry

/-- Genuine nonempty bounded infima equal the sharp constant for all k≥2. -/
theorem sharp_constant (k : ℕ) (hk : 2 ≤ k) :
    {c : ℝ | admissible k c}.Nonempty ∧ BddBelow {c : ℝ | admissible k c} ∧
      bestConstant k = (k : ℝ) / 4 := by sorry

/-- The complete original target. -/
theorem odd_sharp_constant : oddSharpConstantConjecture := by sorry
end NLA.MI03
