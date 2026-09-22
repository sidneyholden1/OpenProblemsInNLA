import Mathlib
import NLA.IE04.Definitions
import LeanCert.Tactic.IntervalAuto.PointIneq
set_option autoImplicit false
set_option leancert.trust "kernel"
noncomputable section
open ProbabilityTheory
namespace NLA.IE04

/-- A single exact point certificate, consumed by the full interval density bound. -/
lemma exp_neg_two_lower : (1:ℝ)/8 < Real.exp (-2) := by
  interval_decide

lemma gaussian_density_lower_proved (x : ℝ) (hx : x ∈ Set.Icc (-2:ℝ) 2) :
    (1/32:ℝ) < gaussianPDFReal 0 1 x := by
  have hs0 : 0 < Real.sqrt (2*Real.pi) := Real.sqrt_pos.mpr (by positivity)
  have hs3 : Real.sqrt (2*Real.pi) < 3 := by
    apply (Real.sqrt_lt' (by norm_num : (0:ℝ)<3)).mpr
    nlinarith [Real.pi_lt_four]
  have hx2 : x^2 ≤ 4 := by nlinarith [hx.1,hx.2, mul_nonneg (sub_nonneg.mpr hx.2) (sub_nonneg.mpr hx.1)]
  have hex : (1:ℝ)/8 < Real.exp (-(x^2)/2) :=
    lt_of_lt_of_le exp_neg_two_lower (Real.exp_le_exp.mpr (by linarith))
  rw [gaussianPDFReal_def]
  norm_num only [NNReal.coe_one, mul_one, sub_zero]
  have h : (1:ℝ)/32 * Real.sqrt (2*Real.pi) < Real.exp (-(x^2)/2) := by nlinarith
  calc
    (1:ℝ)/32 < Real.exp (-(x^2)/2) / Real.sqrt (2*Real.pi) := (lt_div_iff₀ hs0).mpr h
    _ = _ := by ring

end NLA.IE04
