/- Exact scalar inequality from George Stepaniants, IE-15 solution §3.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import Mathlib.Tactic
set_option maxHeartbeats 2000000
noncomputable section
namespace NLA.IE15

def scalarH (c d : ℝ) : ℝ := 3*c*d+1+|c-d|

lemma scalarH_bounds {c d : ℝ} (hc : 0 ≤ c) (hc1 : c ≤ 1)
    (hd : -1 ≤ d) (hd1 : d ≤ 1) :
    0 ≤ scalarH c d ∧ scalarH c d ≤ 4 ∧ scalarH c d ≤ 2+2*c := by
  unfold scalarH
  rcases le_total 0 d with hp | hn
  · have hprod := mul_nonneg (sub_nonneg.mpr hc1) (sub_nonneg.mpr hd1)
    have hcd := mul_nonneg hc hp
    have hcD := mul_nonneg hc (sub_nonneg.mpr hd1)
    have hdC := mul_nonneg hp (sub_nonneg.mpr hc1)
    rcases le_total c d with h | h
    · rw [abs_of_nonpos (sub_nonpos.mpr h)]; refine ⟨?_, ?_, ?_⟩ <;> nlinarith
    · rw [abs_of_nonneg (sub_nonneg.mpr h)]; refine ⟨?_, ?_, ?_⟩ <;> nlinarith
  · rw [abs_of_nonneg (by linarith : 0 ≤ c-d)]
    have h1 := mul_nonneg (sub_nonneg.mpr hc1) (by linarith : 0 ≤ 1+d)
    have h2 := mul_nonneg hc (by linarith : 0 ≤ -d)
    have h3 := mul_nonneg hc (by linarith : 0 ≤ 1+d)
    have h4 := mul_nonneg (sub_nonneg.mpr hc1) (by linarith : 0 ≤ -d)
    refine ⟨?_, ?_, ?_⟩ <;> nlinarith

lemma scalarH_nonpos {c d : ℝ} (hc : 0 ≤ c) (hc1 : c ≤ 1)
    (hd : -1 ≤ d) (hd0 : d ≤ 0) : scalarH c d ≤ 2 := by
  unfold scalarH
  rw [abs_of_nonneg (by linarith : 0 ≤ c-d)]
  have h1 := mul_nonneg (sub_nonneg.mpr hc1) (by linarith : 0 ≤ 1+d)
  have h2 := mul_nonneg hc (by linarith : 0 ≤ -d)
  nlinarith

lemma scalarH_product {c d : ℝ} (hc : 0 ≤ c) (hc1 : c ≤ 1)
    (hd : 0 ≤ d) (hd1 : d ≤ 1) : scalarH c d ≤ 2+2*c*d := by
  unfold scalarH
  have h2 := mul_nonneg hc (sub_nonneg.mpr hd1)
  have h3 := mul_nonneg (sub_nonneg.mpr hc1) hd
  have h4 := mul_nonneg (sub_nonneg.mpr hc1) (sub_nonneg.mpr hd1)
  rcases le_total c d with h | h
  · rw [abs_of_nonpos (sub_nonpos.mpr h)]; nlinarith
  · rw [abs_of_nonneg (sub_nonneg.mpr h)]; nlinarith

lemma scalarH_second {c d : ℝ} (hc : 0 ≤ c) (hc1 : c ≤ 1)
    (hd : 0 ≤ d) (hd1 : d ≤ 1) : scalarH c d ≤ 2+2*d := by
  have h := (scalarH_bounds hd hd1 (by linarith) hc1).2.2
  simpa [scalarH, abs_sub_comm, mul_comm, mul_left_comm, mul_assoc] using h

/-- Algebraic replacement for the source's piecewise monotonicity argument.
No derivatives, divisions, interval arithmetic, or grid are needed. -/
lemma clipped_product_bound {q x y U V : ℝ}
    (hq : 0 < q) (hq2 : q ≤ 2) (hx : 0 ≤ x) (hx1 : x ≤ 1)
    (hy : 0 ≤ y) (hy1 : y ≤ 1) (hU : 1 ≤ U) (hU2 : U ≤ 2)
    (_hV : 1 ≤ V) (hV2 : V ≤ 2) (hqx : q*x ≤ U) (hqy : q*y ≤ V) :
    2*q+2*q*x*y ≤ 4+U*V := by
  have hq0 : 0 ≤ q := le_of_lt hq
  have hxy : 0 ≤ q*x*y := mul_nonneg (mul_nonneg hq0 hx) hy
  have hpx : q*x*y ≤ q*x := by nlinarith [mul_nonneg (mul_nonneg hq0 hx) (sub_nonneg.mpr hy1)]
  have hpy : q*x*y ≤ q*y := by nlinarith [mul_nonneg (mul_nonneg hq0 hy) (sub_nonneg.mpr hx1)]
  have hUV := mul_nonneg (sub_nonneg.mpr hU2) (sub_nonneg.mpr hV2)
  by_cases hqu : q ≤ U
  · nlinarith
  by_cases hqv : q ≤ V
  · nlinarith
  have hprod : (q*x)*(q*y) ≤ U*V := mul_le_mul hqx hqy (mul_nonneg hq0 hy) (by linarith)
  have hUVq : U*V ≤ 2*q := by nlinarith [mul_nonneg (by linarith : 0 ≤ U) (sub_nonneg.mpr hV2)]
  have hfactor := mul_nonneg (sub_nonneg.mpr hq2) (by linarith : 0 ≤ 2*q-U*V)
  have hscaled : q*(2*q+2*q*x*y-(4+U*V)) ≤ 0 := by nlinarith
  nlinarith

/-- Full two-pivot scalar bound, with the literal domains and three original
entry inequalities of Stepaniants's IE-15 Lemma in Section 3. -/
theorem two_pivot_scalar_bound (p q a b c1 c2 d1 d2 : ℝ)
    (hp : 0 < p) (hp1 : p ≤ 1) (hq : 0 < q)
    (ha : |a| ≤ 1) (hb : |b| ≤ 1)
    (hc1 : 0 ≤ c1) (hc1' : c1 ≤ 1) (hc2 : 0 ≤ c2) (hc2' : c2 ≤ 1)
    (hd1 : |d1| ≤ 1) (hd2 : |d2| ≤ 1)
    (h22 : |q+p*a*b| ≤ 1)
    (h23 : |q*d2+p*a*d1| ≤ 1)
    (h32 : |q*c2+p*c1*b| ≤ 1) :
    p*scalarH c1 d1+q*scalarH c2 d2 ≤ 8 := by
  obtain ⟨ha0, ha1⟩ := abs_le.mp ha
  obtain ⟨hb0, hb1⟩ := abs_le.mp hb
  obtain ⟨hd10, hd11⟩ := abs_le.mp hd1
  obtain ⟨hd20, hd21⟩ := abs_le.mp hd2
  obtain ⟨_, h22u⟩ := abs_le.mp h22
  obtain ⟨_, h23u⟩ := abs_le.mp h23
  obtain ⟨_, h32u⟩ := abs_le.mp h32
  obtain ⟨hH10, hH14, hH1c⟩ := scalarH_bounds hc1 hc1' hd10 hd11
  obtain ⟨hH20, hH24, hH2c⟩ := scalarH_bounds hc2 hc2' hd20 hd21
  have hp0 := le_of_lt hp
  have hq0 := le_of_lt hq
  have hP4 : p*scalarH c1 d1 ≤ 4*p := by simpa [mul_comm] using mul_le_mul_of_nonneg_left hH14 hp0
  have hQ4 : q*scalarH c2 d2 ≤ 4*q := by simpa [mul_comm] using mul_le_mul_of_nonneg_left hH24 hq0
  by_cases hq1 : q ≤ 1
  · linarith only [hP4, hQ4, hp1, hq1]
  have hab : a*b < 0 := by
    by_contra h
    have := mul_nonneg hp0 (le_of_not_gt h)
    nlinarith only [this, h22u, hq1]
  have hab1 : -1 ≤ a*b := by
    have habs : |a*b| ≤ 1 := by simpa [abs_mul] using mul_le_mul ha hb (abs_nonneg b) (by norm_num : (0:ℝ) ≤ 1)
    exact (abs_le.mp habs).1
  have hq2 : q ≤ 2 := by nlinarith only [h22u, hp1, mul_nonneg hp0 (by linarith only [hab1] : 0 ≤ a*b+1)]
  by_cases hbpos : 0 < b
  · have haneg : a < 0 := by nlinarith only [hab, hbpos]
    have hqb : q ≤ 1+p*b := by nlinarith only [h22u, mul_nonneg (mul_nonneg hp0 (le_of_lt hbpos)) (by linarith only [ha0] : 0 ≤ a+1)]
    have hPc := mul_le_mul_of_nonneg_left hH1c hp0
    have hQc := mul_le_mul_of_nonneg_left hH2c hq0
    have hbc := mul_nonneg (mul_nonneg hp0 (by linarith : 0 ≤ 1-b)) (sub_nonneg.mpr hc1')
    nlinarith only [hPc, hQc, hbc, h32u, hqb, hp1]
  have hbneg : b < 0 := by
    have hbzero : b ≠ 0 := by intro h; simp [h] at hab
    exact lt_of_le_of_ne (le_of_not_gt hbpos) hbzero
  have hapos : 0 < a := by nlinarith only [hab, hbneg]
  have hqa : q ≤ 1+p*a := by nlinarith only [h22u, mul_nonneg (mul_nonneg hp0 (le_of_lt hapos)) (by linarith only [hb0] : 0 ≤ b+1)]
  by_cases hd2neg : d2 ≤ 0
  · have hH2 := scalarH_nonpos hc2 hc2' hd20 hd2neg
    have := mul_le_mul_of_nonneg_left hH2 hq0
    linarith only [this, hP4, hq2, hp1]
  have hd2pos : 0 ≤ d2 := by linarith
  by_cases hd1pos : 0 ≤ d1
  · have hH1d := scalarH_second hc1 hc1' hd1pos hd11
    have hH2d := scalarH_second hc2 hc2' hd2pos hd21
    have hPd := mul_le_mul_of_nonneg_left hH1d hp0
    have hQd := mul_le_mul_of_nonneg_left hH2d hq0
    have had := mul_nonneg (mul_nonneg hp0 (by linarith : 0 ≤ 1-a)) (sub_nonneg.mpr hd11)
    nlinarith only [hPd, hQd, had, h23u, hqa, hp1]
  have hd1neg : d1 ≤ 0 := by linarith
  have hH2cd := scalarH_product hc2 hc2' hd2pos hd21
  have hH2q := mul_le_mul_of_nonneg_left hH2cd hq0
  have hH1p : p*scalarH c1 d1 ≤ scalarH c1 d1 := by nlinarith only [mul_nonneg (sub_nonneg.mpr hp1) hH10]
  have hpc : p*c1*(-b) ≤ c1 := by
    have hpb : p*(-b) ≤ 1 := mul_le_one₀ hp1 (by linarith) (by linarith)
    nlinarith only [mul_nonneg hc1 (sub_nonneg.mpr hpb)]
  have hpd : p*a*(-d1) ≤ -d1 := by
    have hpa : p*a ≤ 1 := mul_le_one₀ hp1 (le_of_lt hapos) ha1
    nlinarith only [mul_nonneg (by linarith only [hd1neg] : 0 ≤ -d1) (sub_nonneg.mpr hpa)]
  have hclip := clipped_product_bound hq hq2 hc2 hc2' hd2pos hd21
    (by linarith : 1 ≤ 1+c1) (by linarith : 1+c1 ≤ 2)
    (by linarith : 1 ≤ 1-d1) (by linarith : 1-d1 ≤ 2)
    (by nlinarith only [h32u,hpc] : q*c2 ≤ 1+c1) (by nlinarith only [h23u,hpd] : q*d2 ≤ 1-d1)
  have hend := mul_nonneg (sub_nonneg.mpr hc1') (by linarith : 0 ≤ 1+d1)
  unfold scalarH at hH1p
  rw [abs_of_nonneg (by linarith : 0 ≤ c1-d1)] at hH1p
  change p*(3*c1*d1+1+|c1-d1|)+q*scalarH c2 d2 ≤ 8
  rw [abs_of_nonneg (by linarith : 0 ≤ c1-d1)]
  nlinarith only [hH2q, hH1p, hclip, hend]
/-- Signed-coordinate order-three bound, also valid when the last Schur
value is zero (only the first two pivots are required positive). -/
theorem scalar_three_bound (p q a b c e d f : ℝ)
    (hp : 0 < p) (hp1 : p ≤ 1) (hq : 0 < q)
    (ha : |a| ≤ 1) (hb : |b| ≤ 1)
    (hc : 0 ≤ c) (hc1 : c ≤ 1) (he : 0 ≤ e) (he1 : e ≤ 1)
    (hd : |d| ≤ 1) (hf : |f| ≤ 1)
    (h22 : |q+p*a*b| ≤ 1)
    (h23 : |q*f+p*a*d| ≤ 1)
    (h32 : |q*e+p*c*b| ≤ 1) : p*c*d+q*e*f ≤ 2 := by
  obtain ⟨ha0, ha1⟩ := abs_le.mp ha
  obtain ⟨hb0, hb1⟩ := abs_le.mp hb
  obtain ⟨hd0, hd1⟩ := abs_le.mp hd
  obtain ⟨hf0, hf1⟩ := abs_le.mp hf
  have h22u := (abs_le.mp h22).2
  have h23u := (abs_le.mp h23).2
  have h32u := (abs_le.mp h32).2
  have hp0 := le_of_lt hp
  have hq0 := le_of_lt hq
  have hpc0 := mul_nonneg hp0 hc
  have hpc1 : p*c ≤ 1 := mul_le_one₀ hp1 hc hc1
  have hpcd : p*c*d ≤ 1 := by nlinarith only [hpc1, mul_nonneg hpc0 (sub_nonneg.mpr hd1)]
  have habs : |a*b| ≤ 1 := by simpa [abs_mul] using mul_le_mul ha hb (abs_nonneg b) (by norm_num : (0:ℝ) ≤ 1)
  have hab := (abs_le.mp habs).1
  have hq2 : q ≤ 2 := by nlinarith only [h22u, hp1, mul_nonneg hp0 (by linarith : 0 ≤ a*b+1)]
  have hqe0 := mul_nonneg hq0 he
  have hqe : q*e ≤ q := mul_le_of_le_one_right hq0 he1
  have hqef : q*e*f ≤ q*e := by nlinarith only [mul_nonneg hqe0 (sub_nonneg.mpr hf1)]
  by_contra h
  have hqef1 : 1 < q*e*f := by linarith
  have hpcd0 : 0 < p*c*d := by linarith
  have hdpos : 0 < d := by nlinarith only [hpcd0, hpc0]
  have hfpos : 0 < f := by nlinarith only [hqef1, hqe0]
  have hqf : q*e*f ≤ q*f := by nlinarith only [mul_nonneg (mul_nonneg hq0 (le_of_lt hfpos)) (sub_nonneg.mpr he1)]
  have haneg : a < 0 := by
    by_contra hn
    have ht := mul_nonneg (mul_nonneg hp0 (le_of_not_gt hn)) (le_of_lt hdpos)
    nlinarith only [ht, h23u, hqef1, hqf]
  have hbneg : b < 0 := by
    by_contra hn
    have ht := mul_nonneg hpc0 (le_of_not_gt hn)
    nlinarith only [ht, h32u, hqef1, hqef]
  have habpos : 0 < a*b := mul_pos_of_neg_of_neg haneg hbneg
  have hpab := mul_pos hp habpos
  nlinarith only [hpab, h22u, hqef1, hqef, hqe]
end NLA.IE15
