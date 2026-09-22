/- Exact four-state transfer for Stepaniants's original MF-22 Toeplitz family.
The explicit inverse is subsequently identified with the actual matrix inverse. -/
import NLA.MF22.Scalar
import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic
set_option autoImplicit false
set_option maxRecDepth 4000
set_option maxHeartbeats 1200000
open scoped BigOperators Matrix Matrix.Norms.L2Operator
noncomputable section
namespace NLA.MF22
open Complex
abbrev StateMat := Matrix (Fin 4) (Fin 4) ℂ

def leftBlock (r : ℝ) : Block := !![sA r,sB r;sB r,sD r]
def leftInverse (r : ℝ) : Block :=
  (24 * coefA r)⁻¹ • !![sD r,-sB r;-sB r,sA r]
def forcing (r : ℝ) : Matrix (Fin 4) (Fin 2) ℂ := !![
  sD r/(24*coefA r),-sB r/(24*coefA r);
  -sB r/(24*coefA r),sA r/(24*coefA r);
  0,0;0,0]
def transfer (r : ℝ) : StateMat := !![
  (sD r*24*r+sB r*96*I)/(24*coefA r),
  (-sD r*96*I+sB r*24*r)/(24*coefA r),
  (-sD r*sF r+sB r*sC r)/(24*coefA r),
  (-sD r*sC r+sB r*sE r)/(24*coefA r);
  (-sB r*24*r-sA r*96*I)/(24*coefA r),
  (sB r*96*I-sA r*24*r)/(24*coefA r),
  (sB r*sF r-sA r*sC r)/(24*coefA r),
  (sB r*sC r-sA r*sE r)/(24*coefA r);
  1,0,0,0;0,1,0,0]

lemma leftBlock_det (r : ℝ) : (leftBlock r).det = 24*coefA r := by
  simpa [leftBlock,Matrix.det_fin_two,pow_two] using scalar_det r

lemma leftInverse_eq (r : ℝ) (hr : 0<r) : leftInverse r = (leftBlock r)⁻¹ := by
  rw [Matrix.inv_def,leftBlock_det]
  simp [leftInverse,leftBlock,Matrix.adjugate_fin_two_of,Ring.inverse_eq_inv]

lemma det_companion (a b c d e f g h z : ℂ) :
    (1-z • (!![a,b,c,d;e,f,g,h;1,0,0,0;0,1,0,0] : StateMat)).det =
      (1-z*a-z^2*c)*(1-z*f-z^2*h)-(z*b+z^2*d)*(z*e+z^2*g) := by
  have h0 : (0 : Fin 4).succAbove = ![1,2,3] := by funext i; fin_cases i <;> rfl
  have h1 : (1 : Fin 4).succAbove = ![0,2,3] := by funext i; fin_cases i <;> rfl
  have h2 : (2 : Fin 4).succAbove = ![0,1,3] := by funext i; fin_cases i <;> rfl
  have h3 : (3 : Fin 4).succAbove = ![0,1,2] := by funext i; fin_cases i <;> rfl
  have hs : (Fin.succ : Fin 3 → Fin 4) = ![1,2,3] := by funext i; fin_cases i <;> rfl
  rw [Matrix.det_succ_row_zero,Fin.sum_univ_four]
  simp only [Matrix.det_fin_three,Matrix.submatrix_apply]
  norm_num [Matrix.det_fin_three,Matrix.submatrix_apply,h0,h1,h2,h3,hs,
    Matrix.sub_apply,Matrix.one_apply,Matrix.smul_apply,Matrix.cons_val,Matrix.cons_val_two,Matrix.cons_val_three,Matrix.vecHead,Matrix.vecTail,Fin.ext_iff]

  ring

lemma transfer_resolvent_det (r : ℝ) (hr : 0<r) (z : ℂ) :
    (1-z • transfer r).det = denominator r z / coefA r := by
  have ha := coefA_ne_zero r hr
  rw [transfer,det_companion]
  field_simp [ha]
  simp [sA,sB,sC,sD,sE,sF,denominator,coefA,coefB,coefC]
  ring_nf
  norm_num [Complex.I_sq]
  ring

lemma adjugate_companion (a b c d e f g h z : ℂ) :
    (1-z • (!![a,b,c,d;e,f,g,h;1,0,0,0;0,1,0,0] : StateMat)).adjugate 0 0 =
      1-z*f-z^2*h := by
  rw [Matrix.adjugate_fin_succ_eq_det_submatrix]
  simp only [Matrix.det_fin_three,Matrix.submatrix_apply]
  norm_num [Matrix.sub_apply,Matrix.one_apply,Matrix.smul_apply,
    Fin.succAbove_zero,Matrix.cons_val,Matrix.cons_val_two,Matrix.cons_val_three,Matrix.vecHead,Matrix.vecTail,Fin.succ]
  ring

lemma transfer_resolvent_adjugate (r : ℝ) (hr : 0<r) (z : ℂ) :
    (1-z • transfer r).adjugate 0 0 = numerator r z / coefA r := by
  have ha := coefA_ne_zero r hr
  rw [transfer,adjugate_companion]
  field_simp [ha]
  simp [sA,sB,sC,sD,sE,sF,numerator,coefA]
  ring_nf
  norm_num [Complex.I_sq]
  ring

lemma det_char_companion (a b c d e f g h z : ℂ) :
    (z • 1-(!![a,b,c,d;e,f,g,h;1,0,0,0;0,1,0,0] : StateMat)).det =
      (z^2-z*a-c)*(z^2-z*f-h)-(z*b+d)*(z*e+g) := by
  have h0 : (0 : Fin 4).succAbove = ![1,2,3] := by funext i; fin_cases i <;> rfl
  have h1 : (1 : Fin 4).succAbove = ![0,2,3] := by funext i; fin_cases i <;> rfl
  have h2 : (2 : Fin 4).succAbove = ![0,1,3] := by funext i; fin_cases i <;> rfl
  have h3 : (3 : Fin 4).succAbove = ![0,1,2] := by funext i; fin_cases i <;> rfl
  have hs : (Fin.succ : Fin 3 → Fin 4) = ![1,2,3] := by funext i; fin_cases i <;> rfl
  rw [Matrix.det_succ_row_zero,Fin.sum_univ_four]
  simp only [Matrix.det_fin_three,Matrix.submatrix_apply]
  norm_num [Matrix.det_fin_three,Matrix.submatrix_apply,h0,h1,h2,h3,hs,
    Matrix.sub_apply,Matrix.one_apply,Matrix.smul_apply,Matrix.cons_val,Matrix.cons_val_two,Matrix.cons_val_three,Matrix.vecHead,Matrix.vecTail,Fin.ext_iff]

  ring

lemma transfer_char_det (r : ℝ) (hr : 0<r) (z : ℂ) :
    (z • 1-transfer r).det = quartic r z / coefA r := by
  have ha := coefA_ne_zero r hr
  rw [transfer,det_char_companion]
  field_simp [ha]
  simp [sA,sB,sC,sD,sE,sF,quartic,coefA,coefB,coefC]
  ring_nf
  norm_num [Complex.I_sq]
  ring

lemma transfer_charpoly_eval (r : ℝ) (hr : 0<r) (z : ℂ) :
    (transfer r).charpoly.eval z = quartic r z / coefA r := by
  rw [Matrix.eval_charpoly]
  convert transfer_char_det r hr z using 1
  congr 1
  ext i j
  simp [Matrix.scalar,Matrix.diagonal,Matrix.smul_apply,Matrix.one_apply]

#assert_trust kernel transfer_resolvent_det
#assert_trust kernel transfer_resolvent_adjugate

end NLA.MF22
