import NLA.IE04.Robustness
import NLA.IE04.GaussianModel

/-! Exact deterministic and measure-order bridges used in the final tail
counterexample. Mathematical source: George Stepaniants. -/
set_option autoImplicit false
set_option backward.isDefEq.respectTransparency false
noncomputable section
open MeasureTheory ProbabilityTheory
namespace NLA.IE04

lemma spectralNorm_one_proved (n : ℕ) (hn : 1 ≤ n) : spectralNorm (1 : Mat n) = 1 := by
  let : Nonempty (Fin n) := ⟨⟨0,by omega⟩⟩
  unfold spectralNorm
  rw [map_one, norm_one]

lemma threshold_cancel (n : ℕ) (hn : 1 ≤ n) (c₁ : ℝ) :
    threshold n c₁ * Real.rpow n c₁ = highGrowth n/2 := by
  have hp : Real.rpow (n:ℝ) c₁ ≠ 0 := ne_of_gt (Real.rpow_pos_of_pos (by exact_mod_cast hn) _)
  unfold threshold
  field_simp

lemma noiseBox_subset_tail (n : ℕ) (hn : 2 ≤ n) :
    noiseBox n ⊆ tailEvent (1 : Mat n) 1 (highGrowth n/2) := by
  intro G hG
  have h := full_box_robustness_proved n hn (perturb (1:Mat n) 1 G) hG
  exact ⟨h.1,h.2.2.2.2.2⟩

lemma tailProbability_ge_box (n : ℕ) (hn : 2 ≤ n) :
    (gaussianMatrix n).real (noiseBox n) ≤ tailProbability (1 : Mat n) 1 (highGrowth n/2) := by
  exact measureReal_mono (noiseBox_subset_tail n hn)

end NLA.IE04
