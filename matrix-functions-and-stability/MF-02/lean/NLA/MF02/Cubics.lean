/- Chen–Chow cubic construction as exposed in Stepaniants MF-02 §3.
Exact factorizations replace derivative analysis and interval enumeration. -/
import NLA.MF02.Errors
set_option autoImplicit false
set_option maxHeartbeats 2000000
open Polynomial
noncomputable section
namespace NLA.MF02

def critical (a : ℝ) : ℝ := Real.sqrt ((1+a+a^2)/3)
def peak (a : ℝ) : ℝ := 2*(critical a)^3
def nextGap (a : ℝ) : ℝ := a*(1+a)/peak a
def optimalCubic (a : ℝ) : ℝ[X] := cubic ((1+a+a^2)/peak a) (-1/peak a)

lemma critical_props (a : ℝ) (ha : 0 < a) (ha1 : a < 1) :
    0 < critical a ∧ (critical a)^2 = (1+a+a^2)/3 ∧
    a < critical a ∧ critical a < 1 := by
  have hA : 0 < (1+a+a^2)/3 := by positivity
  have hs : 0 < critical a := Real.sqrt_pos.mpr hA
  have he : (critical a)^2 = (1+a+a^2)/3 := Real.sq_sqrt hA.le
  have hleft := mul_pos (sub_pos.mpr ha1) (by linarith : 0 < 1+2*a)
  have hright := mul_pos (sub_pos.mpr ha1) (by linarith : 0 < a+2)
  exact ⟨hs,he,by nlinarith,by nlinarith⟩

lemma peak_pos (a : ℝ) (ha : 0 < a) (ha1 : a < 1) : 0 < peak a := by
  unfold peak
  exact mul_pos (by norm_num) (pow_pos (critical_props a ha ha1).1 3)

lemma peak_identity (a : ℝ) (ha : 0 < a) (ha1 : a < 1) :
    27*(peak a)^2 = 4*(1+a+a^2)^3 := by
  have h := (critical_props a ha ha1).2.1
  have hh : 3*(critical a)^2 = 1+a+a^2 := by linarith
  rw [← hh]
  unfold peak
  ring

lemma numerator_peak (a x : ℝ) (ha : 0 < a) (ha1 : a < 1) :
    peak a-x*(1+a+a^2-x^2) = (x-critical a)^2*(x+2*critical a) := by
  have h := (critical_props a ha ha1).2.1
  have hh : 1+a+a^2 = 3*(critical a)^2 := by linarith
  rw [hh]; unfold peak; ring

lemma nextGap_props (a : ℝ) (ha : 0 < a) (ha1 : a < 1) :
    0 < nextGap a ∧ nextGap a < 1 := by
  have hp := peak_pos a ha ha1
  have hs := critical_props a ha ha1
  have he : critical a*(1+a+a^2-(critical a)^2)-a*(1+a) =
      (critical a-a)*(1-critical a)*(critical a+1+a) := by ring
  have hpos : 0 < (critical a-a)*(1-critical a)*(critical a+1+a) :=
    mul_pos (mul_pos (sub_pos.mpr hs.2.2.1) (sub_pos.mpr hs.2.2.2)) (by linarith [hs.1])
  have hpeak : critical a*(1+a+a^2-(critical a)^2) = peak a := by
    have h := numerator_peak a (critical a) ha ha1
    simp only [sub_self,zero_pow (by decide : 2 ≠ 0),zero_mul] at h
    linarith
  unfold nextGap
  exact ⟨div_pos (mul_pos ha (by linarith)) hp,(div_lt_one hp).mpr (by linarith)⟩

lemma optimalCubic_eval (a x : ℝ) :
    (optimalCubic a).eval x = x*(1+a+a^2-x^2)/peak a := by
  simp [optimalCubic,cubic]
  ring

lemma optimalCubic_interval (a x : ℝ) (ha : 0 < a) (ha1 : a < 1)
    (hx : a ≤ x) (hx1 : x ≤ 1) :
    nextGap a ≤ (optimalCubic a).eval x ∧ (optimalCubic a).eval x ≤ 1 := by
  have hp := peak_pos a ha ha1
  have hs := (critical_props a ha ha1).1
  have hl : 0 ≤ (x-a)*(1-x)*(x+1+a) :=
    mul_nonneg (mul_nonneg (sub_nonneg.mpr hx) (sub_nonneg.mpr hx1)) (by linarith)
  have hu : 0 ≤ (x-critical a)^2*(x+2*critical a) :=
    mul_nonneg (sq_nonneg _) (by linarith)
  have hi := numerator_peak a x ha ha1
  rw [optimalCubic_eval]
  constructor
  · unfold nextGap
    apply (div_le_div_iff_of_pos_right hp).mpr
    nlinarith only [hl]
  · apply (div_le_one hp).mpr
    linarith only [hu,hi]

lemma nextGap_ratio (a : ℝ) (ha : 0 < a) (ha1 : a < 1) :
    gapRatio (nextGap a) ≤ (gapRatio a)^2 := by
  have hp := peak_pos a ha ha1
  have hn := nextGap_props a ha ha1
  have hpeak := peak_identity a ha ha1
  have hfactor : 27*(1+a)^2*(1+a^2)^2-16*(1+a+a^2)^3 =
      (1-a)^2*(11*a^4+28*a^3+30*a^2+28*a+11) := by ring
  have hnonneg : 0 ≤ (1-a)^2*(11*a^4+28*a^3+30*a^2+28*a+11) := by positivity
  have hroot : 2*peak a ≤ (1+a)*(1+a^2) := by
    have hr : 0 < (1+a)*(1+a^2) := by positivity
    nlinarith only [hpeak,hfactor,hnonneg,hp,hr]
  have hnext : 2*a/(1+a^2) ≤ nextGap a := by
    unfold nextGap
    apply (div_le_div_iff₀ (by positivity) hp).mpr
    nlinarith only [mul_nonneg ha.le (sub_nonneg.mpr hroot)]
  unfold gapRatio
  have hden : 0 < 1+nextGap a := by linarith [hn.1]
  have hdena : 0 < 1+a := by linarith
  apply (div_le_iff₀ hden).mpr
  rw [div_pow]
  rw [div_mul_eq_mul_div]
  apply (le_div_iff₀ (pow_pos hdena 2)).mpr
  have hh := (div_le_iff₀ (by positivity : 0 < 1+a^2)).mp hnext
  nlinarith only [hh]

end NLA.MF02
