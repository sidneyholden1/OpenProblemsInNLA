/- Exact noncancellation from Stepaniants's MF-22 proof.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.MF22.Scalar
set_option autoImplicit false
set_option maxHeartbeats 2000000
noncomputable section
namespace NLA.MF22
open Complex

lemma quadratic_common_resultant (a b c d e f z : ℂ)
    (h : a*z^2+b*z+c=0) (k : d*z^2+e*z+f=0) :
    (a*f-c*d)^2-(a*e-b*d)*(b*f-c*e)=0 := by
  have h1 : a*f-c*d+(a*e-b*d)*z=0 := by linear_combination a*k-d*h
  have h2 : (a*e-b*d)*z^2-(b*f-c*e)=0 := by linear_combination e*h-b*k
  linear_combination (a*f-c*d-(a*e-b*d)*z)*h1+(a*e-b*d)*h2

lemma h_ell_no_common (r : ℝ) (z : ℂ) (hh : hPoly r z=0) (hl : ellPoly r z=0) : False := by
  have h := quadratic_common_resultant (sC r) (96*I) (sB r) (sE r) (24*r) (sD r) z
    (by simpa [hPoly,add_comm,add_left_comm,add_assoc,mul_comm] using hh)
    (by simpa [ellPoly,add_comm,add_left_comm,add_assoc,mul_comm] using hl)
  have he : (sC r*sD r-sB r*sE r)^2-
      (sC r*(24*r)-(96*I)*sE r)*((96*I)*sD r-sB r*(24*r)) =
      2177280+946944*(r:ℂ)^2+I*(622080*r+241920*(r:ℂ)^3) := by
    apply Complex.ext <;> simp [sB,sC,sD,sE,mul_re,mul_im,pow_succ] <;> ring
  rw [he] at h
  have hre := congrArg Complex.re h
  simp [mul_re,mul_im,pow_succ] at hre
  nlinarith [sq_nonneg r]

lemma linear_difference (r : ℝ) (z : ℂ) :
    sA r*hPoly r z-sB r*alphaPoly r z =
      24*z*(24-7*(r:ℂ)^2-34*I*r+(7*(r:ℂ)^2+30+22*I*r)*z) := by
  apply Complex.ext <;> simp [sA,sB,sC,sF,hPoly,alphaPoly,mul_re,mul_im,pow_succ] <;> ring

lemma numerator_ne_zero_of_denominator_eq_zero (r : ℝ) (hr : 0<r) (z : ℂ)
    (hd : denominator r z=0) : numerator r z ≠ 0 := by
  intro hn
  have hn' : sA r*ellPoly r z=sB r*hPoly r z := by
    have := numerator_identity r z
    rw [hn,mul_zero] at this
    exact sub_eq_zero.mp this
  have hd' : alphaPoly r z*ellPoly r z=hPoly r z^2 := by
    have := denominator_identity r z
    rw [hd,mul_zero] at this
    exact sub_eq_zero.mp this
  by_cases hl : ellPoly r z=0
  · have hh : hPoly r z=0 := by rw [hl,mul_zero] at hd'; exact (pow_eq_zero_iff (by norm_num : (2:ℕ) ≠ 0)).mp hd'.symm
    exact h_ell_no_common r z hh hl
  have hdif : sA r*hPoly r z-sB r*alphaPoly r z=0 := by
    apply (mul_right_cancel₀ hl)
    linear_combination hPoly r z*hn'-sB r*hd'
  have hz : z ≠ 0 := by
    intro h; subst z
    exact coefA_ne_zero r hr (by simpa [denominator] using hd)
  rw [linear_difference] at hdif
  have hzlin : 24-7*(r:ℂ)^2-34*I*r+(7*(r:ℂ)^2+30+22*I*r)*z=0 :=
    (mul_eq_zero.mp hdif).resolve_left (mul_ne_zero (by norm_num) hz)
  let v : ℂ := 7*(r:ℂ)^2+30+22*I*r
  let w : ℂ := 7*(r:ℂ)^2-24+34*I*r
  have hv : v ≠ 0 := by
    intro h
    have := congrArg Complex.re h
    simp [v,mul_re,mul_im,pow_succ] at this
    nlinarith [sq_nonneg r]
  have hvz : v*z=w := by dsimp [v,w]; linear_combination hzlin
  have hzval : z=w/v := (eq_div_iff hv).mpr (by simpa [mul_comm] using hvz)
  have he : v^2*numerator r (w/v) =
      (134136+32436*(r:ℂ)^2-10404*(r:ℂ)^4)+
      I*r*(-103032-40632*(r:ℂ)^2+840*(r:ℂ)^4) := by
    unfold numerator
    field_simp
    dsimp [v,w,coefA]
    apply Complex.ext <;> simp [mul_re,mul_im,pow_succ] <;> ring
  rw [← hzval,hn,mul_zero] at he
  have hre := congrArg Complex.re he
  have him := congrArg Complex.im he
  simp [mul_re,mul_im,pow_succ] at hre him
  have hi : -103032-40632*r^2+840*r^4=0 := by
    have ht := him.resolve_left (ne_of_gt hr)
    nlinarith [ht]
  nlinarith [sq_nonneg r]

#assert_trust kernel numerator_ne_zero_of_denominator_eq_zero
end NLA.MF22
