import NLA.IE04.Consequences
import NLA.IE04.GaussianProduct
import NLA.IE04.Asymptotic

/-! The actual Gaussian box event violates every candidate exponential-tail
bound. Mathematical argument: George Stepaniants; formalization by Sidney
Holden with Codex assistance. -/
set_option autoImplicit false
noncomputable section
open MeasureTheory ProbabilityTheory
namespace NLA.IE04

lemma gaussian_tail_lower_proved (n : ℕ) (hn : 2 ≤ n) :
    Real.rpow 2 (-(exponentCost n : ℝ)) ≤
      tailProbability (1 : Mat n) 1 (highGrowth n/2) :=
  (gaussian_box_lower_proved n hn).2.trans (tailProbability_ge_box n hn)

lemma every_pair_violated_proved (c₁ c₂ : ℝ) (h₁ : 0 < c₁) (h₂ : 0 < c₂) :
    ∃ n : ℕ, 2 ≤ n ∧ spectralNorm (1 : Mat n) = 1 ∧ 1 ≤ threshold n c₁ ∧
      Real.rpow 2 (-c₂ * threshold n c₁) <
        tailProbability (1 : Mat n) 1 (threshold n c₁ * Real.rpow n c₁) := by
  obtain ⟨N,hN⟩ := asymptotic_escape_proved c₁ c₂ h₁ h₂
  have hn := hN N le_rfl
  refine ⟨N,hn.1,spectralNorm_one_proved N (by omega),hn.2.1,?_⟩
  rw [threshold_cancel N (by omega)]
  have hexp : -c₂*threshold N c₁ < -(exponentCost N:ℝ) := by linarith [hn.2.2]
  exact (Real.rpow_lt_rpow_of_exponent_lt (by norm_num : (1:ℝ)<2) hexp).trans_le
    (gaussian_tail_lower_proved N hn.1)

lemma not_exponentialTailConjecture_proved : ¬ExponentialTailConjecture := by
  rintro ⟨c₁,c₂,h₁,h₂,hbound⟩
  obtain ⟨n,hn,hnorm,hx,hbad⟩ := every_pair_violated_proved c₁ c₂ h₁ h₂
  have hh := hbound n (by omega) (1:Mat n) hnorm.le 1 (by norm_num) le_rfl
    (threshold n c₁) hx
  apply not_le_of_gt hbad
  simpa only [div_one] using hh

end NLA.IE04
