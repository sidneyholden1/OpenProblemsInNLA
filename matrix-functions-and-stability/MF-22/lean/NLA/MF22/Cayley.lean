/- Cayley transformation and exact coefficient checks for MF-22.
Source: George Stepaniants. Formalization: Sidney Holden with Codex. Apache-2.0. -/
import NLA.MF22.Scalar
set_option autoImplicit false
set_option maxHeartbeats 2000000
noncomputable section
namespace NLA.MF22
open Complex

def realCubic (r : ℝ) : Cubic ℝ := ⟨6*(r^2-10),25*r,5*(r^2-6),15*r⟩
lemma realCubic_discr_neg (r : ℝ) : (realCubic r).discr < 0 := by
  have hp : 0 < 120*(r^2)^2-3337*r^2+34200 := by
    nlinarith [sq_nonneg (240*r^2-3337)]
  have he : (realCubic r).discr =
      -25*r^4*(120*r^4-3337*r^2+34200)-5269500*r^2-6480000 := by
    unfold realCubic Cubic.discr
    ring
  rw [he]
  have hprod : 0 ≤ r^4*(120*r^4-3337*r^2+34200) :=
    mul_nonneg (by positivity) (by nlinarith [hp])
  nlinarith [sq_nonneg r]
lemma cayley_at_neg_I (r : ℝ) : cayleyPolynomial r (-I)=-I*coefA r := by
  apply Complex.ext <;> simp [cayleyPolynomial,coefA,mul_re,mul_im,pow_succ] <;> ring
lemma cayley_at_I (r : ℝ) : cayleyPolynomial r I=I*star (coefA r) := by
  apply Complex.ext <;> simp [cayleyPolynomial,coefA,mul_re,mul_im,pow_succ] <;> ring
lemma cayley_den_ne (x : ℂ) (hx : x ≠ -I) : 1-I*x ≠ 0 := by
  intro h
  apply hx
  have hr := congrArg Complex.re h
  have hi := congrArg Complex.im h
  apply Complex.ext <;> simp [mul_re,mul_im] at hr hi ⊢ <;> linarith
lemma cayley_num_ne (x : ℂ) (hx : x ≠ I) : 1+I*x ≠ 0 := by
  intro h
  apply hx
  have hr := congrArg Complex.re h
  have hi := congrArg Complex.im h
  apply Complex.ext <;> simp [mul_re,mul_im] at hr hi ⊢ <;> linarith
lemma cayley_injective (x y : ℂ) (hx : x ≠ -I) (hy : y ≠ -I)
    (h : cayley x=cayley y) : x=y := by
  have hh := (div_eq_div_iff (cayley_den_ne x hx) (cayley_den_ne y hy)).mp h
  have he : 2*I*(x-y)=0 := by linear_combination hh
  have hz : x-y=0 := (mul_eq_zero.mp he).resolve_left (mul_ne_zero (by norm_num) I_ne_zero)
  exact sub_eq_zero.mp hz
lemma cayley_ne_neg_one (x : ℂ) (hx : x ≠ -I) : cayley x ≠ -1 := by
  intro h
  have hh := (div_eq_iff (cayley_den_ne x hx)).mp h
  have : (2:ℂ)=0 := by linear_combination hh
  norm_num at this
lemma cayley_identity (r : ℝ) (x : ℂ) (hx : x ≠ -I) :
    (1-I*x)^3*cubic r (cayley x)=8*I*cayleyPolynomial r x := by
  unfold cubic cayley
  field_simp [cayley_den_ne x hx]
  apply Complex.ext <;> simp [coefA,coefB,cayleyPolynomial,mul_re,mul_im,pow_succ] <;> ring
lemma cayley_norm_sq (x : ℂ) :
    ‖1+I*x‖^2=(1-x.im)^2+x.re^2 ∧ ‖1-I*x‖^2=(1+x.im)^2+x.re^2 := by
  constructor <;> rw [Complex.sq_norm] <;> simp [normSq_apply,mul_re,mul_im] <;> ring
lemma cayley_norm_eq_one (x : ℂ) (hx : x.im=0) : ‖cayley x‖=1 := by
  have hd : x ≠ -I := by intro h; rw [h] at hx; norm_num at hx
  have hden : 0<‖1-I*x‖ := norm_pos_iff.mpr (cayley_den_ne x hd)
  rw [cayley,norm_div,div_eq_one_iff_eq (ne_of_gt hden)]
  have hh := cayley_norm_sq x
  nlinarith [norm_nonneg (1+I*x),norm_nonneg (1-I*x)]
lemma cayley_norm_lt_one (x : ℂ) (hx : 0<x.im) : ‖cayley x‖<1 := by
  have hd : x ≠ -I := by intro h; rw [h] at hx; norm_num at hx
  have hden : 0<‖1-I*x‖ := norm_pos_iff.mpr (cayley_den_ne x hd)
  rw [cayley,norm_div,div_lt_one hden]
  have hh := cayley_norm_sq x
  nlinarith [norm_nonneg (1+I*x),norm_nonneg (1-I*x)]
lemma one_lt_cayley_norm (x : ℂ) (hx : x.im<0) (hd : x ≠ -I) : 1<‖cayley x‖ := by
  have hden : 0<‖1-I*x‖ := norm_pos_iff.mpr (cayley_den_ne x hd)
  rw [cayley,norm_div,one_lt_div hden]
  have hh := cayley_norm_sq x
  nlinarith [norm_nonneg (1+I*x),norm_nonneg (1-I*x)]
end NLA.MF22
