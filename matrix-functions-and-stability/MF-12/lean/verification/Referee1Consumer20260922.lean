/- Independent consumer: exact four frozen Challenge signatures, supplied by Solution. -/
import Solution
import LeanCert.Tactic.Verification
set_option autoImplicit false
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF12

example (μ : ℝ) (q : ℕ) :
    compressU * seed μ ^ q * embedV =
      !![1-(q : ℝ)*(1/4 : ℝ)^q, (q : ℝ)*μ^q; 0, 1] := by exact NLA.MF12.compressed_powers μ q

example (α : ℝ) (hα0 : 0 < α) (hα1 : α < 1) :
    RealizesExponent ({seed (fractionalParameter α), reset} : Set (Mat 6)) α := by exact NLA.MF12.fractional_growth α hα0 hα1

example (γ : ℝ) (hγ : 0 ≤ γ) :
    ∃ d : ℕ, 1 ≤ d ∧ ∃ A B : Mat d, A ≠ B ∧
      RealizesExponent ({A,B} : Set (Mat d)) γ := by exact NLA.MF12.arbitrary_pair γ hγ

example (γ : ℝ) (hγ : 0 ≤ γ) :
    ∃ d : ℕ, 1 ≤ d ∧ ∃ M : Set (Mat d), RealizesExponent M γ := by exact NLA.MF12.original_target γ hγ
end NLA.MF12

#print axioms NLA.MF12.compressed_powers
#assert_trust kernel NLA.MF12.compressed_powers
#print axioms NLA.MF12.fractional_growth
#assert_trust kernel NLA.MF12.fractional_growth
#print axioms NLA.MF12.arbitrary_pair
#assert_trust kernel NLA.MF12.arbitrary_pair
#print axioms NLA.MF12.original_target
#assert_trust kernel NLA.MF12.original_target
