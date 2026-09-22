/- Exact scalar algebra from George Stepaniants's MF-22 manuscript.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.MF22.Definitions
import Mathlib.Tactic
import Mathlib.Algebra.CubicDiscriminant
import Mathlib.Analysis.Complex.Polynomial.Basic
import LeanCert.Tactic.Verification
set_option autoImplicit false
set_option leancert.trust "kernel"
noncomputable section
namespace NLA.MF22
open Complex

def sA (r : ℝ) : ℂ := -r-6*I
def sB (r : ℝ) : ℂ := -7*r-30*I
def sC (r : ℝ) : ℂ := 7*r-30*I
def sD (r : ℝ) : ℂ := -25*r-30*I
def sE (r : ℝ) : ℂ := r-6*I
def sF (r : ℝ) : ℂ := 25*r-30*I
def coefA (r : ℝ) : ℂ := 30-r^2-10*I*r
def coefB (r : ℝ) : ℂ := 24*r^2+80*I*r-240
def coefC (r : ℝ) : ℂ := 420-46*r^2
def numerator (r : ℝ) (z : ℂ) : ℂ :=
  coefA r+(-120-r^2+22*I*r)*z+2*(r^2+18)*z^2
def denominator (r : ℝ) (z : ℂ) : ℂ :=
  coefA r+coefB r*z+coefC r*z^2+star (coefB r)*z^3+star (coefA r)*z^4
def quartic (r : ℝ) (t : ℂ) : ℂ :=
  coefA r*t^4+coefB r*t^3+coefC r*t^2+star (coefB r)*t+star (coefA r)
def cubic (r : ℝ) (t : ℂ) : ℂ :=
  coefA r*t^3+(coefA r+coefB r)*t^2-(star (coefA r)+star (coefB r))*t-star (coefA r)
def alphaPoly (r : ℝ) (z : ℂ) : ℂ := sA r-24*r*z+sF r*z^2
def hPoly (r : ℝ) (z : ℂ) : ℂ := sB r+96*I*z+sC r*z^2
def ellPoly (r : ℝ) (z : ℂ) : ℂ := sD r+24*r*z+sE r*z^2
def cayleyPolynomial (r : ℝ) (x : ℂ) : ℂ :=
  6*(r^2-10)*x^3+25*r*x^2+5*(r^2-6)*x+15*r
def cayley (x : ℂ) : ℂ := (1+I*x)/(1-I*x)

lemma coefA_ne_zero (r : ℝ) (hr : 0<r) : coefA r ≠ 0 := by
  intro h
  have := congrArg Complex.im h
  simp [coefA,pow_two,mul_im] at this
  nlinarith
lemma sA_ne_zero (r : ℝ) : sA r ≠ 0 := by
  intro h
  have := congrArg Complex.im h
  norm_num [sA] at this

lemma scalar_det (r : ℝ) : sA r*sD r-sB r^2=24*coefA r := by
  apply Complex.ext <;> simp [sA,sB,sD,coefA,mul_re,mul_im,pow_two] <;> ring
lemma numerator_identity (r : ℝ) (z : ℂ) :
    sA r*ellPoly r z-sB r*hPoly r z=24*numerator r z := by
  apply Complex.ext <;>
    simp [sA,sB,sD,sE,sC,ellPoly,hPoly,numerator,coefA,mul_re,mul_im,pow_two] <;> ring
lemma denominator_identity (r : ℝ) (z : ℂ) :
    alphaPoly r z*ellPoly r z-hPoly r z^2=24*denominator r z := by
  apply Complex.ext <;>
    simp [sA,sB,sC,sD,sE,sF,alphaPoly,ellPoly,hPoly,denominator,coefA,coefB,coefC,
      mul_re,mul_im,pow_succ] <;> ring
lemma quartic_factor (r : ℝ) (t : ℂ) : quartic r t=(t-1)*cubic r t := by
  apply Complex.ext <;>
    simp [quartic,cubic,coefA,coefB,coefC,mul_re,mul_im,pow_succ] <;> ring
lemma cubic_one (r : ℝ) : cubic r 1=120*I*r := by
  apply Complex.ext <;> simp [cubic,coefA,coefB] <;> ring
lemma denominator_zero (r : ℝ) : denominator r 0=coefA r := by simp [denominator]
lemma quartic_zero (r : ℝ) : quartic r 0=star (coefA r) := by simp [quartic]
lemma quartic_reciprocal (r : ℝ) (t : ℂ) (ht : t ≠ 0) :
    t^4*denominator r t⁻¹=quartic r t := by
  unfold denominator quartic
  field_simp
  <;> ring
end NLA.MF22
