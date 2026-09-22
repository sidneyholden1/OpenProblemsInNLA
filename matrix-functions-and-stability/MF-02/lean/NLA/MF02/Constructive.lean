import NLA.MF02.Cubics
import NLA.MF02.ProgramCosts
set_option autoImplicit false
set_option maxHeartbeats 2000000
open Polynomial
noncomputable section
namespace NLA.MF02

lemma gapRatio_props (a : ℝ) (ha : 0 < a) (ha1 : a < 1) :
    0 < gapRatio a ∧ gapRatio a < 1 := by
  unfold gapRatio
  have hd : 0 < 1+a := by linarith
  exact ⟨div_pos (by linarith) hd,(div_lt_one hd).mpr (by linarith)⟩

lemma gapRatio_involutive (a : ℝ) (ha : 0 < a) : gapRatio (gapRatio a) = a := by
  unfold gapRatio
  have h : 1+a ≠ 0 := by linarith
  field_simp
  <;> ring

lemma cubic_eval_odd (a b x : ℝ) : (cubic a b).eval (-x) = -(cubic a b).eval x := by
  simp [cubic]; ring

lemma composeCubics_odd (cs : List (ℝ × ℝ)) (x : ℝ) :
    (composeCubics cs).eval (-x) = -(composeCubics cs).eval x := by
  induction cs generalizing x with
  | nil => simp [composeCubics]
  | cons ab cs ih =>
    simp only [composeCubics,eval_comp,cubic_eval_odd]
    exact ih _

lemma composeCubics_append (cs : List (ℝ × ℝ)) (a b : ℝ) :
    composeCubics (cs++[(a,b)]) = (cubic a b).comp (composeCubics cs) := by
  induction cs with
  | nil => simp [composeCubics]
  | cons cd cs ih => simp [composeCubics,ih,comp_assoc]

lemma error_le_positive (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (p : ℝ[X]) (hodd : ∀ x, p.eval (-x) = -p.eval x) (e : ℝ)
    (h : ∀ x ∈ Set.Icc δ 1, |p.eval x-1| ≤ e) : uniformError δ p ≤ e := by
  apply error_le δ hδ1 p e
  intro x hx
  rcases hx with hx | hx
  · have hn : -x ∈ Set.Icc δ 1 := ⟨by linarith [hx.2],by linarith [hx.1]⟩
    have hh := h (-x) hn
    rw [hodd] at hh
    have he : -p.eval x-1 = -(p.eval x+1) := by ring
    rw [he,abs_neg] at hh
    simpa [targetSign,show x < 0 by linarith [hx.2]] using hh
  · simpa [targetSign,show ¬x < 0 by linarith [hx.1]] using h x hx

lemma centered_interval (a x : ℝ) (ha : 0 < a) (ha1 : a < 1)
    (hx : a ≤ x) (hx1 : x ≤ 1) : |2*x/(1+a)-1| ≤ gapRatio a := by
  have hd : 0 < 1+a := by linarith
  unfold gapRatio
  rw [abs_le]
  constructor
  · apply (mul_le_mul_iff_left₀ hd).mp
    field_simp
    nlinarith
  · apply (mul_le_mul_iff_left₀ hd).mp
    field_simp
    nlinarith

def scaledCoeffs (a s t : ℝ) : ℝ × ℝ :=
  (t*((1+a+a^2)/peak a)*s, t*(-1/peak a)*s^3)

lemma scaledCubic_eval (a s t x : ℝ) :
    (cubic (scaledCoeffs a s t).1 (scaledCoeffs a s t).2).eval x =
      t*(optimalCubic a).eval (s*x) := by
  simp [scaledCoeffs,optimalCubic,cubic]
  ring

lemma centered_optimal_bound (a x : ℝ) (ha : 0 < a) (ha1 : a < 1)
    (hx : a ≤ x) (hx1 : x ≤ 1) :
    |(2/(1+nextGap a))*(optimalCubic a).eval x-1| ≤ (gapRatio a)^2 := by
  have hn := nextGap_props a ha ha1
  have hi := optimalCubic_interval a x ha ha1 hx hx1
  have hc := centered_interval (nextGap a) ((optimalCubic a).eval x) hn.1 hn.2 hi.1 hi.2
  have he : 2/(1+nextGap a)*(optimalCubic a).eval x = 2*(optimalCubic a).eval x/(1+nextGap a) := by ring
  rw [he]
  exact hc.trans (nextGap_ratio a ha ha1)

lemma one_stage_exists (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) :
    ∃ cs : List (ℝ × ℝ), cs.length = 1 ∧
      uniformError δ (composeCubics cs) ≤ (gapRatio δ)^2 := by
  let ab := scaledCoeffs δ 1 (2/(1+nextGap δ))
  refine ⟨[ab],rfl,?_⟩
  apply error_le_positive δ hδ hδ1 _ (composeCubics_odd _) _
  intro x hx
  simp only [composeCubics,Polynomial.X_comp]
  rw [scaledCubic_eval]
  simpa using centered_optimal_bound δ x hδ hδ1 hx.1 hx.2

lemma append_improves (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (cs : List (ℝ × ℝ)) (he0 : 0 < uniformError δ (composeCubics cs))
    (he1 : uniformError δ (composeCubics cs) < 1) :
    ∃ ds : List (ℝ × ℝ), ds.length = cs.length+1 ∧
      uniformError δ (composeCubics ds) ≤ (uniformError δ (composeCubics cs))^2 := by
  let e := uniformError δ (composeCubics cs)
  let a := gapRatio e
  have ha := gapRatio_props e he0 he1
  let ab := scaledCoeffs a (1/(1+e)) (2/(1+nextGap a))
  refine ⟨cs++[ab],by simp,?_⟩
  apply error_le_positive δ hδ hδ1 _ (composeCubics_odd _) _
  intro x hx
  have herr := point_error_le δ hδ (composeCubics cs) x (Or.inr hx)
  have hxpos : ¬x < 0 := by linarith [hx.1]
  simp only [targetSign,if_neg hxpos] at herr
  change |(composeCubics cs).eval x-1| ≤ e at herr
  have hd : 0 < 1+e := by linarith
  have hlo : a ≤ (composeCubics cs).eval x/(1+e) := by
    unfold a gapRatio
    exact (div_le_div_iff_of_pos_right hd).mpr (by linarith [(abs_le.mp herr).1])
  have hhi : (composeCubics cs).eval x/(1+e) ≤ 1 :=
    (div_le_one hd).mpr (by linarith [(abs_le.mp herr).2])
  rw [composeCubics_append,eval_comp,scaledCubic_eval]
  have hb := centered_optimal_bound a ((composeCubics cs).eval x/(1+e)) ha.1 ha.2 hlo hhi
  have he : gapRatio a = e := gapRatio_involutive e he0
  rw [he] at hb
  simpa only [one_div,div_eq_mul_inv,one_mul,mul_comm] using hb

end NLA.MF02
