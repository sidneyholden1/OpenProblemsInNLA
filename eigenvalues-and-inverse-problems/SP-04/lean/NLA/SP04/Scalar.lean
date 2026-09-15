/- Copyright (c) 2026 Sidney Holden. Released under Apache 2.0.
AI-assisted formalization of Matthew J. Colbrook's SP-04 scalar argument.
Exact quadratic inequalities avoid interval subdivision. -/
import NLA.SP04.Definitions
import NLA.SP04.MatrixReduction
import LeanCert.Tactic.IntervalAuto.PointIneq
set_option autoImplicit false
set_option leancert.trust "kernel"
noncomputable section
open scoped BigOperators Classical
namespace NLA.SP04

lemma low_product_margin : (3/10 : ℝ) * (44/25)^2 < 1 := by
  interval_decide

lemma high_product_margin : (2/5 : ℝ) * (3/2)^2 < 1 := by
  interval_decide

lemma quadratic_root_positive {s c x : ℝ} (hs : 0 < s) (hc : 0 ≤ c)
    (hx : x ≠ 0) (he : x ^ 2 - s * x + c = 0) : 0 < x := by
  by_contra hn
  have hxn : x < 0 := lt_of_le_of_ne (le_of_not_gt hn) hx
  have := mul_pos hs (neg_pos.mpr hxn)
  nlinarith [sq_nonneg x]

lemma quadratic_root_upper {s c x B : ℝ} (_hx : 0 < x)
    (he : x ^ 2 - s * x + c = 0) (_hB : 0 < B)
    (hside : s < 2 * B) (hf : 0 < B ^ 2 - s * B + c) : x < B := by
  by_contra hn
  have hm := mul_nonneg (show 0 ≤ x-B by linarith)
    (show 0 ≤ x+B-s by linarith)
  nlinarith

lemma quadratic_root_gap {s c x a : ℝ}
    (he : x ^ 2 - s * x + c = 0) (_ha : a < 1)
    (hs : a + 1 < s) (hf : a ^ 2 - s * a + c < 0) : x < a ∨ 1 < x := by
  by_contra hn
  push Not at hn
  have hprod := mul_nonpos_of_nonneg_of_nonpos
    (show 0 ≤ x-a by linarith) (show x-1 ≤ 0 by linarith)
  have hlin := mul_nonneg (show 0 ≤ s-a-1 by linarith)
    (show 0 ≤ x-a by linarith)
  nlinarith

lemma triple_product_bound {x : Fin 3 → ℝ} {a B : ℝ}
    (hx : ∀ i, 0 < x i) (hB : ∀ i, x i < B)
    (ha : 0 < a) (hsmall : ∃ i, x i < a) : (∏ i, x i) < a * B ^ 2 := by
  have hb : 0 < B := lt_trans (hx 0) (hB 0)
  obtain ⟨i, hi⟩ := hsmall
  have pair (j k : Fin 3) : x j * x k < B * B :=
    mul_lt_mul (hB j) (hB k).le (hx k) hb.le
  have calc0 : x 0 * (x 1 * x 2) < a * (B * B) := by
    fin_cases i
    · exact mul_lt_mul hi (pair 1 2).le (mul_pos (hx 1) (hx 2)) ha.le
    · change x 1 < a at hi
      have hh := mul_lt_mul hi (pair 0 2).le (mul_pos (hx 0) (hx 2)) ha.le
      simpa only [mul_comm, mul_left_comm, mul_assoc] using hh
    · change x 2 < a at hi
      have hh := mul_lt_mul hi (pair 0 1).le (mul_pos (hx 0) (hx 1)) ha.le
      simpa only [mul_comm, mul_left_comm, mul_assoc] using hh
  simpa [Fin.prod_univ_succ, pow_two, mul_assoc] using calc0

lemma positive_multiplier_exclusion_proved (s : Fin 3 → ℝ) (hs : SingularInterval s)
    (c : ℝ) (hc : 0 ≤ c ∧ c ≤ (13 : ℝ) / 25) :
    ¬ ∃ x : Fin 3 → ℝ, |∏ i, x i| = 1 ∧
      ∀ i, (x i) ^ 2 - s i * x i + c = 0 := by
  rintro ⟨x, hprod, he⟩
  have hn : ∀ i, x i ≠ 0 := by
    have h : (∏ i, x i) ≠ 0 := by intro hz; simp [hz] at hprod
    intro i
    exact Finset.prod_ne_zero_iff.mp h i (Finset.mem_univ i)
  have hx : ∀ i, 0 < x i := fun i => quadratic_root_positive
    (by have := (hs.1 i).1; linarith) hc.1 (hn i) (he i)
  have hp : (∏ i, x i) = 1 := by
    rw [abs_of_pos (Finset.prod_pos fun i _ => hx i)] at hprod
    exact hprod
  have not_all_large : ¬ (∀ i, 1 < x i) := by
    intro h
    have h0 := h 0
    have h1 := h 1
    have h2 := h 2
    have h01 : 1 < x 0 * x 1 := by nlinarith [mul_pos (by linarith : 0 < x 0-1) (by linarith : 0 < x 1-1)]
    have h012 : 1 < x 0 * x 1 * x 2 := by nlinarith [mul_pos (by linarith : 0 < x 0*x 1-1) (by linarith : 0 < x 2-1)]
    simp [Fin.prod_univ_succ] at hp
    nlinarith
  -- Two exact ranges avoid estimating square-root differences.
  by_cases hlow : c ≤ (2 : ℝ)/5
  · have hb : ∀ i, x i < (44 : ℝ)/25 := by
      intro i
      apply quadratic_root_upper (hx i) (he i) (by norm_num)
      · have := (hs.1 i).2; linarith
      · have := (hs.1 i).2; nlinarith [hc.1]
    have hg : ∀ i, x i < (3 : ℝ)/10 ∨ 1 < x i := by
      intro i
      apply quadratic_root_gap (he i) (by norm_num)
      · have := (hs.1 i).1; linarith
      · have := (hs.1 i).1; nlinarith
    have hsmall : ∃ i, x i < (3 : ℝ)/10 := by
      by_contra hn
      push Not at hn
      exact not_all_large fun i => (hg i).resolve_left (not_lt.mpr (hn i))
    have hh := triple_product_bound hx hb (by norm_num : (0:ℝ)<3/10) hsmall
    rw [hp] at hh
    exact lt_asymm hh low_product_margin
  · have hb : ∀ i, x i < (3 : ℝ)/2 := by
      intro i
      apply quadratic_root_upper (hx i) (he i) (by norm_num)
      · have := (hs.1 i).2; linarith
      · have := (hs.1 i).2; nlinarith
    have hg : ∀ i, x i < (2 : ℝ)/5 ∨ 1 < x i := by
      intro i
      apply quadratic_root_gap (he i) (by norm_num)
      · have := (hs.1 i).1; linarith
      · have := (hs.1 i).1; nlinarith [hc.2]
    have hsmall : ∃ i, x i < (2 : ℝ)/5 := by
      by_contra hn
      push Not at hn
      exact not_all_large fun i => (hg i).resolve_left (not_lt.mpr (hn i))
    have hh := triple_product_bound hx hb (by norm_num : (0:ℝ)<2/5) hsmall
    rw [hp] at hh
    exact lt_asymm hh high_product_margin

/-- Magnitude of the negative root when the multiplier is `-t`. -/
def negativeMagnitude (s t : ℝ) : ℝ := (Real.sqrt (s ^ 2 + 4*t) - s) / 2

lemma negative_root_data {s t : ℝ} (hs : 0 < s) (ht : 0 ≤ t) :
    0 < largeNegativeMultiplierRoot s t ∧ 0 ≤ negativeMagnitude s t ∧
    largeNegativeMultiplierRoot s t * negativeMagnitude s t = t ∧
    t / largeNegativeMultiplierRoot s t = negativeMagnitude s t := by
  have hsq := Real.sq_sqrt (show 0 ≤ s^2+4*t by positivity)
  have hn := Real.sqrt_nonneg (s^2+4*t)
  have hle : s ≤ Real.sqrt (s^2+4*t) := by nlinarith
  have ha : 0 < largeNegativeMultiplierRoot s t := by unfold largeNegativeMultiplierRoot; positivity
  have hb : 0 ≤ negativeMagnitude s t := by unfold negativeMagnitude; linarith
  have hab : largeNegativeMultiplierRoot s t * negativeMagnitude s t = t := by
    unfold largeNegativeMultiplierRoot negativeMagnitude
    nlinarith
  refine ⟨ha,hb,hab, ?_⟩
  apply (div_eq_iff (ne_of_gt ha)).mpr
  nlinarith [hab]

lemma negative_roots_strict {s t u : ℝ} (ht : 0 ≤ t) (htu : t < u) :
    largeNegativeMultiplierRoot s t < largeNegativeMultiplierRoot s u ∧
    negativeMagnitude s t < negativeMagnitude s u := by
  have h := Real.sqrt_lt_sqrt (show 0 ≤ s^2+4*t by positivity)
    (show s^2+4*t < s^2+4*u by linarith)
  unfold largeNegativeMultiplierRoot negativeMagnitude
  constructor <;> linarith

lemma selected_product_strict (s : Fin 3 → ℝ) (hs : ∀ i, 0 < s i) :
    StrictMonoOn (selectedProduct s) (Set.Ici 0) := by
  intro t ht u hu htu
  have h0 := negative_root_data (hs 0) ht
  have h1 := negative_root_data (hs 1) ht
  have h2 := negative_root_data (hs 2) ht
  have hu0 := negative_root_data (hs 0) hu
  have hlt0 := (negative_roots_strict (s := s 0) ht htu).2
  have hlt1 := (negative_roots_strict (s := s 1) ht htu).1
  have hlt2 := (negative_roots_strict (s := s 2) ht htu).1
  unfold selectedProduct
  rw [h0.2.2.2,hu0.2.2.2]
  exact mul_lt_mul
    (mul_lt_mul hlt0 hlt1.le h1.1 hu0.2.1)
    hlt2.le h2.1 (mul_nonneg hu0.2.1 (by linarith [h1.1]))

lemma selected_product_continuous (s : Fin 3 → ℝ) (hs : ∀ i, 0 < s i) :
    ContinuousOn (selectedProduct s) (Set.Ici 0) := by
  have ha (i : Fin 3) : Continuous (largeNegativeMultiplierRoot (s i)) := by
    unfold largeNegativeMultiplierRoot
    fun_prop
  apply ContinuousOn.mul
  · apply ContinuousOn.mul
    · exact continuousOn_id.div (ha 0).continuousOn
        (fun t ht => ne_of_gt (negative_root_data (hs 0) ht).1)
    · exact (ha 1).continuousOn
  · exact (ha 2).continuousOn

lemma selected_product_zero (s : Fin 3 → ℝ) : selectedProduct s 0 = 0 := by
  simp [selectedProduct]

lemma selected_product_endpoint (s : Fin 3 → ℝ) (hs : SingularInterval s) :
    1 < selectedProduct s ((13:ℝ)/25) := by
  have ha (i : Fin 3) : 2 < largeNegativeMultiplierRoot (s i) ((13:ℝ)/25) := by
    have hh := (hs.1 i).1
    have hsq := Real.sq_sqrt (show 0 ≤ (s i)^2+4*((13:ℝ)/25) by positivity)
    have hn := Real.sqrt_nonneg ((s i)^2+4*((13:ℝ)/25))
    unfold largeNegativeMultiplierRoot
    nlinarith
  have hb : (1:ℝ)/4 < negativeMagnitude (s 0) ((13:ℝ)/25) := by
    have hh := (hs.1 0).2
    have hl := (hs.1 0).1
    have hsq := Real.sq_sqrt (show 0 ≤ (s 0)^2+4*((13:ℝ)/25) by positivity)
    have hn := Real.sqrt_nonneg ((s 0)^2+4*((13:ℝ)/25))
    unfold negativeMagnitude
    nlinarith
  have hz := negative_root_data (show 0 < s 0 by have := (hs.1 0).1; linarith)
    (by norm_num : (0:ℝ) ≤ 13/25)
  unfold selectedProduct
  rw [hz.2.2.2]
  have hp := mul_lt_mul hb (ha 1).le (by norm_num : (0:ℝ)<2) hz.2.1
  have hq := mul_lt_mul hp (ha 2).le (by norm_num : (0:ℝ)<2)
    (mul_nonneg hz.2.1 (by linarith [ha 1]))
  norm_num at hq ⊢
  exact hq

lemma selected_negative_root_proved (s : Fin 3 → ℝ) (hs : SingularInterval s) :
    ∃! t : ℝ, 0 < t ∧ t < (13 : ℝ) / 25 ∧ selectedProduct s t = 1 := by
  have hpos : ∀ i, 0 < s i := fun i => by have := (hs.1 i).1; linarith
  have hc := (selected_product_continuous s hpos).mono
    (show Set.Icc (0:ℝ) (13/25) ⊆ Set.Ici 0 from fun _ h => h.1)
  have he := selected_product_endpoint s hs
  obtain ⟨t, ht, hval⟩ := intermediate_value_Icc (by norm_num : (0:ℝ) ≤ 13/25) hc
    (show (1:ℝ) ∈ Set.Icc (selectedProduct s 0) (selectedProduct s (13/25)) by
      rw [selected_product_zero]; exact ⟨by norm_num, he.le⟩)
  have ht0 : 0 < t := by
    by_contra hn
    have : t = 0 := by linarith [ht.1]
    subst t
    simp [selected_product_zero] at hval
  have ht1 : t < (13:ℝ)/25 := by
    by_contra hn
    have : t = (13:ℝ)/25 := by linarith [ht.2]
    subst t
    linarith
  refine ⟨t, ⟨ht0,ht1,hval⟩, ?_⟩
  intro u hu
  exact (selected_product_strict s hpos).injOn hu.1.le ht0.le (hu.2.2.trans hval.symm)

/-- The eight exact sign patterns; every nonselected pattern forces a larger product. -/
lemma three_root_pattern {a b x : Fin 3 → ℝ}
    (ha : ∀ i, 1 < a i) (hb : ∀ i, 0 < b i ∧ b i < a i)
    (hab1 : a 0 * b 1 < b 0 * a 1) (hab2 : a 0 * b 2 < b 0 * a 2)
    (hx : ∀ i, x i = a i ∨ x i = -b i) (hp : |∏ i, x i| = 1) :
    x = ![-b 0, a 1, a 2] ∨ 1 < b 0 * a 1 * a 2 := by
  have ha0 : 0 < a 0 := lt_trans zero_lt_one (ha 0)
  have ha1 : 0 < a 1 := lt_trans zero_lt_one (ha 1)
  have ha2 : 0 < a 2 := lt_trans zero_lt_one (ha 2)
  have hb0 := (hb 0).1
  have hb1 := (hb 1).1
  have hb2 := (hb 2).1
  have hb1a := (hb 1).2
  have hb2a := (hb 2).2
  rcases hx 0 with h0 | h0 <;> rcases hx 1 with h1 | h1 <;> rcases hx 2 with h2 | h2
  · have h01 := mul_lt_mul (ha 0) (ha 1).le zero_lt_one ha0.le
    have h012 := mul_lt_mul h01 (ha 2).le zero_lt_one (mul_pos ha0 ha1).le
    simp [Fin.prod_univ_succ,h0,h1,h2,abs_mul,abs_of_pos ha0,abs_of_pos ha1,abs_of_pos ha2] at hp
    exfalso
    nlinarith [h012]
  · right
    have hh := mul_lt_mul_of_pos_right hab2 ha1
    simp [Fin.prod_univ_succ,h0,h1,h2,abs_mul,abs_of_pos ha0,abs_of_pos ha1,abs_of_pos hb2] at hp
    nlinarith [hh]
  · right
    have hh := mul_lt_mul_of_pos_right hab1 ha2
    simp [Fin.prod_univ_succ,h0,h1,h2,abs_mul,abs_of_pos ha0,abs_of_pos hb1,abs_of_pos ha2] at hp
    nlinarith [hh]
  · right
    have hh := mul_lt_mul hab1 hb2a.le hb2 (mul_pos hb0 ha1).le
    simp [Fin.prod_univ_succ,h0,h1,h2,abs_mul,abs_of_pos ha0,abs_of_pos hb1,abs_of_pos hb2] at hp
    nlinarith [hh]
  · left
    funext i
    fin_cases i <;> simp_all
  · right
    have hh := mul_lt_mul_of_pos_left hb2a (mul_pos hb0 ha1)
    simp [Fin.prod_univ_succ,h0,h1,h2,abs_mul,abs_of_pos hb0,abs_of_pos ha1,abs_of_pos hb2] at hp
    nlinarith [hh]
  · right
    have hh := mul_lt_mul_of_pos_right (mul_lt_mul_of_pos_left hb1a hb0) ha2
    simp [Fin.prod_univ_succ,h0,h1,h2,abs_mul,abs_of_pos hb0,abs_of_pos hb1,abs_of_pos ha2] at hp
    nlinarith [hh]
  · right
    have hh := mul_lt_mul (mul_lt_mul_of_pos_left hb1a hb0) hb2a.le hb2 (mul_pos hb0 ha1).le
    simp [Fin.prod_univ_succ,h0,h1,h2,abs_mul,abs_of_pos hb0,abs_of_pos hb1,abs_of_pos hb2] at hp
    nlinarith [hh]

lemma negative_root_identities {s t : ℝ} (hs : 0 < s) (ht : 0 < t) :
    largeNegativeMultiplierRoot s t - negativeMagnitude s t = s ∧
    0 < negativeMagnitude s t ∧
    (largeNegativeMultiplierRoot s t)^2 - s * largeNegativeMultiplierRoot s t - t = 0 ∧
    (-negativeMagnitude s t)^2 - s * (-negativeMagnitude s t) - t = 0 := by
  have hd := negative_root_data hs ht.le
  have hsub : largeNegativeMultiplierRoot s t - negativeMagnitude s t = s := by
    unfold largeNegativeMultiplierRoot negativeMagnitude
    ring
  have hb : 0 < negativeMagnitude s t := by nlinarith [hd.2.2.1]
  exact ⟨hsub,hb,by nlinarith [hd.2.2.1],by nlinarith [hd.2.2.1]⟩

lemma negative_root_classification {s t x : ℝ} (hs : 0 < s) (ht : 0 < t)
    (hx : x^2-s*x-t=0) :
    x = largeNegativeMultiplierRoot s t ∨ x = -negativeMagnitude s t := by
  have hd := negative_root_identities hs ht
  have hab := (negative_root_data hs ht.le).2.2.1
  have he : (x-largeNegativeMultiplierRoot s t)*(x+negativeMagnitude s t)=0 := by
    nlinarith [hd.1]
  rcases mul_eq_zero.mp he with h | h
  · exact Or.inl (by linarith)
  · exact Or.inr (by linarith)

lemma negative_roots_order {s r t : ℝ} (hs : 0 < s) (hsr : s < r) (ht : 0 < t) :
    largeNegativeMultiplierRoot s t < largeNegativeMultiplierRoot r t ∧
    negativeMagnitude r t < negativeMagnitude s t := by
  have hsq := Real.sqrt_lt_sqrt (show 0 ≤ s^2+4*t by positivity)
    (show s^2+4*t < r^2+4*t by nlinarith)
  have ha : largeNegativeMultiplierRoot s t < largeNegativeMultiplierRoot r t := by
    unfold largeNegativeMultiplierRoot
    linarith
  have h1 := negative_root_data hs ht.le
  have h2 := negative_root_data (lt_trans hs hsr) ht.le
  have hb := (negative_root_identities (lt_trans hs hsr) ht).2.1
  have hm := mul_pos (sub_pos.mpr ha) hb
  exact ⟨ha,by nlinarith [h1.2.2.1,h2.2.2.1]⟩

def selectedEntries (s : Fin 3 → ℝ) (t : ℝ) : Fin 3 → ℝ :=
  ![-negativeMagnitude (s 0) t,largeNegativeMultiplierRoot (s 1) t,
    largeNegativeMultiplierRoot (s 2) t]

lemma selected_abs_product (s : Fin 3 → ℝ) (hs : ∀ i, 0 < s i) {t : ℝ} (ht : 0 ≤ t) :
    |∏ i, selectedEntries s t i| = selectedProduct s t := by
  have h0 := negative_root_data (hs 0) ht
  have h1 := negative_root_data (hs 1) ht
  have h2 := negative_root_data (hs 2) ht
  simp [selectedEntries,Fin.prod_univ_succ,abs_mul,abs_of_nonneg h0.2.1,
    abs_of_pos h1.1,abs_of_pos h2.1,selectedProduct,h0.2.2.2,mul_assoc]

lemma negative_pattern_comparison (s : Fin 3 → ℝ) (hs : SingularInterval s)
    (t : ℝ) (ht : 0 < t) (x : Fin 3 → ℝ)
    (hprod : |∏ i, x i|=1) (he : ∀ i, (x i)^2-s i*x i-t=0) :
    x=selectedEntries s t ∨ 1<selectedProduct s t := by
  have hpos : ∀ i, 0 < s i := fun i => by have := (hs.1 i).1; linarith
  have hdata (i : Fin 3) := negative_root_identities (hpos i) ht
  have hd (i : Fin 3) := negative_root_data (hpos i) ht.le
  have ha : ∀ i, 1 < largeNegativeMultiplierRoot (s i) t := by
    intro i
    have hh := hdata i
    have := (hs.1 i).1
    linarith [hh.1,hh.2.1]
  have hb : ∀ i, 0 < negativeMagnitude (s i) t ∧
      negativeMagnitude (s i) t < largeNegativeMultiplierRoot (s i) t := by
    intro i
    exact ⟨(hdata i).2.1,by linarith [(hdata i).1,hpos i]⟩
  have ho1 := negative_roots_order (hpos 0) hs.2.1 ht
  have ho2 := negative_roots_order (hpos 0) (lt_trans hs.2.1 hs.2.2) ht
  have hp1 := mul_lt_mul ho1.1 ho1.2.le (hb 1).1 (hd 1).1.le
  have hp2 := mul_lt_mul ho2.1 ho2.2.le (hb 2).1 (hd 2).1.le
  have hh := three_root_pattern ha hb
    (by simpa only [mul_comm] using hp1)
    (by simpa only [mul_comm] using hp2)
    (fun i => negative_root_classification (hpos i) ht (he i)) hprod
  simpa only [selectedEntries,selectedProduct,(hd 0).2.2.2] using hh

lemma selected_entries_quadratic (s : Fin 3 → ℝ) (hs : ∀ i, 0<s i)
    {t : ℝ} (ht : 0<t) :
    ∀ i, (selectedEntries s t i)^2-s i*selectedEntries s t i-t=0 := by
  intro i
  fin_cases i
  · exact (negative_root_identities (hs 0) ht).2.2.2
  · exact (negative_root_identities (hs 1) ht).2.2.1
  · exact (negative_root_identities (hs 2) ht).2.2.1

lemma bounded_multiplier_identification (s : Fin 3 → ℝ) (hs : SingularInterval s)
    (t : ℝ) (ht : 0<t ∧ t<(13:ℝ)/25 ∧ selectedProduct s t=1)
    (x : Fin 3 → ℝ) (d : ℝ) (hp : |∏ i, x i|=1)
    (he : ∀ i, (x i)^2-s i*x i+d=0) (hd : |d|≤t) :
    d = -t ∧ x=selectedEntries s t := by
  have hpos : ∀ i, 0 < s i := fun i => by have := (hs.1 i).1; linarith
  have hneg : d<0 := by
    by_contra hn
    have hd0 : 0≤d := le_of_not_gt hn
    have hdu : d≤(13:ℝ)/25 := by rw [abs_of_nonneg hd0] at hd; linarith [ht.2.1]
    exact positive_multiplier_exclusion_proved s hs d ⟨hd0,hdu⟩ ⟨x,hp,he⟩
  have hu : 0 < -d := neg_pos.mpr hneg
  have hut : -d≤t := by simpa [abs_of_neg hneg] using hd
  have hh := negative_pattern_comparison s hs (-d) hu x hp
    (fun i => by simpa using he i)
  have hmon := (selected_product_strict s hpos).monotoneOn hu.le ht.1.le hut
  rw [ht.2.2] at hmon
  rcases hh with hx | hx
  · have heq : selectedProduct s (-d)=1 := by
      rw [hx, selected_abs_product s hpos hu.le] at hp
      exact hp
    have heqt : -d=t := (selected_product_strict s hpos).injOn hu.le ht.1.le (heq.trans ht.2.2.symm)
    exact ⟨by linarith,by simpa only [heqt] using hx⟩
  · linarith

lemma scalar_unique_least (s : Fin 3 → ℝ) (hs : SingularInterval s)
    (t : ℝ) (ht : 0<t ∧ t<(13:ℝ)/25 ∧ selectedProduct s t=1)
    (x : Fin 3 → ℝ) (d : ℝ) (hp : |∏ i, x i|=1)
    (he : ∀ i, (x i)^2-s i*x i+d=0) :
    t≤|d| ∧ (|d|=t → x=selectedEntries s t ∧ d = -t) := by
  constructor
  · by_contra hn
    have hd := bounded_multiplier_identification s hs t ht x d hp he (le_of_lt (lt_of_not_ge hn))
    rw [hd.1,abs_neg,abs_of_pos ht.1] at hn
    exact hn le_rfl
  · intro hd
    have hh := bounded_multiplier_identification s hs t ht x d hp he hd.le
    exact ⟨hh.2,hh.1⟩

lemma diagonal_stationary_of_quadratic (s x : Fin 3 → ℝ) (c : ℝ)
    (hp : |∏ i,x i|=1) (he : ∀ i, (x i)^2-s i*x i+c=0) :
    Stationary (Matrix.diagonal s) (Matrix.diagonal x) c := by
  refine ⟨by simpa [Feasible,Matrix.det_diagonal] using hp, ?_⟩
  rw [Matrix.diagonal_transpose, Matrix.diagonal_sub, Matrix.diagonal_mul_diagonal]
  ext i j
  by_cases hij : i=j
  · subst j
    simp only [Matrix.diagonal_apply_eq,
      Matrix.smul_apply,Matrix.one_apply_eq,smul_eq_mul,mul_one]
    nlinarith [he i]
  · simp [Matrix.diagonal, hij]

lemma flip_distance_strict (s : Fin 3 → ℝ) (a b c : ℝ) (hs : 0 < s 0) (ha : 0<a) :
    distanceSq (Matrix.diagonal s) (Matrix.diagonal ![a,b,c]) <
      distanceSq (Matrix.diagonal s) (Matrix.diagonal ![-a,b,c]) := by
  have hm := mul_pos hs ha
  simp [distanceSq,Fin.sum_univ_succ,Matrix.diagonal]
  nlinarith [hm]

lemma flip_feasible (a b c : ℝ) (hp : Feasible (Matrix.diagonal ![-a,b,c])) :
    Feasible (Matrix.diagonal ![a,b,c]) := by
  simpa [Feasible,Matrix.det_diagonal,Fin.prod_univ_succ,abs_mul] using hp

lemma diagonal_unique_failure_proved
    (s : Fin 3 → ℝ) (hs : SingularInterval s) : Failure (Matrix.diagonal s) := by
  obtain ⟨t,ht,_hut⟩ := selected_negative_root_proved s hs
  have hpos : ∀ i,0<s i := fun i => by have := (hs.1 i).1; linarith
  have hprod : |∏ i,selectedEntries s t i|=1 := by
    rw [selected_abs_product s hpos ht.1.le,ht.2.2]
  have hquad : ∀ i,(selectedEntries s t i)^2-s i*selectedEntries s t i+(-t)=0 :=
    fun i => by simpa only [sub_eq_add_neg] using selected_entries_quadratic s hpos ht.1 i
  have hstat := diagonal_stationary_of_quadratic s (selectedEntries s t) (-t) hprod hquad
  refine ⟨Matrix.diagonal (selectedEntries s t),-t,⟨hstat,?_⟩,?_⟩
  · intro Y d hY
    obtain ⟨y,rfl,hyp,hyq⟩ := diagonal_stationary_reduction_proved s hs Y d hY
    have hu := scalar_unique_least s hs t ht y d hyp hyq
    refine ⟨by simpa only [abs_neg,abs_of_pos ht.1] using hu.1,?_⟩
    intro heq
    have hh := hu.2 (by simpa only [abs_neg,abs_of_pos ht.1] using heq)
    exact ⟨congrArg Matrix.diagonal hh.1,hh.2⟩
  · intro hn
    have hfeas := flip_feasible (negativeMagnitude (s 0) t)
      (largeNegativeMultiplierRoot (s 1) t) (largeNegativeMultiplierRoot (s 2) t) hstat.1
    have hdist := flip_distance_strict s (negativeMagnitude (s 0) t)
      (largeNegativeMultiplierRoot (s 1) t) (largeNegativeMultiplierRoot (s 2) t)
      (hpos 0) (negative_root_identities (hpos 0) ht.1).2.1
    exact (not_lt_of_ge (hn.2 _ hfeas)) hdist
end NLA.SP04
