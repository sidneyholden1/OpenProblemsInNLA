import NLA.IE04.GaussianModel
import NLA.IE04.GaussianBounds
set_option autoImplicit false
set_option backward.isDefEq.respectTransparency false
noncomputable section
open scoped BigOperators NNReal
open MeasureTheory ProbabilityTheory
namespace NLA.IE04
lemma gaussian_interval_lower (a r : ℝ) (hr : 0 ≤ r)
    (ha : -2 ≤ a-r) (hb : a+r ≤ 2) :
    r / 16 ≤ (gaussianReal 0 1).real (Set.Icc (a-r) (a+r)) := by
  have hi : IntegrableOn (fun _ : ℝ => (1/32 : ℝ)) (Set.Icc (a-r) (a+r)) :=
    integrableOn_const (ne_of_lt measure_Icc_lt_top)
  have hm := setIntegral_mono_on hi (integrable_gaussianPDFReal 0 1).integrableOn
    measurableSet_Icc (fun x hx => (gaussian_density_lower_proved x ⟨le_trans ha hx.1, le_trans hx.2 hb⟩).le)
  have hab : a-r ≤ a+r := by linarith
  have hc : (∫ _x in Set.Icc (a-r) (a+r), (1/32 : ℝ)) = r/16 := by
    rw [setIntegral_const, Real.volume_real_Icc_of_le hab]
    simp only [smul_eq_mul]
    ring
  rw [hc] at hm
  rw [Measure.real, gaussianReal_apply_eq_integral 0 (by norm_num : (1 : ℝ≥0) ≠ 0),
    ENNReal.toReal_ofReal (integral_nonneg (fun x => gaussianPDFReal_nonneg 0 1 x))]
  exact hm
end NLA.IE04
