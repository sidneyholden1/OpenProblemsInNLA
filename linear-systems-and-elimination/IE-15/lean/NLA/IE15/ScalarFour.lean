/- Stepaniants IE-15 §4: exact corner interpolation replaces separate convexity.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.IE15.Scalar
set_option maxHeartbeats 1000000
noncomputable section
namespace NLA.IE15

lemma bilinear_unit_bound (a b c d M x y : ℝ)
    (hx : 0 ≤ x) (hx1 : x ≤ 1) (hy : 0 ≤ y) (hy1 : y ≤ 1)
    (h00 : d ≤ M) (h10 : b+d ≤ M) (h01 : c+d ≤ M)
    (h11 : a+b+c+d ≤ M) : a*x*y+b*x+c*y+d ≤ M := by
  have h0 := mul_nonneg (mul_nonneg (sub_nonneg.mpr hx1) (sub_nonneg.mpr hy1)) (sub_nonneg.mpr h00)
  have h1 := mul_nonneg (mul_nonneg hx (sub_nonneg.mpr hy1)) (sub_nonneg.mpr h10)
  have h2 := mul_nonneg (mul_nonneg (sub_nonneg.mpr hx1) hy) (sub_nonneg.mpr h01)
  have h3 := mul_nonneg (mul_nonneg hx hy) (sub_nonneg.mpr h11)
  nlinarith only [h0,h1,h2,h3]

lemma bilinear_signed_bound (c d u v : ℝ)
    (hc : 0 ≤ c) (hc1 : c ≤ 1) (_hd : -1 ≤ d) (hd1 : d ≤ 1)
    (hu : |u| ≤ 1) (hv : |v| ≤ 1) :
    -u*v-d*u-c*v ≤ 1+|c-d| := by
  obtain ⟨hu0,hu1⟩ := abs_le.mp hu
  obtain ⟨hv0,hv1⟩ := abs_le.mp hv
  have ha := abs_nonneg (c-d)
  have hab := le_abs_self (c-d)
  have hba := neg_le_abs (c-d)
  have h := bilinear_unit_bound (-4) (2-2*d) (2-2*c) (-1+d+c)
    (1+|c-d|) ((u+1)/2) ((v+1)/2)
    (by linarith) (by linarith) (by linarith) (by linarith)
    (by linarith) (by linarith) (by linarith) (by linarith)
  nlinarith only [h]

/-- The complete signed-coordinate order-four estimate. The three added
inequalities are the actual original entries A33, -A34 and A43. -/
theorem scalar_four_bound (p q r a b c1 c2 d1 d2 u1 u2 v1 v2 C D : ℝ)
    (hp : 0 < p) (hp1 : p ≤ 1) (hq : 0 < q) (_hr : 0 < r)
    (ha : |a| ≤ 1) (hb : |b| ≤ 1)
    (hc1 : 0 ≤ c1) (hc1' : c1 ≤ 1) (hc2 : 0 ≤ c2) (hc2' : c2 ≤ 1)
    (hd1 : |d1| ≤ 1) (hd2 : |d2| ≤ 1)
    (h22 : |q+p*a*b| ≤ 1)
    (h24 : |q*d2+p*a*d1| ≤ 1)
    (h42 : |q*c2+p*c1*b| ≤ 1)
    (hu1 : |u1| ≤ 1) (hu2 : |u2| ≤ 1)
    (hv1 : |v1| ≤ 1) (hv2 : |v2| ≤ 1)
    (hC : 0 ≤ C) (hC1 : C ≤ 1) (hD : 0 ≤ D) (hD1 : D ≤ 1)
    (h33 : r+p*u1*v1+q*u2*v2 ≤ 1)
    (h34 : r*D+p*u1*d1+q*u2*d2 ≤ 1)
    (h43 : r*C+p*c1*v1+q*c2*v2 ≤ 1) :
    p*c1*d1+q*c2*d2+r*C*D ≤ 11/3 := by
  have hp0 := le_of_lt hp
  have hq0 := le_of_lt hq
  have hW := scalar_three_bound p q a b c1 c2 d1 d2 hp hp1 hq ha hb
    hc1 hc1' hc2 hc2' hd1 hd2 h22 h24 h42
  have hH := two_pivot_scalar_bound p q a b c1 c2 d1 d2 hp hp1 hq ha hb
    hc1 hc1' hc2 hc2' hd1 hd2 h22 h24 h42
  have habs : |a*b| ≤ 1 := by simpa [abs_mul] using mul_le_mul ha hb (abs_nonneg b) (by norm_num : (0:ℝ) ≤ 1)
  have h22u := (abs_le.mp h22).2
  have hab := (abs_le.mp habs).1
  have hq2 : q ≤ 2 := by nlinarith only [h22u, hp1, mul_nonneg hp0 (by linarith : 0 ≤ a*b+1)]
  have hdu1 : -1 ≤ d1*u1 := (abs_le.mp (show |d1*u1| ≤ 1 by simpa [abs_mul] using mul_le_mul hd1 hu1 (abs_nonneg u1) (by norm_num : (0:ℝ) ≤ 1))).1
  have hdu2 : -1 ≤ d2*u2 := (abs_le.mp (show |d2*u2| ≤ 1 by simpa [abs_mul] using mul_le_mul hd2 hu2 (abs_nonneg u2) (by norm_num : (0:ℝ) ≤ 1))).1
  have hcv1 : -1 ≤ c1*v1 := by
    have hca : |c1| ≤ 1 := by simpa [abs_of_nonneg hc1] using hc1'
    exact (abs_le.mp (show |c1*v1| ≤ 1 by simpa [abs_mul] using mul_le_mul hca hv1 (abs_nonneg v1) (by norm_num : (0:ℝ) ≤ 1))).1
  have hcv2 : -1 ≤ c2*v2 := by
    have hca : |c2| ≤ 1 := by simpa [abs_of_nonneg hc2] using hc2'
    exact (abs_le.mp (show |c2*v2| ≤ 1 by simpa [abs_mul] using mul_le_mul hca hv2 (abs_nonneg v2) (by norm_num : (0:ℝ) ≤ 1))).1
  have hpd := mul_le_mul_of_nonneg_left hdu1 hp0
  have hqd := mul_le_mul_of_nonneg_left hdu2 hq0
  have hpc := mul_le_mul_of_nonneg_left hcv1 hp0
  have hqc := mul_le_mul_of_nonneg_left hcv2 hq0
  have hinner1 := bilinear_signed_bound c1 d1 u1 v1 hc1 hc1' (abs_le.mp hd1).1 (abs_le.mp hd1).2 hu1 hv1
  have hinner2 := bilinear_signed_bound c2 d2 u2 v2 hc2 hc2' (abs_le.mp hd2).1 (abs_le.mp hd2).2 hu2 hv2
  have hi1 := mul_le_mul_of_nonneg_left hinner1 hp0
  have hi2 := mul_le_mul_of_nonneg_left hinner2 hq0
  unfold scalarH at hH
  have hinterp := bilinear_unit_bound
    (1-p*u1*v1-q*u2*v2) (1-p*d1*u1-q*d2*u2)
    (1-p*c1*v1-q*c2*v2) (3*(p*c1*d1+q*c2*d2)) 11 C D hC hC1 hD hD1
    (by linarith only [hW])
    (by nlinarith only [hW,hpd,hqd,hp1,hq2])
    (by nlinarith only [hW,hpc,hqc,hp1,hq2])
    (by nlinarith only [hH,hi1,hi2])
  have h33m := mul_le_mul_of_nonneg_left h33 (mul_nonneg hC hD)
  have h34m := mul_le_mul_of_nonneg_left h34 hC
  have h43m := mul_le_mul_of_nonneg_left h43 hD
  nlinarith only [hinterp,h33m,h34m,h43m]
end NLA.IE15
