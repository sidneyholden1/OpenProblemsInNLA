/- Full arbitrary-real exponent construction, with all word lengths and actual norm. -/
import NLA.MF12.WordBounds
import NLA.MF12.WordLower
import NLA.MF12.IntegerLift
set_option autoImplicit false
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF12
lemma fractional_pairBounds (α : ℝ) (ha : 0<α) (ha1 : α<1) :
    PairBounds (seed (fractionalParameter α)) reset α := by
  obtain ⟨c,hc,hl⟩ := fractional_lower α ha ha1
  obtain ⟨C,hC,hu⟩ := fractional_upper α ha ha1
  refine ⟨c,c+C,hc,by linarith,?_,hl⟩
  intro w hw
  exact (hu w hw).trans (mul_le_mul_of_nonneg_right (by linarith) (Real.rpow_nonneg (by positivity) _))

lemma fractional_growth_proved (α : ℝ) (ha : 0<α) (ha1 : α<1) :
    RealizesExponent ({seed (fractionalParameter α),reset}:Set (Mat 6)) α :=
  realizes_of_pairBounds _ _ _ (fractional_pairBounds α ha ha1)

lemma arbitrary_pair_proved (γ : ℝ) (hγ : 0≤γ) :
    ∃ d : ℕ,1≤d ∧ ∃ A B : Mat d,A≠B ∧ RealizesExponent ({A,B}:Set (Mat d)) γ :=
  arbitrary_pair_from_fractional fractional_pairBounds γ hγ

lemma original_target_proved (γ : ℝ) (hγ : 0≤γ) :
    ∃ d : ℕ,1≤d ∧ ∃ M : Set (Mat d),RealizesExponent M γ := by
  obtain ⟨d,hd,A,B,_,h⟩ := arbitrary_pair_proved γ hγ
  exact ⟨d,hd,{A,B},h⟩
end NLA.MF12
