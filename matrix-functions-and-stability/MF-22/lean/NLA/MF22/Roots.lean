/- Complete four-root classification, including rho²=10.
Source mathematics: George Stepaniants. Formalization: Sidney Holden with Codex. -/
import NLA.MF22.CubicRoots
import NLA.MF22.Cayley
set_option autoImplicit false
set_option maxHeartbeats 2500000
noncomputable section
namespace NLA.MF22
open Complex
lemma cayleyPolynomial_conj (r : ℝ) (z : ℂ) :
    cayleyPolynomial r (star z)=star (cayleyPolynomial r z) := by
  simp [cayleyPolynomial,map_add,map_sub,map_mul,map_pow]
lemma cayley_root_excludes (r : ℝ) (hr : 0<r) (z : ℂ)
    (hz : cayleyPolynomial r z=0) : z ≠ I ∧ z ≠ -I := by
  constructor
  · intro he; subst z
    rw [cayley_at_I] at hz
    exact (mul_ne_zero I_ne_zero (by simpa using coefA_ne_zero r hr)) hz
  · intro he; subst z
    rw [cayley_at_neg_I] at hz
    exact (mul_ne_zero (neg_ne_zero.mpr I_ne_zero) (coefA_ne_zero r hr)) hz
lemma cubic_of_cayley_root (r : ℝ) (hr : 0<r) (z : ℂ)
    (hz : cayleyPolynomial r z=0) : cubic r (cayley z)=0 := by
  have he := cayley_identity r z (cayley_root_excludes r hr z hz).2
  rw [hz,mul_zero] at he
  exact (mul_eq_zero.mp he).resolve_left (pow_ne_zero _ (cayley_den_ne z (cayley_root_excludes r hr z hz).2))
lemma cayley_root_ne_zero (r : ℝ) (hr : 0<r) (z : ℂ)
    (hz : cayleyPolynomial r z=0) : cayley z ≠ 0 :=
  div_ne_zero (cayley_num_ne z (cayley_root_excludes r hr z hz).1)
    (cayley_den_ne z (cayley_root_excludes r hr z hz).2)
lemma cubic_root_ne_one (r : ℝ) (hr : 0<r) (z : ℂ) (hz : cubic r z=0) : z ≠ 1 := by
  intro he; subst z
  rw [cubic_one] at hz
  exact (mul_ne_zero (mul_ne_zero (by norm_num) I_ne_zero) (by exact_mod_cast ne_of_gt hr)) hz

lemma nonexceptional_cayley_roots (r : ℝ) (hr : 0<r) (he : r^2 ≠ 10) :
    ∃ x z : ℂ, x.im=0 ∧ 0<z.im ∧ cayleyPolynomial r x=0 ∧
      cayleyPolynomial r z=0 ∧ cayleyPolynomial r (star z)=0 := by
  have ha : (realCubic r).a ≠ 0 := by dsimp [realCubic]; exact mul_ne_zero (by norm_num) (sub_ne_zero.mpr he)
  obtain ⟨x,z,hx,hz,hroots,_⟩ := real_cubic_pair (realCubic r) ha (realCubic_discr_neg r)
  have root_of_mem : ∀ w : ℂ, w ∈ ((realCubic r).map ofRealHom).roots → cayleyPolynomial r w=0 := by
    intro w hw
    have hp : ((realCubic r).map ofRealHom).a ≠ 0 := by simpa only [Cubic.map,ofRealHom_eq_coe,ofReal_ne_zero] using ha
    have hh := (Cubic.mem_roots_iff (Cubic.ne_zero_of_a_ne_zero hp) w).mp hw
    simpa [Cubic.map,realCubic,cayleyPolynomial] using hh
  have hxr := root_of_mem x (by simp [hroots])
  have hzr := root_of_mem z (by simp [hroots])
  have hzcr := root_of_mem (star z) (by simp [hroots])
  rcases lt_or_gt_of_ne hz with hz | hz
  · exact ⟨x,star z,hx,by simpa using neg_pos.mpr hz,hxr,hzcr,by simpa using hzr⟩
  · exact ⟨x,z,hx,hz,hxr,hzr,hzcr⟩

lemma exceptional_cayley_roots (r : ℝ) (hr : 0<r) (he : r^2=10) :
    ∃ z : ℂ, 0<z.im ∧ cayleyPolynomial r z=0 ∧ cayleyPolynomial r (star z)=0 := by
  let s : ℝ := Real.sqrt 14600
  have hs : s^2=14600 := Real.sq_sqrt (by norm_num)
  have hsp : 0<s := Real.sqrt_pos.mpr (by norm_num)
  let z : ℂ := (-20+I*s)/(50*r)
  have hd : (50*(r:ℂ)) ≠ 0 := mul_ne_zero (by norm_num) (by exact_mod_cast ne_of_gt hr)
  have hz : cayleyPolynomial r z=0 := by
    dsimp [z]
    unfold cayleyPolynomial
    have hec : (r:ℂ)^2=10 := by exact_mod_cast he
    rw [hec]
    norm_num
    field_simp [hd, show (r:ℂ) ≠ 0 by exact_mod_cast ne_of_gt hr]
    apply Complex.ext <;> simp [mul_re,mul_im,pow_succ]
    · linear_combination 37500*he-25*hs
    · ring
  refine ⟨z,?_,hz,?_⟩
  · dsimp [z]
    simp [Complex.div_im,Complex.normSq_apply,mul_re,mul_im]
    positivity
  · rw [cayleyPolynomial_conj,hz,star_zero]

lemma cubic_three_norm_roots (r : ℝ) (hr : 0<r) :
    ∃ a b c : ℂ, cubic r a=0 ∧ cubic r b=0 ∧ cubic r c=0 ∧
      1<‖a‖ ∧ ‖b‖<1 ∧ ‖c‖=1 ∧ a ≠ 0 ∧ b ≠ 0 ∧ c ≠ 0 := by
  by_cases he : r^2=10
  · obtain ⟨z,hzi,hz,hzc⟩ := exceptional_cayley_roots r hr he
    refine ⟨cayley (star z),cayley z,-1,cubic_of_cayley_root r hr _ hzc,
      cubic_of_cayley_root r hr _ hz,?_,?_,cayley_norm_lt_one z hzi,by simp,
      cayley_root_ne_zero r hr _ hzc,cayley_root_ne_zero r hr _ hz,by norm_num⟩
    · apply Complex.ext <;> simp [cubic,coefA,coefB,mul_re,mul_im,pow_succ] <;> nlinarith [he]
    · exact one_lt_cayley_norm (star z) (by simpa using neg_neg_of_pos hzi)
        (cayley_root_excludes r hr _ hzc).2
  · obtain ⟨x,z,hxi,hzi,hx,hz,hzc⟩ := nonexceptional_cayley_roots r hr he
    exact ⟨cayley (star z),cayley z,cayley x,cubic_of_cayley_root r hr _ hzc,
      cubic_of_cayley_root r hr _ hz,cubic_of_cayley_root r hr _ hx,
      one_lt_cayley_norm _ (by simpa using neg_neg_of_pos hzi) (cayley_root_excludes r hr _ hzc).2,
      cayley_norm_lt_one z hzi,cayley_norm_eq_one x hxi,
      cayley_root_ne_zero r hr _ hzc,cayley_root_ne_zero r hr _ hz,cayley_root_ne_zero r hr _ hx⟩

 theorem roots_classified (r : ℝ) (hr : 0<r) :
    ∃ roots : Fin 4 → ℂ, Function.Injective roots ∧
      (∀ i, roots i ≠ 0 ∧ quartic r (roots i)=0) ∧
      1<‖roots 0‖ ∧ ∀ i, i ≠ 0 → ‖roots i‖ ≤ 1 := by
  obtain ⟨a,b,c,ha,hb,hc,han,hbn,hcn,haz,hbz,hcz⟩ := cubic_three_norm_roots r hr
  have hab : a ≠ b := by intro h; rw [h] at han; linarith
  have hac : a ≠ c := by intro h; rw [h,hcn] at han; linarith
  have ha1 : a ≠ 1 := cubic_root_ne_one r hr a ha
  have hbc : b ≠ c := by intro h; rw [h,hcn] at hbn; linarith
  have hb1 : b ≠ 1 := cubic_root_ne_one r hr b hb
  have hc1 : c ≠ 1 := cubic_root_ne_one r hr c hc
  refine ⟨![a,b,c,1],?_,?_,han,?_⟩
  · intro i j h
    fin_cases i <;> fin_cases j <;> simp_all
  · intro i
    fin_cases i <;> simp [quartic_factor,ha,hb,hc,haz,hbz,hcz]
  · intro i hi
    fin_cases i <;> simp_all <;> linarith
#assert_trust kernel roots_classified
end NLA.MF22
