/- Degree obstruction from the odd-square reduction and exterior Chebyshev
extremality in George Stepaniants' MF-02 proof, Section 2.
Formalization: Sidney Holden with OpenAI Codex assistance. -/
import NLA.MF02.Errors
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Chebyshev.Extremal
import Mathlib.Algebra.Polynomial.Expand
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Chebyshev.Basic
set_option autoImplicit false
set_option maxHeartbeats 2000000
open Polynomial
noncomputable section
namespace NLA.MF02

def oddPart (p : ℝ[X]) : ℝ[X] := (1/2:ℝ) • (p-p.comp (-X))

lemma oddPart_eval (p : ℝ[X]) (x : ℝ) :
    (oddPart p).eval x = (p.eval x-p.eval (-x))/2 := by
  simp [oddPart,eval_smul,eval_comp]; ring

lemma oddPart_odd (p : ℝ[X]) (x : ℝ) :
    (oddPart p).eval (-x) = -(oddPart p).eval x := by
  simp only [oddPart_eval,neg_neg]; ring

lemma oddPart_zero (p : ℝ[X]) : (oddPart p).eval 0 = 0 := by simp [oddPart_eval]

lemma oddPart_degree (p : ℝ[X]) : (oddPart p).natDegree ≤ p.natDegree := by
  unfold oddPart
  refine (natDegree_smul_le _ _).trans ((natDegree_sub_le _ _).trans ?_)
  rw [natDegree_eq_of_degree_eq (degree_comp_neg_X (p:=p)),max_self]

lemma oddPart_positive_error (δ : ℝ) (hδ : 0 < δ) (p : ℝ[X]) (x : ℝ)
    (hx : x ∈ Set.Icc δ 1) : |(oddPart p).eval x-1| ≤ uniformError δ p := by
  have hp := point_error_le δ hδ p x (Or.inr hx)
  have hn := point_error_le δ hδ p (-x) (Or.inl (by constructor <;> linarith [hx.1,hx.2]))
  have hxp : ¬x<0 := by linarith [hx.1]
  have hxn : -x<0 := by linarith [hx.1]
  simp only [targetSign,if_neg hxp,if_pos hxn,sub_neg_eq_add] at hp hn
  rw [abs_le] at hp hn ⊢
  rw [oddPart_eval]
  constructor <;> linarith

lemma oddPart_error_le (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) (p : ℝ[X]) :
    uniformError δ (oddPart p) ≤ uniformError δ p := by
  apply error_le δ hδ1
  intro x hx
  rcases hx with hx | hx
  · have hh := oddPart_positive_error δ hδ p (-x) (by constructor <;> linarith [hx.1,hx.2])
    have hn : x<0 := by linarith [hx.2]
    rw [oddPart_odd] at hh
    rw [show -(oddPart p).eval x-1 = -((oddPart p).eval x+1) by ring,abs_neg] at hh
    simpa only [targetSign,if_pos hn,sub_neg_eq_add] using hh
  · have hn : ¬x<0 := by linarith [hx.1]
    simpa [targetSign,hn] using oddPart_positive_error δ hδ p x hx

lemma odd_square_expand (p : ℝ[X]) :
    expand ℝ 2 (contract 2 ((oddPart p)^2)) = (oddPart p)^2 := by
  let q := (oddPart p)^2
  have he : q.comp (C (-1)*X) = q := by
    apply Polynomial.funext
    intro x
    simp only [eval_comp,eval_mul,eval_C,eval_X,neg_one_mul]
    simp only [q,eval_pow,oddPart_odd,neg_sq]
  ext n
  rw [coeff_expand (by norm_num)]
  by_cases hn : 2∣n
  · simp only [hn,if_true,coeff_contract (by norm_num : (2:ℕ)≠0),Nat.div_mul_cancel hn]
  · simp only [hn,if_false]
    have hc := congrArg (fun f : ℝ[X] => f.coeff n) he
    rw [comp_C_mul_X_coeff] at hc
    have ho : Odd n := Nat.not_even_iff_odd.mp (by simpa only [even_iff_two_dvd] using hn)
    rw [ho.neg_one_pow] at hc
    change 0 = q.coeff n
    linarith

lemma odd_square_degree (p : ℝ[X]) (D : ℕ) (hp : p.natDegree ≤ D) :
    (contract 2 ((oddPart p)^2)).natDegree ≤ D := by
  rw [natDegree_le_iff_coeff_eq_zero]
  intro N hN
  rw [coeff_contract (by norm_num : (2:ℕ)≠0)]
  apply coeff_eq_zero_of_natDegree_lt
  have hd := natDegree_pow_le (p:=oddPart p) (n:=2)
  have ho := (oddPart_degree p).trans hp
  omega

lemma odd_square_eval (p : ℝ[X]) (x : ℝ) :
    (contract 2 ((oddPart p)^2)).eval (x^2) = ((oddPart p).eval x)^2 := by
  rw [← expand_eval,odd_square_expand,eval_pow]

lemma exterior_chebyshev_gap (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1) (D : ℕ) :
    (Chebyshev.T ℝ (D:ℤ)).eval ((1+δ^2)/(1-δ^2)) =
      ((gapRatio δ)^D+((gapRatio δ)^D)⁻¹)/2 := by
  have hr : 0 < gapRatio δ := div_pos (by linarith) (by linarith)
  have he : (1+δ^2)/(1-δ^2) = Real.cosh (Real.log (gapRatio δ)) := by
    rw [Real.cosh_log hr]
    unfold gapRatio
    have hd : 1-δ^2 ≠ 0 := by nlinarith
    field_simp [hd,show 1-δ ≠ 0 by linarith,show 1+δ ≠ 0 by linarith]
    ring
  rw [he,Chebyshev.T_real_cosh]
  simp only [Int.cast_natCast]
  rw [← Real.log_pow,Real.cosh_log (pow_pos hr D)]

/-- Full pointwise degree obstruction. A positive slack epsilon avoids a
separate zero-error polynomial-identity argument. -/
theorem degree_error_bound_proved (δ : ℝ) (hδ : 0 < δ) (hδ1 : δ < 1)
    (D : ℕ) (hD : 1 ≤ D) (p : ℝ[X]) (hp : p.natDegree ≤ D) :
    gapRatio δ ^ D ≤ uniformError δ p := by
  by_contra hnot
  have he : uniformError δ p < gapRatio δ ^ D := lt_of_not_ge hnot
  let r := gapRatio δ ^ D
  let e := (uniformError δ p+r)/2
  have hr0 : 0 < gapRatio δ := div_pos (by linarith) (by linarith)
  have hr1 : gapRatio δ < 1 := (div_lt_one (by linarith)).mpr (by linarith)
  have hr : 0 < r := pow_pos hr0 D
  have hrlt : r < 1 := pow_lt_one₀ hr0.le hr1 (by omega)
  have he0 := error_nonneg δ hδ hδ1 p
  have hpe : uniformError δ p < e := by dsimp [e,r]; linarith
  have hepos : 0 < e := lt_of_le_of_lt he0 hpe
  have her : e < r := by dsimp [e,r]; linarith
  have he1 : e < 1 := her.trans hrlt
  let B := contract 2 ((oddPart p)^2)
  let a : ℝ[X] := C ((1+δ^2)/2) - C ((1-δ^2)/2)*X
  let R : ℝ[X] := (1/(2*e):ℝ) • (C (1+e^2)-B.comp a)
  have hd : 0 < 1-δ^2 := by nlinarith
  have adeg : a.natDegree ≤ 1 := by
    apply (natDegree_sub_le _ _).trans
    simp only [natDegree_C]
    apply max_le (by omega)
    exact (natDegree_mul_le).trans (by simp)
  have bdeg : B.natDegree ≤ D := odd_square_degree p D hp
  have rdeg : R.natDegree ≤ D := by
    apply (natDegree_smul_le _ _).trans
    apply (natDegree_sub_le _ _).trans
    apply max_le (by rw [natDegree_C]; exact Nat.zero_le D)
    exact (natDegree_comp_le).trans (by nlinarith)
  have aeval (t : ℝ) : a.eval t = (1+δ^2-(1-δ^2)*t)/2 := by
    simp [a]; ring
  have reval (t : ℝ) : R.eval t = (1+e^2-B.eval (a.eval t))/(2*e) := by
    simp only [R,eval_smul,eval_sub,eval_C,eval_comp,smul_eq_mul]
    ring
  have rbnd : ∀ t ∈ Set.Icc (-1:ℝ) 1, |R.eval t| ≤ 1 := by
    intro t ht
    have haL : δ^2 ≤ a.eval t := by rw [aeval]; nlinarith [mul_nonneg hd.le (sub_nonneg.mpr ht.2)]
    have haU : a.eval t ≤ 1 := by rw [aeval]; nlinarith [mul_nonneg hd.le (show 0≤t+1 by linarith [ht.1])]
    have ha0 : 0 ≤ a.eval t := (sq_nonneg δ).trans haL
    let x := Real.sqrt (a.eval t)
    have hx : x ∈ Set.Icc δ 1 := ⟨(Real.le_sqrt hδ.le ha0).mpr haL,
      (Real.sqrt_le_left (by norm_num : (0:ℝ)≤1)).mpr (by simpa using haU)⟩
    have hx2 : x^2 = a.eval t := Real.sq_sqrt ha0
    have ho := (oddPart_positive_error δ hδ p x hx).trans hpe.le
    rw [abs_le] at ho
    have hvlo : (1-e)^2 ≤ ((oddPart p).eval x)^2 := by nlinarith [sq_nonneg ((oddPart p).eval x-(1-e))]
    have hvhi : ((oddPart p).eval x)^2 ≤ (1+e)^2 := by nlinarith
    have hb : B.eval (a.eval t) = ((oddPart p).eval x)^2 := by rw [← hx2]; exact odd_square_eval p x
    rw [reval,abs_le]
    constructor
    · apply (le_div_iff₀ (by positivity : 0<2*e)).mpr
      rw [hb]; nlinarith
    · apply (div_le_iff₀ (by positivity : 0<2*e)).mpr
      rw [hb]; nlinarith
  let t₀ := (1+δ^2)/(1-δ^2)
  have ht₀ : 1 ≤ t₀ := (le_div_iff₀ hd).mpr (by nlinarith)
  have hc := Chebyshev.eval_iterate_derivative_le_of_forall_abs_le_one
    (k:=0) ht₀ (natDegree_le_iff_degree_le.mp rdeg) rbnd
  simp only [Function.iterate_zero, id_eq] at hc
  have ha0 : a.eval t₀ = 0 := by rw [aeval]; dsimp [t₀]; field_simp [hd.ne']; ring
  have hb0 : B.eval 0 = 0 := by
    have hb := odd_square_eval p 0
    simpa [B,oddPart_zero] using hb
  rw [reval,ha0,hb0,sub_zero] at hc
  rw [exterior_chebyshev_gap δ hδ hδ1 D] at hc
  change (1+e^2)/(2*e) ≤ (r+r⁻¹)/2 at hc
  have hc' : (1+e^2)*r ≤ (r^2+1)*e := by
    have h := (div_le_div_iff₀ (by positivity : 0<2*e) (by norm_num : (0:ℝ)<2)).mp hc
    have h' := mul_le_mul_of_nonneg_right h hr.le
    field_simp at h'
    nlinarith
  have hprod : 0 < (r-e)*(1-e*r) := mul_pos (by linarith) (by nlinarith)
  nlinarith

#assert_trust kernel degree_error_bound_proved
#print axioms degree_error_bound_proved
end NLA.MF02
