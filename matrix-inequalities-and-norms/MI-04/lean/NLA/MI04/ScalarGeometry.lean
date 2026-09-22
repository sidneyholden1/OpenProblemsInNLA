/- Exact cubic-root-of-unity identity used in MI-04 spectral geometry.
Source mathematics: Matthew J. Colbrook. Formalization: Sidney Holden with Codex. -/
import Mathlib.Analysis.Complex.Basic
import Mathlib.Tactic
import LeanCert.Tactic.Verification
set_option autoImplicit false
noncomputable section
open scoped ComplexConjugate
namespace NLA.MI04
def omega : ℂ := (-1 + Complex.I * Real.sqrt 3) / 2

lemma omega_sum : 1 + omega + star omega = 0 := by
  apply Complex.ext <;> simp [omega, Complex.div_re, Complex.div_im] <;> ring

lemma fourier_norm_difference (a b c : ℂ) :
    ‖a + omega*b + star omega*c‖^2 - ‖a + star omega*b + omega*c‖^2 =
      2*Real.sqrt 3 * ((a-c)*star (b-c)).im := by
  simp only [Complex.sq_norm]
  simp [Complex.normSq_apply,omega,Complex.mul_re,Complex.mul_im,
    Complex.div_re,Complex.div_im]
  ring

lemma fourier_equal_im_zero (a b c : ℂ)
    (h : ‖a + omega*b + star omega*c‖ = ‖a + star omega*b + omega*c‖) :
    ((a-c)*star (b-c)).im = 0 := by
  have hh := fourier_norm_difference a b c
  rw [h, sub_self] at hh
  exact (mul_eq_zero.mp hh.symm).resolve_left (by positivity)
#assert_trust kernel fourier_equal_im_zero
end NLA.MI04
