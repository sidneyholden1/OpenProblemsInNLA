/- Real cubic root classification using Mathlib's exact discriminant identity.
Formalization: Sidney Holden with OpenAI Codex assistance. Apache-2.0. -/
import NLA.MF22.Scalar
set_option autoImplicit false
set_option maxHeartbeats 2000000
noncomputable section
namespace NLA.MF22
open Complex Polynomial

lemma cubic_conj_root (P : Cubic ℝ) (z : ℂ)
    (h : z ∈ (P.map Complex.ofRealHom).roots) :
    star z ∈ (P.map Complex.ofRealHom).roots := by
  have hp : (P.map Complex.ofRealHom).toPoly ≠ 0 := by
    intro he; simpa [Cubic.roots,he] using h
  rw [Cubic.mem_roots_iff hp] at h ⊢
  have hs := congrArg star h
  simpa [Cubic.map,map_add,map_mul,map_pow] using hs

lemma real_cubic_pair (P : Cubic ℝ) (ha : P.a ≠ 0) (hd : P.discr < 0) :
    ∃ x z : ℂ, x.im=0 ∧ z.im ≠ 0 ∧
      (P.map Complex.ofRealHom).roots={x,z,star z} ∧
      x ≠ z ∧ x ≠ star z ∧ z ≠ star z := by
  obtain ⟨x,y,z,h3⟩ :=
    (Cubic.splits_iff_roots_eq_three (φ := Complex.ofRealHom) ha).mp (IsAlgClosed.splits _)
  have hn := (Cubic.discr_ne_zero_iff_roots_ne ha h3).mp (ne_of_lt hd)
  have hnot : ¬(x.im=0 ∧ y.im=0 ∧ z.im=0) := by
    rintro ⟨hx,hy,hz⟩
    have hh := Cubic.discr_eq_prod_three_roots ha h3
    have hr := congrArg Complex.re hh
    simp only [Complex.ofRealHom_eq_coe,ofReal_re,mul_re,mul_im,sub_re,sub_im,pow_two] at hr
    simp [hx,hy,hz] at hr
    nlinarith [sq_nonneg (P.a*P.a*(x.re-y.re)*(x.re-z.re)*(y.re-z.re))]
  have step : ∀ u v w : ℂ,
      (P.map Complex.ofRealHom).roots={u,v,w} → u.im ≠ 0 →
      ∃ x z : ℂ, x.im=0 ∧ z.im ≠ 0 ∧
        (P.map Complex.ofRealHom).roots={x,z,star z} ∧
        x ≠ z ∧ x ≠ star z ∧ z ≠ star z := by
    intro u v w he hu
    have huconj : star u ≠ u := by
      intro h
      have := congrArg Complex.im h
      simp at this
      exact hu (by linarith)
    have hc := cubic_conj_root P u (by simp [he])
    rw [he] at hc
    simp only [Multiset.insert_eq_cons,Multiset.mem_cons,Multiset.mem_singleton] at hc
    have hne := (Cubic.discr_ne_zero_iff_roots_ne ha he).mp (ne_of_lt hd)
    have get : ∀ v w : ℂ,
        (P.map Complex.ofRealHom).roots={u,v,w} → v=star u →
        u ≠ v ∧ u ≠ w ∧ v ≠ w →
        ∃ x z : ℂ, x.im=0 ∧ z.im ≠ 0 ∧
          (P.map Complex.ofRealHom).roots={x,z,star z} ∧
          x ≠ z ∧ x ≠ star z ∧ z ≠ star z := by
      intro v w hv hvu hneq
      subst v
      have hb := Cubic.b_eq_three_roots ha hv
      have hi := congrArg Complex.im hb
      simp [mul_im,add_im] at hi
      have hw : w.im=0 := by
        exact hi.resolve_left ha
      refine ⟨w,u,hw,hu,?_,hneq.2.1.symm,hneq.2.2.symm,hneq.1⟩
      rw [hv]
      simp only [Multiset.insert_eq_cons, ← Multiset.cons_zero]
      rw [Multiset.cons_swap (star u) w, Multiset.cons_swap u w]
    rcases hc with hc | hc | hc
    · exact False.elim (huconj hc)
    · exact get v w he hc.symm hne
    · apply get w v
      · rw [he]
        simp only [Multiset.insert_eq_cons, ← Multiset.cons_zero]
        rw [Multiset.cons_swap v w]
      · exact hc.symm
      · exact ⟨hne.2.1,hne.1,hne.2.2.symm⟩
  by_cases hx : x.im=0
  · by_cases hy : y.im=0
    · apply step z x y
      · rw [h3]
        simp only [Multiset.insert_eq_cons, ← Multiset.cons_zero]
        rw [Multiset.cons_swap y z,Multiset.cons_swap x z]
      · intro hz; exact hnot ⟨hx,hy,hz⟩
    · apply step y x z
      · rw [h3]
        simp only [Multiset.insert_eq_cons, ← Multiset.cons_zero]
        rw [Multiset.cons_swap x y]
      · exact hy
  · exact step x y z h3 hx
end NLA.MF22
