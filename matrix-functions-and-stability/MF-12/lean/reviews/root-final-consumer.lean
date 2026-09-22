/- Trusted statement boundary; four intentional placeholders, no proof claim. -/
import Solution
set_option autoImplicit false
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF12.RootFinalReview

theorem compressed_powers (μ : ℝ) (q : ℕ) :
    compressU * seed μ ^ q * embedV =
      !![1-(q : ℝ)*(1/4 : ℝ)^q, (q : ℝ)*μ^q; 0, 1] := by exact NLA.MF12.compressed_powers μ q

theorem fractional_growth (α : ℝ) (hα0 : 0 < α) (hα1 : α < 1) :
    RealizesExponent ({seed (fractionalParameter α), reset} : Set (Mat 6)) α := by exact NLA.MF12.fractional_growth α hα0 hα1

theorem arbitrary_pair (γ : ℝ) (hγ : 0 ≤ γ) :
    ∃ d : ℕ, 1 ≤ d ∧ ∃ A B : Mat d, A ≠ B ∧
      RealizesExponent ({A,B} : Set (Mat d)) γ := by exact NLA.MF12.arbitrary_pair γ hγ

theorem original_target (γ : ℝ) (hγ : 0 ≤ γ) :
    ∃ d : ℕ, 1 ≤ d ∧ ∃ M : Set (Mat d), RealizesExponent M γ := by exact NLA.MF12.original_target γ hγ
#assert_trust kernel compressed_powers
#print axioms compressed_powers
#assert_trust kernel fractional_growth
#print axioms fractional_growth
#assert_trust kernel arbitrary_pair
#print axioms arbitrary_pair
#assert_trust kernel original_target
#print axioms original_target
end NLA.MF12.RootFinalReview
